package com.olive.utils.service;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.olive.dto.Alarm;
import com.olive.utils.dao.AlarmDao;

@Service
public class AlarmService {
	@Autowired
	private SqlSession sqlsession;
	
	public void insertAlarm(Alarm al) {
		AlarmDao alarmDao = sqlsession.getMapper(AlarmDao.class);
		if(al.getEmpno()!=0) {
			alarmDao.insertAlarm(al);
			
		}
	}
	
	public List<Alarm> getAlarmList(String empno,int index){
		AlarmDao alarmDao  = sqlsession.getMapper(AlarmDao.class);
		int size = 5;
		int start = index*size;
		int end = (index+1)*size;
		return alarmDao.getAlarmList(empno,start,end);
	}
	
	public int alarmCount(String empno){
		AlarmDao alarmDao  = sqlsession.getMapper(AlarmDao.class);
		return alarmDao.alarmCount(empno);
	}
	
	public void readAlarm(String alarmno){
		AlarmDao alarmDao  = sqlsession.getMapper(AlarmDao.class);
		alarmDao.readAlarm(alarmno);
	}
	public void readAllAlarm(String empno) {
		AlarmDao alarmDao  = sqlsession.getMapper(AlarmDao.class);
		System.out.println("service empno"+empno);
		alarmDao.readAllAlarm(empno);
	}
	
}
