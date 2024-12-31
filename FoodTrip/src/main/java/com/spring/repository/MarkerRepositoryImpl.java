package com.spring.repository;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.URL;
import java.net.URLConnection;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.sql.DataSource;

//import org.apache.tomcat.jdbc.pool.DataSource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.spring.domain.Marker;

@Repository
public class MarkerRepositoryImpl implements MarkerRepository{

	private JdbcTemplate template;
	HttpServletRequest req;
	List<Marker> listOfMarker = new ArrayList<Marker>();
	
	@Autowired
	public void setJdbctemplate(DataSource dataSource) {
		this.template = new JdbcTemplate(dataSource);
	}
	
	//	create
	@Override
	public void markerCreate(List<Marker> list) {
		for(int i=0; i<list.size(); i++) {
			String remakeId = null;
			Marker marker = list.get(i);
			remakeId = idCreate(marker.getmarkerId());
			marker.setmarkerId(remakeId);
	
			String code = "http://localhost:8080/FoodTrip/qrcode/qrRead?id=";
			//String code = "http://172.16.3.77:8080/FoodTrip/qrcode/qrRead?id=";
			code += remakeId;
			System.out.println(code);
			
			marker.setQrcode(code);
			
			String SQL = "INSERT INTO marker (markerId, pointX, pointY, category, pointName, phone, address, urltext, qrcode) values(?,?,?,?,?,?,?,?,?)";
			template.update(SQL, marker.getmarkerId(), marker.getPointX(), marker.getPointY(), marker.getCategory(), marker.getPointName(), marker.getPhone(), marker.getAddress(), marker.getUrlText(), marker.getQrcode());
		}
	}

	//	read
	@Override
	public List<Marker> markerReadAll() {
		System.out.println("rdall repo IN");
		String SQL = "SELECT * FROM marker";
		List<Marker> list = template.query(SQL, new MarkerRowMapper());
		System.out.println("rdall repo Query END");
		return list;
	}
	
	//	read-duplicate
	@Override
	public Boolean isExist(String name, String addr) {
		System.out.println("exist? : " + name + " | "+ addr);
		String SQL = "SELECT * FROM marker where pointName=? and address=?";
		
		try {
			Marker marker = template.queryForObject(SQL, new Object[] {name, addr}, new MarkerRowMapper());
			if(marker != null && marker.getPointName().equals(name) && marker.getAddress().equals(addr)) {
				//존재한다.
				System.out.println("exist!!");
				return true;
			}
		}catch(Exception e) {
			System.out.println("no exist");
			return false;
		}
		return false;
	}

	//	read-One
	@Override
	public Marker markerReadOne(String markerId) {
		
		String SQL = "SELECT * FROM marker where markerId=?";
		Marker marker = template.queryForObject(SQL, new Object[] {markerId},new MarkerRowMapper());
		
		return marker;
	}

	//	update
	@Override
	public void markerUpdate(Marker marker) {
		System.out.println(marker.getPointName());

		System.out.println(marker.getmarkerId());
		String SQL = "update marker set pointX=?, pointY=?, category=?, pointName=?, phone=?, address=?, urltext=? where markerId=?";
		template.update(SQL, marker.getPointX(), marker.getPointY(), marker.getCategory(), marker.getPointName(), marker.getPhone(), marker.getAddress(), marker.getUrlText(), marker.getmarkerId());

	}

	//	delete
	@Override
	public void markerDelete(String markerId) {
		String SQL = "delete from marker where markerId=?";
		template.update(SQL, markerId);		
	}

	//	create id before insert marker
	public String idCreate(String id) {
		String SQL ="select num from marker order by num desc limit 0, 1";
		System.out.println(id);
		int num;
		try {
			num = template.queryForObject(SQL, Integer.class);
		}catch(Exception e) {
			num = 0;
		}

		System.out.println("return last : "+ num);
		num++;
		String result = Long.toString(num);
		String reId = id + result;
		
		return reId;
	}
	
	public void ipChange() {
		String SQL ="select num from marker order by num desc limit 0, 1";
		int num;
		try {
			num = template.queryForObject(SQL, Integer.class);
		}catch(Exception e) {
			num = 0;
		}
		System.out.println("num : "+num);
		
		for(int i=0; i<num;i++) {
			String inSQL = "SELECT qrcode FROM marker where num=?";
			String getCode = template.queryForObject(inSQL, String.class, i+1);			
			
			String qrip;
			qrip = getCode.replace("172.16.3.77", "localhost");
			System.out.println("change ip : "+qrip);
			String reSQL = "UPDATE marker SET qrcode=? where num=?";
			template.update(reSQL, qrip, i+1);
		}
	}
	

}
