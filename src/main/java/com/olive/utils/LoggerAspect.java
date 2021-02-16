package com.olive.utils;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.springframework.stereotype.Component;

@Aspect
@Component
public class LoggerAspect {

	final static Log log = LogFactory.getLog(LoggerAspect.class);
	
	@Around("within(com.olive.service.*.*)")
	public Object logOperations(ProceedingJoinPoint joinpoint) throws Throwable {

		String targetClassName = joinpoint.getTarget().getClass().getName();
		String targetMethodName = joinpoint.getSignature().getName();

		//시작하는 메소드 정보 및 파라미터 확인
		if (log.isDebugEnabled()) {
			log.debug(targetClassName + "." + targetMethodName + " 시작!");
			Object[] args = joinpoint.getArgs();
			for (int i = 0; i < args.length; i++) {
				log.debug("arg[" + i + "] : " + args[i]);
			}
		}
		Object result = joinpoint.proceed();
		
		//종료되는 메소드 정보 확인
		if (log.isDebugEnabled()) {
			log.debug(targetClassName + "." + targetMethodName + " 종료!");
		}
		return result;
	}

}

