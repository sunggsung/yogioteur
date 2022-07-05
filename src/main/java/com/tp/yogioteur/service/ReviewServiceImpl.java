package com.tp.yogioteur.service;

import java.io.File;
import java.io.PrintWriter;
import java.nio.file.Files;
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
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.tp.yogioteur.domain.ReImageDTO;
import com.tp.yogioteur.domain.ReviewDTO;
import com.tp.yogioteur.domain.ReviewReplyDTO;
import com.tp.yogioteur.mapper.ReviewMapper;
import com.tp.yogioteur.mapper.ReviewReplyMapper;
import com.tp.yogioteur.util.MyFileUtils;
import com.tp.yogioteur.util.PageUtils;

@Service
public class ReviewServiceImpl implements ReviewService {

	@Autowired
	private ReviewMapper reviewMapper;

	@Autowired
	private ReviewReplyMapper reviewReplyMapper;

	// 목록보기
	@Override
	public void ReviewList(HttpServletRequest request, Model model) {
		Optional<String> opt = Optional.ofNullable(request.getParameter("page"));
		int page = Integer.parseInt(opt.orElse("1"));

		int totalRecord = reviewMapper.selectReviewCount();

		PageUtils pageUtils = new PageUtils();
		pageUtils.setPageEntity(totalRecord, page);

		Map<String, Object> map = new HashMap<String, Object>();
		map.put("beginRecord", pageUtils.getBeginRecord()-1);
		map.put("recordPerPage", pageUtils.getRecordPerPage());

		List<ReviewDTO> reviews = reviewMapper.selectReviewList(map);
		List<ReImageDTO> reImages = reviewMapper.selectReImageList();
		List<ReviewReplyDTO> reviewReply = reviewReplyMapper.selectReviewReplyList();

		model.addAttribute("totalRecrod", totalRecord);
		model.addAttribute("reviews", reviews);
		model.addAttribute("reImages", reImages);
		model.addAttribute("reviewReplies", reviewReply);
		model.addAttribute("beginNo", totalRecord - (page - 1) * pageUtils.getRecordPerPage());
		model.addAttribute("paging", pageUtils.getPaging1(request.getContextPath() + "/review/reviewList"));

	}

	@Override
	public ResponseEntity<byte[]> display(Long reImageNo, String type) {

		// 보내줘야 할 이미지 정보(path, saved)읽기
		ReImageDTO reImage = reviewMapper.selectReImageByNo(reImageNo);
		ResponseEntity<byte[]> entity = null;

		// 보내줘야 할 이미지
		if (reImage != null) {

			File file = new File(reImage.getReImagePath(), reImage.getReImageSaved());

			try {

				HttpHeaders headers = new HttpHeaders();
				headers.add("Content-Type", Files.probeContentType(file.toPath()));
				entity = new ResponseEntity<>(FileCopyUtils.copyToByteArray(file), headers, HttpStatus.OK);

			} catch (Exception e) {
				e.printStackTrace();
			}
		}

		return entity;
	}

	// 리뷰 저장
	@Override
	public void ReviewSave(MultipartHttpServletRequest multipartRequest, HttpServletResponse response) {
		Optional<String> opt = Optional.ofNullable(multipartRequest.getParameter("reviewNo"));
		Long reviewNo = Long.parseLong(opt.orElse("0"));
		
		String memberId = multipartRequest.getParameter("memberId");
		String reviewTitle = multipartRequest.getParameter("reviewTitle");
		String reviewContent = multipartRequest.getParameter("reviewContent");
		String roomName = multipartRequest.getParameter("roomName");
		String rtType = multipartRequest.getParameter("rtType");
		int reviewRevNo = Integer.parseInt(multipartRequest.getParameter("reviewRevNo"));

		// REVIEW
		ReviewDTO review = ReviewDTO.builder()
				.reviewNo(reviewNo)
				.memberId(memberId)
				.reviewTitle(reviewTitle)
				.reviewContent(reviewContent)
				.roomName(roomName)
				.rtType(rtType)
				.reviewRevNo(reviewRevNo)
				.build();

		// REVIEW INSERT 수행
		int ReviewResult = reviewMapper.insertReview(review);

		List<MultipartFile> files = multipartRequest.getFiles("files");

		// 파일 첨부 결과
		int ReImageResult;
		if (files.get(0).getOriginalFilename().isEmpty()) { // 첨부가 없으면 files.size() == 1임. [MultipartFile[field="files",
															// filename=, contentType=application/octet-stream, size=0]]
															// 값을 가짐.
			ReImageResult = 1;
		} else { // 첨부가 있으면 "files.size() == 첨부파일갯수"이므로 fileAttachResult = 0으로 시작함.
			ReImageResult = 0;
		}

		for (MultipartFile multipartFile : files) {

			// 예외 처리는 기본으로 필요함.
			try {

				// 첨부가 없을 수 있으므로 점검해야 함.
				if (multipartFile != null && multipartFile.isEmpty() == false) { // 첨부가 있다.(둘 다 필요함)

					// 첨부파일의 본래 이름(origin)
					String origin = multipartFile.getOriginalFilename();
					origin = origin.substring(origin.lastIndexOf("\\") + 1); // IE는 본래 이름에 전체 경로가 붙어서 파일명만 빼야 함.

					// 첨부파일의 저장된 이름(saved)
					String saved = MyFileUtils.getUuidName(origin);

					// 첨부파일의 저장 경로(디렉터리)
					String path = MyFileUtils.getTodayPath();

					// 저장 경로(디렉터리) 없으면 만들기
					File dir = new File(path);
					if (dir.exists() == false) {
						dir.mkdirs();
					}

					// 첨부파일
					File file = new File(dir, saved);

					// 첨부파일 확인
					String contentType = Files.probeContentType(file.toPath()); // 이미지의 Content-Type(image/jpeg,
																				// image/png, image/gif)
					if (contentType.startsWith("image")) {

						// 첨부파일 서버에 저장(업로드)
						multipartFile.transferTo(file);

						// ReImageDTO
						ReImageDTO reImage = ReImageDTO.builder()
								.reImagePath(path).reImageOrigin(origin)
								.reImageSaved(saved).reviewNo(review.getReviewNo()).build();

						// FileAttach INSERT 수행
						ReImageResult += reviewMapper.insertReImage(reImage);

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
			if (ReviewResult == 1 && ReImageResult >= 1) {
				out.println("<script>");
				out.println("alert('리뷰가 등록되었습니다.')");
				out.println("location.href='" + multipartRequest.getContextPath() + "/review/reviewList'");
				out.println("</script>");
				out.close();
			} else {
				out.println("<script>");
				out.println("alert('리뷰가 등록되지 않았습니다.')");
				out.println("history.back()");
				out.println("</script>");
				out.close();
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	// 리뷰 삭제
	@Override
	public void removeReview(HttpServletRequest request, HttpServletResponse response) {

		Optional<String> opt = Optional.ofNullable(request.getParameter("reviewNo"));
		Long reviewNo = Long.parseLong(opt.orElse("0"));
		
		
		int resRev = reviewMapper.deleteReview(reviewNo);

		try {

			response.setContentType("text/html");
			PrintWriter out = response.getWriter();
			if (resRev >= 1) {
				out.println("<script>");
				out.println("alert('리뷰가 삭제되었습니다')");
				out.println("location.href='" + request.getContextPath() + "/review/reviewList'");
				out.println("</script>");
				out.close();
			} else {
				out.println("<script>");
				out.println("alert('리뷰가 삭제되지 않았습니다')");
				out.println("history.back()");
				out.println("</script>");
				out.close();
			}

		} catch (Exception e) {
			e.printStackTrace();
		}

	}
//		  }

//	}

	// 리뷰 하나
	public void ReviewOne(Long reviewNo, Model model) {
		ReviewDTO review = reviewMapper.selectReviewByNo(reviewNo);
		List<ReImageDTO> reImage = reviewMapper.selectReImage(reviewNo);

		model.addAttribute("review", review);
		model.addAttribute("reImage", reImage);

	}

	@Override
	public void removeReImage(Long reImageNo) {
		ReImageDTO reImage = reviewMapper.selectReImageByNo(reImageNo);

		File file = new File(reImage.getReImagePath(), reImage.getReImageSaved());
		try {

			String contentType = Files.probeContentType(file.toPath());
			if (contentType.startsWith("image")) {

				// 원본 이미지 삭제
				if (file.exists()) {
					file.delete();
				}

			}

		} catch (Exception e) {
			e.printStackTrace();
		}

		reviewMapper.deleteReImage(reImageNo);

	}

	@Override
	public void changeReview(MultipartHttpServletRequest multipartRequest, HttpServletResponse response) {
		String memberId = multipartRequest.getParameter("memberId");
		Long reviewNo = Long.parseLong(multipartRequest.getParameter("reviewNo"));
		String reviewTitle = multipartRequest.getParameter("reviewTitle");
		String reviewContent = multipartRequest.getParameter("reviewContent");
		Integer reviewRevNo = Integer.parseInt(multipartRequest.getParameter("reviewRevNo"));

		ReviewDTO review = ReviewDTO.builder().memberId(memberId).reviewNo(reviewNo).reviewTitle(reviewTitle)
				.reviewContent(reviewContent).reviewRevNo(reviewRevNo).build();

		int reviewChangeResult = reviewMapper.updateReview(review);

		List<MultipartFile> files = multipartRequest.getFiles("files");

		int reviewImageResult;
		if (files.get(0).getOriginalFilename().isEmpty()) {
			reviewImageResult = 1;
		} else {
			reviewImageResult = 0;
		}

		for (MultipartFile multipartFile : files) {

			try {

				if (multipartFile != null && multipartFile.isEmpty() == false) {

					String reviewOrigin = multipartFile.getOriginalFilename();
					reviewOrigin = reviewOrigin.substring(reviewOrigin.lastIndexOf("\\") + 1);

					String reviewSaved = MyFileUtils.getUuidName(reviewOrigin);

					String reviewPath = MyFileUtils.getTodayPath();

					File dir = new File(reviewPath);
					if (dir.exists() == false) {
						dir.mkdirs();
					}

					File file = new File(dir, reviewSaved);

					String contentType = Files.probeContentType(file.toPath()); // 이미지의 Content-Type(image/jpeg,
																				// image/png, image/gif)
					if (contentType.startsWith("image")) {

						// 첨부파일 서버에 저장(업로드)
						multipartFile.transferTo(file);

						// FileAttachDTO
						ReImageDTO reImage = ReImageDTO.builder().reImagePath(reviewPath).reImageOrigin(reviewOrigin)
								.reImageSaved(reviewSaved).reviewNo(reviewNo).build();

						// FileAttach INSERT 수행
						reviewImageResult += reviewMapper.insertReImage(reImage);

					}

				}

			} catch (Exception e) {
				e.printStackTrace();
			}

			try {
				response.setContentType("text/html");
				PrintWriter out = response.getWriter();
				if (reviewChangeResult >= 1 && reviewImageResult >= 1) {
					out.println("<script>");
					out.println("alert('리뷰가 수정되었습니다.')");
					out.println("location.href='" + multipartRequest.getContextPath() + "/review/reviewList'");
					out.println("</script>");
					out.close();
				} else {
					out.println("<script>");
					out.println("alert('리뷰가 수정되지 않았습니다.')");
					out.println("history.back()");
					out.println("</script>");
					out.close();
				}
			} catch (Exception e) {
				e.printStackTrace();
			}

		}

	}

}