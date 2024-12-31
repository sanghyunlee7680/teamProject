package com.spring.service;

import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.domain.Marker;
import com.spring.domain.Road;
import com.spring.repository.RoadRepository;

@Service
public class RoadServiceImpl implements RoadService{

	@Autowired
	private RoadRepository roadRepository;
	
	@Autowired
	private QrcodeService qrcodeSerivce;
	
	@Autowired
	private MarkerService markerService;
	
	//	코스 생성
	@Override
	public void roadCreate(Road road) {
		roadRepository.roadCreate(road);
		System.out.println(road.getUserNick());
		
		if(!road.getUserNick().equals("admin")) {
			System.out.println("여긴 안가지?");
			qrcodeSerivce.setUserQr(road);
		}
	}

	
	@Override
	public List<Road> roadReadAll() {	
		List<Road> list = roadRepository.roadReadAll();
		if(list != null) {
			findMarker(list);
		}
		return list;
	}

	@Override
	public Road roadReadOne(String roadId) {
		Road road = roadRepository.roadReadOne(roadId);
		findMarker(road);
		return road;
	}
	
	@Override
	public Road readMyCourse(String userNick) {
		Road road = roadRepository.readMyCourse(userNick);
		if(road != null) {
			findMarker(road);
		}
		//System.out.println("rd my c : "+ road.getPoints());
		
		return road;
	}
	
	@Override
	public List<Road> readMyCourseList(String userNick) {
		List<Road> list = roadRepository.readMyCourseList(userNick);
		if(list.isEmpty()) {
			System.out.println("비었지? ");
		}else {
			for(int i=0; i<list.size(); i++) {
				Road road = list.get(i);
				findMarker(road);		
			}
		}
		//List<Road> list = roadRepository.readMyCourse(userNick);
		return list;
	}

	@Override
	public List<String> checkFinished(String userNick) {
		List<String> list = roadRepository.checkFinished(userNick);
		return null;
	}

	@Override
	public void roadUpdate(Road road) {
		roadRepository.roadUpdate(road);		
	}

	@Override
	public void roadEndTimeUpdate(Road road) {
		roadRepository.roadEndTimeUpdate(road);
	}


	@Override
	public void roadDelete(String roadId) {
		roadRepository.roadDelete(roadId);		
	}
	
	public void findMarker(List<Road> list){
		//코스가 가진 마커id로 마커를 전부 가져온다.
		//1. 리스트의 요소에 접근
		for(int i=0; i<list.size();i++) {
			ArrayList<Marker> find = new ArrayList<Marker>();
			Road roadOne = list.get(i);
			//System.out.println(roadOne.getCourse());
			String[] tmp = new String[roadOne.getCourseSize()];
			//2. 리스트 요소 내 마커 리스트에 접근
			//System.out.println("rd id in read " + roadOne.getRoadId());
			//System.out.println("rd size in read " + roadOne.getCourseSize());
			System.out.println("tmp size : "+tmp.length);
			for(int j=0; j<roadOne.getCourseSize(); j++) {
				tmp = roadOne.getCourse();	//주소값만 받음.
				System.out.println("tmp in size : "+tmp.length);
				Marker mk = markerService.markerReadOne(tmp[j]);
				System.out.println(mk.getmarkerId());
				find.add(mk);
			}
			roadOne.setPoints(find);
		} 
	}
	
	public void findMarker(Road road) {
		ArrayList<Marker> find = new ArrayList<Marker>();
		Road roadOne = road;
		String[] tmp = new String[roadOne.getCourseSize()];
		//2. 리스트 요소 내 마커 리스트에 접근
		System.out.println("tmp size : "+tmp.length);
		for(int j=0; j<roadOne.getCourseSize(); j++) {
			tmp = roadOne.getCourse();	//주소값만 받음.
			System.out.println("tmp in size : "+tmp.length);
			Marker mk = markerService.markerReadOne(tmp[j]);
			System.out.println(mk.getmarkerId());
			find.add(mk);
		}
		roadOne.setPoints(find);
	}
}
