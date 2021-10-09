package com.kimks.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kimks.domain.CategoryVO;
import com.kimks.domain.ProductVO;
import com.kimks.mapper.ProductMapper;
import com.kimks.util.Criteria;

import lombok.Setter;

@Service
public class ProductServiceImpl implements ProductService {

	@Setter(onMethod_ = @Autowired)
	private ProductMapper mapper;
	
	@Override
	public List<CategoryVO> mainCategory() {
		// TODO Auto-generated method stub
		return mapper.mainCategory();
	}

	@Override
	public List<CategoryVO> subCategory(Integer cate_code) {
		// TODO Auto-generated method stub
		return mapper.subCategory(cate_code);
	}

	@Override
	public List<ProductVO> getListWithPaging(Criteria cri, Integer cate_code) {
		// TODO Auto-generated method stub
		return mapper.getListWithPaging(cri, cate_code);
	}

	@Override
	public int getTotalCount(Integer cate_code) {
		// TODO Auto-generated method stub
		return mapper.getTotalCount(cate_code);
	}

	@Override
	public ProductVO getProduct(Integer pdt_code) {
		// TODO Auto-generated method stub
		return mapper.getProduct(pdt_code);
	}

	@Override
	public List<ProductVO> mainList(Integer cate_prt) {
		// TODO Auto-generated method stub
		return mapper.mainList(cate_prt);
	}

	@Override
	public List<ProductVO> findListWithPaging(Criteria cri) {
		// TODO Auto-generated method stub
		return mapper.findListWithPaging(cri);
	}

	@Override
	public int findTotal(Criteria cri) {
		// TODO Auto-generated method stub
		return mapper.findTotal(cri);
	}



	
}
