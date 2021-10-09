package com.kimks.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.kimks.domain.ReviewVO;
import com.kimks.util.Criteria;

public interface ReviewMapper {

	public void write(ReviewVO vo);
	
	public List<ReviewVO> getListWithPaging(@Param("cri") Criteria cri, @Param("pdt_code") int pdt_code);
	
	public int getCountBypdtcode(int pdt_code);

	public void rvCheckUpdate(@Param("odr_code") Long odr_code, @Param("pdt_code") Integer pdt_code);
}
