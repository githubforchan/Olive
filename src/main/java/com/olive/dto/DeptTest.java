package com.olive.dto;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.Data;

@Data
public class DeptTest {
	private int deptCode;
	private String deptName;
	private int headCode;
	//private int headCode;
	private String headName;
	private int empNo;
	private String pwd;
	private String ename;
	private String email;
	private String pic;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date hireDate;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date leaveDate;
	private int annaul;
	private int classCode;
	private int positionCode;
	//private int deptCode;
	private int statusCode;
	private boolean enabled;
	private int loginCount;
	private int alarm;
	private String birth;
	//private int positionCode;
	private String positionName;
	private int positionSal;
}
