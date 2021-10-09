package com.kimks.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.kimks.domain.OrderDetailVO;
import com.kimks.domain.OrderVO;
import com.kimks.domain.UserOrderDetailInfoVO;
import com.kimks.util.Criteria;

public interface AdOrderMapper {

	public List<OrderVO> orderAllList(Criteria cri);
	
	public int getTotalCount(Criteria cri);
	
	public List<UserOrderDetailInfoVO> userOrderDetailInfo(Long odr_code);
	
	public void orderDelete(Long odr_code);
	
	public int orderDetailFind(Long pdt_code);
	
	public void orderProductDelete(@Param("odr_code") Long odr_code,@Param("pdt_code") Long pdt_code);
	public void orderCountModify(Long odr_code);
	
	public void deliveryStateModify(@Param("odr_code") Long odr_code,@Param("odr_delivery") String odr_delivery);
}
