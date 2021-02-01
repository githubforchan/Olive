package com.olive.utils;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Before;
import org.springframework.stereotype.Component;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

@Aspect
@Component
public class AccessorLogAspect {

	final static Log log = LogFactory.getLog(AccessorLogAspect.class);

//	@Before("execution(* com.olive.authentication.handler.*(..))")
//	public void loginLog(JoinPoint joinpoint) throws Throwable {
//		
//		// 접속자 IP 얻어오기
//		HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.currentRequestAttributes())
//				.getRequest();
//		Object[] args = joinpoint.getArgs();
//		String ip = request.getRemoteAddr();
//
//		String logMsg = "[IP : " + ip + "] : ";
//
//		for (int i = 0; i < args.length; i++) {
//			logMsg += "{arg" + i + " : " + args[i]+"}";
//		}
//		log.info(logMsg);
//	}
}
