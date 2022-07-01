package com.tp.yogioteur.domain;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
@ToString
public class PaymentDTO {

	private String impUid = "";
	private String merchantUid = "";
	private String response;
	private int amount;
}
