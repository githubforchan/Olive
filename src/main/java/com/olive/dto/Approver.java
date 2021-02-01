package com.olive.dto;

import java.util.Date;

import lombok.Data;

@Data
public class Approver {
	private int docno;
	private int app_Order;
	private int app_Check;
	private Date app_Date;
	private String comment;
	private int empno;
	private int total_Approval; 
	private int curr_Approval;
	private String ename;
	private String title;
	private Date writedate;
	private int statusCode;
	private String deptname;
	private String positionname;
	private int typeCode;
	private String typeName;
}
