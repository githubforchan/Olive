package com.olive.utils.controller;

import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.olive.dto.Alarm;
import com.olive.utils.service.AlarmService;

@Component
public class AlarmHandler extends TextWebSocketHandler {
	//사번과 웹소켓 세션을 담는 맵 
	private Map<String, WebSocketSession> socketList = new HashMap<String,WebSocketSession>();
	ObjectMapper objMapper = new ObjectMapper();
	
	@Autowired
	AlarmService alarmService;
	
	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
		// TODO Auto-generated method stub
		System.out.println(session.getPrincipal().getName()+"접속 성공");
		
		socketList.put(session.getPrincipal().getName(), session);
		System.out.println(socketList);
		
		super.afterConnectionEstablished(session);
	}

	@Override
	public void handleMessage(WebSocketSession session, WebSocketMessage<?> message) {
		// TODO Auto-generated method stub
		System.out.println(message.getPayload());
		JSONObject json = JsonToObjectParser((String)message.getPayload());
		System.out.println("json"+json);  
		
		Alarm alarm = new Alarm();
		Date alarmTime = new Date();
		
		String cmd = (String)json.get("cmd");
		String color = (String)json.get("color");
		String title = (String)json.get("docTitle");
		String docno = (String)json.get("docno");
		alarm.setDocno(docno);
		alarm.setAlarmTime(alarmTime);
		alarm.setColor(color);
		docno = (docno==null) ? "" : "("+docno+")";

		String done = ((String)json.get("nextApprover")==null) ? "최종 "  : "";
		
		try {
	//승인 또는 반려 됐다고 기안자에게 보내는 거	
			if(cmd.equals("App")) {
				System.out.println(color);
				String approver = (String)json.get("approver");
				String docWriter = (String)json.get("docWriter");
				String approveOrNot = (color.equals("danger")) ? "반려하셨습니다.": "승인하셨습니다.";
				String content = approver+"님 께서 '"+title+"'"+docno+" 문서를 "+done+approveOrNot;
				
				System.out.println("작성자는 :::::"+ docWriter);
				
				alarm.setEmpno(Integer.parseInt(docWriter));
				alarm.setContent(content);
				String sendjson =objMapper.writeValueAsString(alarm);
				
				for(Map.Entry list : socketList.entrySet()) {
					WebSocketSession sess = (WebSocketSession) list.getValue();
					if(list.getKey().equals(docWriter)) {
						System.out.println("보내는 사람은 ???? (기안자_) "+docWriter);
						sess.sendMessage(new TextMessage(sendjson));
					}
				if(done.equals("최종")) {
					break;
				}
			
			}
	//기안 했으니 승인 해달라 , 승인하면 다음 결재자에게 보내는거
			}else if (cmd.equals("next")) {
				System.out.println("next");
				System.out.println(json);
				String approver = (String) json.get("approver");
				String nextApprover = (String)json.get("nextApprover");
				String docWriter = (String)json.get("docWriter");
				String content = docWriter+"님의 '"+title+"'"+docno+" 문서 결재를 부탁 드립니다.";	
				
				
				alarm.setEmpno(Integer.parseInt(nextApprover));
				if(alarm.getEmpno() ==0) {
					return;
				}
				
				alarm.setContent (content);
				String sendjson =objMapper.writeValueAsString(alarm);
				
				for(Map.Entry list : socketList.entrySet()) {
					WebSocketSession sess = (WebSocketSession) list.getValue();
					if(list.getKey().equals(nextApprover)) {
						System.out.println("보내는 사람은 ? (결재자)"+nextApprover);
						sess.sendMessage(new TextMessage(sendjson));
					}
				}
				
			}
		}catch(Exception e) {
			System.out.println(e.getMessage());
		}
		System.out.println("------------------------------------------------------넣는다----------------");
		alarmService.insertAlarm(alarm);
		System.out.println("알람 디비 저장해야해!!!"+alarm);
		System.out.println("------------------------------------------------------넣었다----------------");
		
	}

	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
		// TODO Auto-generated method stub
		super.afterConnectionClosed(session, status);
	}

	// json형태의 문자열을 파라미터로 받아서 SimpleJson의 파서를 활용하여 JSONObject로 파싱처리를 해주는 함수
	private static JSONObject JsonToObjectParser(String jsonStr) {
		JSONParser parser = new JSONParser();
		JSONObject obj = null;
		try {
			obj = (JSONObject) parser.parse(jsonStr);
		} catch (ParseException e) {
			e.printStackTrace();
		}
		return obj;
	}
	
	//알람이 오는 것  
	//1. 누군가가 문서를 기안하면 다음 결재자에게 결재를 하라고 알람이 가야함
	//2. 누군가가 받은 문서에 승인을 하면 다음 결재자에게 결재를 하라고 알람이 가야함
	//3. 최종 결재가 떨어진다면 기안을 한사람에게 결과(승인, 반려)에 대해 알람이 가야함
	//4. +a 출근하면 출근 찍으라고 알람 감
	
	// => 모든사람이 아니라 문서와 관련이 있는 사람에게만 문자가 가는 거임 => 문서번호가 하나의 방이 된다???
	// => 보통 방은 클릭해서 들어가거나 이런식인데 어떻게 하지? 
	// => 문서 번호로 방을 만든다면 문서를 보고있는 사람만 알람이 간다는 건데... 이건 아니지 
	
	// 모든 사원을 한곳에다가 다몰아 넣어 놓고 문서에 해당되는 사번을 찾은다음 그 사람에게 문자를 보내야함
	
	// 기안을 올리면 다음 결재자(첫번째 결재자) 에게 알림이 가야함  "누가 기안을 올렸습니다"
	// 승인을 하면 다음 결재자에게 알림이 가야함 "누가 어떤 문서 승인을 했습니다. 확인해 주세요"
	// 최종 승인을 하면 기안자아게 다시 알람이 가야함 "어떤 문서가 최종 승인이 됐습니다"
	// 반려가 나면 기안자에게 다시 알람이 가야함 "어떤 문서가 반려가 났습니다"

}