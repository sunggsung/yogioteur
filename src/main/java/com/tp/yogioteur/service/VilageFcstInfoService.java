package com.tp.yogioteur.service;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;
import java.net.URLEncoder;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

// 날씨 정보 api(단기 예보)
public class VilageFcstInfoService implements OpenAPIService {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws IOException {
		
		String serviceKey = "Gg6aU7XS52H2mzg7fE0rsB6EskbUYaEGIq+cUukglRDit4bDX4sXDnbnUXBXRmGgh+VLkmq6M8hF/4f7eANimQ==";
		
		// API 주소
		StringBuilder sb = new StringBuilder();
		try {
			sb.append("http://apis.data.go.kr/1360000/VilageFcstInfoService_2.0/getVilageFcst");
			sb.append("?serviceKey=").append(URLEncoder.encode(serviceKey, "UTF-8"));
			sb.append("&numOfRows=").append(URLEncoder.encode("14", "UTF-8"));
			sb.append("&pageNo=").append(URLEncoder.encode("1", "UTF-8"));
			sb.append("&dataType=").append(URLEncoder.encode("JSON", "UTF-8"));
			sb.append("&base_date=").append(URLEncoder.encode("20220627", "UTF-8"));
			sb.append("&base_time=").append(URLEncoder.encode("1400", "UTF-8"));
			sb.append("&nx=").append(URLEncoder.encode("59", "UTF-8"));
			sb.append("&ny=").append(URLEncoder.encode("38", "UTF-8"));
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
				
		String apiURL = sb.toString();	

		// API 주소 연결
		URL url = null;
		HttpURLConnection con = null;
		try {
			url = new URL(apiURL);
			con = (HttpURLConnection)url.openConnection();
			con.setRequestMethod("GET");
			con.setRequestProperty("Content-Type", "application/json; charset=UTF-8");
		} catch (MalformedURLException e) {
			e.printStackTrace();  // apiURL이 잘못되었다.
		} catch (IOException e) {
			e.printStackTrace();  // API 연결이 실패하였다.
		}
		
		BufferedReader br = null;
		StringBuilder sb2 = new StringBuilder();
		try {
			if(con.getResponseCode() == HttpURLConnection.HTTP_OK) {
				br = new BufferedReader(new InputStreamReader(con.getInputStream()));
			} else {
				br = new BufferedReader(new InputStreamReader(con.getErrorStream()));
			}
			// json 읽어 들이기
			String line = null;
			while((line = br.readLine()) != null) {
				sb2.append(line);
			}
			// 스트림, 연결 종료
			if(br != null) {
				br.close();
			}
			if(con != null) {
				con.disconnect();
			}
		} catch (IOException e) {
			e.printStackTrace();  // API 응답이 실패하였다.
		}
		
		response.setContentType("application/json; charset=UTF-8");
		PrintWriter out = response.getWriter();
		System.out.println(sb2.toString());
		out.write(sb2.toString());
		out.flush();
		out.close();
	}

}
