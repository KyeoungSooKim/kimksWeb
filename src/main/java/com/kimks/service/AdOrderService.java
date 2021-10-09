package com.kimks.service;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.kimks.domain.OrderDetailVO;
import com.kimks.domain.OrderVO;
import com.kimks.domain.UserOrderDetailInfoVO;
import com.kimks.util.Criteria;

public interface AdOrderService {

	public List<OrderVO> orderAllList(Criteria cri);
	
	public int getTotalCount(Criteria cri);
	
	public List<UserOrderDetailInfoVO> userOrderDetailInfo(Long odr_code);
	
	public void orderDelete(Long odr_code);
	
	public int orderDetailFind(Long pdt_code);
	
	public void orderProductDelete(Long odr_code, Long pdt_code);
	
	public void deliveryStateModify(Long odr_code,String odr_delivery);
}
