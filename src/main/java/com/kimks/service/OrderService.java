package com.kimks.service;

import java.util.List;

import com.kimks.domain.OrderDetailVOList;
import com.kimks.domain.OrderVO;
import com.kimks.domain.UserOrderDetailInfoVO;
import com.kimks.util.Criteria;

public interface OrderService {
	public Long getOrderSeq();
	//회원 주문
	public void orderInfoAdd(OrderVO vo, OrderDetailVOList orderDetailList, Long orderSeq);
	public void selectOrderInfoAdd(OrderVO vo, OrderDetailVOList orderDetailList, Long orderSeq, Long[] cart_codeArr);
	public void directOrderInfoAdd(OrderVO vo, OrderDetailVOList orderDetailList, Long orderSeq);
	//비회원 주문
	public void orderInfoAddCookie(OrderVO vo, OrderDetailVOList orderDetailList, Long orderSeq);
	public void selectOrderInfoAddCookie(OrderVO vo, OrderDetailVOList orderDetailList, Long orderSeq, Long[] cart_codeArr);
	public void directOrderInfoAddCookie(OrderVO vo, OrderDetailVOList orderDetailList, Long orderSeq);
	
	public List<OrderVO> userOrderInfoWithPaging(String u_id, Criteria cri);
	
	public int getTotalCount(String u_id);
	
	public List<UserOrderDetailInfoVO> userOrderDetailInfo(Long odr_code);
	
	public OrderVO orderSearch(String odr_name, Long odr_code);

	
}
