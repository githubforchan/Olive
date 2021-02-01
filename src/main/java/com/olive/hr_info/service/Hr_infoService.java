package com.olive.hr_info.service;

import java.io.FileOutputStream;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.commons.CommonsMultipartFile;

import com.olive.dto.DeptTest;
import com.olive.dto.Emp;
import com.olive.hr_info.dao.Hr_infoDao;

    

@Service
public class Hr_infoService {

	   private SqlSession sqlsession;

	   @Autowired 
	   public void setSqlsession(SqlSession sqlsession) {
	      this.sqlsession = sqlsession;
	   }
	   
	   //Emp 전체 검색
	   public List<Emp> showEmpList(){
		   List<Emp> list = null;
		   Hr_infoDao dao = sqlsession.getMapper(Hr_infoDao.class);
		   list = dao.showEmpList();
		   return list;
		   
	   }
	   
	   //Emp 조건 검색 selectbox (사번, 이름, 부서)
	   public List<Emp> searchEmp(Map<String, Object> map) {
		    Hr_infoDao dao = sqlsession.getMapper(Hr_infoDao.class);
		    List<Emp> emplist = dao.searchEmp(map);
			return emplist;
		}
	   
	   //Emp 사번으로 검색 //Mypage에 일단 쓰는중 //modal에도 쓸거임
	   //수정 >> empinfo로 가져올 것
	   public Map<String, Object> searchEmpByEmpno(String empno){
		   Hr_infoDao dao = sqlsession.getMapper(Hr_infoDao.class);
		   Map<String, Object> emp = dao.searchEmpByEmpno(empno);

		   Date hire = new Date(((Date) emp.get("HIREDATE")).getTime());
		   SimpleDateFormat dateFormat = new SimpleDateFormat("YYYY-MM-dd");
		   String date = dateFormat.format(hire);
		     
		   emp.put("HIREDATE", date);

		   return emp;
	   }
	   
	   //조직도 본부 조회 Main (미완성)
	   public List<DeptTest> showOrg(){
		   Hr_infoDao dao = sqlsession.getMapper(Hr_infoDao.class);
		   List<DeptTest> headlist = dao.showOrg();

		   return headlist;
	   }
	   
	   //조직도 부서별 조회 
	   public List<DeptTest> showOrgbyDept(String param){
		   Hr_infoDao dao = sqlsession.getMapper(Hr_infoDao.class);
		   List<DeptTest> emplist = dao.showOrgbyDept(param);

		   return emplist;
	   }
	   
	   //마이페이지 수정
	   public void updateMyInfo(Emp emp, HttpServletRequest request) {
		   Hr_infoDao dao = sqlsession.getMapper(Hr_infoDao.class);
		   
		   CommonsMultipartFile multifile =emp.getFile();
		   String filename = multifile.getOriginalFilename();
			String path = request.getServletContext().getRealPath("/resources/upload");

			String fpath = path + "/" + filename;
			if (!filename.equals("")) {
				// 실 파일 업로드
				try {
					FileOutputStream fs = new FileOutputStream(fpath);
					fs.write(multifile.getBytes());
					fs.close();
				} catch (Exception e) {
					// TODO Auto-generated catch block
					e.printStackTrace();			}
			}
			     
			emp.setPic(filename);   
			dao.updateMyInfo(emp);	   
	   }  
	      
		//이메일 검증
		public Emp checkEmail_Pwd(String email) {
			Hr_infoDao dao = sqlsession.getMapper(Hr_infoDao.class);
			Emp emp = dao.checkEmail_Pwd(email);
			return emp;
		}
		
		//비밀번호 수정
		public void updatePwd(Map<String, Object> map) {
			Hr_infoDao dao = sqlsession.getMapper(Hr_infoDao.class);
			dao.updatePwd(map);
		}

	   
	   
	   
}
