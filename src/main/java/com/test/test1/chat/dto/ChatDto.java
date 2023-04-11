package com.test.test1.chat.dto;

import java.util.Date;

/* 02.26 - 장재호 */
public class ChatDto {
	//sender - 보내는사람의 pk
	private int user_id, sender;
	private String msg, id, uuid;
	private Date create_time;
	
	
	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}
	
	public int getUser_id() {
		return user_id;
	}
	
	public void setUser_id(int user_id) {
		this.user_id = user_id;
	}
	
	public int getSender() {
		return sender;
	}
	
	public void setSender(int sender) {
		this.sender = sender;
	}
	
	public String getMsg() {
		return msg;
	}
	
	public void setMsg(String msg) {
		this.msg = msg;
	}

	public Date getCreate_time() {
		return create_time;
	}

	public void setCreate_time(Date create_time) {
		this.create_time = create_time;
	}

	public String getUuid() {
		return uuid;
	}

	public void setUuid(String uuid) {
		this.uuid = uuid;
	}
	
	@Override
	public String toString() {
		return "ChatDto:[user_id="+user_id+", sender="+sender+", msg="+msg+ ", id="+id+", create_time="
				+create_time+", uuid="+uuid+"]";
	}

}
/***********************************/
