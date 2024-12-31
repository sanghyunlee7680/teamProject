package com.spring.repository;

import java.sql.ResultSet;
import java.sql.SQLException;
import org.springframework.jdbc.core.RowMapper;

import com.spring.domain.Qrcode;

public class QrcodeRowMapper implements RowMapper<Qrcode>{

	@Override
	public Qrcode mapRow(ResultSet rs, int rowNum) throws SQLException {
		Qrcode qrcode = new Qrcode();
		//System.out.println("rs: "+rs);
		qrcode.setUsernick(rs.getString(2));
		//System.out.println("2번");
		qrcode.setRoadId(rs.getString(3));
		//System.out.println("3번");
		qrcode.setMarkerId(rs.getString(4));
		//System.out.println("4번");
		qrcode.setChecktime(rs.getTimestamp(5));
		//System.out.println("5번");
		
		return qrcode;
	}

}
