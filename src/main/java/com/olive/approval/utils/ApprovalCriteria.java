package com.olive.approval.utils;

import com.olive.utils.Criteria;

import lombok.Data;

@Data
public class ApprovalCriteria extends Criteria {
	
	private String searchType2; // 검색타입
	private String keyword2; // 검색어
	//Controller에서 직접 넣어줘야 되
	private String table; // Table OR View 이름
	private String column; // 정렬 컬럼
	private String sort; // 정렬 방법 (asc or desc)
	
	//View로부터 받는것
	private String searchType; // 검색타입
	private String keyword; // 검색어
	private int page;
	private int perPageNum;
	
	//자동으로 계산됨
	private int rowStart;
	
	public ApprovalCriteria() {
		this.page = 1; //현재 페이지 
		this.perPageNum = 5; //보여주는 페이지갯수 
		this.searchType = "1"; // 검색할 nav바 
		this.keyword = this.searchType; //검색어 
		this.searchType2= "1";
		this.keyword2=this.searchType2;
		
	}
	
	public void setPage(int page) { //현재 페이지 
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
	
	
	private int setRowStart() { //게시글 글 번호 
		return ((page - 1) * perPageNum);
	}

	public void setCriteria(String table, String column, String sort) {
		this.table = table;
		this.column = column;
		this.sort = sort;
		this.rowStart = setRowStart();
	}
	
	
	

}
