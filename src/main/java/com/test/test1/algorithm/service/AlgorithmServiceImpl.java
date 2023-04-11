package com.test.test1.algorithm.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.test.test1.algorithm.dao.AlgorithmDao;
import com.test.test1.algorithm.dto.AlgorithmDto;
import com.test.test1.video.dto.VideoDto;

//알고리즘 구현을 위한 서비스 - 02.15 장재호
@Service
public class AlgorithmServiceImpl implements AlgorithmService {

	@Autowired
	AlgorithmDao algorithmDao;
	
	@Override
	public Integer check(Map<String, Object> map) {
		return algorithmDao.check(map);
	}

	@Override
	public void insert(Map<String, Object> map) {
		algorithmDao.insert(map);		
	}

	@Override
	public void update(Map<String, Object> map) {
		algorithmDao.update(map);				
	}

	@Override
	public List<AlgorithmDto> categoryRate() {
		return algorithmDao.categoryRate();
	}

	@Override
	public List<AlgorithmDto> genreRate() {
		return algorithmDao.genreRate();
	}

	@Override
	public List<AlgorithmDto> weeklyVisitor() {
		return algorithmDao.weeklyVisitor();
	}

	@Override
	public List<AlgorithmDto> weeklySales() {
		return algorithmDao.weeklySales();
	}

////////////////////02.27 시청기록 구현 - 김범수 //////////////////////
	@Override
	public List<VideoDto> userlist(String user_id) {
		return algorithmDao.userlist(user_id);
	}
	
}
