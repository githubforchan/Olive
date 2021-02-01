/*
	파일명: Position.java
    설명: 부서 내 역할(Position) DTO 객체
    작성일: 2021-01-02
    작성자: 백희승
*/
package com.olive.dto;

import lombok.Data;

@Data
public class Position {
	private int positionCode;
	private String positionName;
	private int positionSal;
}
