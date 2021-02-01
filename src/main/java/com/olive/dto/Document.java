package com.olive.dto;

import java.util.Date;
import java.util.List;

import org.springframework.web.multipart.commons.CommonsMultipartFile;

import lombok.Data;

@Data
public class Document {
	private int docno;
	private int empno;
	private Date writedate;
	private String content;
	private int total_Approval;
	private int curr_Approval;
	private String filename;
	// emp에서 직접 가져오기위해서
	private String ename;
	//상태 관련 코드
	private int statusCode;
	private String statusName;
	//문서 종류 관련 코드 
	private int typeCode;
	private String typeName;
	private CommonsMultipartFile file;
	//추가 문서관련
	private String title;
	private Date start;
	private Date end;
	private int annual;
	private int count;
	private int diff;
	private String color;
	
	
	private List<String> approvers;
	private List<String> referrers;
}
