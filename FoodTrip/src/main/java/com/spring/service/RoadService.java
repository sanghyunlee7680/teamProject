package com.spring.service;

import java.sql.Timestamp;
import java.util.List;

import org.springframework.stereotype.Service;

import com.spring.domain.Road;

public interface RoadService {
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
