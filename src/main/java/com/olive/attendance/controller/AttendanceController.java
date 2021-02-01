/*
	파일명:AttendanceController.java 
	설명: 근태관리 컨트롤러 뷰페이지 전달 
	작성일 : 2020-12-28 
	수정일 : 2020-01-07
	작성자 : 심재형 
*/
package com.olive.attendance.controller;

import java.util.Collection;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.olive.attendance.service.AnnualService;
import com.olive.attendance.service.AttendanceService;
import com.olive.attendance.utils.AttendanceCriteria;
import com.olive.dto.Att_Record;
import com.olive.dto.Document;
import com.olive.dto.WorkHourPerWeek;
import com.olive.hr_info.service.Hr_infoService;
import com.olive.utils.Criteria;
import com.olive.utils.Pagination;
import com.olive.utils.service.PagingService;

@Controller
@RequestMapping("/attendance/")
public class AttendanceController {
	@Autowired
	private PagingService pagingService;

	@Autowired
	private AttendanceService attendanceService;

	@Autowired
	private Hr_infoService empService;
	
	@Autowired
	private AnnualService annualService;

	@RequestMapping("annual.do")
	public String mannual(Model model, Criteria cri) {
		System.out.println("cri 값 초기화 전" + cri);
		cri.setCriteria("annual_diff", "docno", "desc");
		System.out.println("cri 값 초기화 후" + cri);

		int totalCount = pagingService.getListCount(cri);
		Pagination pagination = new Pagination(cri, totalCount);
		List<Map<String, Object>> result = pagingService.getList(cri);
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();

		String username = auth.getName();
		System.out.println("emp컨트롤러" + username);
		Map<String, Object> emp = empService.searchEmpByEmpno(username);
		String empno = auth.getName();
		Document annualCard = annualService.annualCard(empno);
		System.out.println("카드"+annualCard);

		model.addAttribute("annualCard", annualCard);
		model.addAttribute("emp", emp);
		model.addAttribute("list", result);
		model.addAttribute("pagination", pagination);
		model.addAttribute("criteria", cri);
		System.out.println("휴가관리" + result);
		return "attendance/Annual";
	}

	@RequestMapping(value = "attendance.do", method = RequestMethod.GET)
	public String mattendance(Model model, AttendanceCriteria cri) {
		// 인증된 사용자의 권한 정보
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		String username = auth.getName();
		
		// 매니저가 아닐 경우 자신의 근태정보만...
		cri.setCriteria("rectable", "starttime", "desc");
		cri.setFirstCondition("deptName", attendanceService.getDeptName(username));
		if( !userHasRole(auth, "ROLE_MANAGER") ) {
			cri.setSecondCondition("empno", username);
		}
		
		int totalCount = attendanceService.getListCount(cri);
		Pagination pagination = new Pagination(cri, totalCount);
		List<Map<String, Object>> result = attendanceService.getList(cri);
		
		WorkHourPerWeek workHours = attendanceService.getHoursPerWeek(username);
		List<Att_Record> hoursEachList = attendanceService.getHoursEachDays(username);
		Map<String, Object> emp = empService.searchEmpByEmpno(username);
		
		model.addAttribute("emp", emp);
		model.addAttribute("list", result);
		model.addAttribute("pagination", pagination);
		model.addAttribute("criteria", cri);
		model.addAttribute("workHours", workHours);
		model.addAttribute("hoursEachList", hoursEachList);

		System.out.println("**********************");
		System.out.println(hoursEachList);
		System.out.println("**********************");
		System.out.println(workHours);
		System.out.println("**********************");
		return "attendance/Attendance";
	}

	// 희승 : 권한 체크 함수
	private boolean userHasRole(Authentication auth, String role) {
		Collection<? extends GrantedAuthority> authorities = auth.getAuthorities();
		
		return authorities.contains(new SimpleGrantedAuthority(role));
	}
	
}
