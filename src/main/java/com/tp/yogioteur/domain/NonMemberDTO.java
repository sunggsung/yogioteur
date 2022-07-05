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
	private String nonId;
	private String nonName;
	private String nonPhone;
	private String nonBirth;
}
