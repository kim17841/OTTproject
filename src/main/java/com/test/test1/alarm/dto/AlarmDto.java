package com.test.test1.alarm.dto;

import java.util.Date;

public class AlarmDto {

	private int idx, user_id;
	private String code, checked, prefix;
	private Date create_date;
	
	public int getIdx() {
		return idx;
	}
	
	public void setIdx(int idx) {
		this.idx = idx;
	}
	
	public int getUser_id() {
		return user_id;
	}
	
	public void setUser_id(int user_id) {
		this.user_id = user_id;
	}
	
	public String getCode() {
		return code;
	}
	
	public void setCode(String code) {
		this.code = code;
	}
	
	public String getChecked() {
		return checked;
	}
	
	public void setChecked(String checked) {
		this.checked = checked;
	}
	
	public String getPrefix() {
		return prefix;
	}
	
	public void setPrefix(String prefix) {
		this.prefix = prefix;
	}
	
	@Override
	public String toString() {
		return "AlarmDto=[idx="+idx+",user_id="+user_id+",code="+code+",checked="+checked+",create_date="+create_date+",prefix="+prefix+"]";
	}
}
