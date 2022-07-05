package com.tp.yogioteur.service;

import java.io.PrintWriter;
import java.util.Optional;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import com.tp.yogioteur.domain.ReviewReplyDTO;
import com.tp.yogioteur.mapper.ReviewReplyMapper;


@Service 
public class ReviewReplyServiceImpl implements ReviewReplyService {

	@Autowired
	private ReviewReplyMapper reviewReplyMapper;
	
	

	@Override
	public void ReviewReplySave(HttpServletRequest request, HttpServletResponse response) {
		Long reviewNo = Long.parseLong(request.getParameter("reviewNo"));
		String replyContent = request.getParameter("replyContent");
		
		
		ReviewReplyDTO reviewReply = ReviewReplyDTO.builder()
				.reviewNo(reviewNo)
				.replyContent(replyContent)
				.build();

		int reviewReplyResult = reviewReplyMapper.insertReviewReply(reviewReply);
		
		try {
			response.setContentType("text/html");
			PrintWriter out = response.getWriter();
			if(reviewReplyResult == 1) {
				out.println("<script>");
				out.println("alert('리뷰댓글이 등록되었습니다.')");
				out.println("location.href='" + request.getContextPath() + "/review/reviewList'");
				out.println("</script>");
				out.close();
			} else {
				out.println("<script>");
				out.println("alert('리뷰댓글이 등록되지 않았습니다.')");
				out.println("history.back()");
				out.println("</script>");
				out.close();
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		
	}

	@Override
	public void ReviewReplyRemove(HttpServletRequest request, HttpServletResponse response) {
		 Optional<String> opt = Optional.ofNullable(request.getParameter("replyNo"));
		 Long replyNo = Long.parseLong(opt.orElse("0"));
		
		int replyRemoveResult = reviewReplyMapper.deleteReviewReply(replyNo);
		
		try {
			  
			  response.setContentType("text/html");
			  PrintWriter out = response.getWriter();
			  if(replyRemoveResult ==1 ) {
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
			  
			  
		  }catch (Exception e) {
			  e.printStackTrace();
		  }
		
	}
	
	@Override
	public void ReviewReplySelectOne(Long replyNo, Model model) {
		ReviewReplyDTO reviewReply = reviewReplyMapper.selectReplyByNo(replyNo);
		
		model.addAttribute("reviewReply", reviewReply);
		
	}
	
	// 리뷰댓글 수정
	@Override
	public void ReviewReplyChange(HttpServletRequest request, HttpServletResponse response) {
		Long replyNo = Long.parseLong(request.getParameter("replyNo"));
		String replyContent = request.getParameter("replyContent");
		
		ReviewReplyDTO reviewReply = ReviewReplyDTO.builder()
				.replyNo(replyNo)
				.replyContent(replyContent)
				.build();
		
		int ReviewReplyChangeRes = reviewReplyMapper.updateReply(reviewReply);
		
		try {
			  
			  response.setContentType("text/html");
			  PrintWriter out = response.getWriter();
			  if(ReviewReplyChangeRes == 1 ) {
				  out.println("<script>");
				  out.println("alert('댓글이 수정되었습니다')");
				  out.println("location.href='" + request.getContextPath() + "/review/reviewList'");
				  out.println("</script>");
				  out.close();
			  } else {
				  out.println("<script>");
				  out.println("alert('댓글이 수정되지 않았습니다')");
				  out.println("history.back()");
				  out.println("</script>");
				  out.close();
			  }
			  
			  
		  }catch (Exception e) {
			  e.printStackTrace();
		  }
		
	}

}