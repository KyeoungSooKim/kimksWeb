package com.kimks.service;

import java.util.List;

import org.apache.poi.xssf.streaming.SXSSFWorkbook;

import com.kimks.domain.MemberVO;

public interface ExcelService {

	public List<MemberVO> getListExel();
	
	public SXSSFWorkbook excelFileDownLoadProcess(List<MemberVO> list);
}
