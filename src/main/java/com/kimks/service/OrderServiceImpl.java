package com.kimks.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.kimks.domain.OrderDetailVO;
import com.kimks.domain.OrderDetailVOList;
import com.kimks.domain.OrderVO;
import com.kimks.domain.UserOrderDetailInfoVO;
import com.kimks.mapper.CartMapper;
import com.kimks.mapper.OrderMapper;
import com.kimks.util.Criteria;

import lombok.Setter;

@Service
public class OrderServiceImpl implements OrderService {

	@Setter(onMethod_ = @Autowired)
	private OrderMapper mapper;

	@Setter(onMethod_ = @Autowired)
	private CartMapper mapper2;
	
	//장바구니 전체주문
	@Transactional
	@Override
	public void orderInfoAdd(OrderVO vo, OrderDetailVOList orderDetailList, Long orderSeq) {
		// TODO Auto-generated method stub
		
		vo.setOdr_code(orderSeq);
		
		List<OrderDetailVO> list = orderDetailList.getOrderDetailList();
		vo.setOdr_count(list.size());
		
		mapper.orderAdd(vo);
		
		for(int i =0; i<list.size(); i++) {
			OrderDetailVO orderDetail = list.get(i);
			orderDetail.setOdr_code(orderSeq);
			mapper.orderDetailAdd(orderDetail);
		}
		
		//장바구니 삭제
		mapper2.deleteCartByUserId(vo.getU_id());
	}

	//장바구니 선택주문
	@Transactional
	@Override
	public void selectOrderInfoAdd(OrderVO vo, OrderDetailVOList orderDetailList, Long orderSeq, Long[] cart_codeArr) {
	
		vo.setOdr_code(orderSeq); //주문번호 시퀀스값 세팅
		
		List<OrderDetailVO> list = orderDetailList.getOrderDetailList();
		vo.setOdr_count(list.size()); //넘어온 주문상세 정보로 주문 건수 세팅
		
		mapper.orderAdd(vo); //주문테이블 작업
		
		//주문상세테이블 작업
		for(int i =0; i<list.size(); i++) {
			OrderDetailVO orderDetail = list.get(i);
			orderDetail.setOdr_code(orderSeq);
			mapper.orderDetailAdd(orderDetail);
		}
		
		//선택했던 장바구니 코드를 통한 삭제
		for(int i =0; i<cart_codeArr.length; i++)
		mapper2.deleteCart(cart_codeArr[i]);
	}

	//바로구매
	@Transactional
	@Override
	public void directOrderInfoAdd(OrderVO vo, OrderDetailVOList orderDetailList, Long orderSeq) {
		// TODO Auto-generated method stub

		vo.setOdr_code(orderSeq);
		
		List<OrderDetailVO> list = orderDetailList.getOrderDetailList();
		vo.setOdr_count(list.size());
		
		mapper.orderAdd(vo);
		
		for(int i =0; i<list.size(); i++) {
			OrderDetailVO orderDetail = list.get(i);
			orderDetail.setOdr_code(orderSeq);
			mapper.orderDetailAdd(orderDetail);
		}
	}
	
	//장바구니 전체주문
		@Transactional
		@Override
		public void orderInfoAddCookie(OrderVO vo, OrderDetailVOList orderDetailList, Long orderSeq) {
			// TODO Auto-generated method stub
			
			vo.setOdr_code(orderSeq);
			
			List<OrderDetailVO> list = orderDetailList.getOrderDetailList();
			vo.setOdr_count(list.size());
			
			mapper.orderAddCookie(vo);
			
			for(int i =0; i<list.size(); i++) {
				OrderDetailVO orderDetail = list.get(i);
				orderDetail.setOdr_code(orderSeq);
				mapper.orderDetailAdd(orderDetail);
			}
			
			//장바구니 삭제
			mapper2.deleteCartByCookieId(vo.getCookie_id());
		}

		//장바구니 선택주문
		@Transactional
		@Override
		public void selectOrderInfoAddCookie(OrderVO vo, OrderDetailVOList orderDetailList, Long orderSeq, Long[] cart_codeArr) {
		
			vo.setOdr_code(orderSeq); //주문번호 시퀀스값 세팅
			
			List<OrderDetailVO> list = orderDetailList.getOrderDetailList();
			vo.setOdr_count(list.size()); //넘어온 주문상세 정보로 주문 건수 세팅
			
			mapper.orderAddCookie(vo); //주문테이블 작업
			
			//주문상세테이블 작업
			for(int i =0; i<list.size(); i++) {
				OrderDetailVO orderDetail = list.get(i);
				orderDetail.setOdr_code(orderSeq);
				mapper.orderDetailAdd(orderDetail);
			}
			
			//선택했던 장바구니 코드를 통한 삭제
			for(int i =0; i<cart_codeArr.length; i++)
			mapper2.deleteCart(cart_codeArr[i]);
		}

		//바로구매
		@Transactional
		@Override
		public void directOrderInfoAddCookie(OrderVO vo, OrderDetailVOList orderDetailList, Long orderSeq) {
			// TODO Auto-generated method stub

			vo.setOdr_code(orderSeq);
			
			List<OrderDetailVO> list = orderDetailList.getOrderDetailList();
			vo.setOdr_count(list.size());
			
			mapper.orderAddCookie(vo);
			
			for(int i =0; i<list.size(); i++) {
				OrderDetailVO orderDetail = list.get(i);
				orderDetail.setOdr_code(orderSeq);
				mapper.orderDetailAdd(orderDetail);
			}
		}
		
	@Override
	public List<UserOrderDetailInfoVO> userOrderDetailInfo(Long odr_code) {
		// TODO Auto-generated method stub
		return mapper.userOrderDetailInfo(odr_code);
	}

	@Override
	public List<OrderVO> userOrderInfoWithPaging(String u_id, Criteria cri) {
		// TODO Auto-generated method stub
		return mapper.userOrderInfoWithPaging(u_id, cri);
	}

	@Override
	public int getTotalCount(String u_id) {
		// TODO Auto-generated method stub
		return mapper.getTotalCount(u_id);
	}

	@Override
	public OrderVO orderSearch(String odr_name, Long odr_code) {
		// TODO Auto-generated method stub
		return mapper.orderSearch(odr_name, odr_code);
	}

	@Override
	public Long getOrderSeq() {
		
		return mapper.getOrderSeq();
	}



	
}
