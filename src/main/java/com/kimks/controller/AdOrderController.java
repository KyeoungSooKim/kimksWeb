package com.kimks.controller;

import java.util.List;

import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PatchMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.kimks.domain.OrderVO;
import com.kimks.domain.UserOrderDetailInfoVO;
import com.kimks.service.AdOrderService;
import com.kimks.util.Criteria;
import com.kimks.util.PageDTO;

import lombok.AllArgsConstructor;

@Controller
@AllArgsConstructor
@RequestMapping("/admin/order/*")
public class AdOrderController {

	private AdOrderService service;
	
	@GetMapping("list")
	public void orderlist(Criteria cri, Model model) throws Exception{
		
		cri.setAmount(2);
		
		int total = service.getTotalCount(cri);
		
		PageDTO pageMaker = new PageDTO(total, cri);
		
		if(cri.getPageNum() > pageMaker.getRealEnd()) {
			cri.setPageNum(pageMaker.getRealEnd());
		}
		
		List<OrderVO> list = service.orderAllList(cri);
		
		model.addAttribute("total", total);
		model.addAttribute("pageMaker", pageMaker);
		model.addAttribute("list", list);
	}
	
	@ResponseBody
	@GetMapping(value = "/userOrderDetailInfo/{odr_code}", produces={MediaType.APPLICATION_JSON_UTF8_VALUE, MediaType.APPLICATION_XML_VALUE})
	public ResponseEntity<List<UserOrderDetailInfoVO>> userOrderDetailInfo(@PathVariable("odr_code") Long odr_code) throws Exception{
		ResponseEntity<List<UserOrderDetailInfoVO>> entity = null;
		
		entity = new ResponseEntity<List<UserOrderDetailInfoVO>>(service.userOrderDetailInfo(odr_code), HttpStatus.OK);
		return entity;
	}
	
	@PostMapping("orderDelete")
	public String orderDelete(Criteria cri, Long odr_code, RedirectAttributes rttr) {
		
		service.orderDelete(odr_code);
		rttr.addAttribute("pageNum", cri.getPageNum());
		rttr.addAttribute("amount", cri.getAmount());
		rttr.addAttribute("type", cri.getType());
		rttr.addAttribute("keyword", cri.getKeyword());
		
		return "redirect:/admin/order/list";
	}
	
	@ResponseBody
	@GetMapping(value = "/orderDeleteProduct/{odr_code}/{pdt_code}")
	public ResponseEntity<String> orderDeleteProduct(@PathVariable("odr_code") Long odr_code, @PathVariable("pdt_code") Long pdt_code) throws Exception{
		ResponseEntity<String> entity = null;
		
		service.orderProductDelete(odr_code, pdt_code);
		entity = new ResponseEntity<String>("success", HttpStatus.OK);
		return entity;
	}
	
	@ResponseBody
	@PatchMapping(value = "/deliveryStateModify/{odr_code}/{odr_delivery}")
	public ResponseEntity<String> orderDeleteProduct(@PathVariable("odr_code") Long odr_code, @PathVariable("odr_delivery") String odr_delivery) throws Exception{
		ResponseEntity<String> entity = null;
		
		service.deliveryStateModify(odr_code, odr_delivery);
		entity = new ResponseEntity<String>("success", HttpStatus.OK);
		return entity;
	}
	
	@ResponseBody
	@PostMapping("deliveryModifyChecked") //ajax 배열로 넘어온경우
	public ResponseEntity<String> deliveryModifyChecked(@RequestParam("odr_codeArr[]") List<Long> odr_codeArr,@RequestParam("odr_deliveryArr[]") List<String> odr_deliveryArr) {
		ResponseEntity<String> entity = null;
		
		for(int i=0; i<odr_codeArr.size(); i++) {
			
			service.deliveryStateModify(odr_codeArr.get(i), odr_deliveryArr.get(i));
		}
		entity = new ResponseEntity<String>("success", HttpStatus.OK);
		return entity;
	}
	
	@ResponseBody
	@PostMapping("deleteChecked") //ajax 배열로 넘어온경우
	public ResponseEntity<String> deleteChecked(@RequestParam("odr_codeArr[]") List<Long> odr_codeArr) {
		ResponseEntity<String> entity = null;
		
		for(int i=0; i<odr_codeArr.size(); i++) {
			
			service.orderDelete(odr_codeArr.get(i));
		}
		entity = new ResponseEntity<String>("success", HttpStatus.OK);
		return entity;
	}
}
