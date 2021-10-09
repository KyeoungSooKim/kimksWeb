package com.kimks.service;

import java.util.List;

import com.kimks.domain.ReviewVO;
import com.kimks.util.Criteria;

public interface ReviewService {
	
	public void write(ReviewVO vo, Long odr_code, Integer pdt_code);
	
	public List<ReviewVO> getListWithPaging(Criteria cri, int pdt_code);
	
	public int getCountBypdtcode(int pdt_code);

}
