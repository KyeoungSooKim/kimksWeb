package com.kimks.service;

import java.util.Date;
import java.util.List;

import com.kimks.domain.StatChartVO;

public interface ChartService {

	public List<StatChartVO> yearSales();
	
	public List<StatChartVO> monthSales();
	
	public List<StatChartVO> weekSales();
	
	public List<StatChartVO> monthSalesSearch(String year);
	
	public List<StatChartVO> weekSalesSearch(String searchDate);
}
