package com.tp.yogioteur.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.tp.yogioteur.domain.ReviewReplyDTO;

@Mapper
public interface ReviewReplyMapper {
	
		// 리뷰댓글 목록
		public List<ReviewReplyDTO> selectReviewReplyList();
		
		
		// 리뷰댓글 추가
		public int insertReviewReply(ReviewReplyDTO reviewReply);
		
		// 리뷰댓글 삭제
		public int deleteReviewReply(Long replyNo);
	 
	
		// 하나 리뷰의 리뷰댓글 가져오기
		public ReviewReplyDTO selectReplyByNo(Long replyNo);
		
		// 리뷰 수정
		public int updateReply(ReviewReplyDTO reviewReply);

}
