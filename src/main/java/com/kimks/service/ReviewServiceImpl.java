package com.kimks.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.kimks.domain.ReviewVO;
import com.kimks.mapper.ReviewMapper;
import com.kimks.util.Criteria;

import lombok.Setter;

@Service
public class ReviewServiceImpl implements ReviewService {

	@Setter(onMethod_ = @Autowired)
	private ReviewMapper mapper;

	@Transactional
	@Override
	public void write(ReviewVO vo, Long odr_code, Integer pdt_code) {
		// TODO Auto-generated method stub
		mapper.write(vo);
		mapper.rvCheckUpdate(odr_code, pdt_code);
	}

	@Override
	public List<ReviewVO> getListWithPaging(Criteria cri, int pdt_code) {
		// TODO Auto-generated method stub
		return mapper.getListWithPaging(cri, pdt_code);
	}

	@Override
	public int getCountBypdtcode(int pdt_code) {
		// TODO Auto-generated method stub
		return mapper.getCountBypdtcode(pdt_code);
	}




}
