package com.kimks.controller;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.CookieValue;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.kimks.domain.CartListVO;
import com.kimks.domain.CartVO;
import com.kimks.domain.MemberVO;
import com.kimks.service.CartService;
import com.kimks.util.UploadFileUtils;

import lombok.AllArgsConstructor;

@Controller
@RequestMapping("/cart/*")
@AllArgsConstructor
public class CartController {

	private CartService service;
	
	@Resource(name = "uploadPath")
	private String uploadPath;
	
	@ResponseBody
	@PostMapping("/cartAdd")
	public ResponseEntity<String> cartAdd(@CookieValue(value="cart", required=false) String cookie, HttpSession session, Integer pdt_code, Integer cart_amount){
		ResponseEntity<String> entity = null;
		String u_id = "";
		String cookie_id = "";
		if(session.getAttribute("loginStatus") == null) {
			
			cookie_id = cookie;
		}else {
			u_id = ((MemberVO)session.getAttribute("loginStatus")).getU_id();	
		}
		
		CartVO vo = new CartVO();
		vo.setCart_amount(cart_amount);
		vo.setPdt_code(pdt_code);
		vo.setU_id(u_id);
		vo.setCookie_id(cookie_id);
		service.addCart(vo);
		entity = new ResponseEntity<String>("success", HttpStatus.OK);
		return entity;
	}
	
	@GetMapping("/list")
	public void list(@CookieValue(value="cart", required=false) String cookie, HttpSession session, Model model) throws Exception{
		
		String u_id = "";
		String cookie_id = "";
		List<CartListVO> list = null;
		if(session.getAttribute("loginStatus") == null) {
			
			cookie_id = cookie;
			list = service.cartListCookieId(cookie_id);
		}else {
			u_id = ((MemberVO)session.getAttribute("loginStatus")).getU_id();
			list = service.cartList(u_id);
		}
		
		model.addAttribute("list", list);
	}
	
	@ResponseBody
	@GetMapping("/displayFile")
	public ResponseEntity<byte[]> displayFile(String fileName) throws Exception{
		ResponseEntity<byte[]> entity = null;
		
		entity = UploadFileUtils.getFileByte(fileName, uploadPath);
		
		return entity;
	}
	
	@ResponseBody
	@PostMapping("/edit")
	public ResponseEntity<String> edit(Long cart_code, Integer cart_amount){
		ResponseEntity<String> entity = null;
		
		CartVO vo = new CartVO();
		vo.setCart_amount(cart_amount);
		vo.setCart_code(cart_code);
		service.editAmount(vo);
		entity = new ResponseEntity<String>("success", HttpStatus.OK);
		return entity;
	}
	
	@ResponseBody
	@PostMapping("/delete")
	public ResponseEntity<String> delete(Long cart_code){
		ResponseEntity<String> entity = null;
		
		service.deleteCart(cart_code);
		entity = new ResponseEntity<String>("success", HttpStatus.OK);
		return entity;
	}
	
	@GetMapping("/deleteAll")
	public String deleteAll(@CookieValue(value="cart", required=false) String cookie, HttpSession session){
		String u_id = "";
		String cookie_id = "";
		if(session.getAttribute("loginStatus") == null) {
			
			cookie_id = cookie;
			service.deleteCartByCookieId(cookie_id);
		}else {
			u_id = ((MemberVO)session.getAttribute("loginStatus")).getU_id();
			service.deleteCartByUserId(u_id);
		}

		return "redirect:/cart/list";
	}
	
	@ResponseBody
	@PostMapping("checkedModify") //ajax 배열로 넘어온경우
	public ResponseEntity<String> checkedModify(@RequestParam("cart_codeArr[]") List<Long> cart_codeArr,@RequestParam("cart_amountArr[]") List<Integer> cart_amountArr) {
		ResponseEntity<String> entity = null;
		
		for(int i=0; i<cart_codeArr.size(); i++) {
			CartVO vo = new CartVO();
			vo.setCart_amount(cart_amountArr.get(i));
			vo.setCart_code(cart_codeArr.get(i));
			service.editAmount(vo);
		}
		
		return entity;
	}
	
	@ResponseBody
	@PostMapping("deleteChecked") //ajax 배열로 넘어온경우
	public ResponseEntity<String> deleteChecked(@RequestParam("cart_codeArr[]") List<Long> cart_codeArr) {
		ResponseEntity<String> entity = null;
		
		for(int i=0; i<cart_codeArr.size(); i++) {
			
			service.deleteCart(cart_codeArr.get(i));
		}
		
		return entity;
	}
}
