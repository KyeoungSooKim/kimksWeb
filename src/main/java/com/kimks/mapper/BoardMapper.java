package com.kimks.mapper;

import java.util.List;

import com.kimks.domain.BoardVO;
import com.kimks.domain.CategoryVO;
import com.kimks.util.Criteria;

public interface BoardMapper {

	public void insert(BoardVO board);
	
	public List<BoardVO> getList();
	
	public List<BoardVO> getListWithPaging(Criteria cri);
	
	public int getTotalCount(Criteria cri);
	
	public BoardVO read(Long bno);
	
	public void update(BoardVO board);
	
	public void delete(Long bno);
	
	public List<CategoryVO> getMainCate();
	
	public List<CategoryVO> getSubCate(Integer cate_prt);
}
