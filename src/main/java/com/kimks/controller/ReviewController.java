package com.kimks.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.kimks.domain.MemberVO;
import com.kimks.domain.ReviewVO;
import com.kimks.domain.UserOrderDetailInfoVO;
import com.kimks.service.OrderService;
import com.kimks.service.ReviewService;
import com.kimks.util.Criteria;
import com.kimks.util.PageDTO;

import lombok.AllArgsConstructor;

@AllArgsConstructor
@RequestMapping("/review/*")
@RestController
public class ReviewController {

	private OrderService o_service;
	private ReviewService service;
	
	@PostMapping("/write")
	public ResponseEntity<List<UserOrderDetailInfoVO>> write(ReviewVO vo, Long odr_code, HttpSession session) throws Exception{
		ResponseEntity<List<UserOrderDetailInfoVO>> entity = null;
		
		String u_id = ((MemberVO)session.getAttribute("loginStatus")).getU_id();
		vo.setU_id(u_id);
		
		//log.info(vo);
			
		service.write(vo, odr_code, vo.getPdt_code());
		
		entity = new ResponseEntity<List<UserOrderDetailInfoVO>>(o_service.userOrderDetailInfo(odr_code), HttpStatus.OK);
		
		return entity;
	}
		
	
	@GetMapping(value = "/{pdt_code}/{page}", produces = {MediaType.APPLICATION_XML_VALUE, MediaType.APPLICATION_JSON_UTF8_VALUE})
	public ResponseEntity<Map<String, Object>> listPage(@PathVariable("pdt_code") int pdt_code, @PathVariable("page") Integer page)
	{
		ResponseEntity<Map<String, Object>> entity = null;
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		//1)댓글목록데이타
		Criteria cri = new Criteria(page, 3);
//		cri.setPageNum(page);
		
		List<ReviewVO> list = service.getListWithPaging(cri, pdt_code);
		
		//2)페이징정보
		int total = service.getCountBypdtcode(pdt_code);
		PageDTO pageMaker = new PageDTO(total, cri);
		
		// map컬렉션에 2개의 정보추가
		map.put("list", list); // 1)상품후기
		map.put("pageMaker", pageMaker); //2)페이징정보추가
		
		entity = new ResponseEntity<Map<String,Object>>(map, HttpStatus.OK);
		
		return entity;
	}
	
}
