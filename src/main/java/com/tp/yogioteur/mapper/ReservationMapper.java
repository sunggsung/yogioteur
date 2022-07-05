package com.tp.yogioteur.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.tp.yogioteur.domain.PaymentDTO;
import com.tp.yogioteur.domain.PriceDTO;
import com.tp.yogioteur.domain.ReservationDTO;
import com.tp.yogioteur.domain.RoomDTO;

@Mapper
public interface ReservationMapper {
	
	public int reservationInsert(ReservationDTO reservation);
	public List<ReservationDTO> reservationSelect(); 
	public ReservationDTO reservationSelectConfirm(String reserNo);
	public List<ReservationDTO> reservationMemberSelectConfirm(Long memberNo);
	public int priceInsert(PriceDTO price);	
	public PriceDTO priceSelectConfirm(String priceNo);
	public RoomDTO reservationRoomSelectConfirm(Long roomNo); 
	
	public int deleteReservation(String resNo);
	public int updateReservation(ReservationDTO reservation);
	public int deletePayments(String resNo);
	public int deletePrice(String resNo);
	public int paymentInsert(PaymentDTO payment);
	public PaymentDTO paymentSelectByNo(String resNo);
}
