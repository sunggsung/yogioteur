package com.tp.yogioteur.controller;


import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class MainController {
	
	@GetMapping("/")
	public String index() {
		return "mainPage";
	}
	 
	@GetMapping("/admin/index")
	public String adminPage() {
		return "admin/index";
	}
	
	@GetMapping("/faq/faqPage")
	public String faqPage() {
		return "faq/faqSearch";
	}
	
	@GetMapping("/review/reviewPage")
	public String reviewPage() {
		return "review/reviewList";
	}


}
