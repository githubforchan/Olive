package com.olive.utils;

import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;

import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

public class ExcelFileType {

	public static Workbook getWorkbook(String filePath) {
		FileInputStream fis = null;
		try {
			fis = new FileInputStream(filePath);
		} catch (FileNotFoundException e) {
			throw new RuntimeException(e.getMessage(), e);
		}
		
		Workbook workbook = null;

		if (filePath.endsWith("xls")) {
				try {
					workbook = new HSSFWorkbook(fis);
				} catch (IOException e) {
					e.printStackTrace();
				}
				
		} else if (filePath.endsWith("xlsx")) {
				try {
					workbook = new XSSFWorkbook(fis);
				} catch (IOException e) {
					e.printStackTrace();
				}
		}
		System.out.println("workbook : " + workbook);
		return workbook;
	}
}
