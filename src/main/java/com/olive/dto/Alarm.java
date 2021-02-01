package com.olive.dto;

import java.util.Date;

import lombok.Data;

@Data
public class Alarm {
	//알람 insert 하기 위한 것
	private int alarmno;
	private Date alarmTime;
	private int empno;
	private String content;
	private boolean alarmCheck;
	private int alarmCount;
	
	//알람을 보내기 위한 것 
	private String color;
	private String nextApprover;
	private String approver;
	private String docWriter;
	private String docno;
}