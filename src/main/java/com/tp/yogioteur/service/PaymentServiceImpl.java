package com.tp.yogioteur.service;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.net.URL;
import java.util.Map;

import javax.net.ssl.HttpsURLConnection;

import com.google.gson.Gson;
import com.google.gson.JsonObject;

public class PaymentServiceImpl implements PaymentService {

	private String impKey;
	private String impSecret;
	
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
		
		System.out.println("gson:" + gson);
		System.out.println("bw:" + sb.toString());		
		System.out.println("br:" + br.toString());
		System.out.println("conn:" + conn);		
		System.out.println("response:" + response);

		String token = gson.fromJson(response, Map.class).get("access_token").toString();

		br.close();
		conn.disconnect();

		return token;
	}

	@Override
	public int paymentInfo(String imp_uid, String access_token) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public void paymentCancle(String imp_uid, String access_token, String reason) {
		// TODO Auto-generated method stub

	}

}
