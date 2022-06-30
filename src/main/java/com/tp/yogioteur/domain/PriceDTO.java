package com.tp.yogioteur.domain;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class PriceDTO {
	
	private String priceNo;
	private Integer totalPrice;
	private Integer roomPrice;
	private Integer foodPrice;
	private Integer tipPrice;
}
