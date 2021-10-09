package com.kimks.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.kimks.domain.OrderDetailVO;
import com.kimks.domain.OrderVO;
import com.kimks.domain.UserOrderDetailInfoVO;
import com.kimks.mapper.AdOrderMapper;
import com.kimks.util.Criteria;

import lombok.Setter;

@Service
public class AdOrderServiceImpl implements AdOrderService {

	@Setter(onMethod_ = @Autowired)
	private AdOrderMapper mapper;

	@Override
	public List<OrderVO> orderAllList(Criteria cri) {
	
		return mapper.orderAllList(cri);
	}

	@Override
	public int getTotalCount(Criteria cri) {
		
		return mapper.getTotalCount(cri);
	}

	@Override
	public void orderDelete(Long odr_code) {
	
		mapper.orderDelete(odr_code);
		
	}

	@Transactional
	@Override
	public void orderProductDelete(Long odr_code, Long pdt_code) {
		
		mapper.orderProductDelete(odr_code, pdt_code);
		mapper.orderCountModify(odr_code);
	}

	@Override
	public List<UserOrderDetailInfoVO> userOrderDetailInfo(Long odr_code) {
	
		return mapper.userOrderDetailInfo(odr_code);
	}

	@Override
	public void deliveryStateModify(Long odr_code, String odr_delivery) {
		
		mapper.deliveryStateModify(odr_code, odr_delivery);
	}

	@Override
	public int orderDetailFind(Long pdt_code) {
		// TODO Auto-generated method stub
		return mapper.orderDetailFind(pdt_code);
	}
}
