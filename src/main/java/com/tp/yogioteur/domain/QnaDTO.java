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
public class QnaDTO {

	
	private Long qnaNo;
	private String memberId;
	private String qnaTitle;
	private Integer qnaHit;
	private String qnaContent;
	private Date qnaCreated;
	private Date qnaModified;
	
	
	
}
