package com.test.test1.admin.service;

import java.util.List;

import com.test.test1.admin.dto.AdminETCDto;
import com.test.test1.video.dto.VideoDto;

public interface AdminService {
/****************************************** 02.18~ 장재호 ***********************************************/
	int getTotalSales();

	void deletes(List<Integer> delArr);

	int getDailySales();

	int getTodayVisit();

	int getTotalVisit();

	void videoDel(int video_id);

	void videoDels(List<Integer> delArr);

	void videoDataModify(VideoDto dto);

	List<AdminETCDto> getCategory();

	List<AdminETCDto> getGenre();
	
	List<AdminETCDto> getActor();

	void addCategory(String category_name);

	void addGenre(String genre_name);
	
	void addActorDb(String actor_name);

	void delCategory(String category_name);

	void delGenre(String genre_name);

	void addActor(String[] actor);
	
	void delActor(String actor_name);

	void addVideo(AdminETCDto dto);

	void addVideoCategory(AdminETCDto dto);

	void addVideoGenre(AdminETCDto dto);

	void addVideoActor(AdminETCDto dto);

	String check(AdminETCDto dto);




}
/****************************************** 02.18~ 장재호 ***********************************************/
