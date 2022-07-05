package com.tp.yogioteur.domain;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class SignOutMemberDTO {

	private Long signOutNo;
	private String id;
	private String name;
	private Long memberNo;
	private String email;
	private Integer agreeState;
	private Date signIn;
	private Date signOut;

}
