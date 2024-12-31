package com.spring.service;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.domain.Marker;
import com.spring.repository.MarkerRepository;

@Service
public class MarkerServiceImpl implements MarkerService{

	@Autowired
	private MarkerRepository markerRepository;
	
	@Override
	public void markerCreate(List<Marker> list) {
		markerRepository.markerCreate(list);
	}

	@Override
	public List<Marker> markerReadAll() {
		List<Marker> list = markerRepository.markerReadAll();
		
		return list;
	}
	

	@Override
	public Boolean isExist(String name, String addr) {
		return markerRepository.isExist(name, addr);	
	}

	@Override
	public Marker markerReadOne(String markerId) {
		Marker marker = markerRepository.markerReadOne(markerId);
		
		return marker;
	}

	@Override
	public void markerUpdate(Marker marker) {
		markerRepository.markerUpdate(marker);
	}

	@Override
	public void markerDelete(String markerId) {
		markerRepository.markerDelete(markerId);		
	}


}
