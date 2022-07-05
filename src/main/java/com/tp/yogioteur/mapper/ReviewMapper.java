package com.tp.yogioteur.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.tp.yogioteur.domain.ReImageDTO;
import com.tp.yogioteur.domain.ReviewDTO;

@Mapper
public interface ReviewMapper {
	
	
	  	//리뷰갯수 
		public int selectReviewCount();
	  
		//리뷰 목록가져오기 
		public List<ReviewDTO> selectReviewList(Map<String, Object>map); 
	  
		// 사진 전체 가저오기 
		public List<ReImageDTO> selectReImageList();
		
		// 리뷰 사진가져오기
		public ReImageDTO selectReImageByNo(Long reImageNo);

		// 리뷰 하나당 사진 여러개
		public List<ReImageDTO> selectReImage(Long reviewNo);
		
		// 리뷰 수정
		public int updateReview(ReviewDTO review);
		
		
		
		
		
		
		// 리뷰 하나
		public ReviewDTO selectReviewByNo(Long reviewNo);
		
		
		// 리뷰 추가
		public int insertReview(ReviewDTO review); 
		
		// 리뷰 사진 추가 
		public int insertReImage(ReImageDTO reImage);
	  
	  
		// 리뷰 삭제 
		public int deleteReview(Long reviewNo);
		
		//리뷰를 삭제 했을때 reviewNo image 전체 삭제
		
		public int deleteReImageByReviewNo(Long reviewNo);
	 
		// 리뷰 첨부사진 삭제
		public int deleteReImage(Long reImageNo);

}