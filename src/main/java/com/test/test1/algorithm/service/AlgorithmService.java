package com.test.test1.algorithm.service;

import java.util.List;
import java.util.Map;

import com.test.test1.algorithm.dto.AlgorithmDto;
import com.test.test1.video.dto.VideoDto;

//알고리즘 구현을 위한 서비스 인터페이스 - 02.15 장재호
public interface AlgorithmService {

	public Integer check(Map<String, Object> map);

	public void insert(Map<String, Object> map);

	public void update(Map<String, Object> map);

	public List<AlgorithmDto> categoryRate();

	public List<AlgorithmDto> genreRate();

	public List<AlgorithmDto> weeklyVisitor();

	public List<AlgorithmDto> weeklySales();

	public List<VideoDto> userlist(String user_id);	
	
}
