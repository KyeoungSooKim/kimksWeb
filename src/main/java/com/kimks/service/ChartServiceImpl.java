package com.kimks.service;

import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kimks.domain.StatChartVO;
import com.kimks.mapper.ChartMapper;

import lombok.Setter;

@Service
public class ChartServiceImpl implements ChartService {

	@Setter(onMethod_ = @Autowired)
	private ChartMapper mapper;
	@Override
	public List<StatChartVO> yearSales() {
		// TODO Auto-generated method stub
		return mapper.yearSales();
	}
	@Override
	public List<StatChartVO> monthSales() {
		// TODO Auto-generated method stub
		return mapper.monthSales();
	}
	@Override
	public List<StatChartVO> monthSalesSearch(String year) {
		// TODO Auto-generated method stub
		return mapper.monthSalesSearch(year);
	}
	@Override
	public List<StatChartVO> weekSales() {
		// TODO Auto-generated method stub
		return mapper.weekSales();
	}
	@Override
	public List<StatChartVO> weekSalesSearch(String searchDate) {
		// TODO Auto-generated method stub
		return mapper.weekSalesSearch(searchDate);
	}

	
}
