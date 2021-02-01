/*
	파일명:AttendanceService.java 
	설명: 근태관리 서비스
	작성일 : 2020-12-28 
	수정일 : 2020-01-07
	작성자 : 심재형 
*/

package com.olive.attendance.service;


import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Service;

import com.olive.attendance.dao.AttendanceDao;
import com.olive.dto.Document;

@Service
public class AnnualService {
		private SqlSession sqlsession;
	
		@Autowired
		   public void setSqlsession(SqlSession sqlsession) {
		      this.sqlsession = sqlsession;
		      System.out.println(this.sqlsession);
		      System.out.println("연결");
		   }

	

//=================== 휴가 캘린더  ===================// 
			
		public List<Document> calendarList () {
			Authentication auth = SecurityContextHolder.getContext().getAuthentication();
			AttendanceDao analcaldao = sqlsession.getMapper(AttendanceDao.class);
			return analcaldao.getanaltableList(auth.getName());			
		}
//=================== 휴가 캘린더 radio select ===================// 
		
		public List<Document> calendarUserList (String empno) {
			AttendanceDao analcaldao = sqlsession.getMapper(AttendanceDao.class);
			return analcaldao.getanaltableUserList(empno);			
		}
//=================== 휴가 카드  ===================// 



		public Document annualCard(String empno) {
			AttendanceDao annualCard = sqlsession.getMapper(AttendanceDao.class);
			return annualCard.annualCard(empno);	
		
		}
		




}
