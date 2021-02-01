package com.olive.utils;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.springframework.web.servlet.view.document.AbstractExcelView;

import com.olive.dto.Emp;

@SuppressWarnings("deprecation")
public class EmpTableToExcel extends AbstractExcelView{

	@Override
	protected void buildExcelDocument(Map<String, Object> model, HSSFWorkbook workbook, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		response.setHeader("Content-Disposition", "attachment; filename=\"EmpList.xls\";");
		HSSFSheet sheet = createFirstSheet(workbook);
		createColumnLabel(sheet);
		List<Map<String, Object>> list = (List<Map<String, Object>>)model.get("list");
		
		int rowNum = 1;
		
		for(Map<String, Object> emp : list) {
			createColumnData(sheet, emp, rowNum);
			rowNum++;
		}
	}
	private HSSFSheet createFirstSheet(HSSFWorkbook workbook) {
		HSSFSheet sheet = workbook.createSheet();
		workbook.setSheetName(0, "사원정보");
		sheet.setDefaultColumnWidth(15);
		return sheet;
	}
	
	//Excel Sheet 1행(컬럼 생성)
		private void createColumnLabel(HSSFSheet sheet) {
			HSSFRow	row = sheet.createRow(0); //1행
			HSSFCell cell;
			cell = row.createCell(0);
			cell.setCellValue("EMPNO");
			cell = row.createCell(1);
			cell.setCellValue("ENAME");
			cell = row.createCell(2);
			cell.setCellValue("EMAIL");
			cell = row.createCell(3);
			cell.setCellValue("HIREDATE");
			cell = row.createCell(4);
			cell.setCellValue("LEAVEDATE");
			cell = row.createCell(5);
			cell.setCellValue("ANNUAL");
			cell = row.createCell(6);
			cell.setCellValue("CLASSNAME");
			cell = row.createCell(7);
			cell.setCellValue("POSITIONNAME");
			cell = row.createCell(8);
			cell.setCellValue("DEPTNAME");
			cell = row.createCell(9);
			cell.setCellValue("HEADNAME");
			cell = row.createCell(10);
			cell.setCellValue("STATUSNAME");
		}
		
		private void createColumnData(HSSFSheet sheet, Map<String, Object> emp, int rowNum) {
			HSSFRow row = sheet.createRow(rowNum);
			HSSFCell cell;
			cell = row.createCell(0);
			cell.setCellValue(String.valueOf(emp.get("EMPNO")));
			cell = row.createCell(1);
			cell.setCellValue(String.valueOf(emp.get("ENAME")));
			cell = row.createCell(2);
			cell.setCellValue(String.valueOf(emp.get("EMAIL")));
			cell = row.createCell(3);
			cell.setCellValue(String.valueOf(emp.get("HIREDATE")));
			cell = row.createCell(4);
			cell.setCellValue(String.valueOf(emp.get("LEAVEDATE")));
			cell = row.createCell(5);
			cell.setCellValue(String.valueOf(emp.get("ANNUAL")));
			cell = row.createCell(6);
			cell.setCellValue(String.valueOf(emp.get("CLASSNAME")));
			cell = row.createCell(7);
			cell.setCellValue(String.valueOf(emp.get("POSITIONNAME")));
			cell = row.createCell(8);
			cell.setCellValue(String.valueOf(emp.get("DEPTNAME")));
			cell = row.createCell(9);
			cell.setCellValue(String.valueOf(emp.get("HEADNAME")));
			cell = row.createCell(10);
			cell.setCellValue(String.valueOf(emp.get("STATUSNAME")));
		}
	
	
}
