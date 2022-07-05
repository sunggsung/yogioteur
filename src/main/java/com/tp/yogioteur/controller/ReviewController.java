package com.tp.yogioteur.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.tp.yogioteur.service.ReviewService;


@Controller
public class ReviewController {

	@Autowired
	public ReviewService reviewService;
	
	// 리뷰 전체 목록
	@GetMapping("/review/reviewList")
	public String reviewList(HttpServletRequest request, Model model) {
		reviewService.ReviewList(request, model);
		return "review/reviewList";
	}
	
	//리뷰 저장
	@GetMapping("/review/reviewSavePage")
	public String reviewSavePage(@RequestParam(value="roomNo", required=false) Long roomNo, HttpServletRequest request, Model model) {
		
		System.out.println(roomNo);
		model.addAttribute("roomNo", roomNo);
		return"review/reviewSave";
	}
	
	@PostMapping("/review/reviewSave") 
	public void reviewSave(MultipartHttpServletRequest multiparRequest, HttpServletResponse response) {
	
		reviewService.ReviewSave(multiparRequest, response); 
	
	}
	// 리뷰 사진 보이기
	@GetMapping("/review/display")
	public ResponseEntity<byte[]> display(Long reImageNo, @RequestParam(value="type", required=false, defaultValue="image") String type){
		return reviewService.display(reImageNo, type);
	}
	
	// 리뷰 지우기
	@GetMapping("/review/reviewRemove") 
	public void removeReview(HttpServletRequest request, HttpServletResponse response) {
		reviewService.removeReview(request, response);
	}
	
	// 리뷰 수정
	@GetMapping("/review/reviewChangePage")
	public String reviewChangePage(Long reviewNo, Model model) {
		reviewService.ReviewOne(reviewNo, model);
		return "review/reviewChange";
	}
	
	@PostMapping("/review/reviewChange")
	public void reviewChange(MultipartHttpServletRequest multiparRequest, HttpServletResponse response) {
		reviewService.changeReview(multiparRequest, response);
	}
	
	// 리뷰 이미지 수정삭제
	@GetMapping("/review/removeReImage")
	public String removeReIage(@RequestParam Long reImageNo,@RequestParam Long reviewNo ) {
		reviewService.removeReImage(reImageNo);
		return "redirect:/review/reviewChangePage?reviewNo="+reviewNo;
	}
	
	 
}