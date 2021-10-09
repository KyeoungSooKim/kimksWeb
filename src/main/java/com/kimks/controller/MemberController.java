package com.kimks.controller;

import java.util.Date;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.springframework.web.util.WebUtils;

import com.kimks.domain.LoginDTO;
import com.kimks.domain.MemberVO;
import com.kimks.service.MemberService;
import com.kimks.util.SessionConfig;

import lombok.AllArgsConstructor;

@Controller
@RequestMapping("/member/*")
@AllArgsConstructor
public class MemberController {

	private BCryptPasswordEncoder crytPassEnc;
	
	private MemberService service;
	
	//회원가입폼
	@GetMapping("/join")
	public void join() {}
	
	@PostMapping("/join")
	public String joinOk(MemberVO vo, RedirectAttributes rttr) throws Exception{
		vo.setU_pw(crytPassEnc.encode(vo.getU_pw()));//암호화
		service.join(vo);
		rttr.addFlashAttribute("msg", "가입성공");
		return "redirect:/";
	}
	//회원수정 폼
	@GetMapping(value= {"/modify","/mypage"})
	public void modify(HttpSession session, Model model) throws Exception{
		
		String u_id = ((MemberVO)session.getAttribute("loginStatus")).getU_id();
		String u_pw = ((MemberVO)session.getAttribute("loginStatus")).getU_pw();
		
		LoginDTO dto = new LoginDTO();
		dto.setU_id(u_id);
		dto.setU_pw(u_pw);
		
		MemberVO vo = service.login(dto);
		
		model.addAttribute("memberVO", vo);
	}
	//회원수정
	@PostMapping("/modify")
	public String modify(MemberVO vo, RedirectAttributes rttr) throws Exception{

			service.modify(vo);
			rttr.addFlashAttribute("msg", "수정성공");
	
		return "redirect:/member/mypage";
	}
	//회원삭제 비밀번호 입력
	@GetMapping("/deleteConfirm")
	public void deleteConfirm() {
		
	}
	
	//회원삭제
	@PostMapping("/delete")
	public String delete(HttpSession session, @RequestParam("u_pw") String u_pw, RedirectAttributes rttr) throws Exception{
		String u_id = ((MemberVO)session.getAttribute("loginStatus")).getU_id();
		
		LoginDTO dto = new LoginDTO();
		dto.setU_id(u_id);
		
		MemberVO vo = service.login(dto);
		
		String returnUrl = "/member/deleteConfirm";
		
		if(vo != null) {
			if(crytPassEnc.matches(u_pw, vo.getU_pw())) {
				service.delete(dto);
				session.invalidate();
				rttr.addFlashAttribute("msg", "탈퇴성공");
				returnUrl = "/";
			}else {
				//비밀번호 틀림		
				rttr.addFlashAttribute("msg", "탈퇴실패");
			}	
		}
		
		return "redirect:" + returnUrl;
	}
	
	//로그인폼
	@GetMapping("/login")
	public void login() {}

	//로그인
	@PostMapping("/login")
	public String login(LoginDTO dto, HttpSession session, RedirectAttributes rttr, HttpServletResponse res) throws Exception{
		
		MemberVO vo = service.login(dto); //아이디로 회원정보 가져옴
		String returnUrl = "";
		//아이디 존재할경우
		if(vo != null) {//사용자가 입력한 비밀번호, 암호화된 비밀번호 매칭
			if(crytPassEnc.matches(dto.getU_pw(), vo.getU_pw())) {
				returnUrl = "/";
				SessionConfig.getSessionCheck("loginDuplicateStatus", vo.getU_id());
				session.setAttribute("loginStatus", vo);
				session.setAttribute("loginDuplicateStatus", vo.getU_id());
				session.setMaxInactiveInterval(60*30);
				if(dto.isRememberLogin()) { //자동로그인 체크 시 쿠키 작업
					
					Cookie cookie = new Cookie("loginCookie", session.getId());
					cookie.setPath("/"); //모든경로에서 사용
					int time = 60*60*24*3; 
					cookie.setMaxAge(time); //쿠키 유지 기한 3일
					res.addCookie(cookie);
					
					Date u_loginlimit = new Date(System.currentTimeMillis() + time*1000); //현재시간으로부터 3일 후 시간
					service.keepLogin(vo.getU_id(), u_loginlimit, session.getId()); //DB 회원테이블에 쿠키에 설정한 세션ID값과 쿠키 기한 저장
				}
			}else {
				returnUrl = "/member/login";
				rttr.addFlashAttribute("msg", "로그인실패");
			}
		}else {
			returnUrl = "/member/login";
			rttr.addFlashAttribute("msg", "로그인실패");
		}
		
		return "redirect:"+returnUrl;
	}
	//로그아웃
	@GetMapping("/logout")
	public String logOut(HttpSession session, HttpServletRequest request, HttpServletResponse res, RedirectAttributes rttr) {
		
		String u_id = ((MemberVO)session.getAttribute("loginStatus")).getU_id();
		
		Cookie loginCookie = WebUtils.getCookie(request, "loginCookie");
		
		if(loginCookie !=null) {
			loginCookie.setPath("/");
			loginCookie.setMaxAge(0);
			res.addCookie(loginCookie);
			Date loginlimit = new Date(System.currentTimeMillis());
			service.keepLogin(u_id, loginlimit, session.getId());
		}

		session.invalidate();
		
		rttr.addFlashAttribute("msg", "로그아웃");
		return "redirect:/";
	}
	//중복체크
	@ResponseBody
	@PostMapping("/idCheck")
	public ResponseEntity<String> idCheck(@RequestParam("u_id") String u_id) throws Exception{
		ResponseEntity<String> entity = null;
		
		String msg = "yes";
		if(service.idCheck(u_id) != null) msg = "no";
		
		entity = new ResponseEntity<String>(msg, HttpStatus.OK);
		return entity;
	}
	//비밀번호 변경폼
	@GetMapping("/changePW")
	public void changePW() {
		
	}
	//비밀번호 변경
	@PostMapping("/changePW")
	public String changePW(HttpSession session, String u_pw, String u_npw, RedirectAttributes rttr) {
		
		String u_id = ((MemberVO)session.getAttribute("loginStatus")).getU_id();
		LoginDTO dto = new LoginDTO();
		dto.setU_id(u_id);
		
		MemberVO vo = service.login(dto);
		
		String returnUrl = "";
		
		if(vo != null) {
			if(crytPassEnc.matches(u_pw, vo.getU_pw())) {
				vo.setU_pw(crytPassEnc.encode(u_npw));//암호화
				service.changePW(vo);
				rttr.addFlashAttribute("msg", "비밀번호변경성공");
				session.setAttribute("loginStatus", vo);
				returnUrl = "/member/mypage";
			}else {
				rttr.addFlashAttribute("msg", "비밀번호변경실패");
				returnUrl = "/member/changePW";
			}
		}else {
			rttr.addFlashAttribute("msg", "비밀번호변경실패");
			returnUrl = "/member/changePW";
		}
		
		return "redirect:"+returnUrl;
	}
	//아이디찾기
	@GetMapping("/findIDPW")
	public void findIDPW() {}
	
	@ResponseBody
	@PostMapping("/findID")
	public ResponseEntity<String> findID(@RequestParam("u_name") String u_name, @RequestParam("u_email") String u_email) {
		ResponseEntity<String> entity = null;
		MemberVO vo = new MemberVO();
		vo.setU_name(u_name);
		vo.setU_email(u_email);
		
		MemberVO foundVO = service.findID(vo);
		
		if(foundVO != null) {
			entity = new ResponseEntity<String>(foundVO.getU_id(), HttpStatus.OK);	
		}else {
			entity = new ResponseEntity<String>("fail", HttpStatus.OK);
		}
		
		return entity;
	}
	
}
