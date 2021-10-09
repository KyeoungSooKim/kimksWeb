package com.kimks.controller;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.CookieValue;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.kimks.service.BannerService;
import com.kimks.service.ProductService;

import lombok.AllArgsConstructor;

@Controller
@AllArgsConstructor
public class HomeController {
	
	private ProductService service;
	
	private BannerService b_service;
		
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Model model, @CookieValue(value="cart", required=false) String cartCookie, HttpServletResponse res, HttpSession session) {
		//log.info("Welcome home!");
				
		model.addAttribute("cate1", service.mainList(1) );
		model.addAttribute("cate2", service.mainList(2) );
		model.addAttribute("cate3", service.mainList(3) );
		model.addAttribute("cate4", service.mainList(4) );
		model.addAttribute("cate5", service.mainList(5) );
		
		model.addAttribute("firstBanner", b_service.getFirstBanner());
		model.addAttribute("banner", b_service.getBanner());
		return "main";
	}
	
}
