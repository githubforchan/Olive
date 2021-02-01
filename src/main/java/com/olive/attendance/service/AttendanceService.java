/*
	파일명:AttendanceService.java 
	설명: 근태관리 서비스
	작성일 : 2020-12-28 
	수정일 : 2020-01-07
	작성자 : 심재형 
*/

package com.olive.attendance.service;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Service;

import com.olive.attendance.dao.AttendanceDao;
import com.olive.dto.Att_Record;
import com.olive.dto.WorkHourPerWeek;
import com.olive.utils.Criteria;

@Service
public class AttendanceService {
	private SqlSession sqlsession;

	@Autowired
	public void setSqlsession(SqlSession sqlsession) {
		this.sqlsession = sqlsession;
	}

	// 재형 : 출근
	public void startwork(int id) {
		AttendanceDao attdao = sqlsession.getMapper(AttendanceDao.class);

		int attcode = 0;
		Date tardyDate = new Date();// 지각 기준시간
		Date curDate = new Date();// 현재시간
		SimpleDateFormat dateFormat = new SimpleDateFormat("YYYY-MM-DD HH:mm:ss");// string 날짜형식 정의
		SimpleDateFormat tardyFormat = new SimpleDateFormat("YYYY-MM-DD 09:00:00");// string 날짜형식 정의
		String curDatestr = dateFormat.format(curDate);
		String tardyDatestr = dateFormat.format(tardyDate);

		try {

			Date tardyDateFormat = dateFormat.parse(tardyDatestr);
			Date curDateFormat = dateFormat.parse(curDatestr);
			if (curDateFormat.getTime() < tardyDateFormat.getTime()) {
				attcode = 10;

			} else {
				attcode = 20;
			}
			Att_Record att = new Att_Record();
			att.setAttCode(attcode);
			att.setEmpNo(id);
			attdao.startwork(att);

		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	// 재형 : 퇴근 버튼 update
	public void endwork(int id) {
		AttendanceDao attdao = sqlsession.getMapper(AttendanceDao.class);
		int attcode = 70;// 퇴근 근태코드
		Date curDate = new Date();// 현재시간
		SimpleDateFormat dateFormat = new SimpleDateFormat("HH:mm:ss");// string 날짜형식 정의
		String curDatestr = dateFormat.format(curDate);
		try {
			Att_Record att = new Att_Record();
			att.setAttCode(attcode);
			att.setEmpNo(id);
			attdao.endwork(att);

		} catch (Exception e) {
			// TODO: handle exception
		}
	}

	// 재형 : 근태 출/퇴근 테이블 select
	public List<Att_Record> tableList() {
		AttendanceDao tabledao = sqlsession.getMapper(AttendanceDao.class);
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		return tabledao.gettableList(auth.getName());
	}


	// 재형 : 근태 캘린더
	public List<Att_Record> calendarList() {
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		AttendanceDao caldao = sqlsession.getMapper(AttendanceDao.class);
		return caldao.gettableList(auth.getName());
	}
	// 재형 : 근태 캘린더 radio select
	public List<Att_Record> calendarUserList(String empno) {
		AttendanceDao attcaldao = sqlsession.getMapper(AttendanceDao.class);
		return attcaldao.gettableUserList(empno);
	}

	// 희승 : 이번 주 총 근무시간
	public WorkHourPerWeek getHoursPerWeek(String empno) {
		AttendanceDao dao = sqlsession.getMapper(AttendanceDao.class);
		WorkHourPerWeek workHours = dao.getHoursPerWeek(empno);
		return workHours;
	}


	// 희승 : 이번 주 요일별 근무시간
	public List<Att_Record> getHoursEachDays(String empno) {
		AttendanceDao dao = sqlsession.getMapper(AttendanceDao.class);
		List<Att_Record> hoursEachList = dao.getHoursEachDays(empno);
		return hoursEachList;
	}
	
	// 희승 : Criteria 상속된 조건으로 리스트 개수 검색
	public int getListCount(Criteria cri) {
		AttendanceDao dao = sqlsession.getMapper(AttendanceDao.class);
		return dao.getListCount(cri);
	}
		
	// 희승 : Criteria 상속된 기본 조건 리스트 반환
	public List<Map<String, Object>> getList(Criteria cri){
		AttendanceDao dao = sqlsession.getMapper(AttendanceDao.class);
		return dao.getList(cri);
	}
		
	// 희승 : Criteria 상속된 동적 쿼리 조건 리스트 반환
	public List<Map<String, Object>> getAttList(Criteria cri){
		AttendanceDao dao = sqlsession.getMapper(AttendanceDao.class);
		return dao.getAttList(cri);
	}
		
	// 희승 : 부서번호 가져오기
	public String getDeptName(String empno) {
		AttendanceDao dao = sqlsession.getMapper(AttendanceDao.class);
		return dao.getDeptName(empno);
	}
	
	// 희승 : 출근 확인
	public Map<String, Object> isPunchedIn(String empno) {
		AttendanceDao dao = sqlsession.getMapper(AttendanceDao.class);
		return dao.isPunchedIn(empno);
	}
	
	public Map<String,Object> arrangedAtt(){
		SimpleDateFormat format = new SimpleDateFormat("MM");
		Calendar cal = Calendar.getInstance();
		int thisMonth = cal.get(cal.MONTH)+1;
		List<Att_Record> attlist = calendarList();
		Map <String, Object> attMap = new HashMap<>();
		ArrayList<Att_Record> normal = new ArrayList();
		ArrayList<Att_Record> over = new ArrayList();
		ArrayList<Att_Record> early = new ArrayList();
		ArrayList<Att_Record> none = new ArrayList();
		for(Att_Record att : attlist) {
			if(Integer.parseInt(format.format(att.getDate())) == thisMonth) {
				if(att.getAttCode()==80) { 
					normal.add(att);
				}else if(att.getAttCode()==20) {
					over.add(att);
				}else if(att.getAttCode()==30) {
					early.add(att);
				}else if(att.getAttCode()==40) {
					none.add(att);
				}
			};
		}
		attMap.put("normal", normal);
		attMap.put("over", over);
		attMap.put("early", early);
		attMap.put("none", none);
		
		return attMap;
	}
}
