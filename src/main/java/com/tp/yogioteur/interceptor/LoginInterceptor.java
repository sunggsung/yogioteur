package com.tp.yogioteur.interceptor;

import java.io.PrintWriter;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import com.tp.yogioteur.domain.SignOutMemberDTO;
import com.tp.yogioteur.service.MemberService;
import com.tp.yogioteur.util.SecurityUtils;

public class LoginInterceptor implements HandlerInterceptor {
	
	@Autowired
	private MemberService memberService;
	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		
		String memberId = SecurityUtils.xss(request.getParameter("memberId"));
		
		// 탈퇴한 회원
		SignOutMemberDTO member = memberService.findSignOutMember(memberId);
		if(member != null) {
			response.setContentType("text/html");
			PrintWriter out = response.getWriter();
			out.println("<script>");
			out.println("alert('탈퇴된 회원입니다.')");
			out.println("location.href='" + request.getContextPath() + "'");
			out.println("</script>");
			return false;
		}
		return true;
	}
	
	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
			ModelAndView modelAndView) throws Exception {
		
		Map<String, Object> map = modelAndView.getModel();
		Object loginMember = map.get("loginMember");
		Object url = map.get("url");
		
		if(loginMember != null) {
			HttpSession session = request.getSession();
			session.setAttribute("loginMember", loginMember);
			
			if(url.toString().isEmpty()) {		
				response.sendRedirect(request.getContextPath());
			} else {							
				response.sendRedirect(url.toString());
			}
		} 
		else {
			if(url.toString().isEmpty()) {		
				response.sendRedirect(request.getContextPath() + "/member/loginPage");	
			} else {
				response.sendRedirect(request.getContextPath() + "/member/loginPage?url=" + url.toString());									
			}
		}
	}
}