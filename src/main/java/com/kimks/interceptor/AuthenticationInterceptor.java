package com.kimks.interceptor;

import java.util.UUID;

import javax.inject.Inject;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;
import org.springframework.web.util.WebUtils;

import com.kimks.domain.MemberVO;
import com.kimks.service.MemberService;

public class AuthenticationInterceptor extends HandlerInterceptorAdapter {

	@Inject
	MemberService service;
	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		
		HttpSession session = request.getSession();
		
		if(session.getAttribute("loginStatus") == null) {
			
			Cookie cartCookie = WebUtils.getCookie(request, "cart"); //비회원을 위한 쿠키
			Cookie loginCookie = WebUtils.getCookie(request, "loginCookie"); //자동로그인 체크를 위한 쿠키
			
			
			if(loginCookie != null) { //자동로그인 확인작업		
				MemberVO vo = service.loginCheckWithSessionId(loginCookie.getValue());
				
				if(vo != null) {
					session.setAttribute("loginStatus", vo);
					return true;
				}
			} else { //세션정보도 없고 자동로그인 쿠키정보도 없으면 쿠키 발급
				if(cartCookie == null) {
					UUID uuid = UUID.randomUUID(); //중복되지 않는 쿠키 값을 위한 랜덤문자열 생성
					Cookie cookie = new Cookie("cart", uuid.toString());
					cookie.setPath("/"); //모든경로에서 사용
					cookie.setMaxAge(60*60); //쿠키 유지기한 1시간
					response.addCookie(cookie);
				}
			}
			return true;
		}
		return true;
	}

	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
			ModelAndView modelAndView) throws Exception {
		// TODO Auto-generated method stub
		super.postHandle(request, response, handler, modelAndView);
	}

	@Override
	public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex)
			throws Exception {
		// TODO Auto-generated method stub
		super.afterCompletion(request, response, handler, ex);
	}


	
}
