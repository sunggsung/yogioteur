package com.tp.yogioteur.service;

import java.io.PrintWriter;
import java.util.HashMap;
import java.util.Map;
import java.util.Optional;
import java.util.Properties;

import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.tp.yogioteur.domain.MemberDTO;
import com.tp.yogioteur.domain.SignOutMemberDTO;
import com.tp.yogioteur.mapper.MemberMapper;
import com.tp.yogioteur.util.SecurityUtils;

@Service
public class MemberServiceImpl implements MemberService {

	@Autowired
	private MemberMapper memberMapper;
	
	@Override
	public Map<String, Object> idCheck(String memberId) {
		Map<String, Object> map = new HashMap<>();
		map.put("res", memberMapper.selectMemberById(memberId));
		return map;
	}
	
	
	// 인증코드 발송
	@Override
	public Map<String, Object> sendAuthCode(String memberEmail) {
		String authCode = SecurityUtils.authCode(6);  
		System.out.println(authCode);
		
		Properties props = new Properties();
		props.put("mail.smtp.host", "smtp.gmail.com"); 
		props.put("mail.smtp.port", "587");            
		props.put("mail.smtp.auth", "true");           
		props.put("mail.smtp.starttls.enable", "true"); 
		

		final String USERNAME = "forspringlec@gmail.com";
		final String PASSWORD = "ukpiajijxfirdgcz";     
		

		Session session = Session.getInstance(props, new Authenticator() {
			@Override
			protected PasswordAuthentication getPasswordAuthentication() {
				return new PasswordAuthentication(USERNAME, PASSWORD);
			}
		});
		
		try {
			
			Message message = new MimeMessage(session);
			
			message.setHeader("Content-Type", "text/plain; charset=UTF-8");
			message.setFrom(new InternetAddress(USERNAME, "인증코드관리자"));
			message.setRecipient(Message.RecipientType.TO, new InternetAddress(memberEmail));
			message.setSubject("인증 요청 메일입니다.");
			message.setText("인증번호는 " + authCode + "입니다.");
			
			Transport.send(message);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		Map<String, Object> map = new HashMap<>();
		map.put("authCode", authCode);
		return map;
	}
	
	@Override
	public Map<String, Object> emailCheck(String memberEmail) {
		
		Map<String, Object> map = new HashMap<>();
		map.put("res", memberMapper.selectMemberByEmail(memberEmail));
		return map;
	}
	
	@Override
	public void signIn(HttpServletRequest request, HttpServletResponse response) {
		String memberId = SecurityUtils.xss(request.getParameter("memberId"));        
		String memberPw = SecurityUtils.sha256(request.getParameter("memberPw"));    
		String memberName = SecurityUtils.xss(request.getParameter("memberName"));   
		String memberPhone =request.getParameter("memberPhone");    
		String memberBirth = request.getParameter("memberBirth");   
		String memberGender = request.getParameter("memberGender");
		String memberPostCode = request.getParameter("memberPostCode");
		String memberRoadAddr = request.getParameter("memberRoadAddr");
		String memberEmail = SecurityUtils.xss(request.getParameter("memberEmail")); 
		String memberPromoAdd = request.getParameter("memberPromoAdd");
		String info = request.getParameter("info");
		String event = request.getParameter("event");
		int agreeState = 1;  
		if(info.equals("info") && event.equals("event")) {
			agreeState = 4; 
		} else if(info.equals("info") && event.isEmpty()) {
			agreeState = 2;  
		} else if(info.isEmpty() && event.equals("event")) {
			agreeState = 3;  
		}
		
		MemberDTO member = MemberDTO.builder()
				.memberId(memberId)
				.memberPw(memberPw)
				.memberName(memberName)
				.memberPhone(memberPhone)
				.memberBirth(memberBirth)
				.memberPromoAdd(memberPhone)
				.memberGender(memberGender)
				.memberPostCode(memberPostCode)
				.memberRoadAddr(memberRoadAddr)
				.memberEmail(memberEmail)
				.memberPromoAdd(memberPromoAdd)
				.agreeState(agreeState)
				.build();

		int res = memberMapper.insertMember(member);
		
		try {
			response.setContentType("text/html");
			PrintWriter out = response.getWriter();
			if(res == 1) {
				out.println("<script>");
				out.println("alert('회원 가입이 완료되었습니다.')");
				out.println("location.href='" + request.getContextPath() + "'");
				out.println("</script>");
				out.close();
			} else {
				out.println("<script>");
				out.println("alert('회원 가입에 실패했습니다.')");
				out.println("history.back()");
				out.println("</script>");
				out.close();
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		
	}
	
	

	@Override
	public MemberDTO login(HttpServletRequest request) {
		String memberId = SecurityUtils.xss(request.getParameter("memberId"));        
		String memberPw = SecurityUtils.sha256(request.getParameter("memberPw"));
		
		MemberDTO member = new MemberDTO();
		member.setMemberId(memberId);
		member.setMemberPw(memberPw);
		
		MemberDTO loginMember= memberMapper.selectMemberByIdPw(member);
		if(loginMember != null) {
			memberMapper.insertMemberLog(memberId);
		}
		return loginMember;
	}
	

	
	// 아이디찾기
	@Override
	public MemberDTO findId(HttpServletRequest request) {
		
		String memberName = SecurityUtils.xss(request.getParameter("memberName")); 
		String memberEmail = SecurityUtils.xss(request.getParameter("memberEmail"));
		MemberDTO member = MemberDTO.builder()
				.memberName(memberName)
				.memberEmail(memberEmail)
				.build();
		MemberDTO memberConfirm = memberMapper.findMemberByNameEmail(member);
		
		return memberConfirm;
	}

	
	@Override
	public Map<String, Object> idEmailCheck(MemberDTO member) {
		Map<String, Object> map = new HashMap<>();
		map.put("findMember", memberMapper.selectMemberByIdEmail(member));
		return map;
	}
	
	@Override
	public void changePw(HttpServletRequest request, HttpServletResponse response) {
		String memberId = SecurityUtils.xss(request.getParameter("memberId"));
		String memberPw = SecurityUtils.sha256(request.getParameter("memberPw"));
		
		MemberDTO member = MemberDTO.builder()
				.memberId(memberId)
				.memberPw(memberPw)
				.build();
		
		int res = memberMapper.updatePw(member);
		
		try {
			response.setContentType("text/html");
			PrintWriter out = response.getWriter();
			if(res == 1) {
				out.println("<script>");
				out.println("alert('비밀번호가 수정되었습니다.')");
				out.println("location.href='" + request.getContextPath() + "/'");
				out.println("</script>");
				out.close();
			} else {
				out.println("<script>");
				out.println("alert('비밀번호가 수정되지 않았습니다.')");
				out.println("history.back()");
				out.println("</script>");
				out.close();
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		
	}
	
	// 회원정보
	@Override
	public MemberDTO memberCheck(String memberId) {
		return memberMapper.selectMemberById(memberId);
	}
	
	// 회원정보 수정
	@Override
	public void changeMember(HttpServletRequest request, HttpServletResponse response) {

		String memberId = SecurityUtils.xss(request.getParameter("memberId"));        
		String memberName = request.getParameter("memberName");   
		String memberPhone =request.getParameter("memberPhone");    
		String memberBirth = request.getParameter("memberBirth");   
		String memberGender = request.getParameter("memberGender");
		String memberPostCode = request.getParameter("memberPostCode");
		String memberRoadAddr = request.getParameter("memberRoadAddr");
		String memberEmail = SecurityUtils.xss(request.getParameter("memberEmail")); 
		String memberPromoAdd = request.getParameter("memberPromoAdd");
		
		MemberDTO member = MemberDTO.builder()
				.memberId(memberId)
				.memberName(memberName)
				.memberBirth(memberBirth)
				.memberPhone(memberPhone)
				.memberPostCode(memberPostCode)
				.memberRoadAddr(memberRoadAddr)
				.memberGender(memberGender)
				.memberEmail(memberEmail)
				.memberPromoAdd(memberPromoAdd)
				.build();
		
		int res = memberMapper.updateMember(member);
		try {
			response.setContentType("text/html; charset=UTF-8");
			HttpSession session = request.getSession();
			session.setAttribute("loginMember", member);
			PrintWriter out = response.getWriter();
			if(res > 0) {
				out.println("<script>");
				out.println("alert('정상적으로 수정되었습니다.')");
				out.println("location.href='"+ request.getContextPath() + "/member/memberPage'");		
				out.println("</script>");
				out.close();
			} else {
				out.println("<script>");
				out.println("alert('수정에 실패했습니다.')");
				out.println("history.back()");		
				out.println("</script>");
				out.close();
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		
	}

	// 탈퇴
	@Override
	public void signOut(HttpServletRequest request, HttpServletResponse response) {
		
		String memberId = request.getParameter("memberId");
		int res = memberMapper.removeMember(memberId);

		try {
			response.setContentType("text/html");
			PrintWriter out = response.getWriter();
			if(res == 1 ) {
				request.getSession().invalidate();									
				out.println("<script>");
				out.println("alert('탈퇴되었습니다.')");
				out.println("location.href='" + request.getContextPath() + "'");	
				out.println("</script>");
				out.close();
			} else {
				out.println("<script>");
				out.println("alert('탈퇴에 실패했습니다.')");
				out.println("history.back()");
				out.println("</script>");
				out.close();
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		
	}
	
	// 탈퇴확인
	@Override
	public SignOutMemberDTO findSignOutMember(String memberId) {
		return memberMapper.selectSignOutMemberByMemberId(memberId);
	}

	@Override
	public MemberDTO pwCheck(HttpServletRequest request, HttpServletResponse response) {
		String memberId = SecurityUtils.xss(request.getParameter("memberId"));        
		String memberPw = SecurityUtils.sha256(request.getParameter("memberPw"));    

		MemberDTO member = new MemberDTO();
		member.setMemberId(memberId);
		member.setMemberPw(memberPw);
		
		MemberDTO memberInfo= memberMapper.selectMemberByIdPw(member);
		
		return memberInfo;
		
	}
	
	
	
}