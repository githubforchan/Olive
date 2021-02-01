/*
	파일명: HomeController.java
    설명: 로그인 화면, 알람 및 이메일 인증 관련 매핑을 담당하는 HomeController ( 기능별 분리해야될 수도 있는 소지 ) 
    작성일: 
    작성자: 
    수정자: 백희승
*/
package com.olive.controller;

import java.io.UnsupportedEncodingException;
import java.security.Principal;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.velocity.VelocityEngineFactoryBean;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.olive.approval.service.ApprovalService;
import com.olive.attendance.service.AttendanceService;
import com.olive.authentication.service.AuthenticationService;
import com.olive.authentication.service.MailService;

import com.olive.dto.Approver;
import com.olive.dto.Att_Record;
import com.olive.dto.Document;
import com.olive.dto.Emp;
import com.olive.hr_info.service.Hr_infoService;
import com.olive.utils.NewsAPI;

@Controller
public class HomeController {

	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);

	@Autowired
	private JavaMailSender mailSender;

	@Autowired
	private VelocityEngineFactoryBean vefb;

	@Autowired
	private MailService mailService;
	
	@Autowired
	private Hr_infoService infoService;

	@Autowired
	private AuthenticationService authService;
	
	@Autowired
	private BCryptPasswordEncoder bCryptPasswordEncoder;

	@Autowired
	private ApprovalService approvalService;
	
	@Autowired
	private AttendanceService attendanceService;
	

	// 최초 index.jsp 접근 시 : Login 페이지
	@RequestMapping("/goToLogin.do")
	public String goToLogin() {
		return "Login2";
	}

	// 로그인 시 Main : 대쉬보드 페이지 (LoginForm은 Post, But Security 처리 = GetMapping)
	@RequestMapping(value = "/goToMain.do", method = RequestMethod.GET)
	public String home(Model model) {
		try {
			Authentication auth = SecurityContextHolder.getContext().getAuthentication();
			String n = auth.getName();
			String r = auth.getAuthorities().toString();

			System.out.println("홈컨트롤러 /goToMain - HOME_CONTROLLER_auth.getName() : " + n);
			System.out.println("홈컨트롤러 /goToMain - HOME_CONTROLLER_auth.getAuthroties().toString() : " + r);

			List<Document> doclist = approvalService.getDocument(n);
			List<Approver> applist = approvalService.getApprover(n);
			
			Map arrangedAppList = approvalService.arrangedAppDoc(applist);
			Map arrangedDocList = approvalService.arrangeDoc(doclist);
			
			System.out.println("App"+arrangedAppList);
			System.out.println("Doc"+arrangedDocList);
			
			model.addAttribute("arrangedAppList",arrangedAppList);
			model.addAttribute("arrangedDocList",arrangedDocList);
			
			Map<String,Object> attList = attendanceService.arrangedAtt();
			model.addAttribute("attList",attList);
			
			Emp emp = approvalService.selectEmp(n);
			model.addAttribute("emp",emp);
			
		} catch (Exception e) {
			// TODO: handle exception
		}
		return "Main";
	}

	// 메인 대쉬보드 : 뉴스 가져오기
	@RequestMapping(value = "/getNewsData.do", method = RequestMethod.GET)
	@ResponseBody
	public JSONObject getNewsData() throws UnsupportedEncodingException {
		NewsAPI newsAPI = new NewsAPI();
		JSONObject result = newsAPI.returnNewsData();
		System.out.println(result);
		return result;
	}

	// 알람페이지로 이동하기
	@RequestMapping(value = "/Alrams.do", method = RequestMethod.GET)
	public String Alram() {
		return "etc/Alrams";
	}

	// 초기 이메일 인증 페이지
	@RequestMapping(value = "/registEmail.do", method = RequestMethod.GET)
	public String goToEmail() {
		return "etc/Email";
	}

	// 이메일 입력 > 메일 보내기
	@RequestMapping(value = "/registEmail.do", method = RequestMethod.POST)
	public ResponseEntity<String> registEmail(HttpServletRequest request, String email) {
		ResponseEntity<String> entity = null;

		Authentication auth = SecurityContextHolder.getContext().getAuthentication();

		HttpSession session = request.getSession();
		
		String ename;
		Emp emp = infoService.checkEmail_Pwd(email);
		if(emp != null) {
			ename = emp.getEname();
		}else {
			ename = null;
		}

		
		if (mailService.sendMail(session, email, ename)) {
			entity = new ResponseEntity<String>("sended", HttpStatus.OK);
		} else {
			entity = new ResponseEntity<String>("failed", HttpStatus.OK);
		}

		return entity;
	}

	// 인증번호 인증
	@RequestMapping(value = "/certificate.do", method = { RequestMethod.POST })
	public ResponseEntity<Boolean> certifyEmail(HttpServletRequest request, Principal principal, String inputCode,
			String email) {
		ResponseEntity<Boolean> entity = null;

		Authentication auth = SecurityContextHolder.getContext().getAuthentication();

		HttpSession session = request.getSession();
		boolean match = mailService.certifyEmail(session, principal, inputCode);

		if (match) {
			entity = new ResponseEntity<Boolean>(true, HttpStatus.OK);
		} else {
			entity = new ResponseEntity<Boolean>(false, HttpStatus.OK);
		}
		return entity;
	}

	// 이메일 인증 시 로그아웃
	@RequestMapping(value = "/goToWork.do")
	@ResponseBody
	public String goToWork(Principal principal, String email) {
		authService.updateEmail(principal.getName(), email);
		authService.setGeneralRole(principal.getName());
		authService.setActivate(principal.getName());

		return "logout";
	}

	// 비밀번호 찾기 페이지
	@RequestMapping(value = "/findPassword.do", method = RequestMethod.GET)
	public String goToPassword() {
		return "etc/Password";
	}

	
	// 이메일 중복검증
	@RequestMapping(value = "/checkEmail_Pwd.do", method = RequestMethod.POST)
	@ResponseBody
	public Emp checkEmail_Pwd(String email) {
		System.out.println(email);
		Emp emp = infoService.checkEmail_Pwd(email);
		return emp;
	}
	
	// 비밀번호 수정
	@RequestMapping(value = "/updatePwd.do", method = RequestMethod.POST)
	@ResponseBody
	public void updatePwd(String email, String pwd) {
		System.out.println(email);
		System.out.println(pwd);
		
		String newpwd = bCryptPasswordEncoder.encode(pwd);
		System.out.println(newpwd);
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("email", email);
		map.put("pwd", newpwd);
		System.out.println(map);
		infoService.updatePwd(map);
	}


}
