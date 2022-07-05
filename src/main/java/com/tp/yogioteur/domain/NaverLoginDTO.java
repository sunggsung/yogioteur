package com.tp.yogioteur.domain;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;

@Data
@AllArgsConstructor
@Builder
public class NaverLoginDTO {
	
	private Long memberNo;
	private String memberId;
	private String memberName;
	private String memberEmail;
	private String memberGender;
	private String memberPhone;
	
}
