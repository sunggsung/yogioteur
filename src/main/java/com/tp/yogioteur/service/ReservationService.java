package com.tp.yogioteur.service;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.ui.Model;

import com.tp.yogioteur.domain.ReservationDTO;

public interface ReservationService {
	public void payments(HttpServletRequest request, HttpServletResponse response);
	public void confirms(HttpServletRequest request, Model model);
	public void reserList(HttpServletRequest request, Model model);
	public void reserToken(HttpServletRequest request, Model model);
	public void confirmsPopUp(String no, HttpServletRequest request, Model model);
	
	public Map<String, Object> removeReservation(String resNo);
	public Map<String, Object> changeReservation(ReservationDTO reservation, HttpServletResponse response);
}
