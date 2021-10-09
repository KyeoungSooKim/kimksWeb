package com.kimks.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.kimks.domain.StatChartVO;

public interface ChartMapper {

	public List<StatChartVO> yearSales();
	
	public List<StatChartVO> monthSales();
	
	public List<StatChartVO> weekSales();
	
	public List<StatChartVO> monthSalesSearch(String year);
	
	public List<StatChartVO> weekSalesSearch(String searchDate);
}
