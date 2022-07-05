package com.tp.yogioteur.controller;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.tp.yogioteur.domain.MemberDTO;
import com.tp.yogioteur.service.MemberService;
import com.tp.yogioteur.service.ReservationService;

@Controller
public class MemberController {
	
	// 회원가입
	@Autowired
	private MemberService memberService;
	
	@Autowired
	private ReservationService reservationService;
	
	@GetMapping("/member/agreePage")
	public String agreePage() {
		return "member/agree";
	}
	
	@GetMapping("/member/signInPage")
	public String signInPage(@RequestParam(required=false) String[] agreements, Model model) {
		model.addAttribute("agreements", agreements);
		return "member/signIn";
	}
	
	@ResponseBody
	@GetMapping(value="/member/idCheck", produces="application/json")
	public Map<String, Object> idCheck(@RequestParam String memberId) {
		return memberService.idCheck(memberId);
	}
	
	
	@ResponseBody
	@GetMapping(value="/member/sendAuthCode", produces="application/json")
	public Map<String, Object> sendAuthCode(@RequestParam String memberEmail){
		return memberService.sendAuthCode(memberEmail);
	}
	
	@ResponseBody
	@GetMapping(value="/member/emailCheck", produces="application/json")
	public Map<String, Object> emailCheck(@RequestParam String memberEmail){
		return memberService.emailCheck(memberEmail);
	}

	@PostMapping("/member/signIn")
	public void signIn(HttpServletRequest request, HttpServletResponse response) {
		memberService.signIn(request, response);
	}
	

	// 네이버 로그인
	// 로그인 화면 열기
	@GetMapping(value="/member/loginPage")
	public String loginPage(HttpServletRequest request, Model model) {
		model.addAttribute("url", request.getParameter("url"));
		memberService.loginPage(request, model);
		return "member/login";
	}
	
	@GetMapping(value="/member/naver/login")  // 네이버로그인 버튼을 클릭하면 code, state를 받아오는 callback url
	public String naverLogin(HttpServletRequest request, HttpServletResponse response, Model model) {
		String token = memberService.getAccessToken(request, response);
		MemberDTO loginMember = memberService.getMemberProfile(request, response, token);
		if(loginMember != null) {
			model.addAttribute("loginMember", loginMember);
		} 
		return "mainPage";
	}

	// 기존 로그인
	@PostMapping("/member/login")
	public void login(HttpServletRequest request, Model model) {
		MemberDTO loginMember = memberService.login(request);
		if(loginMember != null) {
			model.addAttribute("loginMember", loginMember);
		} 
		model.addAttribute("url", request.getParameter("url"));
	}
	
	// 로그아웃
	@GetMapping("/member/logout")
	public String logout(HttpSession session, HttpServletResponse response) { 
		MemberDTO loginMember = (MemberDTO) session.getAttribute("loginMember");	
		if (loginMember != null) {
				session.invalidate(); 
		}
		return "redirect:/";
	}
	
	
	// 아이디찾기
	@GetMapping("/member/findIdPage")
	public String findIdPage() {
		return "member/findId";
	}
	
	@PostMapping("/member/findId")
	public String findId(HttpServletRequest request, Model model) {
		model.addAttribute("memberConfirm", memberService.findId(request));
		return "member/findIdResult";
	}
	

	
	// 비밀번호찾기
	@GetMapping("/member/findPwPage")
	public String findPwPage() {
		return "member/findPw";
	}
	
	@ResponseBody
	@GetMapping("/member/idEmailCheck")
	public Map<String, Object> idEmailCheck(MemberDTO member) {
		return memberService.idEmailCheck(member);
	}
	
	@ResponseBody
	@PostMapping(value = "/member/findPw")
	public void findPw(HttpServletRequest request, HttpServletResponse response){
		memberService.changePw(request, response);
	}
	
	// 회원 탈퇴 본인인증
	@GetMapping("/member/confirm")
	public String confirm() {
		return "member/confirmMember";
	}
	
	// 회원 탈퇴
	@GetMapping("/member/signOut")
	public void signOut(HttpServletRequest request, HttpServletResponse response) {
		memberService.signOut(request, response);
	}
	
	// 회원탈퇴 조회
	@PostMapping("/member/reSignInPage")
	public String resignInPage() {
		return "member/reSignIn";
	}
	
	// 회원 정보
	@GetMapping("/member/memberPage")
	public String memberPage(){
		return "member/memberInfo";
	}
	@GetMapping("/member/memberInfo")
	public String memberInfo(){
		return "member/memberInfo";
	}
	
	// 회원 수정
	@PostMapping("/member/modifyMember")
	public void modifyMember(HttpServletRequest request, HttpServletResponse response){
		memberService.changeMember(request, response);
	}
	
	
	// 비밀번호 재설정 페이지 이동
	@GetMapping(value = "/member/modifyPwPage")
	public String modifyPwPage() {
		return "member/modifyPw";
	}
	//회원비밀번호 재설정
	@PostMapping("/member/modifyPw")
	public void modifyPw(HttpServletRequest request, HttpServletResponse response) {
		memberService.changePw(request, response);
	}
	
	//예약내역
	@GetMapping("/member/confirmReserPage")
	public String confirmReserPage(HttpServletRequest request, Model model) {
		reservationService.reserList(request, model);
		return "member/confirmReser";
	}
	
//	// 문의내역(qna)
//	@GetMapping("/member/confirmQnaPage")
//	public String confirmFaqPage() {
//		return "member/confirmQna";
//	}
	
}