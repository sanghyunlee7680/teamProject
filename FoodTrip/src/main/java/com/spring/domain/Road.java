package com.spring.domain;

import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.springframework.web.multipart.MultipartFile;

public class Road {
	private String roadId;				//	코스 id
	private String userNick;			//	유저 닉네임
	private String course[];			//	코스에 포함된 마커 String배열 --
	private String courseToString;		//	코스에 포함된 마커 String배열 -- 한 문자열로 가지고 DB에 입출력.
	private int courseSize;				//	코스에 포함된 마커 개수
	private String category;			//	코스의 카테고리
	private ArrayList<Marker> points;	//	마커 정보를 담고 있는 배열
	private Timestamp createTime;		//	코스 생성시간 -- 사용자가 코스 선택 시 기록(관리자는 제외)
	private Timestamp endTime;			//	코스 종료시간 -- 사용자의 완주 시 기록
	private String description;			//	코스 설명	-- 현재 따로 쓰이지 않음
	
	//	get(), set()
	public String getRoadId() {
		return roadId;
	}
	public void setRoadId(String roadId) {
		this.roadId = roadId;
	}
	public String getUserNick() {
		return userNick;
	}
	public void setUserNick(String userNick) {
		this.userNick = userNick;
	}
	public String[] getCourse() {
		return course;
	}
	public void setCourse(String[] course) {
		//	String[]가 들어오면 DB와도 입출력을 위해 String 형태로도 바로 변환 후 저장 
		setCourseToString(course);
		this.course = course;
	}
	public int getCourseSize() {
		return courseSize;
	}
	public void setCourseSize(int courseSize) {
		this.courseSize = courseSize;
	}
	public ArrayList<Marker> getPoints() {
		return points;
	}
	public void setPoints(ArrayList<Marker> points) {
		this.points = points;
	}
	public String getCategory() {
		return category;
	}
	public void setCategory(String category) {
		this.category = category;
	}
	public Date getCreateTime() {
		return createTime;
	}
	public void setCreateTime(Timestamp createTime) {
		this.createTime = createTime;
	}
	public Date getEndTime() {
		return endTime;
	}
	public void setEndTime(Timestamp endTime) {
		this.endTime = endTime;
	}
	public String getCourseToString() {
		return courseToString;
	}
	
	//	문자열배열로 들어온 파라미터를 join을 통해 하나의 문자열로 변환
	//	코스 생성 시 사용
	public void setCourseToString(String[] courseToString) {
		System.out.println("String[] to String");
		this.courseToString = String.join(",", courseToString);
	}
	
	//	DB로부터 읽어왔을 때 들어온 문자열을 String[]형태로 저장하기 위한 메서드
	//	DB로부터 Read 시 사용
	public void setCourseToString(String courseToString) {
		System.out.println("String to String[]");
		this.courseToString = courseToString;
		StringToCourse();
	}
	
	//	한 문자열로 들어온 코스를 문자열 배열로 바꿔 넣음 
	public void StringToCourse() {
		//course = new String[courseSize];
		this.course = courseToString.split(",");		
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	
/*
	private String roadMaker;
	private Marker startPoint;
	private String sPointStr;
	private Marker endPoint;
	private String ePointStr;
*/
	
//	private MultipartFile image;
//	private String imageName;
/*	
	public Marker getStartPoint() {
		return startPoint;
	}
	public void setStartPoint(Marker startPoint) {
		this.startPoint = startPoint;
	}
	public Marker getEndPoint() {
		return endPoint;
	}
	public void setEndPoint(Marker endPoint) {
		this.endPoint = endPoint;
	}*/
/*	
	public MultipartFile getImage() {
		return image;
	}
	public void setImage(MultipartFile image) {
		this.image = image;
	}
	public String getImageName() {
		return imageName;
	}
	public void setImageName(String imageName) {
		this.imageName = imageName;
	}
	*/
}
