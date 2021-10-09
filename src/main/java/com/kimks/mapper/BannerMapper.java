package com.kimks.mapper;

import java.util.List;

import com.kimks.domain.BannerVO;

public interface BannerMapper {

	public BannerVO getFirstBanner();
	
	public List<BannerVO> getBanner();
	
	public void insert(BannerVO vo);
	
	public int getOrder();
	
	public void delete(Long bn_code);
	
	public void updateOrder(Long bn_code);
	
	public List<BannerVO> getAll();
	
	public void modify(BannerVO vo);
}
