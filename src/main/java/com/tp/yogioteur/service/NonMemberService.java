package com.tp.yogioteur.service;

import javax.servlet.http.HttpServletRequest;

import com.tp.yogioteur.domain.NonMemberDTO;

public interface NonMemberService {
	
	public NonMemberDTO saveNonMember(HttpServletRequest request);
	
}
