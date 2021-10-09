package com.kimks.interceptor;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.kimks.service.AdminService;

import lombok.extern.log4j.Log4j;
@Log4j
public class AdminInterceptor extends HandlerInterceptorAdapter {

	@Inject
	AdminService service;
	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		
		HttpSession session = request.getSession();

		if(session.getAttribute("adminStatus") == null) {
			//세션이 널인데 ajax 요청했을경우 에러로 처리
			if(isAjaxRequest(request)) {
				response.sendError(500);
				return false;
			}
				saveDest(request);
				response.sendRedirect("/admin/main");
				return false;
			}
		
		return true;
	}

	//ajax 요청인지 확인
	private boolean isAjaxRequest(HttpServletRequest request) {
		// TODO Auto-generated method stub
		String header = request.getHeader("AJAX");
		if("true".equals(header)) {
			return true;
		}else {
			return false;
		}
		
	}

	// /admin/product/list?pdt_code=1
	//비로그인 상태에서 get방식으로 요청한 주소를 세션으로 저장하여, 로그인 후 리다이렉트 하기위한 용도
	private void saveDest(HttpServletRequest request) {
		
		String uri = request.getRequestURI(); // /admin/product/list
		String query = request.getQueryString(); // pdt_code=1
		if(query == null) {
			query = "";
		}else {
			query = "?" + query; // ?pdt_code=1
		}
		
		if(request.getMethod().equals("GET")) {
			log.info("dest: " + (uri+query));
			request.getSession().setAttribute("dest", uri + query);
		}
	}

	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
			ModelAndView modelAndView) throws Exception {
		// TODO Auto-generated method stub
		/*
		HttpSession session = request.getSession();
		ModelMap modelMap = modelAndView.getModelMap();
		Object adminVO = modelMap.get("adminVO");
		if(adminVO != null) {
			String url = session.getAttribute("dest") !=null ? (String)session.getAttribute("dest") : "/admin/adminMain";
			response.sendRedirect(url);
			
		}
		*/
	}

	@Override
	public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex)
			throws Exception {
		// TODO Auto-generated method stub
		super.afterCompletion(request, response, handler, ex);
	}


	
}
