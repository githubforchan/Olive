package com.olive.utils;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.springframework.web.servlet.view.document.AbstractExcelView;


public class SalaryExcelFormat extends AbstractExcelView {

	@Override
	protected void buildExcelDocument(Map<String, Object> model, HSSFWorkbook workbook, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		response.setHeader("Content-Disposition", "attachment; filename=\"SalaryForm.xls\";");
		HSSFSheet sheet = createFirstSheet(workbook);
		createColumnLabel(sheet);
	}
	
	private HSSFSheet createFirstSheet(HSSFWorkbook workbook) {
		HSSFSheet sheet = workbook.createSheet();
		workbook.setSheetName(0, "급여지급");
		sheet.setDefaultColumnWidth(15);
		return sheet;
	}
	
	//Excel Sheet 1행(컬럼 생성)
	private void createColumnLabel(HSSFSheet sheet) {
		HSSFRow	row = sheet.createRow(0); //1행
		HSSFCell cell;
		cell = row.createCell(0);
		cell.setCellValue("지급일자");
		cell = row.createCell(1);
		cell.setCellValue("사번");
		cell = row.createCell(2);
		cell.setCellValue("기본급");
		cell = row.createCell(3);
		cell.setCellValue("시간외수당");
		cell = row.createCell(4);
		cell.setCellValue("직책수당");
		cell = row.createCell(5);
		cell.setCellValue("상여금");
		cell = row.createCell(6);
		cell.setCellValue("차량유지");
		cell = row.createCell(7);
		cell.setCellValue("식대");
		cell = row.createCell(8);
		cell.setCellValue("교육지원");
	}

}
