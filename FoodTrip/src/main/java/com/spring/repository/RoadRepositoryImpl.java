package com.spring.repository;

import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

import javax.sql.DataSource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.spring.domain.Marker;
import com.spring.domain.Road;

@Repository
public class RoadRepositoryImpl implements RoadRepository{

	private JdbcTemplate template;
	
	List<Road> listOfMarker = new ArrayList<Road>();
	
	@Autowired
	public void setJdbctemplate(DataSource dataSource) {
		this.template = new JdbcTemplate(dataSource);
	}

	@Override
	public void roadCreate(Road road) {
		String remakeId = null;
		//remakeId = idCreate(road.getRoadId());
		if(road.getUserNick().equals("admin")) {
			remakeId = idCreate(road.getRoadId());			
			road.setRoadId(remakeId);
		}
		
		System.out.println("make id : "+remakeId);
		System.out.println("입력전 마지막 nick : "+ road.getUserNick());
		
		
		//road테이블에 입력될 데이터만 넣어준다.(관리자)
		if(road.getUserNick().equals("admin")) {
			String SQL = "INSERT INTO road (roadId, usernick, course, courseSize, category, description, starttime, endtime) values(?,?,?,?,?,?,?,?)";
			template.update(SQL, road.getRoadId(), road.getUserNick(), road.getCourseToString(), road.getCourseSize(), road.getCategory(), road.getDescription(), road.getCreateTime(), road.getEndTime());
		}else if(!(road.getUserNick().equals("admin"))){
			String SQL = "INSERT INTO road (roadId, usernick, course, courseSize, category, description, starttime, endtime) values(?,?,?,?,?,?,?,?)";
			template.update(SQL, road.getRoadId(), road.getUserNick(), road.getCourseToString(), road.getCourseSize(), road.getCategory(), road.getDescription(), road.getCreateTime(), road.getEndTime());
		}
	}


	@Override
	public List<Road> roadReadAll() {		
		String SQL = "SELECT * FROM road where usernick='admin'";
		List<Road> list = template.query(SQL, new RoadRowMapper());
		System.out.println("rdall repo Query END");
		return list;
	}

	@Override
	public Road roadReadOne(String roadId) {
		System.out.println("DB진입전 : "+ roadId);
		String SQL = "SELECT * FROM road where roadId=?";
		Road road = template.queryForObject(SQL, new Object[] {roadId}, new RoadRowMapper());
		System.out.println("db에서 인출 : "+ road.getUserNick());
		return road;
	}
	
	@Override
	public Road readMyCourse(String userNick) {
		String SQL = "SELECT * FROM road where userNick=?";
		Road road = null;
		//List<Road> list = null;
		try {
			//list = template.query(SQL, new Object[] {userNick}, new RoadRowMapper());
			road = template.queryForObject(SQL, new Object[] {userNick}, new RoadRowMapper());
			//System.out.println("db에서 인출 : "+ road.getUserNick());
			System.out.println("exist!!");
			return road;
		}catch(Exception e) {
			System.out.println("not exist");
			return null;
		}
	}
	
	@Override
	public List<Road> readMyCourseList(String userNick) {
		String SQL = "SELECT * FROM road where userNick=?";
		
		List<Road> list = null;
		try {
			list = template.query(SQL, new Object[] {userNick}, new RoadRowMapper());
			System.out.println("exist!!");
			return list;
		}catch(Exception e) {
			System.out.println("not exist");
			return null;
		}
	}

	@Override
	public List<String> checkFinished(String userNick) {
		List<String> list = null;
		/*		
		String SQL = "select roadId from road where userick=?";
		list = template.query(SQL, userNick, );
		*/
		return list;
	}

	@Override
	public void roadUpdate(Road road) {
		System.out.println("db update befofe : "+road.getRoadId());
		String SQL = "UPDATE road SET course=?, courseSize=?, category=? where roadId=?";
		template.update(SQL, road.getCourseToString(), road.getCourseSize(), road.getCategory(), road.getRoadId());
	}	
		
	@Override
	public void roadEndTimeUpdate(Road road) {
		//System.out.println("date : "+date+"nick : "+usernick);
		String SQL = "UPDATE road SET endtime=? where roadId=? and usernick=?";
		template.update(SQL, road.getEndTime() ,road.getRoadId(), road.getUserNick());
	}

	@Override
	public void roadDelete(String roadId) {
		String SQL = "DELETE FROM road where roadId=?";
		template.update(SQL, roadId);		
	}
	
	public String idCreate(String id) {
		String SQL ="select num from road order by num desc limit 0, 1";
		System.out.println(id);
		int num;
		try {
			num = template.queryForObject(SQL, Integer.class);
		}catch(Exception e) {
			num = 0;
		}

		System.out.println("return last : "+ num);
		
		String result = Long.toString(num);
		
		String reId = id + result;
		System.out.println("end id : "+ reId);
		
		return reId;
		
	}
	

}
