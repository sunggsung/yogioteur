package com.tp.yogioteur.service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.ui.Model;

public interface QnaService {

	
	public void selectQnas(HttpServletRequest request, Model model);
	
	public void selectDetailQna(Long qnaNo, Model model);
	
	public void AddQna(HttpServletRequest request, HttpServletResponse response);

	public void saveReply(HttpServletRequest request, HttpServletResponse response);
	
	// 댓글 조회
	public void selectQnaReplies(Long qnaNo, Model model);
	
	public void saveReplySecond(HttpServletRequest request, HttpServletResponse response);

	//댓글 삭제
	public void removeReply(HttpServletRequest request, HttpServletResponse response);
	
	// 게시글 삭제
	public void removeQna(HttpServletRequest request, HttpServletResponse response);
	
	// 게시글 수정
	public void modifyQna(HttpServletRequest request, HttpServletResponse response);
	
}
