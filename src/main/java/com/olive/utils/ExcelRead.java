package com.olive.utils;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.poi.openxml4j.exceptions.InvalidFormatException;
import org.apache.poi.openxml4j.opc.OPCPackage;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFCell;
import org.apache.poi.xssf.usermodel.XSSFRow;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.web.multipart.MultipartFile;

import com.olive.dto.Sal_Record;

public class ExcelRead {

	public static List<Map<String, String>> read(ExcelReadOption excelReadOption) {

		Workbook workbook = ExcelFileType.getWorkbook(excelReadOption.getFilePath());

		Sheet sheet = workbook.getSheetAt(0);
		System.out.println("Sheet 이름: " + workbook.getSheetName(0));
		System.out.println("데이터가 있는 Sheet의 수 :" + workbook.getNumberOfSheets());

		int numOfRows = sheet.getPhysicalNumberOfRows();
		System.out.println(numOfRows);
		int numOfCells = 0;

		Row row = null;
		Cell cell = null;
		String cellName = null;
		Map<String, String> map = null;
		List<Map<String, String>> result = new ArrayList<Map<String, String>>();
		for (int rowIndex = excelReadOption.getStartRow()-1; rowIndex < numOfRows; rowIndex++) {
			row = sheet.getRow(rowIndex);
			if (row != null) {
				numOfCells = row.getPhysicalNumberOfCells();
				map = new HashMap<String, String>();	
				for (int cellIndex = 0; cellIndex < numOfCells; cellIndex++) {

					cell = row.getCell(cellIndex);
					System.out.println("[cell]"+cell);

					cellName = sheet.getRow(0).getCell(cellIndex).getStringCellValue()+"";
					System.out.println("[cellName]"+cellName);
					
					if (!excelReadOption.getOutputColumns().contains(cellName)) {
						continue;
					}
					map.put(cellName, ExcelCellRef.getValue(cell));
				}
				result.add(map);
				System.out.println(map);
			}
		}
		return result;
	}
}
