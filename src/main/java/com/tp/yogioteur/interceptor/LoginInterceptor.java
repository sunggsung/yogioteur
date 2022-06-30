package com.tp.yogioteur.interceptor;

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
		
		HttpSession session = request.getSession();
		if(session.getAttribute("loginMember") != null) {
			session.removeAttribute("loginMember");
		}
		
		String memberId = SecurityUtils.xss(request.getParameter("memberId"));
		
		SignOutMemberDTO member = memberService.findSignOutMember(memberId);
		if(member != null) {
			request.setAttribute("member", member);
			request.getRequestDispatcher("/member/reSignInPage").forward(request, response);
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
