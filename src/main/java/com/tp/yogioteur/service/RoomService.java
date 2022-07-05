package com.tp.yogioteur.service;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.http.ResponseEntity;
import org.springframework.ui.Model;

import com.tp.yogioteur.domain.RoomDTO;

public interface RoomService {
	
	//checkIn,out 데이터 보내기
	

	//객실 조회
	public List<RoomDTO> roomList(HttpServletRequest request);
	//객실 이미지
	public ResponseEntity<byte[]> view(Long roomNo, String type);
	
	/*
	 * //객실 상세 이미지 public ResponseEntity<byte[]> detailView(Long roomNo, String
	 * type);
	 */
	
	//객실 상세
	public void findRoomTypeByNo(HttpServletRequest request, Model model);
	
	
}
