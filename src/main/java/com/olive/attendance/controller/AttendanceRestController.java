/*
	파일명:AttendanceRestController.java 
	설명: 근태관리 컨트롤러
	작성일 : 2020-12-28   
	수정일 : 2020-01-07
	작성자 : 심재형 
 */
package com.olive.attendance.controller;

import java.security.Principal;
import java.text.SimpleDateFormat;
import java.util.Collection;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.olive.attendance.service.AttendanceService;
import com.olive.attendance.utils.AttendanceCriteria;
import com.olive.dto.Att_Record;
import com.olive.utils.Pagination;

@RestController
@RequestMapping("/attendance/")
public class AttendanceRestController {

	private AttendanceService service;

	@Autowired
	public void setAttendanceService(AttendanceService attendanceservice) {
		this.service = attendanceservice;
	}

	@InitBinder
	public void initBinder(WebDataBinder binder) {
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		binder.registerCustomEditor(Date.class, new CustomDateEditor(dateFormat, true));
	}

	// 출근 확인
	@RequestMapping(value = "isPunchedIn.do", method = RequestMethod.POST)
	public Map<String, Object> isPunchedIn() {
		HashMap<String, Object> record = null;

		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		String username = auth.getName();

		try {
			record = (HashMap<String, Object>) service.isPunchedIn(username);

		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		// 출근하지 않았다면 record == null, 이미 출근했다면 record != null
		return record;
	}

	// 출근하기
	@RequestMapping(value = "startWork.do", method = RequestMethod.POST)
	public Map<String, Object> startWork() {
		HashMap<String, Object> record = null;

		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		String username = auth.getName();

		try {
			service.startwork(Integer.parseInt(username));
			record = (HashMap<String, Object>) service.isPunchedIn(username);
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}

		// 출근 처리 후 처리된 record를 반환
		return record;
	}

	// 퇴근 처리
	@RequestMapping(value = "endWork.do", method = RequestMethod.POST)
	public Map<String, Object> endWork() {
		HashMap<String, Object> record = null;

		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		String username = auth.getName();

		try {
			service.endwork(Integer.parseInt(username));
			record = (HashMap<String, Object>) service.isPunchedIn(username);
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}

		return record;
	}

	// =================== 근태 출/퇴근 테이블 select ===================//
	@RequestMapping(value = "attTableList.do", method = RequestMethod.GET)
	public List<Att_Record> attTableList() {
		List<Att_Record> tableList = null;
		tableList = service.tableList();
		System.out.println("서비스에서가져옴 ");
		return tableList;
	}

	// =================== 근태 캘린더 select ===================//
	@ResponseBody
	@RequestMapping(value = "calendarList.do", method = RequestMethod.GET)
	public List<Att_Record> calendarList() {
		List<Att_Record> calendarList = null;
		System.out.println("1");
		calendarList = service.calendarList();
		System.out.println("캘린더리스트" + calendarList);
		return calendarList;
	}
	

	// =================== 근태 테이블테스트 ===================//
	@RequestMapping(value = "attPage.do", method = RequestMethod.POST)
	public JSONObject attPage(AttendanceCriteria cri, Principal principal) {
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		String username = auth.getName();

		System.out.println(cri);
		cri.setCriteria("rectable", "starttime", "desc");
		cri.setFirstCondition("deptName", service.getDeptName(username));
		if (!userHasRole(auth, "ROLE_MANAGER")) {
			cri.setSecondCondition("empno", username);
		}
		
		System.out.println("***********매니저 검색시작 : " + cri);
		int totalCount = service.getListCount(cri);
		Pagination pagination = new Pagination(cri, totalCount);
		List<Map<String, Object>> result = service.getList(cri);

		
		System.out.println("***********Pagenation : " + pagination);
		System.out.println("***********result : " + result);
		
		JSONObject jsonObject = new JSONObject();
		jsonObject.put("list", result);
		jsonObject.put("pagination", pagination);
		jsonObject.put("criteria", cri);
		jsonObject.put("auth", auth.getAuthorities());

		return jsonObject;
	}

	// 희승 : 권한 체크 함수
	private boolean userHasRole(Authentication auth, String role) {
		Collection<? extends GrantedAuthority> authorities = auth.getAuthorities();

		return authorities.contains(new SimpleGrantedAuthority(role));
	}

	// =================== 근태 캘린더 radio select ===================//

	@RequestMapping(value = "calendarUserList.do", method = RequestMethod.POST)
	public List<Att_Record> calendarUserList(String empno) {
		List<Att_Record> calendarUserList = null;
		calendarUserList = service.calendarUserList(empno);
		return calendarUserList;
	}
}
