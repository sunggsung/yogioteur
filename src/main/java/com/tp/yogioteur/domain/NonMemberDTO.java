package com.tp.yogioteur.domain;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class NonMemberDTO {
	private Long nonNo;
	private Long nonReserNo;
	private String nonPhone;
	private String nonName;
}
