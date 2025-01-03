package com.spring.repository;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;

import com.spring.domain.BoardLike;

public class BoardLikeRowMapper implements RowMapper<BoardLike>{

	@Override
	public BoardLike mapRow(ResultSet rs, int rowNum) throws SQLException {
		BoardLike brk = new BoardLike();
		brk.setLikeNum(rs.getLong(1));
		brk.setBrdNum(rs.getLong(2));
		brk.setNickName(rs.getString(3));
		return brk;
	}

}
