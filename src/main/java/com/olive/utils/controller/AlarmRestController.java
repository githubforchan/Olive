package com.olive.utils.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.olive.dto.Alarm;
import com.olive.utils.service.AlarmService;

@RestController
public class AlarmRestController {
	
	@Autowired
	AlarmService alarmService;
	
	@RequestMapping(value="/*/alarmlist.do")
	public List<Alarm> getAlarmModal(String empno, int index){
		
		return alarmService.getAlarmList(empno, index);
	}

	@RequestMapping(value="/*/alarmCount.do")
	public int alarmCount(String empno){
		
		return alarmService.alarmCount(empno);
	}
	
	@RequestMapping(value="/*/readAlarm.do")
	public void readAlarm(String alarmno){
		alarmService.readAlarm(alarmno);
	}
	 
	@RequestMapping(value="/alarm/readAllAlarm.do")
	public String readAllAlarm(String empno) {
		System.out.println(empno);
		alarmService.readAllAlarm(empno);
		return "/Alrams.do"; 
	}

}
