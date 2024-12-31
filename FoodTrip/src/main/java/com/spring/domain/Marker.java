package com.spring.domain;

import java.io.Serializable;

import org.springframework.web.multipart.MultipartFile;

public class Marker implements Serializable{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 2801250020627927749L;
	
	private String markerId;	//	마커명
	private Double pointX;		//	좌표 X
	private Double pointY;		//	좌표 Y
	private String category;	//	카테고리
	private String pointName;	//	장소명
	private String phone;		//	전화번호
	private String address;		//	주소
	private String urlText;		//	사이트 URL
	private String qrcode;		//	QR 코드
	
	
	//	get(), set()
	public String getmarkerId() {
		return markerId;
	}
	public void setmarkerId(String markerId) {
		this.markerId = markerId;
	}
	public Double getPointX() {
		return pointX;
	}
	public void setPointX(Double pointX) {
		this.pointX = pointX;
	}
	public Double getPointY() {
		return pointY;
	}
	public void setPointY(Double pointY) {
		this.pointY = pointY;
	}
	public String getCategory() {
		return category;
	}
	public void setCategory(String category) {
		this.category = category;
	}
	public String getPointName() {
		return pointName;
	}
	public void setPointName(String pointName) {
		this.pointName = pointName;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public String getUrlText() {
		return urlText;
	}
	public void setUrlText(String description) {
		this.urlText = description;
	}
	public String getQrcode() {
		return qrcode;
	}
	public void setQrcode(String qrcode) {
		this.qrcode = qrcode;
	}
	
	
}
