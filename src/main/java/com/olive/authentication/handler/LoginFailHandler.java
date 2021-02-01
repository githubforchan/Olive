/*
	파일명: LoginFailHandler.java
    설명: 기존 Spring Security 사용한 로그인 시 default Login fail Handler에 로직을 추가하기 위해 커스텀한 Class : 로그인 실패 시 로직을 담당
    작성일: 2021-01-03
    작성자: 백희승
*/
package com.olive.authentication.handler;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.AccountExpiredException;
import org.springframework.security.authentication.AuthenticationServiceException;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.authentication.CredentialsExpiredException;
import org.springframework.security.authentication.DisabledException;
import org.springframework.security.authentication.LockedException;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.web.authentication.AuthenticationFailureHandler;

import com.olive.authentication.service.AuthenticationService;

public class LoginFailHandler implements AuthenticationFailureHandler {
	/*
	 * >> 로그인 실패 시 Security는 Provider가 throw한 exception을 여기 fail Handler로 전달한다.
	 * 
	 * ----Fail Handler가 받는 예외 종류---- [ (타입 = AuthenticationException), (Class
	 * Library = org.springframework.security.authentication.*) ]
	 * 
	 * - AuthenticationServiceException : select 결과 null 값을 리턴했을 경우 -
	 * BadCredentialException : UsernameNotFoundException 예외를 Throw UserDetails 객체를
	 * 리턴했으나, ID 또는 PWD가 틀림. - LockedException : UserDetails 객체의
	 * isAccountNonLocked() 메소드의 리턴값이 false - DisabledException : UserDetails 객체의
	 * isEnabled() 메소드의 리턴값이 false - AccountExpiredException : UserDetails 객체의
	 * isAccountNonExpired() 메소드의 리턴값이 false - CredentialExpiredException :
	 * UserDetails 객체의 isCredentialsNonExpired() 메소드의 리턴값이 false
	 */

	private String empno;
	private String pwd;
	private String errorMsgName;
	private String defaultFailureUrl;

	private AuthenticationService service;

	@Override
	public void onAuthenticationFailure(HttpServletRequest request, HttpServletResponse response,
			AuthenticationException exception) throws IOException, ServletException {

		String username = request.getParameter(empno); // 헷갈리지 마세요. username은 사번입니다.
		String password = request.getParameter(pwd);
		String errormsg = exception.getMessage();

		// 존재하는 계정이 아님 or 비밀번호가 틀림
		if (exception instanceof BadCredentialsException) {

			// 존재하는 계정의 경우
			if (service.selectEmp(username) != null) {
				System.out.println("==========" + username);
				// 먼저 로그인 오류 횟수 검색
				int count = service.getFailCount(username);
				System.out.println("==========" + count);
				if (count >= 4) {
					service.disable(username);
					errormsg = "해당 계정은 로그인 시도 횟수 초과로 인해 계정이 <br>비활성화되었습니다. 계정을 복구하시려면 <br>부서 관리자에게 문의바랍니다.";
				} else {
					if (count >= 2) {
						errormsg = "비밀번호를 잘못 입력하셨습니다.<br>(최대 오류 : 5회, " + (4 - count)
								+ "회 남음)<br>5회 초과 잘못 입력 시 계정이 잠깁니다.";
					}
					// 로그인 오류 횟수 증가
					service.addFailCount(username);
				}

			}

		} else if (exception instanceof DisabledException) { // 비활성화 된 계정일 경우
		}

		System.out.println("로그인 시도 : " + username + "/" + password);
		System.out.println("[Exception]" + exception.toString() + "\nSecurity.properties  : " + errormsg);

		// 에러정보를 forward
		request.setAttribute(errorMsgName, errormsg);
		
	
		// 로그인 페이지로 다시 포워딩하면 기존 시큐리티와 다르게 "세션을 이용하지 않고, 오류 메세지를 forward하여 출력가능"
		request.getRequestDispatcher(defaultFailureUrl).forward(request, response);
	}
	
	
	

	@Autowired
	public void setService(AuthenticationService service) {
		this.service = service;
	}

	public String getEmpno() {
		return empno;
	}

	public void setEmpno(String empno) {
		this.empno = empno;
	}

	public String getPwd() {
		return pwd;
	}

	public void setPwd(String pwd) {
		this.pwd = pwd;
	}

	public String getErrorMsgName() {
		return errorMsgName;
	}

	public void setErrorMsgName(String errorMsgName) {
		this.errorMsgName = errorMsgName;
	}

	public String getDefaultFailureUrl() {
		return defaultFailureUrl;
	}

	public void setDefaultFailureUrl(String defaultFailureUrl) {
		this.defaultFailureUrl = defaultFailureUrl;
	}

	public AuthenticationService getService() {
		return service;
	}

}
