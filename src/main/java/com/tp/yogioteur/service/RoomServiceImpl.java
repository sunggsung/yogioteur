package com.tp.yogioteur.service;

import java.io.File;
import java.nio.file.Files;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;

import com.tp.yogioteur.domain.ImageDTO;
import com.tp.yogioteur.domain.RoomDTO;
import com.tp.yogioteur.mapper.RoomMapper;

@Service
public class RoomServiceImpl implements RoomService {

	@Autowired
	private RoomMapper roomMapper;

	/*
	 * @Override public void roomList(HttpServletRequest request, Model model) {
	 * 
	 * checkIn > checkOut 되어있다면 alert창 뜨게하기 roomStatus 0이 없다면 예약이 꽉찼다는 alert창 뜨게하기
	 * //checkIn, out 데이터 받기 String checkIn = request.getParameter("checkIn");
	 * String checkOut = request.getParameter("checkOut");
	 * 
	 * 
	 * //mapper 데이터 받기 model.addAttribute("roomList", roomMapper.checkInRoomList());
	 * 
	 * }
	 */

	@Override
	public List<RoomDTO> roomList(HttpServletRequest request) {
		
		
		
		/*
		 * Date checkIn = Date.valueOf(request.getParameter("checkIn"));
		 * Date checkOut =Date.valueOf(request.getParameter("checkOut"));
		 */
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("roomCheckIn", request.getParameter("roomCheckIn"));
		map.put("roomCheckOut", request.getParameter("roomCheckOut"));
		List<RoomDTO> roomList = roomMapper.checkInRoomList(map);
		System.out.println(roomList);
		return roomList;
		
		
	}
	
	@Override
	public ResponseEntity<byte[]> view(Long roomNo, String type) {
		
		
		ImageDTO image = roomMapper.selectImageByNo(roomNo);
				
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
	
	//객실 상세
	@Override
	public void findRoomTypeByNo(HttpServletRequest request, Model model) {
		
		Long roomNo = Long.parseLong(request.getParameter("roomNo"));
		
		model.addAttribute("rn", roomMapper.selectRoomTypeByNo(roomNo));
		//객실 정보 가져와서 model에 저장
		
	}
	
}
