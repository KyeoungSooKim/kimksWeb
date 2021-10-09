package com.kimks.service;

import java.util.List;

import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.CreationHelper;
import org.apache.poi.xssf.streaming.SXSSFCell;
import org.apache.poi.xssf.streaming.SXSSFRow;
import org.apache.poi.xssf.streaming.SXSSFSheet;
import org.apache.poi.xssf.streaming.SXSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kimks.domain.MemberVO;
import com.kimks.mapper.ExcelMapper;

import lombok.Setter;

@Service
public class ExcelServiceImpl implements ExcelService {

	@Setter(onMethod_ = @Autowired)
	private ExcelMapper mapper;
	
	@Override
	public List<MemberVO> getListExel() {
		// TODO Auto-generated method stub
		return mapper.getListExel();
	}

	@Override
	public SXSSFWorkbook excelFileDownLoadProcess(List<MemberVO> list) {
		// TODO Auto-generated method stub
		return this.makeMemberVOExcelWorkbook(list);
	}

	public SXSSFWorkbook makeMemberVOExcelWorkbook(List<MemberVO> list) {
		//통합문서 생성
		SXSSFWorkbook workbook = new SXSSFWorkbook();
		//시트생성
		SXSSFSheet sheet = workbook.createSheet("회원목록");
		//열 넓이
		sheet.setColumnWidth(0, 2000);
		sheet.setColumnWidth(1, 1500);
		sheet.setColumnWidth(2, 6000);
		sheet.setColumnWidth(3, 1500);
		sheet.setColumnWidth(4, 8000);
		sheet.setColumnWidth(5, 2000);
		sheet.setColumnWidth(6, 4000);
		sheet.setColumnWidth(7, 5000);
		sheet.setColumnWidth(8, 5000);
		
		//행
		SXSSFRow titleRow = sheet.createRow(0);
		//행의 셀
		SXSSFCell titleCell = titleRow.createCell(0);
		titleCell.setCellValue("아이디");
		titleCell = titleRow.createCell(1);
		titleCell.setCellValue("이름");
		titleCell = titleRow.createCell(2);
		titleCell.setCellValue("이메일");
		titleCell = titleRow.createCell(3);
		titleCell.setCellValue("지번");
		titleCell = titleRow.createCell(4);
		titleCell.setCellValue("주소1");
		titleCell = titleRow.createCell(5);
		titleCell.setCellValue("주소2");
		titleCell = titleRow.createCell(6);
		titleCell.setCellValue("전화번호");
		titleCell = titleRow.createCell(7);
		titleCell.setCellValue("가입일");
		titleCell = titleRow.createCell(8);
		titleCell.setCellValue("수정일");
		
		SXSSFRow dataRow = null;
		SXSSFCell dataCell = null;
		
		CellStyle style = workbook.createCellStyle();
		CreationHelper helper = workbook.getCreationHelper();
		style.setDataFormat(helper.createDataFormat().getFormat("yyyy-MM-dd hh:mm:ss"));
		
		for(int i=0; i<list.size(); i++) {
			MemberVO vo = list.get(i);
			//행 생성
			dataRow = sheet.createRow(i+1);
			//행의 셀 작업
			dataCell = dataRow.createCell(0);
			dataCell.setCellValue(vo.getU_id());
			dataCell = dataRow.createCell(1);
			dataCell.setCellValue(vo.getU_name());
			dataCell = dataRow.createCell(2);
			dataCell.setCellValue(vo.getU_email());
			dataCell = dataRow.createCell(3);
			dataCell.setCellValue(vo.getU_zipcode());
			dataCell = dataRow.createCell(4);
			dataCell.setCellValue(vo.getU_addr());
			dataCell = dataRow.createCell(5);
			dataCell.setCellValue(vo.getU_addr_d());
			dataCell = dataRow.createCell(6);
			dataCell.setCellValue(vo.getU_phone());

			dataCell = dataRow.createCell(7);
			dataCell.setCellValue(vo.getU_regdate());
			dataCell.setCellStyle(style);
			
			dataCell = dataRow.createCell(8);
			dataCell.setCellValue(vo.getU_updatedate());
			dataCell.setCellStyle(style);
		}
		return workbook;
	}
}
