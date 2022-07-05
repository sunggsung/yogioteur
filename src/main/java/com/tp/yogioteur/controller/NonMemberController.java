package com.tp.yogioteur.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;

import com.tp.yogioteur.domain.NonMemberDTO;
import com.tp.yogioteur.service.NonMemberService;

@Controller
public class NonMemberController {
	
	@Autowired
	private NonMemberService nonMemberService;
	
	@PostMapping("/nonMember/login")
	public void nonMemberLogin(HttpServletRequest request, Model model) {
		NonMemberDTO nonMember = nonMemberService.saveNonMember(request);
		if(nonMember != null) {
			model.addAttribute("nonMember", nonMember);
		}
		model.addAttribute("url", request.getParameter("url"));
	}
	
}
