package com.kimks.controller;

import java.util.List;

import org.apache.poi.xssf.streaming.SXSSFWorkbook;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.kimks.domain.MemberVO;
import com.kimks.service.ExcelService;

import lombok.AllArgsConstructor;

@Controller
@AllArgsConstructor
@RequestMapping("/excel/*")
public class ExcelController {

	private ExcelService service;
	
	@PostMapping("/downloadExcelFile")
	public String downloadExcelFile(Model model) {
		
		List<MemberVO> list = service.getListExel();
		SXSSFWorkbook workbook = service.excelFileDownLoadProcess(list);
		model.addAttribute("workbook", workbook);
		return "excelDownLoadView"; //servlet-context.xml bean설정에 의해 bean이름으로 해석
	}
}
