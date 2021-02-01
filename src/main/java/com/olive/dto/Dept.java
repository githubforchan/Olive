/*
	파일명: Dept.java
    설명: 부서 테이블 DTO 객체
    작성일: 2021-01-02
    작성자: 백희승
*/
package com.olive.dto;

import lombok.Data;

@Data
public class Dept {
	private int deptCode;
	private String deptName;
	private int headCode;
	private String headName;
}
