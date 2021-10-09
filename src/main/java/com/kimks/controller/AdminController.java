package com.kimks.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.kimks.domain.AdminVO;
import com.kimks.domain.StatChartVO;
import com.kimks.service.AdminService;
import com.kimks.service.ChartService;
import com.kimks.util.SessionConfig;

import lombok.AllArgsConstructor;

@Controller
@RequestMapping("/admin/*")
@AllArgsConstructor
public class AdminController {

	private AdminService service;
	private ChartService ch_service;
	//로그인폼
	@GetMapping("/main")
	public String adminLoginForm() {
		return "/admin/adminLogin";
	}
	
	@GetMapping("/adminMain")
	public void adminMain(Model model) {
	
		List<StatChartVO> monthSalesList = ch_service.monthSales();
		
		List<StatChartVO> yearSalesList = ch_service.yearSales();
		
		String source = "[['Month', 'Sales' ,{ role: \'style\' }],";
		int c = 0;
		for(StatChartVO vo : monthSalesList) {
			source += "['" + vo.getYear()+"', " + vo.getTotal() + ", 'powderblue']";
			c++;
			if(c<monthSalesList.size()) {
				source +=",";
			}
		}
		source += "]";
		model.addAttribute("data", source);
		model.addAttribute("years", yearSalesList);
	}
	
	//로그인
	@PostMapping("/login")
	public String adminLoginCheck(AdminVO vo, HttpSession session, RedirectAttributes rttr, Model model) throws Exception{
		
		AdminVO adLoginVO = service.adminLogin(vo);
		model.addAttribute("adminVO", adLoginVO);
		String url = "";
		
		if(adLoginVO != null) {
			url = "/admin/adminMain";
			if(session.getAttribute("dest") != null) url = (String)session.getAttribute("dest");
			SessionConfig.getSessionCheck("adminDuplicateStatus", adLoginVO.getAdmin_id());
			session.setAttribute("adminStatus", adLoginVO);
			session.setAttribute("adminDuplicateStatus", adLoginVO.getAdmin_id());
			service.loginTimeUpdate(adLoginVO);
		}else {
			url = "/admin/main";
			rttr.addFlashAttribute("msg", "관리자로그인실패");
		}
		
		return "redirect:"+url;
	}
	
	@GetMapping("/adminMenu")
	public void adminMenu() throws Exception{
		
	}
	
	@GetMapping("/starter")
	public void starter() {
		
	}
	//로그아웃
	@GetMapping("/logout")
	public String logout(HttpSession session, RedirectAttributes rttr) {
		
		session.invalidate();
		rttr.addFlashAttribute("msg", "logout");
		return "redirect:/admin/main";
	}
	//비밀번호 변경 폼
	@GetMapping("/adminPWChange")
	public void adminPWChange(HttpSession session){
		session.getAttribute("adminStatus");
		
	}
	//비밀번호 변경
	@PostMapping("adminPWChange")
	public String adminPWChange(HttpSession session, String admin_cpw, String admin_npw, RedirectAttributes rttr) throws Exception{
		String admin_id = ((AdminVO)session.getAttribute("adminStatus")).getAdmin_id();
		
		AdminVO vo = new AdminVO();
		vo.setAdmin_id(admin_id);
		vo.setAdmin_pw(admin_cpw);
		
		AdminVO adLoginVO = service.adminLogin(vo);
		
		if(adLoginVO != null) {
			
			vo.setAdmin_pw(admin_npw);
			service.adminPWChange(vo);
			rttr.addFlashAttribute("msg", "PWChanged");					
		}else {
			
			rttr.addFlashAttribute("msg", "ChangeFail");
		}
	
		return "redirect:/admin/adminPWChange";
	}
}
