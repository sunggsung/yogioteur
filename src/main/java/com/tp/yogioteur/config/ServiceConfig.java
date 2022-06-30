package com.tp.yogioteur.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import com.tp.yogioteur.service.MemberService;
import com.tp.yogioteur.service.MemberServiceImpl;
import com.tp.yogioteur.service.OpenAPIService;
import com.tp.yogioteur.service.PaymentService;
import com.tp.yogioteur.service.PaymentServiceImpl;
import com.tp.yogioteur.service.RoomService;
import com.tp.yogioteur.service.RoomServiceImpl;
import com.tp.yogioteur.service.VilageFcstInfoService;

@Configuration
public class ServiceConfig {
	
	@Bean
	public MemberService memberService() {
		return new MemberServiceImpl();
	}
	@Bean
	public RoomService roomService() {
		return new RoomServiceImpl();
	}
	@Bean
	public OpenAPIService openAPIService() {
		return new VilageFcstInfoService();
	}
	@Bean
	public PaymentService paymentService() {
		return new PaymentServiceImpl();
	}
	
}
