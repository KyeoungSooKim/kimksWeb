package com.kimks.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.kimks.domain.OrderDetailVO;
import com.kimks.domain.OrderVO;
import com.kimks.domain.UserOrderDetailInfoVO;
import com.kimks.util.Criteria;

public interface OrderMapper {

	public void orderAdd(OrderVO vo);
	
	public void orderAddCookie(OrderVO vo);
	
	public void orderDetailAdd(OrderDetailVO vo);
	
	public Long getOrderSeq();
	
	public List<OrderVO> userOrderInfoWithPaging(@Param("u_id") String u_id,@Param("cri") Criteria cri);
	
	public int getTotalCount(String u_id);
	
	public List<UserOrderDetailInfoVO> userOrderDetailInfo(Long odr_code);
	
	public OrderVO orderSearch(@Param("odr_name") String odr_name,@Param("odr_code") Long odr_code);
}
