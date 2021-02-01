package com.olive.hr_management.controller;

import java.io.File;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.olive.dto.Dept;
import com.olive.dto.Emp;
import com.olive.dto.Head;
import com.olive.dto.Position;
import com.olive.hr_management.service.Hr_managementService;
import com.olive.utils.Criteria;
import com.olive.utils.Pagination;
import com.olive.utils.service.PagingService;

@RestController
@RequestMapping("/HR_managementRest/")
public class Hr_ManagementRestController {

	@Autowired
	private PagingService pagingService;

	@Autowired
	private Hr_managementService managementService;

	// 인사관리 - 계정관리 - 게시판 페이징
	@RequestMapping(value = "getList.do", method = RequestMethod.POST)
	public JSONObject getEmpListBykeyword(Criteria cri) {
		cri.setCriteria("empinfo", "empno", "desc");
		int totalCount = pagingService.getListCount(cri);
		cri.setPerPageNum(5);
		Pagination pagination = new Pagination(cri, totalCount);
		List<Map<String, Object>> result = pagingService.getList(cri);
		JSONObject jsonObject = new JSONObject();
		jsonObject.put("list", result);
		jsonObject.put("pagination", pagination);
		jsonObject.put("criteria", cri);
		return jsonObject;
	}

	// 인사관리 - 계정관리 - 사원 등록 - 사번생성
	@RequestMapping(value = "createEmpno.do", method = RequestMethod.POST)
	public String createEmpno(String empno) {
		String result = managementService.createEmpno(empno);
		return result;
	}

	// 인사관리 - 조직관리 - 근태현황 - 아이디검색
	@RequestMapping(value = "searchEmp.do", method = RequestMethod.POST)
	public List<Map<String, Object>> searchEmp(String ename) {
		List<Map<String, Object>> result = managementService.searchEmp(ename);
		return result;
	}

	// 인사관리 - 조직관리 - 근태현황 - 아이디검색
	@RequestMapping(value = "getAttbyEmpno.do", method = RequestMethod.POST)
	public JSONObject getAttbyEmpno(String empno) {
		JSONObject jsonObject = new JSONObject();
		List<HashMap<String, Object>> attrecord = managementService.getAttbyEmpno(empno);
		Map<String, Object> empinfo = managementService.getEmpInfo(empno);
		jsonObject.put("attrecord", attrecord);
		jsonObject.put("empinfo", empinfo);
		return jsonObject;
	}

	// 인사관리 > 계정 관리 > 사원 신규 등록 시 사번 중복 검증
	/*
	 * @RequestMapping(value = "checkEmpNo.do", method = RequestMethod.POST) public
	 * Emp checkEmpNo(String empNo) { Emp dto = managementService.checkEmpNo(empNo);
	 * return dto; }
	 */

	// 인사관리 > 계정 관리 > 사원 신규 등록 시 AJAx 본부 테이블 가져오기
	@RequestMapping(value = "getHead.do", method = RequestMethod.POST)
	public List<Head> getHeadQuarters() {
		List<Head> HQList = managementService.getHeadQuarters();
		return HQList;
	}

	// 인사관리 > 계정 관리 > 사원 신규 등록 > 본부 선택 시 해당 본부의 부서 AJAx 가져오기
	@RequestMapping(value = "getDept.do", method = RequestMethod.POST)
	public List<Dept> getDepartments(String headCode) {
		List<Dept> deptList = managementService.getDepartments(headCode);
		return deptList;
	}

	// 인사관리 > 계정 관리 > 사원 신규 등록 > 직책(Position) 테이블 가져오기
	@RequestMapping(value = "getPosition.do", method = RequestMethod.POST)
	public List<Position> getPositions() {
		List<Position> positionList = managementService.getPositions();
		return positionList;
	}

	// 인사관리 > 계정 관리 > 사원 신규 등록 > 직위(Class) 테이블 가져오기
	@RequestMapping(value = "getClass.do", method = RequestMethod.POST)
	public List<com.olive.dto.Class> getClasses() {
		List<com.olive.dto.Class> classList = managementService.getClasses();
		return classList;
	}

	// 인사관리 - 급여관리 - 게시판 페이징
	@RequestMapping(value = "Salary.do", method = RequestMethod.POST)
	public JSONObject getSalaryList(Criteria cri) {
		cri.setCriteria("salaryinfo", "SAL_DATE", "DESC");
		cri.setPerPageNum(5);
		int totalCount = pagingService.getListCount(cri);
		Pagination pagination = new Pagination(cri, totalCount);
		List<Map<String, Object>> result = pagingService.getList(cri);
		JSONObject jsonObject = new JSONObject();
		jsonObject.put("list", result);
		jsonObject.put("pagination", pagination);
		jsonObject.put("criteria", cri);
		return jsonObject;
	}

	// 인사관리 - 급여관리 - 엑셀파일 업로드
	@RequestMapping(value = "uploadExcelFile.do", method = RequestMethod.POST)
	public boolean uploadExcelFile(MultipartFile excelFile, MultipartHttpServletRequest request) {
		excelFile = request.getFile("excelFile");
		if (excelFile == null || excelFile.isEmpty()) {
			throw new RuntimeException("엑셀파일을 선택해주세요...");
		}
		File destFile = new File(
				"C:\\Users\\Min_Chan\\Desktop\\FinalProject\\EXCEL\\" + excelFile.getOriginalFilename());
		try {
			excelFile.transferTo(destFile);
		} catch (Exception e) {
			throw new RuntimeException(e.getMessage(), e);
		}
		boolean result = managementService.excelUpload(destFile);
		destFile.delete();
		return result;
	}

	// 근태관리
	@RequestMapping(value = "getAttList.do", method = RequestMethod.POST)
	public JSONObject getEmpAttListBykeyword(Criteria cri) {
		cri.setCriteria("emp_att", "starttime", "desc");
		cri.setPerPageNum(5);
		int totalCount = pagingService.getListCount(cri);
		Pagination pagination = new Pagination(cri, totalCount);
		List<Map<String, Object>> result = pagingService.getList(cri);
		JSONObject jsonObject = new JSONObject();
		jsonObject.put("list", result);
		jsonObject.put("pagination", pagination);
		jsonObject.put("criteria", cri);
		return jsonObject;
	}

	// 휴가관리
	@RequestMapping(value = "getAnnList.do", method = RequestMethod.POST)
	public JSONObject getEmpAnnListBykeyword(Criteria cri) {
		cri.setCriteria("empAnnual", "empno", "asc");
		int totalCount = pagingService.getListCount(cri);
		Pagination pagination = new Pagination(cri, totalCount);
		List<Map<String, Object>> result = pagingService.getList(cri);
		JSONObject jsonObject = new JSONObject();
		jsonObject.put("list", result);
		jsonObject.put("pagination", pagination);
		jsonObject.put("criteria", cri);
		return jsonObject;
	}

	// 급여관리 - 부서별 평균 급여 Chart
	@RequestMapping(value = "getSalChartDataForClass.do", method = RequestMethod.POST)
	public List<Map<String, Object>> getSalChartDataForClass() {
		List<Map<String, Object>> result = managementService.getSalChartDataForClass();
		return result;
	}

	// 급여관리 - 직급별 평균 급여 Chart
	@RequestMapping(value = "getSalChartDataForDept.do", method = RequestMethod.POST)
	public List<Map<String, Object>> getSalChartDataForDept() {
		List<Map<String, Object>> result = managementService.getSalChartDataForDept();
		return result;
	}

	// 휴가관리 연차이력 조회 >> 휴가관리 모달
	@RequestMapping(value = "getAnnualList.do", method = RequestMethod.POST)
	public List<Map<String, Object>> getAnnualList(String empno) {
		List<Map<String, Object>> annualList = managementService.getAnnualList(empno);
		return annualList;
	}

	// 휴가관리 수정하기
	@RequestMapping(value = "updateAnnual.do", method = RequestMethod.POST)
	public String updateAnnual(String empno, String annual) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("empno", empno);
		map.put("annual", annual);
		managementService.updateAnnual(map);
		return "/HR_management/EmployeeAttendance.do";
	}

	// 근태관리 수정하기 >> 퇴근처리
	@RequestMapping(value = "updateAttRecord.do", method = RequestMethod.POST)
	public String updateAttRecord(String empno, String starttime) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("empno", empno);
		map.put("starttime", starttime);
		managementService.updateAttRecord(map);
		return "/HR_management/EmployeeAttendance.do";
	}

	// 인사관리 - 조직관리 - 근태현황 - 부서별 근태 현황
	@RequestMapping(value = "getAttGroupByDept.do", method = RequestMethod.POST)
	public JSONObject getAttGroupByDept(String deptName) {
		JSONObject jsonObject = managementService.getAttGroupByDept(deptName);
		return jsonObject;
	}

	// 조직관리 > 연도별 총 사원 수 현황 선 그래프
	@RequestMapping(value = "getLineChartData.do", method = RequestMethod.POST)
	public JSONObject getLineChartData() {
		JSONObject jsonObject = managementService.getLineChartData();

		return jsonObject;
	}

	// 조직관리 > 부서별 근속사원 수 현황 파이 그래프
	@RequestMapping(value = "getPieChartData.do", method = RequestMethod.POST)
	public JSONObject getPieChartData() {
		JSONObject jsonObject = managementService.getPieChartData();
		return jsonObject;
	}

	// 인사관리 > 계정관리 > 수정하기페이지 > 계정 초기화
	@RequestMapping(value = "resetAccount.do", method = RequestMethod.POST)
	public String resetAccount(String empno) {
		managementService.resetAccount(empno);
		return empno;
	}
	// 인사관리 > 계정관리 > 수정하기페이지 > 퇴사처리
	@RequestMapping(value = "retireAccount.do", method = RequestMethod.POST)
	public String retireAccount(String empno) {
		managementService.retireAccount(empno);
		return empno;
	}
	
	// 인사관리 > 계정관리 > 수정하기페이지 > 수정 완료
	@RequestMapping(value = "updateEmp.do", method = RequestMethod.POST)
	public void updateEmp(Emp emp) {
		System.out.println(emp);
		managementService.updateAccount(emp);
	}
}
