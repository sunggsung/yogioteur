package com.tp.yogioteur.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;

import com.tp.yogioteur.service.PaymentService;
import com.tp.yogioteur.service.ReservationService;
import com.tp.yogioteur.service.RoomService;

@Controller
public class ReservationController {

	@Autowired
	private ReservationService reservationService;
	
	@Autowired
	private PaymentService paymentService;
	
	@Autowired
	private RoomService roomService;
	
	@PostMapping("reservation/reservationPage")
	public String reservationPage(HttpServletRequest request, Model model) throws IOException {

		reservationService.reserToken(request, model);
		
		Map<String, Object> roomInfo = new HashMap<>();
		roomInfo.put("chkIn", request.getParameter("chkIn"));
		roomInfo.put("chkOut", request.getParameter("chkOut"));
		roomInfo.put("roomNo", request.getParameter("roomNo"));
		roomInfo.put("roomName", request.getParameter("roomName"));
		roomInfo.put("roomPrice", request.getParameter("roomPr"));
		
		model.addAttribute("roomInfo", roomInfo);
		
		System.out.println(roomInfo);
		
		String token = paymentService.getToken();
		System.out.println(token);
		
		return "reservation/reservationPage";
	}
	
	@GetMapping("reservation/reservationConfirm")
	public String reservationConfirm(HttpServletRequest request, Model model) {
		reservationService.confirms(request, model);
		return "reservation/reservationConfirm";
	}
	
	@PostMapping("/payments")
	public void payments(HttpServletRequest request, HttpServletResponse response) {
		reservationService.payments(request, response);
	}
	
	@GetMapping("/reservation/reservationCancel")
	public String reservationCancel(@PathVariable String reserNo) {
		
		return "reservation/reservationCancel";
	}
	
	
}
