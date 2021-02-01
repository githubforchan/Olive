package com.olive.hr_info.controller;

import java.security.Principal;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.olive.dto.DeptTest;
import com.olive.dto.Emp;
import com.olive.dto.SalaryInfo;
import com.olive.hr_info.service.Hr_infoService;
import com.olive.hr_management.service.Hr_managementService;
import com.olive.utils.Criteria;
import com.olive.utils.Pagination;
import com.olive.utils.service.PagingService;
@Controller
@RequestMapping("/HRinfo/")
public class HRController {
	
	private Hr_infoService empService;
	
	@Autowired
	private Hr_managementService managementService;
	
	@Autowired
	public void setEmpService(Hr_infoService empService) {
		this.empService = empService;
	}
	
	@Autowired
	private BCryptPasswordEncoder bCryptPasswordEncoder;
	
	@Autowired
	private PagingService pagingService;
	
	
	
	//인사관리 > 급여관리 > 급여상세
	@RequestMapping(value = "SalaryDetail.do", method = RequestMethod.GET)
	public String getSalaryDetail(Model model, String date, int empno) {
		SalaryInfo salaryInfo = managementService.getSalaryDetail(date, empno);
		salaryInfo.conversionFormality();
		model.addAttribute("salaryInfo", salaryInfo);
		return "HRinfo/salaryDetail";
	}
	
	@RequestMapping(value="Salary.do", method=RequestMethod.GET)
	public String showSalary(Model model, Criteria cri, Principal pri) {	
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		cri.setCriteria("salaryinfo", "SAL_DATE", "DESC");
		cri.setSearchType("empno");
		cri.setKeyword(auth.getName());
		int totalCount = pagingService.getListCount(cri);
		cri.setPerPageNum(5);
		Pagination pagination = new Pagination(cri, totalCount);

		List<Map<String, Object>> result = pagingService.getList(cri);

		model.addAttribute("list", result);
		model.addAttribute("pagination", pagination);
		model.addAttribute("criteria", cri);
		return "HRinfo/Salary";
	}
	
	@RequestMapping("SalaryDetail.do")
	public String showSalaryDetail() {	
		return "HRinfo/salaryDetail";
	}

	//전체 사원 목록 조회
	@RequestMapping(value="Emp.do", method=RequestMethod.GET)
	public String showEmpList(Model model, Criteria cri) {
		//empinfo 뷰 사용
		cri.setCriteria("empinfo", "empno", "asc");
		int totalCount = pagingService.getListCount(cri); 
	    Pagination pagination = new Pagination(cri, totalCount);
	      
	    cri.setPerPageNum(5);
	 
	    List<Map<String, Object>> result = pagingService.getList(cri);

	    model.addAttribute("emplist", result);
	    model.addAttribute("pagination", pagination);
	    model.addAttribute("criteria", cri);

	    return "HRinfo/Emp";   
	}
	
	//조직도 본부 단위 (default) //미완성
	@RequestMapping(value="Organization_chart.do", method=RequestMethod.GET)
	public String showOrg(Model model) {
		List<DeptTest> headlist = empService.showOrg();
		model.addAttribute("head", headlist);
		return "HRinfo/Organization_chart";
	}
	
	//마이페이지 처음 보여줄 때
	@RequestMapping(value="EditMyinfo.do", method=RequestMethod.GET)
	public String editMyinfo(Model model) {
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		String username = auth.getName();
		Map<String, Object> emp = empService.searchEmpByEmpno(username);
		model.addAttribute("emp", emp);
		return "HRinfo/EditMyinfo";
		
	}
	
	//마이페이지 수정하기
	@RequestMapping(value="updateMyInfo.do", method=RequestMethod.POST)
	public String updateMyInfo(Emp emp, HttpServletRequest request) {
		emp.setPwd(this.bCryptPasswordEncoder.encode(emp.getPwd()));
		
		empService.updateMyInfo(emp, request);
		return "redirect:/HRinfo/EditMyinfo.do";
			
	}
}
