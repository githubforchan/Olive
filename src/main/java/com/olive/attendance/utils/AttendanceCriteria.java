/*
	파일명: AttendanceCriteria.java 
	설명: Criteria.java를 상속하여 비동기 데이터 송수신 시 쿼리 조건에 따라 반환된 객체 + 페이징 지원
	작성일 : 2021-01-13 
	작성자 : 백희승
*/
package com.olive.attendance.utils;

import com.olive.utils.Criteria;

import lombok.Data;
import lombok.ToString;

@Data
@ToString
public class AttendanceCriteria extends Criteria {
	private String table;	
	private String column;
	private String sort;

	// 쿼리 조건에 해당하는 멤버필드 : 동적쿼리 구성이 2가지 가능하다.
	private String searchType;
	private String searchType2;
	private String searchType3;
	private String keyword;
	private String keyword2;
	private String keyword3;

	private int page;
	private int perPageNum;
	
	private int rowStart;

	public AttendanceCriteria() {
		this.page = 1; // 현재 페이지
		this.perPageNum = 5; // 보여주는 페이지갯수
		
		this.searchType = "1"; 
		this.keyword = this.searchType; // 검색어
		
		this.searchType2 = "0";
		this.keyword2 = "1";
		
		this.searchType3 = "0";
		this.keyword3 = "1";
	}

	public void setPage(int page) { // 현재 페이지
		this.page = (page <= 0) ? 1 : page;
	}

	public void serPerPageNum(int perPageNum) {
		this.perPageNum = (perPageNum <= 0 || perPageNum > 100) ? 5 : perPageNum;
	}

	public void setSearchType(String searchType) {
		this.searchType = searchType;
	}

	public void setKeyword(String keyword) {
		this.keyword = keyword;
	}

	private int setRowStart() { // 게시글 글 번호
		return ((page - 1) * perPageNum);
	}
	
	@Override
	public void setCriteria(String table, String column, String sort) {
		this.table = table;
		this.column = column;
		this.sort = sort;
		this.rowStart = setRowStart();
	}
	
	public void setFirstCondition(String searchType, String keyword) {
		this.searchType = searchType;
		this.keyword = keyword;
	}
	
	public void setSecondCondition(String searchType2, String keyword2) {
		this.searchType2 = searchType2;
		this.keyword2 = keyword2;
	}
	
	public void setThirdContdition(String searchType3, String keyword3) {
		this.searchType3 = searchType3;
		this.keyword3 = keyword3;
	}
	
	public void setFullCondition(String searchType, String keyword, String searchType2, String keyword2, String searchType3, String keyword3) {
		this.searchType = searchType;
		this.keyword = keyword;
		this.searchType2 = searchType2;
		this.keyword2 = keyword2;
		this.searchType3 = searchType3;
		this.keyword3 = keyword3;
	}
}
