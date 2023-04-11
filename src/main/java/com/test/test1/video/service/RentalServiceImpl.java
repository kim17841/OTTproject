package com.test.test1.video.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.test.test1.video.dao.RentalDao;
import com.test.test1.video.dto.RentalDTO;
import com.test.test1.video.dto.VideoDto;

@Service
public class RentalServiceImpl implements RentalService{
	
	@Inject
	RentalDao rentalDao;

	@Override
	public void insert(RentalDTO dto) {
		rentalDao.insert(dto);
	}

	@Override
	public void delete(RentalDTO dto) {
		rentalDao.delete(dto);
	}

	@Override
	public String getid(RentalDTO dto) {
		return rentalDao.getid(dto);
	}

	@Override
	public List<VideoDto> list(String user_id) {
		return rentalDao.list(user_id);
	}

}
