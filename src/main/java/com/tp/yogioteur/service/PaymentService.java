package com.tp.yogioteur.service;

import java.io.IOException;
import java.util.Map;

import com.tp.yogioteur.domain.PaymentDTO;

public interface PaymentService {

	public String getToken() throws IOException;
	int paymentInfoF(String imp_uid, String access_token) throws IOException;
	public void paymentCancle(String merchant_uid, String access_token, int amount, String reason) throws IOException;
	
	int paymentInfo(String merchant_uid, String access_token) throws IOException;
	public Map<String, Object> paymentSave(PaymentDTO payment);
	public String paymentSearch(String resNo);
}
