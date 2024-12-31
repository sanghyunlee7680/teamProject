package com.spring.repository;

import java.util.List;

import javax.sql.DataSource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.spring.domain.Marker;
import com.spring.domain.Qrcode;
import com.spring.domain.Road;
import com.spring.service.MarkerService;

@Repository
public class QrcodeRepositoryImpl implements QrcodeRepository{
	
	private JdbcTemplate template;
		
	@Autowired
	public void setJdbctemplate(DataSource dataSource) {
		this.template = new JdbcTemplate(dataSource);
	}

	/*
	 * @Desc   : 중간 지점(마커)에 시간을 기록하기 위한 메서드. 
	 * 			 해당하는 마커의 checktime 컬럼에 값을 update한다.
	 * @Param  : qrcode(Qrcode) 
	 * @Return : void
	 * @Edit   : KYEONGMIN
	 * */	
	@Override
	public void checkMidTime(Qrcode qrcode) {
		String SQL = "update useqrsave set checktime=? where usernick=? and markerId=?";
		template.update(SQL, qrcode.getChecktime(), qrcode.getUsernick(), qrcode.getMarkerId());
	}

	/*
	 * @Desc   : 사용자가 코스 선택 후 코스에 포함된 마커의 정보를 QR Table에 기록하는 메서드
	 * @Param  : road(Road) 
	 * @Return : void
	 * @Edit   : KYEONGMIN
	 * */
	@Override
	public void setUserQr(Road road) {
		//	road에서 마커의 갯수만큼 반복 입력
		for(int i=0; i<road.getCourseSize(); i++) {
			String courseOne = road.getCourse()[i];
			System.out.println(courseOne);
			
			String SQL = "INSERT INTO useqrsave (usernick, roadId, markerId) VALUES(?,?,?)";
			
			template.update(SQL, road.getUserNick(), road.getRoadId(), courseOne);			
		}
	}

	/*
	 * @Desc   : 사용자가 자신의 코스를 Read할 때 해당 코스에 
	 * 			 어떤 마커를 달성했는지 구분하여 표시하기 위해 사용하는 메서드
	 * @Param  : road(Road) 
	 * @Return : void
	 * @Edit   : KYEONGMIN
	 * */
	@Override
	public List<Qrcode> getQrList(String usernick) {
		System.out.println("qr repo : "+usernick);
		
		//	이렇게 하면 road가 달라져도 같은 nick의 qr을 전부 가져온다. 수정요
		String SQL = "SELECT * FROM useqrsave where usernick=?";
		List<Qrcode> list = template.query(SQL, new QrcodeRowMapper(), usernick);
		System.out.println("list없어? : " + list);
		
		return list;
	}
	
	
}
