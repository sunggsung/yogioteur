package com.tp.yogioteur.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.tp.yogioteur.service.RoomService;

@Controller
public class RoomController {

	@Autowired
	private RoomService roomService;

	// 객실 조회
	@PostMapping("/room/roomList")
	public String roomList(HttpServletRequest request, Model model) {
		 model.addAttribute("roomList", roomService.roomList(request));
		 return "room/roomList";
	}

	// 이미지 보여주기
	@ResponseBody
	@GetMapping("/room/view")
	public ResponseEntity<byte[]> view(Long roomNo,
			@RequestParam(value = "type", required = false, defaultValue = "image") String type) {
		return roomService.view(roomNo, type);
	}
	
	// 객실 상세
	@GetMapping("/room/detail")
	public String detail(HttpServletRequest request, Model model) {
		roomService.findRoomTypeByNo(request, model);
		return "room/detail";
	}
	// 객실 상세 이미지
}

//mv.setViewName("/reservation/reservationPage"); //여긴 아마 roomCheckIn 변수가 없어서 안떳겠지
//일단저기 서비스에서 페이지 조정하고 이러면안도
// 저기까지해서 데이터 처리하는 부분이라 데이터 전처리만 하고
// 요기 controller에서 페이지랑 파라미터 보내는게 정석이라
// 일단 최대한 단계를 분리해서 개발하세용
// 그렇구먼,,,, 다른 소스찾아서 최대한 가독성잇게 쓰는게 좋아
