package com.spring.repository;

import java.sql.Timestamp;
import java.util.List;

import com.spring.domain.Road;

public interface RoadRepository {
	void roadCreate(Road road);
	
	List<Road> roadReadAll();
	Road roadReadOne(String roadId);
	List<Road> readMyCourseList(String userNick);
	Road readMyCourse(String userNick);
	List<String> checkFinished(String userNick);
	
	void roadUpdate(Road road);
	void roadEndTimeUpdate(Road road);
	
	void roadDelete(String roadId);
}
