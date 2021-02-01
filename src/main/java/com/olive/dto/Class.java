/*
	파일명: Class.java
    설명: 사원 테이블의 직급 DTO 객체 ( + 급여 계산시도 사용 )
    작성일: 2021-01-02
    작성자: 백희승
*/
package com.olive.dto;

import lombok.Data;

@Data
public class Class {
	private int classCode;
	private String className;
	private int classSal;
}
