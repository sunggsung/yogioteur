package com.tp.yogioteur.service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.ui.Model;

public interface ReviewReplyService {
	
	
		// 리뷰 댓글 추가
		public void ReviewReplySave(HttpServletRequest request, HttpServletResponse response);
		
		// 리뷰 댓글 삭제
		public void ReviewReplyRemove(HttpServletRequest request, HttpServletResponse response);
		
		// 리뷰 하나의 댓글 가져오기
		public void ReviewReplySelectOne(Long replyNo, Model model);
	
		// 리뷰 수정
		public void ReviewReplyChange(HttpServletRequest request, HttpServletResponse response);
}
