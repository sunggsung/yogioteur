package com.tp.yogioteur.controller;

import java.io.IOException;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.tp.yogioteur.service.AdminService;
import com.tp.yogioteur.service.OpenAPIService;

@Controller
public class AdminController {
	
	@Autowired private OpenAPIService openAPIService;
	@Autowired private AdminService adminService;
	
	@GetMapping("/admin/adminPage")
	public String adminPage() {
		return "admin/adminPage";
	}	
	
	@GetMapping("/admin/tourPage")
	public String tourPage() {
		return "admin/tour";
	}
	
	@GetMapping("/admin/tour")
	public void tour(HttpServletRequest request, HttpServletResponse response) throws IOException {
		openAPIService.execute(request, response);
	}
	
	/* 객실 관리 */
	@GetMapping("/admin/addRoomPage")
	public String addRoomPage() {
		return "admin/addRoom";
	}
	
	@GetMapping("/admin/room")
	public String room(HttpServletRequest request, Model model) {
		adminService.findRooms(request, model);
		return "admin/room";
	}
	
	@GetMapping("/admin/roomDetail")
	public String roomDetail(HttpServletRequest request, Model model) {
		adminService.findRoomByNo(request, model);
		return "admin/roomDetail";
	}
	
	@ResponseBody
	@GetMapping("/room/displayImage")
	public ResponseEntity<byte[]> displayImage(Long imageNo, @RequestParam(value = "type", required = false, defaultValue = "image") String type) {
		return adminService.display(imageNo, type);
	}
	
	@PostMapping("/room/saveRoom")
	public void saveRoom(MultipartHttpServletRequest request, HttpServletResponse response) {
		adminService.saveRoom(request, response);
	}
	
	@PostMapping("/room/changeRoom")
	public void changeRoom(MultipartHttpServletRequest request, HttpServletResponse response) {
		adminService.changeRoom(request, response);
	}
	
	@GetMapping("/room/removeRoom")
	public void removeRoom(HttpServletRequest request, HttpServletResponse response) {
		adminService.removeRoom(request, response);
	}
	
	@ResponseBody
	@GetMapping(value = "/admin/findRoomByStatus", produces = "application/json")
	public Map<String, Object> findRoomByStatus(@RequestParam int roomStatus) {
		return adminService.findRoomByStatus(roomStatus);
	}

	/* 회원 관리 */
	@GetMapping("/admin/member")
	public String member(HttpServletRequest request, Model model) {
		adminService.findMembers(request, model);
		return "admin/member";
	}
	
	@GetMapping("/admin/memberDetail")
	public String memberDetail(HttpServletRequest request, Model model) {
		adminService.findMemberByNo(request, model);
		return "admin/memberDetail";
	}
	
	
	/* 예약 관리 */
	@GetMapping("/admin/reservationList")
	public String reservationList(HttpServletRequest request, Model model) {
		return "admin/calendar";
	}
	
	@GetMapping("/admin/reserDetail")
	public String reserDetail(HttpServletRequest request, Model model) {
		adminService.findReservationByReserNo(request, model);
		return "admin/reserDetail";
	}
	
	// calendar.jsp
	@ResponseBody
	@GetMapping(value = "/admin/reserList", produces = "application/json")
	public Map<String, Object> reserList() {
		return adminService.findReservations();
	}
	
	// memberDetail.jsp
	@ResponseBody
	@GetMapping("/admin/memberReserList")
	public Map<String, Object> reservation(HttpServletRequest request, Model model) {
		return adminService.findReservationByMemberNo(request, model);
	}

}
