package com.olive.utils;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

//게시판 페이징 전용 클래스
@Getter
@Setter
@ToString
public class Pagination {
	
	private Criteria cri;
	
	private int totalCount; // 총 게시물 갯수
	
	private int startPage;	// 시작 페이지 번호
	private int endPage;	// 끝 페이지 번호
	private boolean prev;	// 이전 버튼의 유무
	private boolean next;	// 다음 버튼의 유무
	private int displayPageNum = 5; //미리 설정

	public Pagination(Criteria cri, int totalCount) {
		this.cri = cri;
		this.totalCount = totalCount;
		calcData();
	}
        
    private void calcData() {
        
    	int tempEndPage = (int) (Math.ceil(totalCount / (double) cri.getPerPageNum()));

    	endPage = (int) (Math.ceil(cri.getPage() / (double) displayPageNum) * displayPageNum);
    	if (endPage > tempEndPage) {
    		endPage = tempEndPage;
    	}
        
    	startPage = (endPage - displayPageNum) + 1;
        if(startPage <= 0) startPage = 1;
        
 
        prev = startPage == 1 ? false : true;
        next = endPage * cri.getPerPageNum() < totalCount ? true : false;
    }
}