package com.spring.repository;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;
import com.spring.domain.Board;

public class BoardRowMapper implements RowMapper<Board>{

	@Override
	public Board mapRow(ResultSet rs, int rowNum) throws SQLException {
		System.out.println("Board의 mapRow() 실행");
		Board bd = new Board();
		bd.setBrdNum(rs.getLong(1));
		bd.setParentNum(rs.getLong(2));
		bd.setNickName(rs.getString(3));
		bd.setRoadId(rs.getString(4));
		bd.setTitle(rs.getString(5));
		bd.setContent(rs.getString(6));
		bd.setCreateTime(rs.getString(7));
		bd.setUpdateDay(rs.getString(8));
		bd.setIp(rs.getString(9));
		bd.setLikes(rs.getInt(10));
		bd.setViews(rs.getInt(11));
		bd.setDepth(rs.getInt(12));
		bd.setPath(rs.getString(13));
		return bd;
	}
	
	
}
