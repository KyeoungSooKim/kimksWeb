package com.kimks.controller;

import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ModelAttribute;

import com.kimks.service.ProductService;

import lombok.AllArgsConstructor;
//모든 jsp 에서 model 작업한 내용 참조 가능
@ControllerAdvice(basePackages = {"com.kimks.controller"})
@AllArgsConstructor
public class GlobalController {

	private ProductService service;
	
	@ModelAttribute
	public void message(Model model) {

		model.addAttribute("mainCategory", service.mainCategory());
		
	}
}
