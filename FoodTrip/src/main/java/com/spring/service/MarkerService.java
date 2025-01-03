package com.spring.service;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Service;

import com.spring.domain.Marker;

public interface MarkerService {
	//void markerCreate(Marker marker);
	void markerCreate(List<Marker> list);
	List<Marker> markerReadAll();
	Boolean isExist(String name, String addr);
	Marker markerReadOne(String markerId);
	void markerUpdate(Marker marker);
	void markerDelete(String markerId);
}
