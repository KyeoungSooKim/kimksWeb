package com.kimks.controller;

import java.util.List;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.kimks.domain.MemberVO;
import com.kimks.service.MemberService;
import com.kimks.util.Criteria;
import com.kimks.util.PageDTO;

import lombok.AllArgsConstructor;

@Controller
@AllArgsConstructor
@RequestMapping("/admin/member/*")
public class AdMemberController {

	private MemberService service;
	
	@GetMapping("list")
	public void orderlist(Criteria cri, Model model) throws Exception{
		
		cri.setAmount(3);
		
		int total = service.getTotalCount(cri);
		
		PageDTO pageMaker = new PageDTO(total, cri);
		
		if(cri.getPageNum() > pageMaker.getRealEnd()) {
			cri.setPageNum(pageMaker.getRealEnd());
		}
		
		List<MemberVO> list = service.getListWithPaging(cri);
		
		model.addAttribute("total", total);
		model.addAttribute("pageMaker", pageMaker);
		model.addAttribute("list", list);
	}

	@GetMapping("/userDetailInfo")
	public void userDetailInfo(String u_id, Model model){
		
		model.addAttribute("memberVO", service.userInfo(u_id));
	}
	
	@PostMapping("memberDelete")
	public String orderDelete(Criteria cri, String u_id, RedirectAttributes rttr) {
		
		service.deleteByAd(u_id);
		rttr.addAttribute("pageNum", cri.getPageNum());
		rttr.addAttribute("amount", cri.getAmount());
		rttr.addAttribute("type", cri.getType());
		rttr.addAttribute("keyword", cri.getKeyword());
		
		return "redirect:/admin/member/list";
	}
	
	@PostMapping("/modifyByAd")
	public String modify(MemberVO vo, RedirectAttributes rttr) throws Exception{

			service.modifyByAd(vo);
			rttr.addAttribute("u_id", vo.getU_id());
		return "redirect:/admin/member/userDetailInfo";
	}
	
	@ResponseBody
	@PostMapping("deleteChecked") //ajax 배열로 넘어온경우
	public ResponseEntity<String> deleteChecked(@RequestParam("u_idArr[]") List<String> u_idArr) {
		ResponseEntity<String> entity = null;
		
		for(int i=0; i<u_idArr.size(); i++) {
			
			service.deleteByAd(u_idArr.get(i));
		}
		entity = new ResponseEntity<String>("success", HttpStatus.OK);
		return entity;
	}
}
