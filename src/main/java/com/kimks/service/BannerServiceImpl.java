package com.kimks.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.kimks.domain.BannerVO;
import com.kimks.mapper.BannerMapper;

import lombok.Setter;

@Service
public class BannerServiceImpl implements BannerService {

	@Setter(onMethod_ = @Autowired)
	private BannerMapper mapper;
	
	@Override
	public List<BannerVO> getBanner() {
		// TODO Auto-generated method stub
		return mapper.getBanner();
	}

	@Transactional
	@Override
	public void insert(BannerVO vo) {
		// TODO Auto-generated method stub
		int bn_order = mapper.getOrder()+1;
		vo.setBn_order(bn_order);
		mapper.insert(vo);
	}

	@Override
	public BannerVO getFirstBanner() {
		// TODO Auto-generated method stub
		return mapper.getFirstBanner();
	}

	@Transactional
	@Override
	public void delete(Long bn_code) {
		// TODO Auto-generated method stub
		mapper.updateOrder(bn_code);
		mapper.delete(bn_code);
	}

	@Override
	public List<BannerVO> getAll() {
		// TODO Auto-generated method stub
		return mapper.getAll();
	}

	@Override
	public void modify(BannerVO vo) {
		// TODO Auto-generated method stub
		mapper.modify(vo);
	}

}
