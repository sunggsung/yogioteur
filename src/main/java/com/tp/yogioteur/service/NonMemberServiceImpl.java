package com.tp.yogioteur.service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Service;

import com.tp.yogioteur.domain.NonMemberDTO;

@Service
public class NonMemberServiceImpl implements NonMemberService {
	
	@Override
	public void saveNonMember(HttpServletRequest request) {
		String nonName = request.getParameter("nonName");
		String nonPhone = request.getParameter("nonPhone");
		
		
		
		NonMemberDTO nonMember = NonMemberDTO.builder()
				.nonName(nonName)
				.nonPhone(nonPhone)
				.nonReserNo(null)
				.build();
		HttpSession session = request.getSession();
		session.setAttribute("nonMember", nonMember);
	}
	
	
}
