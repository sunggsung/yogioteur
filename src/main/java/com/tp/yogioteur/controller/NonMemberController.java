package com.tp.yogioteur.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

import com.tp.yogioteur.service.NonMemberService;

@Controller
public class NonMemberController {
	
	@Autowired
	private NonMemberService nonMemberService;
	
	@GetMapping("/nonMember/nonMemberLoginPage")
	public String nonMemberLoginPage() {
		return "nonMember/nonMemberLogin";
	}
	
	@PostMapping("/nonMember/nonMemberLogin")
	public String nonMemberLogin(HttpServletRequest request) {
		nonMemberService.saveNonMember(request);
		System.out.println(request.getSession().getAttribute("nonMember"));
		return "mainPage";
	}
	
}
