package com.tp.yogioteur.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

import com.tp.yogioteur.mapper.QnaMapper;
import com.tp.yogioteur.service.QnaService;

@Controller
public class QnaController {
	
	@Autowired
	private QnaService qnaService;
	
	@Autowired
	private QnaMapper qnaMapper;
	
	@GetMapping("/qna/qnaList")
	public String qnaList(HttpServletRequest request, Model model) {
		qnaService.selectQnas(request, model);
		return "qna/qnaList";
	}
	
	@GetMapping("/qna/qnaDetailPage")
	public String qnaDetailPage(Long qnaNo, Model model) {
		
		qnaService.selectDetailQna(qnaNo, model);
		qnaService.selectQnaReplies(qnaNo, model);
		
		return "qna/qnaDetail";
	}
	
	@GetMapping("/qna/qnaSavePage")
	public String qnaSavePage () {
		return "qna/qnaSave";
	}
	
	@PostMapping("/qna/qnaSave")
	public void qnaSave(HttpServletRequest request, HttpServletResponse response) {
		qnaService.AddQna(request, response);
	}
	
	@PostMapping("/qnaReply/qnaReplySave")
	public void qnaReplySave(HttpServletRequest request, HttpServletResponse response) {
		qnaService.saveReply(request ,response);
	}
	
	@PostMapping("/qnaReply/qnaReplySaveSecond")
	public void qnaReplySaveSecond(HttpServletRequest request, HttpServletResponse response){
		qnaService.saveReplySecond(request, response);
		
	}
	
	@GetMapping("/qnaReply/qnaReplyRemove")
	public void qnaReplyRemove(HttpServletRequest request, HttpServletResponse response) {
		qnaService.removeReply(request, response);
	}
	
	@GetMapping("/qna/qnaRemove")
	public void qnaRemove(HttpServletRequest request, HttpServletResponse response) {
		qnaService.removeQna(request, response);
	}
	
	@GetMapping("/qna/qnaUpdatePage")
	public String qnaUpdatePage(Long qnaNo, Model model) {
		qnaService.selectDetailQna(qnaNo, model);
		qnaMapper.updateQnaHitnotD(qnaNo);
		return "qna/qnaUpdate";
	}
	
	@PostMapping("/qna/qnaUpdate")
	public void qnaUpdate(HttpServletRequest request, HttpServletResponse response) {
		qnaService.modifyQna(request, response);
	}
	
}
