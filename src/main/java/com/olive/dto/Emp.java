/*
	파일명: Emp.java
    설명: 사원(Emp) DTO 객체
    작성일: 
    작성자: 
*/
package com.olive.dto;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.web.multipart.commons.CommonsMultipartFile;

import lombok.Data;

@Data
public class Emp {
	private int empNo;
	private String pwd;
	private String ename;
	private String email;
	private String pic;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date hireDate;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date leaveDate;
	private int annual;
	private int classCode;
	private String classname;
	private int positionCode;
	private String positionname;
	private int deptCode;
	private String deptname;
	private int statusCode;
	private String statusname;
	private boolean enabled;
	private int loginCount;
	private int alarm;
	private String birth;
	private String phone;
	private String address;
	private String headname;
	private int headcode;
	private CommonsMultipartFile file;
	private String usedAnnual;	
}
