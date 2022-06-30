package com.tp.yogioteur.service;

import java.io.PrintWriter;
import java.util.List;
import java.util.Optional;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import com.tp.yogioteur.domain.MemberDTO;
import com.tp.yogioteur.domain.PriceDTO;
import com.tp.yogioteur.domain.ReservationDTO;
import com.tp.yogioteur.mapper.ReservationMapper;
import com.tp.yogioteur.util.ReservationUtils;

@Service
public class ReservationServiceImpl implements ReservationService {

	@Autowired
	private ReservationMapper reservationMapper;
	
	
	
	@Override
	public void reserToken(HttpServletRequest request, Model model) {
		String no = ReservationUtils.reservataionCode(8).trim();
		String reserNo = "RN_" + no;
		System.out.println(reserNo);
		model.addAttribute("reserNo", reserNo);
	}
	
	@Override
	public void payments(HttpServletRequest request, HttpServletResponse response) {
		
		String reserNo = request.getParameter("resReserNo").trim();
		Long memberNo = Long.parseLong(request.getParameter("resMemberNo"));
		Long roomNo = Long.parseLong(request.getParameter("resRoomNo"));
		Long nonNo = 1L;
		Optional<String> optNo = Optional.ofNullable(request.getParameter("food"));
		Integer food = Integer.parseInt(optNo.orElse("0"));
		Integer adult = Integer.parseInt(request.getParameter("adult"));
		Integer child = Integer.parseInt(request.getParameter("child"));
		Integer status = 1; // 예약성공
		Optional<String> opt = Optional.ofNullable(request.getParameter("req"));
		String req = opt.orElse("요청 사항 없음");
		
		Integer people = adult + child;
		System.out.println(reserNo);
		
		ReservationDTO reservation = ReservationDTO.builder()
				.reserNo(reserNo)
				.memberNo(memberNo)
				.roomNo(roomNo)
				.nonNo(nonNo)
				.reserFood(food)
				.reserPeople(people)
				.reserStatus(status)
				.reserRequest(req)
				.build();
		
		int res = reservationMapper.reservationInsert(reservation);
		
		Integer totalPr = Integer.parseInt(request.getParameter("totalPrice"));
		Integer roomPr = Integer.parseInt(request.getParameter("roomPrice"));
		Integer foodPr = Integer.parseInt(request.getParameter("foodPrice"));
		Integer tipPr = Integer.parseInt(request.getParameter("tipPrice"));
		
		PriceDTO price = PriceDTO.builder()
				.priceNo(reserNo)
				.totalPrice(totalPr)
				.roomPrice(roomPr)
				.foodPrice(foodPr)
				.tipPrice(tipPr)
				.build();
		
		int pri = reservationMapper.priceInsert(price);
		
		try {
			response.setContentType("text/html");
			PrintWriter out = response.getWriter();
			if(res == 1) {
				out.println("<script>");
				out.println("alert('결제 완료 되었습니다.')");
				out.println("location.href='" + request.getContextPath() + "/reservation/reservationConfirm?reserNo=" + reserNo + "'");
				out.println("</script>");
				out.close();
			} else {
				out.println("<script>");
				out.println("alert('결제가 실패했습니다.')");
				out.println("history.back()");
				out.println("</script>");
				out.close();
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	@Override
	public void confirms(HttpServletRequest request, Model model) {		
		String no = request.getParameter("reserNo");
		
		model.addAttribute("reservation", reservationMapper.reservationSelectConfirm(no));
		model.addAttribute("money", reservationMapper.priceSelectConfirm(no));
		
//		System.out.println(reservationMapper.reservationSelectConfirm(no));
//		System.out.println(reservationMapper.priceSelectConfirm(no));
	}
	
	@Override
	public void reserList(HttpServletRequest request, Model model) {
		HttpSession session = request.getSession(); //
		MemberDTO member = (MemberDTO) session.getAttribute("loginMember"); //
		Long no = member.getMemberNo();
		
		List<ReservationDTO> resers = reservationMapper.reservationMemberSelectConfirm(no);
		
		model.addAttribute("reservations", resers);
	}
}
