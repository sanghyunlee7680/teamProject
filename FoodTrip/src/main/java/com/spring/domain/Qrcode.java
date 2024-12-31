package com.spring.domain;

import java.sql.Timestamp;

public class Qrcode {
	private String usernick;		//	유저 닉네임
	private String roadId;			//	코스 id
	private String markerId;		//	마커	id
	private Timestamp checktime;	//	중간 달성 시간
	
	
	//	get(), set()
	public String getUsernick() {
		return usernick;
	}
	public void setUsernick(String usernick) {
		this.usernick = usernick;
	}
	public String getMarkerId() {
		return markerId;
	}
	public void setMarkerId(String markerId) {
		this.markerId = markerId;
	}
	public String getRoadId() {
		return roadId;
	}
	public void setRoadId(String roadId) {
		this.roadId = roadId;
	}
	public Timestamp getChecktime() {
		return checktime;
	}
	public void setChecktime(Timestamp checktime) {
		this.checktime = checktime;
	}
	
}
