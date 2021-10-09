package com.kimks.controller;

import java.util.ArrayList;
import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.CookieValue;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.kimks.domain.CartListVO;
import com.kimks.domain.MemberVO;
import com.kimks.domain.OrderDetailVOList;
import com.kimks.domain.OrderVO;
import com.kimks.domain.ProductVO;
import com.kimks.domain.UserOrderDetailInfoVO;
import com.kimks.service.CartService;
import com.kimks.service.OrderService;
import com.kimks.service.ProductService;
import com.kimks.util.Criteria;
import com.kimks.util.PageDTO;

import lombok.AllArgsConstructor;

@Controller
@RequestMapping("/order/*")
@AllArgsConstructor
public class OrderController {
	
	@Inject
	private ProductService p_service;
	
	@Inject
	private OrderService o_service;
	
	@Inject
	private CartService c_service;
	
	@GetMapping("orderInfo")
	public void orderInfo(Integer pdt_code, @ModelAttribute("odr_amount") Integer odr_amount, Model model) throws Exception{
		ProductVO vo = p_service.getProduct(pdt_code);
		
		model.addAttribute("vo", vo);
		
	}
	
	@GetMapping()
	public void orderCodeSearch(){}
	
	@PostMapping("/orderFind")
	public String orderFind(OrderVO vo, RedirectAttributes rttr, Model model) throws Exception{
		
		String url = "";
	
		OrderVO orderVO = o_service.orderSearch(vo.getOdr_name(), vo.getOdr_code());

		if(orderVO != null) {
			url = "/order/guestOrderInfo";
			model.addAttribute("vo", orderVO);
		}else {
			url = "redirect:/order/orderCodeSearch";
			rttr.addFlashAttribute("msg", "notFound");
		}
		
		return url;
	}
	
	@GetMapping("/orderCartInfo")
	public void orderCartInfo(@CookieValue(value="cart", required=false) String cookie, HttpSession session, Model model) throws Exception{
		
		String u_id = "";
		String cookie_id = "";
		List<CartListVO> list = null;
		if(session.getAttribute("loginStatus") == null) {
			
			cookie_id = cookie;
			list = c_service.cartListCookieId(cookie_id);
		}else {
			u_id = ((MemberVO)session.getAttribute("loginStatus")).getU_id();
			list = c_service.cartList(u_id);
		}

		model.addAttribute("list", list);	
	}
	
	@GetMapping("/orderSelectCartInfo")
	public void orderSelectCartInfo(@CookieValue(value="cart", required=false) String cookie, HttpSession session, Model model,@RequestParam("cart_codeArr") Long[] cart_codeArr) throws Exception{
		
		String u_id = "";
		String cookie_id = "";
		List<CartListVO> selectOrder = new ArrayList<CartListVO>();
		
		if(session.getAttribute("loginStatus") == null) {
			
			cookie_id = cookie;
			
			for(int i=0; i<cart_codeArr.length; i++) {
				selectOrder.add(c_service.selectCartListCookieId(cookie_id,cart_codeArr[i]));
				}
		}else {
			u_id = ((MemberVO)session.getAttribute("loginStatus")).getU_id();
			
			for(int i=0; i<cart_codeArr.length; i++) {
				selectOrder.add(c_service.selectCartList(u_id,cart_codeArr[i]));
				}
		}
		model.addAttribute("list", selectOrder);	
	}
	
	@PostMapping("directOrderProcess")
	public String directOrderProcess(@CookieValue(value="cart", required=false) String cookie, OrderVO vo, OrderDetailVOList orderDetailList, HttpSession session, Model model) throws Exception{
		String u_id = "";
		String cookie_id = "";
		String url = "";
		if(session.getAttribute("loginStatus") == null) {
			
			cookie_id = cookie;
			url = "/order/guestOrderInfoResult";
			vo.setCookie_id(cookie_id);
			Long orderSeq = o_service.getOrderSeq();
			o_service.directOrderInfoAddCookie(vo, orderDetailList, orderSeq);
			model.addAttribute("orderCode", orderSeq);
		}else {
			u_id = ((MemberVO)session.getAttribute("loginStatus")).getU_id();
			url = "redirect:/order/orderInfoResult";
			vo.setU_id(u_id);
			Long orderSeq = o_service.getOrderSeq();
			o_service.directOrderInfoAdd(vo, orderDetailList, orderSeq);
		}
		
		
		return url;
	}
	
	@PostMapping("orderProcess")
	public String orderProcess(@CookieValue(value="cart", required=false) String cookie, OrderVO vo, OrderDetailVOList orderDetailList, HttpSession session, Model model) throws Exception{
		String u_id = "";
		String cookie_id = "";
		String url = "";
		if(session.getAttribute("loginStatus") == null) {
			
			cookie_id = cookie;
			url = "/order/guestOrderInfoResult";
			vo.setCookie_id(cookie_id);
			Long orderSeq = o_service.getOrderSeq();
			o_service.orderInfoAddCookie(vo, orderDetailList, orderSeq);
			model.addAttribute("orderCode", orderSeq);
		}else {
			u_id = ((MemberVO)session.getAttribute("loginStatus")).getU_id();
			url = "redirect:/order/orderInfoResult";
			vo.setU_id(u_id);
			Long orderSeq = o_service.getOrderSeq();
			o_service.orderInfoAdd(vo, orderDetailList, orderSeq);
		}
		
		
		return url;
	}
	
	@PostMapping("selectOrderProcess")
	public String selectOrderProcess(@CookieValue(value="cart", required=false) String cookie, OrderVO vo, OrderDetailVOList orderDetailList, HttpSession session, Model model,@RequestParam("cart_code") Long[] cart_codeArr) throws Exception{
		String u_id = "";
		String cookie_id = "";
		String url = "";
		if(session.getAttribute("loginStatus") == null) {
			
			cookie_id = cookie;
			url = "/order/guestOrderInfoResult";
			vo.setCookie_id(cookie_id);
			Long orderSeq = o_service.getOrderSeq();
			o_service.selectOrderInfoAddCookie(vo, orderDetailList, orderSeq, cart_codeArr);
			model.addAttribute("orderCode", orderSeq);
		}else {
			u_id = ((MemberVO)session.getAttribute("loginStatus")).getU_id();
			url = "redirect:/order/orderInfoResult";
			vo.setU_id(u_id);
			Long orderSeq = o_service.getOrderSeq();
			o_service.selectOrderInfoAdd(vo, orderDetailList, orderSeq, cart_codeArr);
		}
		
		return url;
	}
	@GetMapping("orderInfoResult")
	public void orderInfoResult() {}
	
	@GetMapping(value = "/userOrderInfo/{pageNum}")
	public String userOrderInfo(HttpSession session, Model model, Criteria cri,@PathVariable("pageNum") int pageNum ) throws Exception{
		String u_id = ((MemberVO)session.getAttribute("loginStatus")).getU_id();
		cri.setPageNum(pageNum);
		cri.setAmount(4);
		int total = o_service.getTotalCount(u_id);
		PageDTO pageMaker = new PageDTO(total, cri);
		
		model.addAttribute("list", o_service.userOrderInfoWithPaging(u_id, cri));
		model.addAttribute("pageMaker", pageMaker);
		
		return "/order/userOrderInfo";
	}
	
	@ResponseBody
	@GetMapping(value = "/userOrderDetailInfo/{odr_code}", produces={MediaType.APPLICATION_JSON_UTF8_VALUE, MediaType.APPLICATION_XML_VALUE})
	public ResponseEntity<List<UserOrderDetailInfoVO>> userOrderDetailInfo(@PathVariable("odr_code") Long odr_code) throws Exception{
		ResponseEntity<List<UserOrderDetailInfoVO>> entity = null;
		
		entity = new ResponseEntity<List<UserOrderDetailInfoVO>>(o_service.userOrderDetailInfo(odr_code), HttpStatus.OK);
		return entity;
	}
}
