package com.test.test1.chat.util;
/* 02.25 - 장재호 */

import java.io.IOException;

import javax.websocket.OnClose;
import javax.websocket.OnMessage;
import javax.websocket.OnOpen;
import javax.websocket.Session;
import javax.websocket.server.ServerEndpoint;

@ServerEndpoint("/adminchat")
public class AdminSocket {
	//admin 한명 (둘 이상의 세션에서 접속을 하면 마지막 세션만 작동) -> 추가 가능
	private static Session admin = null;
	
	//접속
	@OnOpen
	public void handleOpen(Session userSession) throws IOException {
		//기존에 운영자 유저의 소켓이 접속중이라면
		if (admin != null) {
			try {
				//접속을 끊는다.
				admin.close();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		//운영자 유저의 세션을 바꾼다.
		admin = userSession;
		//기존에 접속해 있는 유저의 정보를 운영자 client로 보낸다.
		for(String key : UserSocket.getUserKeys()) {
			//전송
			visit(key);
		}
	}
	//메세지 보낼 때
	@OnMessage
	public void handleMessage(String message, Session userSession) throws IOException {
		
		String[] split = message.split("#####", 2);
		//유저 UK를 조건으로 메세지 전송
		String key = split[0];
		String msg = split[1];
		UserSocket.sendMessage(key, msg);
	}
	
	//접속종료
	@OnClose
	public void handleClose(Session userSession) {
		admin = null;
	}
	
	//admin view로
	private static void send(String message) {
		if (admin != null) {
			try {
				admin.getBasicRemote().sendText(message);
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
	}
	
	//아래의 조건들로 방생성, 방종료, 메세지전송
	//유저 입장
	public static void visit(String key) {		
		send("{\"status\":\"visit\", \"key\":\"" + key + "\"}");
	}
	
	//유저 message 받음
	public static void sendMessage(String key, String message) {
		send("{\"status\":\"message\", \"key\":\"" + key + "\", \"message\":\"" + message + "\"}");
	}
	
	//유저 나감
	public static void bye(String key) {
		send("{\"status\":\"bye\", \"key\":\"" + key + "\"}");
	}
}

/* ********************************************************** */