/*
	파일명: LoginSuccessHandler.java
    설명: Security 로그인 성공 후 
    작성일: 2021-01-06
    작성자: 백희승
*/
package com.olive.authentication.handler;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.web.DefaultRedirectStrategy;
import org.springframework.security.web.RedirectStrategy;
import org.springframework.security.web.WebAttributes;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;
import org.springframework.security.web.authentication.WebAuthenticationDetails;
import org.springframework.security.web.savedrequest.HttpSessionRequestCache;
import org.springframework.security.web.savedrequest.RequestCache;
import org.springframework.security.web.savedrequest.SavedRequest;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import com.olive.authentication.service.AuthenticationService;

public class LoginSuccessHandler implements AuthenticationSuccessHandler {

	private String empno; // 로그인 한 계정 : empno
	private String defaultTargetUrl; // 로그인 성공 시

	// 세션에 저장된 정보를 확인
	private RequestCache requestCache = new HttpSessionRequestCache();

	// view에 Redirect하여 화면을 이동
	private RedirectStrategy redirectStratgy = new DefaultRedirectStrategy();

	@Autowired
	private AuthenticationService service;
	
	final static Log log = LogFactory.getLog(LoginSuccessHandler.class);

	// 로그인 성공 시 실행되는 onAuthenticationSuccess() 함수
	@Override
	public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response,
			Authentication authentication) throws IOException, ServletException {

		String username = request.getParameter(empno);
		System.out.println("Login username : " + username);
		
		// IP, 세션 ID, 인증 ID
		WebAuthenticationDetails web = (WebAuthenticationDetails) authentication.getDetails();
		System.out.println("IP : " + web.getRemoteAddress() + "\nSession ID : " + web.getSessionId() + "\nname : " + authentication.getName());

		// 권한 리스트
		List<GrantedAuthority> authList = (List<GrantedAuthority>) authentication.getAuthorities();
		for (int i = 0; i < authList.size(); i++) {
			System.out.println(authList.get(i).getAuthority());
		}

		// 로그인 실패 횟수 초기화
		service.initFailCount(username);

		// error 세션 비우기
		clearAuthenticationAttributes(request);

		
		// 신입 사원일 경우 email 인증 페이지로 redirect (상태코드가 10[신입]이던지, ROLE이 하나[ROLE_USER]일 경우)
		if ( (service.selectEmp(username).getStatusCode() == 10 || authList.size() == 1)) {
			redirectStratgy.sendRedirect(request, response, "/registEmail.do");
			return;
		}

		// 해당 주소로 Redirect
		resultRedirectStrategy(request, response, authentication);
	}

	// 로그인 전에 요청이 있다면, 로그인 후 요청 주소로 redirect Or default target url 화면으로 이동
	protected void resultRedirectStrategy(HttpServletRequest request, HttpServletResponse response,
			Authentication authentication) throws IOException, ServletException {
		SavedRequest savedRequest = requestCache.getRequest(request, response);

		if (savedRequest != null) {

			// savedRequest 객체를 통해 getRedirectUrl (로그이 화면을 보기전에 갔던 url)
			String targetUrl = savedRequest.getRedirectUrl();
			redirectStratgy.sendRedirect(request, response, targetUrl);
			System.out.println("URL" + targetUrl);
		} else {

			// 직접 로그인 화면으로 이동했을 경우
			redirectStratgy.sendRedirect(request, response, defaultTargetUrl);
		}
	}

	// 로그인 과정에서 실패한 후 성공하는 경우, 한번이라도 로그인 실패 시 에러가 세션에 남는다. 그 세션을 지우는 작업.
	protected void clearAuthenticationAttributes(HttpServletRequest request) {
		HttpSession session = request.getSession(false);
		if (session == null) {
			return;
		}
		session.removeAttribute(WebAttributes.AUTHENTICATION_EXCEPTION);
	}

	public String getEmpno() {
		return empno;
	}

	public void setEmpno(String empno) {
		this.empno = empno;
	}

	public String getDefaultTargetUrl() {
		return defaultTargetUrl;
	}

	public void setDefaultTargetUrl(String defaultTargetUrl) {
		this.defaultTargetUrl = defaultTargetUrl;
	}

}
