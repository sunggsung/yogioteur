package com.tp.yogioteur.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.tp.yogioteur.domain.QnaDTO;
import com.tp.yogioteur.domain.QnaReplyDTO;

@Mapper
public interface QnaMapper {

	// 목록가져오기
	public List<QnaDTO> selectQnaList(Map<String, Object> map);
	public int selelctQnaCount();
	public int updateQnaHit(Long qnaNo); // 조회수
	public int updateQnaHitnotD(Long qnaNo); // 조회수
	
	
	// 디테일 정보 가져오기
	public QnaDTO selectQnaByNo(Long qnaNo);
	
	// qna 추가
	public int insertQna(QnaDTO qna);
	
	// 댓글 전 처리
	public int updatPreviousReply(QnaReplyDTO qnaReply);
	
	// 댓글 추가
	public int insertQnaReply(QnaReplyDTO qnaReply);
	
	// 댓글 조회
	public List<QnaReplyDTO> selectQnaReplyByNo(Long qnaNo);
	
	// 댓글두번쨰추가
	public int insertQnaReplySecond(QnaReplyDTO qnaReply);
	
	
	// 댓글 삭제
	public int deleteQnaReply(Long qnaReplyNo);
	
	// 게시글 삭제
	public int deleteQna(Long qnaNo);
	public int deleteQnaAndReply(Long qnaNo);
	
	
	//게시글 수정
	public int updateQna(QnaDTO qna);
	
}
