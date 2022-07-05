package com.tp.yogioteur.service;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.tp.yogioteur.domain.NonMemberDTO;
import com.tp.yogioteur.mapper.AdminMapper;
import com.tp.yogioteur.util.SecurityUtils;

@Service
public class NonMemberServiceImpl implements NonMemberService {
	
	@Autowired AdminMapper adminMapper;
	
	@Override
	public NonMemberDTO saveNonMember(HttpServletRequest request) {
		String nonName = SecurityUtils.xss(request.getParameter("nonName"));
		String nonPhone = request.getParameter("nonPhone");
		String nonBirth = request.getParameter("nonBirth");
		String nonId = "guest_";

		NonMemberDTO nonMember = NonMemberDTO.builder()
				.nonId(nonId)
				.nonName(nonName)
				.nonPhone(nonPhone)
				.nonBirth(nonBirth)
				.build();
		
		adminMapper.insertNonMember(nonMember);
		return nonMember;
	}

	
}
