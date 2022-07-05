package com.tp.yogioteur.domain;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class QnaReplyDTO {

	
	private Long qnaReplyNo;
	private Long qnaNo;
	private String memberId;
	private String qnaReplyContent;
	private Date qnaReplyCreated;
	private Integer qnaReplyState;
	private Integer qnaReplyDepth;
	private Long qnaReplyGroupNo;
	private Integer qnaReplyGroupOrd;
	
	
}
