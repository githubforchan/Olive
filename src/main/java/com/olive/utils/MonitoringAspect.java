package com.olive.utils;


import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.springframework.stereotype.Component;
import org.springframework.util.StopWatch;

@Aspect
@Component
public class MonitoringAspect {
	
	private static Log log = LogFactory.getLog(MonitoringAspect.class);
	

	@Around("within(com.olive.dao.*.*)")
	public Object doDAOMonitoring(ProceedingJoinPoint joinpoint) throws Throwable {
		StopWatch clock = new StopWatch("Profiling ...");

		Object result;
		try {
			clock.start(joinpoint.toShortString());
			result = joinpoint.proceed();
		} finally {
			clock.stop();
		}
		// 작동시간이 0.5초이상 걸리는 경우 경고 + 관련 정보
		if (clock.getTotalTimeMillis() > 500) {
			if (log.isWarnEnabled()) {
				log.warn("Execution Location : " + joinpoint.getTarget().getClass().getName());
				log.warn("Execution Method : " + joinpoint.toShortString());
				log.warn("Execution Time : " + clock.prettyPrint());
			}
		}
		return result;
	}
}
