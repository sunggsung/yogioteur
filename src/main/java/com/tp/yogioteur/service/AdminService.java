package com.tp.yogioteur.service;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.http.ResponseEntity;
import org.springframework.ui.Model;
import org.springframework.web.multipart.MultipartHttpServletRequest;

public interface AdminService {

	public void saveRoom(MultipartHttpServletRequest request, HttpServletResponse response);
	public void findRooms(HttpServletRequest request, Model model);
	public void findRoomByNo(HttpServletRequest request, Model model);
	public ResponseEntity<byte[]> display(Long imageNo, String type);
	public void removeRoom(HttpServletRequest request, HttpServletResponse response);
	public void changeRoom(MultipartHttpServletRequest request, HttpServletResponse response);
	public Map<String, Object> findRoomByStatus(int roomStatus);
	
	public void findMembers(HttpServletRequest request, Model model);
	public void findMemberByNo(HttpServletRequest request, Model model);
	
	public Map<String, Object> findReservations();
	public Map<String, Object> findReservationByMemberNo(HttpServletRequest request, Model model);
	public Model findReservationByReserNo(HttpServletRequest request, Model model);
	
}
