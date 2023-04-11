package com.test.test1.alarm.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.test.test1.alarm.service.AlarmService;


/* 02.24 장재호 */
@Controller
public class AlarmController {

	@Autowired
	AlarmService alarmService;
	
	@ResponseBody
	@RequestMapping(value="/alarmDel", method=RequestMethod.POST)
	public void alarmDel(int idx) {
		alarmService.alarmDel(idx);
	}
	
}
/*******************************************/