/*
	파일명: Hr_managementDao.java
    설명: 인사관리 Dao
    작성일: 2021-01-02
    작성자: 백희승
*/
package com.olive.hr_management.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.olive.dto.Class;
import com.olive.dto.Dept;
import com.olive.dto.Emp;
import com.olive.dto.Head;
import com.olive.dto.Position;
import com.olive.dto.Sal_Record;
import com.olive.dto.SalaryInfo;

public interface Hr_managementDao {

//	public List<Emp> getEmpList() throws Exception;

//	public List<Map<String, Object>> getEmpList(Criteria cri);

//	public int getListCount() throws Exception;

	public void insertNewEmp(Emp emp);

	public List<Emp> selectAllList();

	public Emp checkEmpNo(String empNo);

	public List<Head> getHeadQuarters();

	public List<Dept> getDepartments(String headCode);

	public List<Position> getPositions();

	public List<Class> getClasses();

	public SalaryInfo getSalaryDetail(Map parameter);

	public void insertSalaryTbl(List<Sal_Record> excelData);

	public List<Map<String, Object>> getAnnualList(String empno);

	public void updateAnnual(Map<String, Object> map);

	public void updateAttRecord(Map<String, Object> map);

	public String checkEmpno(String empno);

	public List<Map<String, Object>> searchEmp(String ename);

	public List<HashMap<String, Object>> getAttbyEmpno(String empno);

	public Map<String, Object> getEmpInfo(String empno);

	public String getHiredCount();

	public String getHeadCount();

	public String getRetiredCount();

	public List<Map<String, Object>> getSalChartDataForClass();

	public List<Map<String, Object>> getSalChartDataForDept();

	public List<HashMap<String, Object>> getHiredDate();

	public List<HashMap<String, Object>> getLeavedDate();

	public int getTotalCount();

	public List<HashMap<String, Object>> getAttGroupByDept();

	public List<HashMap<String, Object>> getGroupedDeptData();

	public List<Class> getClassList();

	public List<String> getAttList();

	public void resetAccount(Map<String, String> parameter);
	
	public void retireAccount(String empno);

	public void updateAccount(Emp emp);
	
}
