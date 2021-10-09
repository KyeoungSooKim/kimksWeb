package com.kimks.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.kimks.domain.CategoryVO;
import com.kimks.domain.ProductVO;
import com.kimks.util.Criteria;

public interface ProductMapper {

	public List<CategoryVO> mainCategory();
	
	public List<CategoryVO> subCategory(Integer cate_code);
	
	public List<ProductVO> getListWithPaging(@Param("cri") Criteria cri,@Param("cate_code") Integer cate_code);
	
	public int getTotalCount(Integer cate_code);
	
	public ProductVO getProduct(Integer pdt_code);
	
	public List<ProductVO> mainList(Integer cate_prt);
	
	public List<ProductVO> findListWithPaging(Criteria cri);
	
	public int findTotal(Criteria cri);
}
