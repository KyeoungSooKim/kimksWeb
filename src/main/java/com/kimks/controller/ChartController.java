package com.kimks.controller;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.kimks.domain.StatChartVO;
import com.kimks.service.ChartService;

import lombok.AllArgsConstructor;

@Controller
@RequestMapping("/admin/chart/*")
@AllArgsConstructor
public class ChartController {

	private ChartService service;
	@GetMapping("/statistics")
	public void statistics(Model model) {
		/*
		[
        ["Element", "Density", { role: "style" } ],
        ["Copper", 8.94, "#b87333"],
        ["Silver", 10.49, "silver"],
        ["Gold", 19.30, "gold"],
        ["Platinum", 21.45, "color: #e5e4e2"]
        ];
		 */
		List<StatChartVO> yearSalesList = service.yearSales();
		
		String source = "[['Year', 'Sales' ,{ role: \'style\' }],";
		int c = 0;
		for(StatChartVO vo : yearSalesList) {
			source += "['" + vo.getYear()+"', " + vo.getTotal() + ", 'powderblue']";
			c++;
			if(c<yearSalesList.size()) {
				source +=",";
			}
		}
		source += "]";
		model.addAttribute("data", source);
	}
	
	@GetMapping("/searchStatistics")
	public void searchStatistics(@RequestParam("year") String year, Model model) {

		List<StatChartVO> monthSalesList = service.monthSalesSearch(year);
		
		List<StatChartVO> yearSalesList = service.yearSales();
		
		String source = "[['Month', 'Sales' ,{ role: \'style\' }],";
		int c = 0;
		for(StatChartVO vo : monthSalesList) {
			source += "['" + vo.getYear()+"', " + vo.getTotal() + ", 'powderblue']";
			c++;
			if(c<monthSalesList.size()) {
				source +=",";
			}
		}
		source += "]";
		model.addAttribute("data", source);
		model.addAttribute("years", yearSalesList);
	}
	
	@GetMapping("/monthStatistics")
	public void monthStatistics(Model model) {

		List<StatChartVO> monthSalesList = service.monthSales();
		
		List<StatChartVO> yearSalesList = service.yearSales();
		
		String source = "[['Month', 'Sales' ,{ role: \'style\' }],";
		int c = 0;
		for(StatChartVO vo : monthSalesList) {
			source += "['" + vo.getYear()+"', " + vo.getTotal() + ", 'powderblue']";
			c++;
			if(c<monthSalesList.size()) {
				source +=",";
			}
		}
		source += "]";
		model.addAttribute("data", source);
		model.addAttribute("years", yearSalesList);
	}
	
	@GetMapping("/weekStatistics")
	public void weekStatistics(Model model) {
	
		List<StatChartVO> weekSalesList = service.weekSales();
		
		String source = "[['Week', 'Sales' ,{ role: \'style\' }],";
		int c = 0;
		for(StatChartVO vo : weekSalesList) {
			source += "['" + vo.getYear()+"', " + vo.getTotal() + ", 'powderblue']";
			c++;
			if(c<weekSalesList.size()) {
				source +=",";
			}
		}
		source += "]";
		model.addAttribute("data", source);
	}
	
	@GetMapping("/weekSearch")
	public void weekSearch(@RequestParam("searchDate") String searchDate, Model model) {
	
		List<StatChartVO> weekSalesList = service.weekSalesSearch(searchDate);
		
		String source = "[['Week', 'Sales' ,{ role: \'style\' }],";
		int c = 0;
		for(StatChartVO vo : weekSalesList) {
			source += "['" + vo.getYear()+"', " + vo.getTotal() + ", 'powderblue']";
			c++;
			if(c<weekSalesList.size()) {
				source +=",";
			}
		}
		source += "]";
		model.addAttribute("data", source);
	}
}
