package com.tp.yogioteur.service;

import java.io.IOException;

public interface PaymentService {

	public String getToken() throws IOException;
	
	int paymentInfo(String imp_uid, String access_token);
	
	public void paymentCancle(String imp_uid, String access_token, String reason);
}
