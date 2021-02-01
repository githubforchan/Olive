package com.olive.hr_info.controller;

import java.security.Principal;
import java.util.List;
import java.util.Map;

import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.olive.dto.DeptTest;
import com.olive.dto.Emp;
import com.olive.hr_info.service.Hr_infoService;
import com.olive.utils.Criteria;
import com.olive.utils.Pagination;
import com.olive.utils.service.PagingService;




@RestController
@RequestMapping("/HRinfo/")
public class HRAjaxController {
	
	@Autowired
	private Hr_infoService empService;  

	@Autowired
	private PagingService pagingService;
	
	@RequestMapping(value = "Emp.do", method = RequestMethod.POST)
	public JSONObject getEmpListBykeyword(Criteria cri) {
		
		cri.setCriteria("empinfo", "empno", "asc");
		int totalCount = pagingService.getListCount(cri);
		Pagination pagination = new Pagination(cri, totalCount);
		List<Map<String, Object>> result = pagingService.getList(cri);
		
		cri.setPerPageNum(3);
		
		JSONObject jsonObject = new JSONObject();  
		jsonObject.put("emplist", result);
		jsonObject.put("pagination", pagination);
		jsonObject.put("criteria", cri);		
		return jsonObject;		
	}	

	//사원 사번 조회 //일단 모달창 전용으로 
	@RequestMapping(value="searchByEmpno.do", method = RequestMethod.POST)
	public Map<String, Object> searchEmpByEmpno(String empno){
		Map<String, Object> emp = empService.searchEmpByEmpno(empno);
		return emp;    
	}     
	
	//조직도 부서별 조회
	@RequestMapping(value="showOrgbyDept.do")   
	public List<DeptTest> showOrgbyDept(String param){
		List<DeptTest> emplist = empService.showOrgbyDept(param);
		return emplist;
	}
	
	@RequestMapping(value="salaryPaging.do", method=RequestMethod.GET)
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

	@RequestMapping(value="organization.do")
	public List<Emp> organization() {
		
		return empService.showEmpList();
		
	}
	
	

}
