package com.olive.hr_info.dao;

import java.util.List;
import java.util.Map;

import com.olive.dto.DeptTest;
import com.olive.dto.Emp;

public interface Hr_infoDao {
	public List<Emp> showEmpList();
	public List<Emp> searchEmp(Map<String, Object> map);
	public Map<String, Object> searchEmpByEmpno(String emono);
	public List<DeptTest> showOrg();
	public List<DeptTest> showOrgbyDept(String param);
	public int updateMyInfo(Emp emp);
	public Emp checkEmail_Pwd(String email);
	public void updatePwd(Map<String, Object> map);
}
