/*
	파일명: Hr_managementService.java
    설명: 인사관리 Service 
    작성일: 2021-01-02
    작성자: 백희승
*/
package com.olive.hr_management.service;

import java.io.File;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import com.olive.dto.Class;
import com.olive.dto.Dept;
import com.olive.dto.Emp;
import com.olive.dto.Head;
import com.olive.dto.Position;
import com.olive.dto.Sal_Record;
import com.olive.dto.SalaryInfo;
import com.olive.hr_management.dao.Hr_managementDao;
import com.olive.utils.ExcelRead;
import com.olive.utils.ExcelReadOption;

@Service
public class Hr_managementService {

	private SqlSession sqlsession;

	@Autowired
	public void setSqlsession(SqlSession sqlsession) {
		this.sqlsession = sqlsession;
		System.out.println(this.sqlsession);
	}
	
	@Autowired
	private BCryptPasswordEncoder bCryptPasswordEncoder;

	// 인사관리 : 사원 신규 등록
	public void insertNewEmp(Emp emp) {
		Hr_managementDao dao = sqlsession.getMapper(Hr_managementDao.class);
		dao.insertNewEmp(emp);
	}

	// 인사관리 : 사원 리스트 출력 테스트
	public List<Emp> selectAllList() {
		List<Emp> list = new ArrayList<Emp>();
		Hr_managementDao dao = sqlsession.getMapper(Hr_managementDao.class);
		list = dao.selectAllList();
		return list;
	}

	// 인사관리 : 사원 신규 등록 시 Ajax 사번 중복 검증용
	public Emp checkEmpNo(String empNo) {
		Hr_managementDao dao = sqlsession.getMapper(Hr_managementDao.class);
		Emp dto = dao.checkEmpNo(empNo);
		return dto;
	}

	// 인사관리 : 사원 신규 등록 시 Ajax 본부 목록 호출
	public List<Head> getHeadQuarters() {
		Hr_managementDao dao = sqlsession.getMapper(Hr_managementDao.class);
		System.out.println("head service");
		List<Head> HQList = dao.getHeadQuarters();
		System.out.println(HQList);
		return HQList;
	}

	// 인사관리 : 사원 신규 등록 시 Ajax 본부 코드 선택 시 부서 코드 호출
	public List<Dept> getDepartments(String headCode) {
		Hr_managementDao dao = sqlsession.getMapper(Hr_managementDao.class);
		List<Dept> deptList = dao.getDepartments(headCode);
		return deptList;
	}

	// 인사관리 : 사원 신규 등록 시 포지션(임무) 가져오기
	public List<Position> getPositions() {
		Hr_managementDao dao = sqlsession.getMapper(Hr_managementDao.class);
		List<Position> positionList = dao.getPositions();
		return positionList;
	}

	// 인사관리 : 사원 신규 등록 시 클래스(직급) 가져오기
	public List<Class> getClasses() {
		Hr_managementDao dao = sqlsession.getMapper(Hr_managementDao.class);
		List<Class> classList = dao.getClasses();
		return classList;
	}

	// 연차이력 리스트
	public List<Map<String, Object>> getAnnualList(String empno) {
		Hr_managementDao dao = sqlsession.getMapper(Hr_managementDao.class);
		List<Map<String, Object>> annualList = dao.getAnnualList(empno);
		return annualList;
	}

	// 사원근태 >> 퇴근처리
	public void updateAttRecord(Map<String, Object> map) {
		Hr_managementDao dao = sqlsession.getMapper(Hr_managementDao.class);
		dao.updateAttRecord(map);
	}

	// 사원 연차 수정
	public void updateAnnual(Map<String, Object> map) {
		Hr_managementDao dao = sqlsession.getMapper(Hr_managementDao.class);
		dao.updateAnnual(map);
	}

	public SalaryInfo getSalaryDetail(String date, int empno) {
		Hr_managementDao dao = sqlsession.getMapper(Hr_managementDao.class);
		Map parameter = new HashMap<String, Object>();
		parameter.put("sal_date", date);
		parameter.put("empno", empno);
		return dao.getSalaryDetail(parameter);

	}

	public boolean excelUpload(File destFile) {
		boolean result = false;
		ExcelReadOption excelReadOption = new ExcelReadOption();
		excelReadOption.setFilePath(destFile.getAbsolutePath());
		excelReadOption.setOutputColumns("지급일자", "사번", "기본급", "시간외수당", "직책수당", "상여금", "차량유지", "식대", "교육지원");
		excelReadOption.setStartRow(2);
		List<Map<String, String>> excelContent = ExcelRead.read(excelReadOption);

		if (!excelContent.isEmpty()) {
			result = true;
			List<Sal_Record> excelData = new ArrayList<>();
			Sal_Record salRecord = null;
			for (int i = 0; i < excelContent.size(); i++) {
				if (excelContent.get(i).size() == 9) {
					salRecord = new Sal_Record();
					salRecord.setSal_date(excelContent.get(i).get("지급일자"));
					salRecord.setEmpno(Integer.parseInt(excelContent.get(i).get("사번")));
					salRecord.setBasic_pay(Integer.parseInt(excelContent.get(i).get("기본급")));
					salRecord.setOvertime_pay(Integer.parseInt(excelContent.get(i).get("시간외수당")));
					salRecord.setPosition_pay(Integer.parseInt(excelContent.get(i).get("직책수당")));
					salRecord.setBonus(Integer.parseInt(excelContent.get(i).get("상여금")));
					salRecord.setMaintenance_of_vehicle(Integer.parseInt(excelContent.get(i).get("차량유지")));
					salRecord.setMess_allowance(Integer.parseInt(excelContent.get(i).get("식대")));
					salRecord.setEducational_supports(Integer.parseInt(excelContent.get(i).get("교육지원")));
					salRecord.calcTax();
					excelData.add(salRecord);
				}
			}
			Hr_managementDao dao = sqlsession.getMapper(Hr_managementDao.class);
			dao.insertSalaryTbl(excelData);
		}
		return result;
	}

	public String createEmpno(String empno) {
		Hr_managementDao dao = sqlsession.getMapper(Hr_managementDao.class);
		String checkNum = null;
		String result;
		checkNum = dao.checkEmpno(empno);
		if (checkNum != null) {
			result = "" + (Integer.parseInt(checkNum) + 1);
		} else {
			result = empno + "001";
		}
		return result;
	}

	public List<Map<String, Object>> searchEmp(String ename) {
		Hr_managementDao dao = sqlsession.getMapper(Hr_managementDao.class);
		List<Map<String, Object>> result = dao.searchEmp(ename);
//		List<String> data = new ArrayList<>();
//		for(HashMap<String, Object> result : results) {
//			String temp = "";
//			data.add(result.get("ename")+" "+result.get("classname")+"/"+result.get("deptname"));
//		}
		return result;
	}

	public List<HashMap<String, Object>> getAttbyEmpno(String empno) {
		Hr_managementDao dao = sqlsession.getMapper(Hr_managementDao.class);
		List<HashMap<String, Object>> list = dao.getAttbyEmpno(empno);
		List<HashMap<String, Object>> result = new ArrayList<HashMap<String, Object>>();
		System.out.println(list.get(0));
		for (HashMap<String, Object> item : list) {
			if (item.containsValue("출근")) {
				result.add(item);
			} else if (item.containsValue("지각")) {
				result.add(item);
			} else if (item.containsValue("결근")) {
				result.add(item);
			}
			System.out.println(item);
		}
		System.out.println(result);
		return result;
	}

	public Map<String, Object> getEmpInfo(String empno) {
		Hr_managementDao dao = sqlsession.getMapper(Hr_managementDao.class);
		Map<String, Object> result = dao.getEmpInfo(empno);
		return result;
	}

	public Map<String, String> getOrganizationInfo() {
		Hr_managementDao dao = sqlsession.getMapper(Hr_managementDao.class);
		String headCount = dao.getHeadCount();
		String hired = dao.getHiredCount();
		String retired = dao.getRetiredCount();
		Map<String, String> result = new HashMap<String, String>();
		result.put("headCount", headCount);
		result.put("hired", hired);
		result.put("retired", retired);
		System.out.println(result);
		return result;
	}

	public List<Map<String, Object>> getSalChartDataForClass() {
		Hr_managementDao dao = sqlsession.getMapper(Hr_managementDao.class);
		List<Map<String, Object>> result = dao.getSalChartDataForClass();
		List<Class> classResult = dao.getClassList();
		List<Map<String, Object>> sortResult = new ArrayList<>();
		for (Class sort : classResult) {
			for (Map<String, Object> data : result) {
				if (sort.getClassName().equals(data.get("class"))) {
					sortResult.add(data);
					break;
				}
			}
		}
		System.out.println(result);
		return sortResult;
	}

	public List<Map<String, Object>> getSalChartDataForDept() {
		Hr_managementDao dao = sqlsession.getMapper(Hr_managementDao.class);
		List<Map<String, Object>> result = dao.getSalChartDataForDept();

		return result;
	}

	public JSONObject getAttGroupByDept(String deptName) {
		Hr_managementDao dao = sqlsession.getMapper(Hr_managementDao.class);
		JSONObject jsonObject = new JSONObject();
		List<HashMap<String, Object>> datas = dao.getAttGroupByDept();
		List<String> labels = dao.getAttList();
		jsonObject.put("labels", labels);
		
		for(HashMap<String, Object> data : datas) {
			List<Integer> chartData = new ArrayList<>();
			for(int i=0; i<labels.size(); i++) {
				chartData.add(Integer.parseInt(data.get(labels.get(i))+""));
			}
			jsonObject.put(data.get("dept"), chartData);
		}
		System.out.println(jsonObject);
		return jsonObject;
	}

	// 연도별 총 사원 수 현황 선 그래프
	public JSONObject getLineChartData() {
		Hr_managementDao dao = sqlsession.getMapper(Hr_managementDao.class);

		JSONObject jsonObject = new JSONObject();

		Calendar cal = Calendar.getInstance();
		int year = cal.get(Calendar.YEAR); // 현재년도

		long empCount = dao.getTotalCount(); // 쿼리1 : 현 시점 회사 인원
		List<HashMap<String, Object>> hireResult = dao.getHiredDate(); // 쿼리2 : 년도별 입사자 수
		List<HashMap<String, Object>> leaveResult = dao.getLeavedDate(); // 쿼리3 : 년도별 퇴사자 수

		List<Object> result = new ArrayList<>();
		List<Object> label = new ArrayList<>();

		for (int i = 0; i < 5; year--, i++) {
			result.add(empCount);
			for (HashMap<String, Object> data : hireResult) {
				if (data.get("year").equals(year + "")) {
					empCount -= ((long) data.get("hireCount"));
				}
			}
			for (HashMap<String, Object> data : leaveResult) {
				if (data.get("year") == null) {

				} else if (data.get("year").equals(year + "")) {
					empCount += ((long) data.get("leaveCount"));
				}
			}
			if (year == cal.get(Calendar.YEAR)) {
				label.add("현재");
			} else {
				label.add(year + "년");
			}
		}
		List<Object> sortResult = new ArrayList<>();
		List<Object> sortLabel = new ArrayList<>();
		for (int i = result.size() - 1; i >= 0; i--) {
			sortResult.add(result.get(i));
			sortLabel.add(label.get(i));
		}
		jsonObject.put("EmpCountByYear", sortResult); // 연도별 증,감된 총 사원수
		jsonObject.put("labelList", sortLabel); // 연도 라벨
		return jsonObject;
	}

	// 부서별 사원 수 파이 차트 데이터
	public JSONObject getPieChartData() {
		Hr_managementDao dao = sqlsession.getMapper(Hr_managementDao.class);

		JSONObject jsonObject = new JSONObject();
		List<HashMap<String, Object>> groupedDeptList = dao.getGroupedDeptData();

		List<Object> deptList = new ArrayList<>();
		List<Object> countList = new ArrayList<>();
		for (HashMap<String, Object> data : groupedDeptList) {
			deptList.add(data.get("deptName"));
			countList.add(data.get("empCount"));
		}
		jsonObject.put("deptList", deptList);
		jsonObject.put("countList", countList);
		return jsonObject;
	}

	public void resetAccount(String empno) {
		Hr_managementDao dao = sqlsession.getMapper(Hr_managementDao.class);
		String pwd = this.bCryptPasswordEncoder.encode(empno);
		Map<String, String> parameter = new HashMap<String, String>();
		parameter.put("empno", empno);
		parameter.put("pwd", pwd);
		System.out.println(parameter);
		dao.resetAccount(parameter);
	}

	public void retireAccount(String empno) {
		Hr_managementDao dao = sqlsession.getMapper(Hr_managementDao.class);
		dao.retireAccount(empno);
	}

	public void updateAccount(Emp emp) {
		Hr_managementDao dao = sqlsession.getMapper(Hr_managementDao.class);
		dao.updateAccount(emp);
	}
}