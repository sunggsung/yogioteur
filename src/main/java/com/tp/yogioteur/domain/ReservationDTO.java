package com.tp.yogioteur.domain;

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
	private String reserCheckIn;
	private String reserCheckOut;
	private Integer reserStatus;
	private Integer reserPeople;
	private Integer reserFood;
	private String reserRequest;
}
