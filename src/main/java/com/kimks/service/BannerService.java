package com.kimks.service;

import java.util.List;

import com.kimks.domain.BannerVO;

public interface BannerService {

	public BannerVO getFirstBanner();
	
	public List<BannerVO> getBanner();

	public void insert(BannerVO vo);

	public void delete(Long bn_code);

	public List<BannerVO> getAll();
	
	public void modify(BannerVO vo);
}
