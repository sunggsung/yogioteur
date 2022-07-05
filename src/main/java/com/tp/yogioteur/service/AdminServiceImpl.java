package com.tp.yogioteur.service;

import java.io.File;
import java.io.PrintWriter;
import java.nio.file.Files;
import java.sql.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.tp.yogioteur.domain.ImageDTO;
import com.tp.yogioteur.domain.MemberDTO;
import com.tp.yogioteur.domain.ReservationDTO;
import com.tp.yogioteur.domain.RoomDTO;
import com.tp.yogioteur.mapper.AdminMapper;
import com.tp.yogioteur.util.MyFileUtils;
import com.tp.yogioteur.util.PageUtils;

import net.coobird.thumbnailator.Thumbnails;

@Service
public class AdminServiceImpl implements AdminService {
	
	@Autowired private AdminMapper adminMapper;
	
	@Override
	@Transactional
	public void saveRoom(MultipartHttpServletRequest request, HttpServletResponse response) {
		String roomName = request.getParameter("roomName");
		Integer roomPrice = Integer.parseInt(request.getParameter("roomPrice"));
		Long rtNo = Long.parseLong(request.getParameter("rtNo"));
		RoomDTO room = RoomDTO.builder()
				.roomName(roomName)
				.roomPrice(roomPrice)
				.roomStatus(0)
				.rtNo(rtNo)
				.roomCheckOut(Date.valueOf("9999-12-31"))
				.build();
		int res = adminMapper.insertRoom(room);
		
		// 첨부된 모든 파일들
		List<MultipartFile> files = request.getFiles("image1");
		
		// 파일 첨부 결과
		int fileAttachResult;
		if(files.get(0).isEmpty() && files.get(1).isEmpty()) {
			fileAttachResult = 1; 
		} else {
			fileAttachResult = 0;
		}
		for (MultipartFile multipartFile : files) {
			try {
				// 첨부가 없을 수 있으므로 점검해야 함.
				if(multipartFile != null && multipartFile.isEmpty() == false) {  // 첨부가 있다.(둘 다 필요함)
					// 첨부파일의 본래 이름(origin)
					String origin = multipartFile.getOriginalFilename();
					origin = origin.substring(origin.lastIndexOf("\\") + 1);  // IE는 본래 이름에 전체 경로가 붙어서 파일명만 빼야 함
					
					// 첨부파일의 저장된 이름(saved)
					String saved = MyFileUtils.getUuidName(origin);
					
					// 첨부파일의 저장 경로(디렉터리)
					String path = MyFileUtils.getTodayPath();
					
					// 저장 경로 없으면 만들기
					File dir = new File(path);
					if(dir.exists() == false) {
						dir.mkdirs();
					}
					
					// 첨부파일
					File file = new File(dir, saved);
					
					// 첨부파일 확인
					String contentType = Files.probeContentType(file.toPath());  // 이미지의 Content-Type(image/jpeg, image/png, image/gif)
					if(contentType.startsWith("image")) {
						// 첨부파일 서버에 저장(업로드)
						multipartFile.transferTo(file);
						
						// 썸네일 서버에 저장(썸네일 정보는 DB에 저장되지 않음)
						Thumbnails.of(file)
							.size(96, 54)
							.toFile(new File(dir, "s_" + saved));
						
						ImageDTO image = ImageDTO.builder()
								.imagePath(path)
								.imageOrigin(origin)
								.imageSaved(saved)
								.roomNo(room.getRoomNo())
								.build();
						
						// FileAttach INSERT 수행
						fileAttachResult += adminMapper.insertImage(image);
					}
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		// 응답
		try {
			response.setContentType("text/html");
			PrintWriter out = response.getWriter();
			if(res == 1 && fileAttachResult == files.size()) {
				out.println("<script>");
				out.println("alert('객실이 등록되었습니다.')");
				out.println("location.href='" + request.getContextPath() + "/admin/room'");
				out.println("</script>");
				out.close();
			} else {
				out.println("<script>");
				out.println("alert('객실 등록에 실패했습니다.')");
				out.println("history.back()");
				out.println("</script>");
				out.close();
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	@Override
	public void findRooms(HttpServletRequest request, Model model) {
		Optional<String> opt = Optional.ofNullable(request.getParameter("page"));
		int page = Integer.parseInt(opt.orElse("1"));
		int totalRecord = adminMapper.selectRoomCount(); 
		
		PageUtils pageUtils = new PageUtils();
		pageUtils.setPageEntity(totalRecord, page);
		
		Map<String, Object> map = new HashMap<>();
		map.put("beginRecord", pageUtils.getBeginRecord());
		map.put("endRecord", pageUtils.getEndRecord());
		
		List<RoomDTO> rooms = adminMapper.selectRoomList(map);
		
		model.addAttribute("totalRecord", totalRecord);
		model.addAttribute("rooms", rooms);
		model.addAttribute("beginNo", totalRecord - (page - 1) * pageUtils.getRecordPerPage());
		model.addAttribute("paging", pageUtils.getPaging(request.getContextPath() + "/admin/room"));
	}
	
	@Override
	public void findRoomByNo(HttpServletRequest request, Model model) {
		Long roomNo = Long.parseLong(request.getParameter("roomNo"));
		model.addAttribute("room", adminMapper.selectRoomByNo(roomNo));
		List<ImageDTO> images =  adminMapper.selectImageListInTheRoom(roomNo);
		model.addAttribute("image", images);
	}
	
	@Override
	public ResponseEntity<byte[]> display(Long imageNo, String type) {
		// 보내줘야 할 이미지 정보(path, saved) 읽기
		ImageDTO image = adminMapper.selectImageByNo(imageNo);
		
		// 보내줘야 할 이미지
		File file = null;
		switch(type) {
		case "thumb":
			file = new File(image.getImagePath(), "s_" + image.getImageSaved());
			break;
		case "image":
			file = new File(image.getImagePath(), image.getImageSaved());
			break;
		}
		// ResponseEntity
		ResponseEntity<byte[]> entity = null;
		try {
			HttpHeaders headers = new HttpHeaders();
			headers.add("Content-Type", Files.probeContentType(file.toPath()));
			entity = new ResponseEntity<byte[]>(FileCopyUtils.copyToByteArray(file), headers, HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return entity;
	}
	
	@Override
	public void removeRoom(HttpServletRequest request, HttpServletResponse response) {
		Optional<String> opt = Optional.ofNullable(request.getParameter("roomNo"));
		Long roomNo = Long.parseLong(opt.orElse("0"));
		
		List<ImageDTO> attaches = adminMapper.selectImageListInTheRoom(roomNo);
		
		// 저장되어 있는 첨부 파일이 있는지 확인
		if(attaches != null && attaches.isEmpty() == false) {
			
			// 하나씩 삭제
			for (ImageDTO attach : attaches) {
				
				// 첨부 파일 알아내기
				File file = new File(attach.getImagePath(), attach.getImageSaved());
				try {
					
					// 첨부 파일이 이미지가 맞는지 확인
					String contentType = Files.probeContentType(file.toPath());
					if(contentType.startsWith("image")) {
						// 원본 이미지 삭제
						if(file.exists() ) {
							file.delete();
						}
						// 썸네일 이미지 삭제
						File thumbnail = new File(attach.getImagePath(), "s_" + attach.getImageSaved());
						if(thumbnail.exists()) {
							thumbnail.delete();
						}
					}
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		}
		
		int res = adminMapper.deleteRoom(roomNo);
		try {
			response.setContentType("text/html");
			PrintWriter out = response.getWriter();
			if(res == 1) {
				out.println("<script>");
				out.println("alert('객실이 삭제되었습니다.')");
				out.println("location.href='" + request.getContextPath() + "/admin/room'");
				out.println("</script>");
				out.close();
			} else {
				out.println("<script>");
				out.println("alert('객실이 삭제되지 않았습니다.')");
				out.println("history.back()");
				out.println("</script>");
				out.close();
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	@Override
	@Transactional
	public void changeRoom(MultipartHttpServletRequest request, HttpServletResponse response) {
		String roomName = request.getParameter("roomName");
		Integer roomPrice = Integer.parseInt(request.getParameter("roomPrice"));
		Long rtNo = Long.parseLong(request.getParameter("rtNo"));
		Long roomNo = Long.parseLong(request.getParameter("roomNo"));
		
		
		RoomDTO room = RoomDTO.builder()
				.roomNo(roomNo)
				.roomName(roomName)
				.roomPrice(roomPrice)
				.rtNo(rtNo)
				.build();
		
		int res = adminMapper.updateRoom(room);
		
		// 첨부된 모든 파일들
		List<MultipartFile> files = request.getFiles("image1");
		
		// 파일 첨부 결과
		int fileAttachResult;
		if(files.get(0).isEmpty() && files.get(1).isEmpty()) {
			fileAttachResult = 1; 
		} else {
			fileAttachResult = 0;
		}
		for(int i = 0; i < files.size(); i++) {
			MultipartFile multipartFile = files.get(i);
			System.out.println(multipartFile);
			try {
				if(multipartFile != null && multipartFile.isEmpty() == false) {  // 첨부가 있다.(둘 다 필요함)
					Long imageNo = Long.parseLong(request.getParameter("image" + (i + 1) + "No"));
					// 첨부파일의 본래 이름(origin)
					String origin = multipartFile.getOriginalFilename();
					origin = origin.substring(origin.lastIndexOf("\\") + 1);
					
					// 첨부파일의 저장된 이름(saved)
					String saved = MyFileUtils.getUuidName(origin);
					
					// 첨부파일의 저장 경로(디렉터리)
					String path = MyFileUtils.getTodayPath();
					
					// 저장 경로 없으면 만들기
					File dir = new File(path);
					if(dir.exists() == false) {
						dir.mkdirs();
					}
					
					// 첨부파일
					File file = new File(dir, saved);
					
					// 첨부파일 확인
					String contentType = Files.probeContentType(file.toPath());  // 이미지의 Content-Type(image/jpeg, image/png, image/gif)
					if(contentType.startsWith("image")) {
						// 첨부파일 서버에 저장(업로드)
						multipartFile.transferTo(file);
						
						// 썸네일 서버에 저장(썸네일 정보는 DB에 저장되지 않음)
						Thumbnails.of(file)
							.size(96, 54)
							.toFile(new File(dir, "s_" + saved));
						
						ImageDTO image = ImageDTO.builder()
								.imagePath(path)
								.imageOrigin(origin)
								.imageSaved(saved)
								.roomNo(room.getRoomNo())
								.imageNo(imageNo)
								.build();
						
						// FileAttach INSERT 수행
						fileAttachResult += adminMapper.updateImageByNo(image);
					}
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		// 응답
		try {
			response.setContentType("text/html");
			PrintWriter out = response.getWriter();
			if(res == 1 || fileAttachResult == files.size()) {
				out.println("<script>");
				out.println("alert('객실이 수정되었습니다.')");
				out.println("location.href='" + request.getContextPath() + "/admin/roomDetail?roomNo=" + roomNo + "'");
				out.println("</script>");
				out.close();
			} else {
				out.println("<script>");
				out.println("alert('객실이 수정되지 않았습니다.')");
				out.println("history.back()");
				out.println("</script>");
				out.close();
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	@Override
	public Map<String, Object> findRoomByStatus(int roomStatus) {
		List<RoomDTO> rooms = adminMapper.selectRoomByStatus(roomStatus);
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("rooms", rooms);
		
		return map;
	}
	
	
	@Override
	public void findMembers(HttpServletRequest request, Model model) {
		Optional<String> opt = Optional.ofNullable(request.getParameter("page"));
		int page = Integer.parseInt(opt.orElse("1"));
		int totalRecord = adminMapper.selectMemberCount();
		
		PageUtils pageUtils = new PageUtils();
		pageUtils.setPageEntity(totalRecord, page);
		
		Map<String, Object> map = new HashMap<>();
		map.put("beginRecord", pageUtils.getBeginRecord());
		map.put("endRecord", pageUtils.getEndRecord());
		
		List<MemberDTO> members = adminMapper.selectMemberList(map);
		
		model.addAttribute("totalRecord", totalRecord);
		model.addAttribute("members", members);
		model.addAttribute("beginNo", totalRecord - (page - 1) * pageUtils.getRecordPerPage());
		model.addAttribute("paging", pageUtils.getPaging(request.getContextPath() + "/admin/member"));
	}
	
	@Override
	public void findMemberByNo(HttpServletRequest request, Model model) {
		Long memberNo = Long.parseLong(request.getParameter("memberNo"));
		model.addAttribute("member", adminMapper.selectMemberByNo(memberNo));
	}
	
	@Override
	public Map<String, Object> findReservations() {
		Map<String, Object> map = new HashMap<>();
		
		List<MemberDTO> reservations = adminMapper.selectReservationList();
		map.put("reservations", reservations);
		
		return map;
	}
	
	@Override
	public Map<String, Object> findReservationByMemberNo(HttpServletRequest request, Model model) {
		Long memberNo = Long.parseLong(request.getParameter("memberNo"));
		Map<String, Object> map = new HashMap<>();
		List<ReservationDTO> reservation =  adminMapper.selectReservationByMemberNo(memberNo);
		map.put("reservation", reservation);
		return map;
	}
	
	@Override
	public Model findReservationByReserNo(HttpServletRequest request, Model model) {
		Long reserNo = Long.parseLong(request.getParameter("reserNo"));
		ReservationDTO reservation = adminMapper.selectReservationByReserNo(reserNo);
		model.addAttribute("reservation", reservation);
		model.addAttribute("member", reservation.getMemberNo());
		model.addAttribute("room", reservation.getRoomNo());
		return model;
	}
	
}
