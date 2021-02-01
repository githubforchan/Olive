/*
	파일명:AttendanceController.java 
	설명: 근태관리 Dto
	작성일 : 2020-12-28
	수정일 : 2020-01-07
	작성자 : 심재형 
*/
package com.olive.dto;

import java.util.Date;

import lombok.Data;

@Data
public class Att_Record {
	private Date date;
	private int empNo;
	private Date start;
	private Date end;
	private int attCode;
	private String title;
	private String color ;
	private String weekDays;
	private int dayTotalHours;
	private int dayTotalMinutes;
	private int overHours;
	private int overMinutes;
}
