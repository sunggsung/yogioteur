package com.tp.yogioteur.interceptor;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

public class NonMemberInterceptor implements HandlerInterceptor {
	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		
		HttpSession session = request.getSession();
		if(session.getAttribute("nonMember") != null) {
			session.removeAttribute("nonMember");
		}
		
		return true;
	}
	
	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
			ModelAndView modelAndView) throws Exception {
		
		Map<String, Object> map = modelAndView.getModel();
		Object nonMember = map.get("nonMember");
		Object url = map.get("url");
		
		if(nonMember != null) {
			HttpSession session = request.getSession();
			session.setAttribute("nonMember", nonMember);
			
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