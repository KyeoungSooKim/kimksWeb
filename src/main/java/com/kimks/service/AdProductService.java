package com.kimks.service;

import java.util.List;

import com.kimks.domain.CategoryVO;
import com.kimks.domain.ProductVO;
import com.kimks.util.Criteria;

public interface AdProductService {

	public List<CategoryVO> mainCategory();
	
	public List<CategoryVO> subCategory(Integer cate_code);
	
	public void insert(ProductVO vo);
	
	public List<ProductVO> getListWithPaging(Criteria cri);
	
	public int getTotal(Criteria cri);
	
	public ProductVO getProduct(Integer pdt_code);
	
	public void edit(ProductVO vo);
	
	public void priceEdit(ProductVO vo);
	
	public void delete(Long pdt_code);

}
