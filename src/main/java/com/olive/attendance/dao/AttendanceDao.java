/*
	파일명:AttendanceDao.java 
	설명: 근태관리 dao  
	작성자 : 심재형 
	작성일 : 2020-12-28 
	수정자 : 백희승
	수정일 : 2020-01-07
 */
package com.olive.attendance.dao;

import java.util.List;
import java.util.Map;

import com.olive.dto.Att_Record;
import com.olive.dto.Document;
import com.olive.dto.WorkHourPerWeek;
import com.olive.utils.Criteria;

public interface AttendanceDao {
	// 출근 확인
	public Map<String, Object> isPunchedIn(String empno);
	
	// 출근처리
	public void startwork(Att_Record attrecord);

	// 퇴근처리
	public void endwork(Att_Record attrecord);

	// 근태관리 테이블/캘린더 select
	public List<Att_Record> gettableList(String empno);
	
	// 근태관리 테이블/캘린더 radio select
	public List<Att_Record> gettableUserList(String empno);
	
	// 휴가관리  card select
	public Document annualCard(String empno);
	
	// 휴가관리  테이블/캘린더 select
	public List<Document> getanaltableList(String empno);

	// 휴가관리  캘린더 radio select
	public List<Document> getanaltableUserList(String empno);

	// 희승 : 이번 주 총 근무시간
	public WorkHourPerWeek getHoursPerWeek(String empno);

	// 희승 : 이번 주 요일별 근무시간
	public List<Att_Record> getHoursEachDays(String empno);

	// 희승 : Criteria 상속된 조건으로 리스트 개수 검색
	public int getListCount(Criteria cri);
	
	// 희승 : Criteria 상속된 기본 조건 리스트 반환
	public List<Map<String, Object>> getList(Criteria cri);
	
	// 희승 : Criteria 상속된 동적 쿼리 조건 리스트 반환
	public List<Map<String, Object>> getAttList(Criteria cri);
	
	// 희승 : 부서 이름 가져오기
	public String getDeptName(String empno);
}