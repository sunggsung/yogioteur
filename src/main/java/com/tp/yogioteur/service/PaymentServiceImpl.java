package com.tp.yogioteur.service;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.net.URL;
import java.util.HashMap;
import java.util.Map;

import javax.net.ssl.HttpsURLConnection;

import org.springframework.beans.factory.annotation.Autowired;

import com.google.gson.Gson;
import com.google.gson.JsonObject;
import com.tp.yogioteur.domain.PaymentDTO;
import com.tp.yogioteur.mapper.ReservationMapper;

import lombok.Getter;
import lombok.ToString;

public class PaymentServiceImpl implements PaymentService {

	@Autowired
	private ReservationMapper reservationMapper;
	
	private String impKey;
	private String impSecret;
	
	@ToString
	@Getter
	private class Response {
		private PaymentDTO response;
	}
	
	@Override
	public String getToken() throws IOException {

		impKey = "7140511320678943";
		impSecret = "42e46de3df99d9bd75fe41be430ebb931cd7871a70ba5f48719a9a5bfa48ad0a6065599459b64ea6";
		
		HttpsURLConnection conn = null;
		 
		URL url = new URL("https://api.iamport.kr/users/getToken");

		conn = (HttpsURLConnection) url.openConnection();

		conn.setRequestMethod("POST");
		conn.setRequestProperty("Content-type", "application/json");
		conn.setRequestProperty("Accept", "application/json");
		conn.setDoOutput(true);
		JsonObject json = new JsonObject();

		json.addProperty("imp_key", impKey);
		json.addProperty("imp_secret", impSecret);
		
		BufferedWriter bw = new BufferedWriter(new OutputStreamWriter(conn.getOutputStream()));
		
		bw.write(json.toString());
		bw.flush();
		bw.close();
		
		BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream(), "UTF-8"));

		Gson gson = new Gson();

		String response = gson.fromJson(br.readLine(), Map.class).get("response").toString();
		
		StringBuilder sb = new StringBuilder();
		sb.append(bw);
		
//		System.out.println("gson:" + gson);
//		System.out.println("bw:" + sb.toString());		
//		System.out.println("br:" + br.toString());
//		System.out.println("conn:" + conn);		
//		System.out.println("response:" + response);

		String token = gson.fromJson(response, Map.class).get("access_token").toString();

		br.close();
		conn.disconnect();

		return token;
	}
	
	@Override
	public Map<String, Object> paymentSave(PaymentDTO payment) {
		Map<String, Object> map = new HashMap<>();
		map.put("res", reservationMapper.paymentInsert(payment));
		return map;
	}
	
	@Override
	public String paymentSearch(String resNo) {
		System.out.println(resNo);
		
		PaymentDTO payment = reservationMapper.paymentSelectByNo(resNo);
		
		return payment.getImpUid();
	}

	@Override
	public int paymentInfoF(String imp_uid, String access_token) throws IOException {
		HttpsURLConnection conn = null;
		 
	    URL url = new URL("https://api.iamport.kr/payments/" + imp_uid);
	 
	    conn = (HttpsURLConnection) url.openConnection();
	 
	    conn.setRequestMethod("GET");
	    conn.setRequestProperty("Authorization", access_token);
	    conn.setDoOutput(true);
	 
	    BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream(), "utf-8"));
	    
	    Gson gson = new Gson();
	    
	    Response response = gson.fromJson(br.readLine(), Response.class);
	    
	    br.close();
	    conn.disconnect();
	    
	    return response.getResponse().getAmount();
	}
	
	@Override
	public int paymentInfo(String merchant_uid, String access_token) throws IOException {
		HttpsURLConnection conn = null;
		 
	    URL url = new URL("https://api.iamport.kr/payments/" + merchant_uid);
	 
	    conn = (HttpsURLConnection) url.openConnection();
	 
	    conn.setRequestMethod("GET");
	    conn.setRequestProperty("Authorization", access_token);
	    conn.setDoOutput(true);
	 
	    BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream(), "utf-8"));
	    
	    Gson gson = new Gson();
	    
	    Response response = gson.fromJson(br.readLine(), Response.class);
	    
	    br.close();
	    conn.disconnect();
	    
	    return response.getResponse().getAmount();
	}

	@Override
	public void paymentCancle(String merchant_uid, String access_token, int amount, String reason) throws IOException {
		System.out.println("결제 취소");
		
		System.out.println(access_token);
		
		System.out.println(merchant_uid);
		
		HttpsURLConnection conn = null;
		URL url = new URL("https://api.iamport.kr/payments/cancel");
 
		conn = (HttpsURLConnection) url.openConnection();
 
		conn.setRequestMethod("POST");
 
		conn.setRequestProperty("Content-type", "application/json");
		conn.setRequestProperty("Accept", "application/json");
		conn.setRequestProperty("Authorization", access_token);
 
		conn.setDoOutput(true);
		
		JsonObject json = new JsonObject();
 
		json.addProperty("reason", reason);
		json.addProperty("merchant_uid", merchant_uid);
		json.addProperty("amount", amount);
 
		BufferedWriter bw = new BufferedWriter(new OutputStreamWriter(conn.getOutputStream()));
 
		bw.write(json.toString());
		bw.flush();
		bw.close();
		
		BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream(), "utf-8"));
 
		br.close();
		conn.disconnect();

	}

}
