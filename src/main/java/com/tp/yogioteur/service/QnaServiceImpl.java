package com.tp.yogioteur.service;

import java.io.PrintWriter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import com.tp.yogioteur.domain.QnaDTO;
import com.tp.yogioteur.domain.QnaReplyDTO;
import com.tp.yogioteur.mapper.QnaMapper;
import com.tp.yogioteur.util.PageUtils;

@Service
public class QnaServiceImpl implements QnaService {

	@Autowired
	private QnaMapper qnaMapper;
	
	
	@Override
	public void selectQnas(HttpServletRequest request, Model model) {
		
		Optional<String> opt = Optional.ofNullable(request.getParameter("page"));
		int page = Integer.parseInt(opt.orElse("1"));
		
		int totalRecord = qnaMapper.selelctQnaCount();
		
		PageUtils pageUtils = new PageUtils();
		pageUtils.setPageEntity(totalRecord, page);
		
		Map<String, Object> map = new HashMap<>();
		map.put("beginRecord", pageUtils.getBeginRecord() -1);
		map.put("recordPerPage", pageUtils.getRecordPerPage());
		
		List<QnaDTO> qnas = qnaMapper.selectQnaList(map);
		
		model.addAttribute("qnas", qnas);
		model.addAttribute("totalRecord", totalRecord);
		model.addAttribute("paging", pageUtils.getPaging1(request.getContextPath() + "/qna/qnaList"));
		
	}
	
	@Override
	public void selectDetailQna(Long qnaNo, Model model) {
		QnaDTO qna = qnaMapper.selectQnaByNo(qnaNo);
		qnaMapper.updateQnaHit(qnaNo);
		
		model.addAttribute("qna", qna);
		
	}
	
	
	@Override
	public void AddQna(HttpServletRequest request, HttpServletResponse response) {
		
		String memberId = request.getParameter("memberId");
		String qnaTitle = request.getParameter("qnaTitle");
		String qnaContent = request.getParameter("qnaContent");
		
		QnaDTO qna = QnaDTO.builder()
				.memberId(memberId)
				.qnaTitle(qnaTitle)
				.qnaContent(qnaContent)
				.build();
		
		int AddQnaRes = qnaMapper.insertQna(qna);
		
		try {
			response.setContentType("text/html");
			PrintWriter out = response.getWriter();
			if(AddQnaRes == 1) {
				out.println("<script>");
				out.println("alert('QnA가 등록되었습니다.')");
				out.println("location.href='" + request.getContextPath() + "/qna/qnaList'");
				out.println("</script>");
				out.close();
			}else {
				out.println("<script>");
				out.println("alert('QnA가 등록되지 않았습니다.')");
				out.println("history.back()");
				out.println("</script>");
				out.close();
			}
			
			
		}catch (Exception e) {
			e.printStackTrace();
		}
		
		
	}
	
	@Override
	public void saveReply(HttpServletRequest request, HttpServletResponse response) {
		Long qnaNo = Long.parseLong(request.getParameter("qnaNo"));
		String memberId = request.getParameter("memberId");
		String qnaReplyContent =request.getParameter("qnaReplyContent");
		
		QnaReplyDTO qnaReply = QnaReplyDTO.builder()
				.qnaNo(qnaNo)
				.memberId(memberId)
				.qnaReplyContent(qnaReplyContent)
				.build();
		
		int AddQnaReply = qnaMapper.insertQnaReply(qnaReply);
		qnaMapper.updateQnaHitnotD(qnaNo);
		
		try {
			response.setContentType("text/html");
			PrintWriter out = response.getWriter();
			if(AddQnaReply == 1) {
				out.println("<script>");
				out.println("alert('댓글이 등록되었습니다.')");
				out.println("location.href='" + request.getContextPath() + "/qna/qnaDetailPage?qnaNo=" + qnaNo+"'");
				out.println("</script>");
				out.close();
			}else {
				out.println("<script>");
				out.println("alert('댓글이 등록되지 않았습니다.')");
				out.println("history.back()");
				out.println("</script>");
				out.close();
			}
			
			
		}catch (Exception e) {
			e.printStackTrace();
		}
		
		
		
	}
	
	@Override
	public void selectQnaReplies(Long qnaNo, Model model) {
		List<QnaReplyDTO> qnaReplies = qnaMapper.selectQnaReplyByNo(qnaNo);
		qnaMapper.updateQnaHitnotD(qnaNo);
		model.addAttribute("qnaReplies", qnaReplies);
		
	}

	@Override
	public void saveReplySecond(HttpServletRequest request, HttpServletResponse response) {
		Long qnaNo = Long.parseLong(request.getParameter("qnaNo"));
		String memberId = request.getParameter("memberId");
		String qnaReplyContent =request.getParameter("qnaReplyContent");
		
		int qnaReplyDepth = Integer.parseInt(request.getParameter("qnaReplyDepth"));
		Long qnaReplyGroupNo = Long.parseLong(request.getParameter("qnaReplyGroupNo"));
		int qnaReplyGroupOrd = Integer.parseInt(request.getParameter("qnaReplyGroupOrd"));
		
		QnaReplyDTO qnaReply = new QnaReplyDTO();
		qnaReply.setQnaReplyGroupNo(qnaReplyGroupNo);
		qnaReply.setQnaReplyGroupOrd(qnaReplyGroupOrd);
		qnaMapper.updatPreviousReply(qnaReply);
		
		QnaReplyDTO qnaReplySec = QnaReplyDTO.builder()
				.qnaNo(qnaNo)
				.memberId(memberId)
				.qnaReplyContent(qnaReplyContent)
				.qnaReplyDepth(qnaReplyDepth +1)
				.qnaReplyGroupNo(qnaReplyGroupNo)
				.qnaReplyGroupOrd(qnaReplyGroupOrd +1)
				.build();
		
		int AddQnaReply = qnaMapper.insertQnaReplySecond(qnaReplySec);
		qnaMapper.updateQnaHitnotD(qnaNo);
		try {
			response.setContentType("text/html");
			PrintWriter out = response.getWriter();
			if(AddQnaReply == 1) {
				out.println("<script>");
				out.println("alert('댓글이 등록되었습니다.')");
				out.println("location.href='" + request.getContextPath() + "/qna/qnaDetailPage?qnaNo=" + qnaNo+"'");
				out.println("</script>");
				out.close();
			}else {
				out.println("<script>");
				out.println("alert('댓글이 등록되지 않았습니다.')");
				out.println("history.back()");
				out.println("</script>");
				out.close();
			}
			
			
		}catch (Exception e) {
			e.printStackTrace();
		}

	}
	
	
	@Override
	public void removeReply(HttpServletRequest request, HttpServletResponse response) {
		Long qnaNo = Long.parseLong(request.getParameter("qnaNo"));
		Long qnaReplyNo = Long.parseLong(request.getParameter("qnaReplyNo"));
		int removeReplyRes = qnaMapper.deleteQnaReply(qnaReplyNo);
		qnaMapper.updateQnaHitnotD(qnaNo);
		try {
			response.setContentType("text/html");
			PrintWriter out = response.getWriter();
			if(removeReplyRes == 1) {
				out.println("<script>");
				out.println("alert('댓글이 삭제되었습니다.')");
				out.println("location.href='" + request.getContextPath() + "/qna/qnaDetailPage?qnaNo=" + qnaNo+"'");
				out.println("</script>");
				out.close();
			}else {
				out.println("<script>");
				out.println("alert('댓글이 삭제되지 않았습니다.')");
				out.println("history.back()");
				out.println("</script>");
				out.close();
			}
			
			
		}catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	
	@Override
	public void removeQna(HttpServletRequest request, HttpServletResponse response) {
		Long qnaNo = Long.parseLong(request.getParameter("qnaNo"));
		int removeQnaReplyRes = qnaMapper.deleteQnaAndReply(qnaNo);
		int removeQnaRes = qnaMapper.deleteQna(qnaNo);
		qnaMapper.updateQnaHitnotD(qnaNo);
		try {
			response.setContentType("text/html");
			PrintWriter out = response.getWriter();
			if(removeQnaRes == 1 || removeQnaReplyRes >= 1) {
				out.println("<script>");
				out.println("alert('게시글이 삭제되었습니다.')");
				out.println("location.href='" + request.getContextPath() + "/qna/qnaList'");
				out.println("</script>");
				out.close();
			}else {
				out.println("<script>");
				out.println("alert('게시글이 삭제되지 않았습니다.')");
				out.println("history.back()");
				out.println("</script>");
				out.close();
			}
			
			
		}catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	@Override
	public void modifyQna(HttpServletRequest request, HttpServletResponse response) {
		Long qnaNo = Long.parseLong(request.getParameter("qnaNo"));
		String qnaContent = request.getParameter("qnaContent");
		
		QnaDTO qna = QnaDTO.builder()
				.qnaNo(qnaNo)
				.qnaContent(qnaContent)
				.build();
		
		int modifyQnaRes = qnaMapper.updateQna(qna);
		qnaMapper.updateQnaHitnotD(qnaNo);
		qnaMapper.updateQnaHitnotD(qnaNo);
		try {
			response.setContentType("text/html");
			PrintWriter out = response.getWriter();
			if(modifyQnaRes == 1 ) {
				out.println("<script>");
				out.println("alert('게시글이 수정되었습니다.')");
				out.println("location.href='" + request.getContextPath() + "/qna/qnaDetailPage?qnaNo=" + qnaNo+"'");
				out.println("</script>");
				out.close();
			}else {
				out.println("<script>");
				out.println("alert('게시글이 수정되지 않았습니다.')");
				out.println("history.back()");
				out.println("</script>");
				out.close();
			}
			
			
		}catch (Exception e) {
			e.printStackTrace();
		}
	}
}
