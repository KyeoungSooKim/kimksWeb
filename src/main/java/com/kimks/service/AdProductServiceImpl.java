package com.kimks.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kimks.domain.CategoryVO;
import com.kimks.domain.ProductVO;
import com.kimks.mapper.AdProductMapper;
import com.kimks.util.Criteria;

import lombok.Setter;

@Service
public class AdProductServiceImpl implements AdProductService {

	@Setter(onMethod_ = @Autowired)
	private AdProductMapper mapper;

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
	public void insert(ProductVO vo) {
		// TODO Auto-generated method stub
		mapper.insert(vo);
	}

	@Override
	public List<ProductVO> getListWithPaging(Criteria cri) {
		// TODO Auto-generated method stub
		return mapper.getListWithPaging(cri);
	}

	@Override
	public int getTotal(Criteria cri) {
		// TODO Auto-generated method stub
		return mapper.getTotal(cri);
	}

	@Override
	public ProductVO getProduct(Integer pdt_code) {
		// TODO Auto-generated method stub
		return mapper.getProduct(pdt_code);
	}

	@Override
	public void edit(ProductVO vo) {
		// TODO Auto-generated method stub
		mapper.edit(vo);
	}

	@Override
	public void delete(Long pdt_code) {
		// TODO Auto-generated method stub
		mapper.delete(pdt_code);
	}

	@Override
	public void priceEdit(ProductVO vo) {
		// TODO Auto-generated method stub
		mapper.priceEdit(vo);
	}
}
