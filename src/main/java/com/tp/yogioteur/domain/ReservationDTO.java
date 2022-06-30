package com.tp.yogioteur.domain;

import java.sql.Date;

import com.fasterxml.jackson.annotation.JsonFormat;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class ReservationDTO {

	private String reserNo;
	private Long memberNo;
	private Long roomNo;
	private Long nonNo;
	// ajax에서 date 형식으로 만들기 위해 사용
	@JsonFormat(pattern = "yyyy-MM-dd")
	private Date reserCheckin;
	
	@JsonFormat(pattern = "yyyy-MM-dd")
	private Date reserCheckout;
	
	private Integer reserStatus;
	private Integer reserPeople;
	private Integer reserFood;
	private String reserRequest;
}
