package com.spring.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.domain.Marker;
import com.spring.domain.Qrcode;
import com.spring.domain.Road;
import com.spring.repository.QrcodeRepository;

@Service
public class QrcodeServiceImpl implements QrcodeService{

	@Autowired
	private QrcodeRepository qrcodeRepository;
	
	@Autowired
	private MarkerService markerService;

	/*
	 * @Desc   : 중간 지점(마커)에 시간을 기록하기 위한 메서드. 
	 * 			 여기서 마커에 대한 정보도 가져온다. QR Table에 기록 후 MarkerService를 호출하여
	 * 			 마커의 정보를 return
	 * @Param  : qrcode(Qrcode) 
	 * @Return : Marker
	 * @Edit   : KYEONGMIN
	 * */	
	@Override
	public Marker checkMidTime(Qrcode qrcode) {
		qrcodeRepository.checkMidTime(qrcode);
		String findMid = qrcode.getMarkerId();
		System.out.println("find Marker Id : "+findMid);
		Marker marker = markerService.markerReadOne(findMid);
		
		return marker;
	}

	/*
	 * @Desc   : 사용자가 코스 선택 후 코스에 포함된 마커의 정보를 QR Table에 기록하는 메서드
	 * @Param  : road(Road) 
	 * @Return : void
	 * @Edit   : KYEONGMIN
	 * */
	@Override
	public void setUserQr(Road road) {
		qrcodeRepository.setUserQr(road);
	}

	/*
	 * @Desc   : 사용자가 자신의 코스를 Read할 때 해당 코스에 
	 * 			 어떤 마커를 달성했는지 구분하여 표시하기 위해 사용하는 메서드
	 * @Param  : usernick(String)
	 * @Return : List<Qrcode>
	 * @Edit   : KYEONGMIN
	 * */
	@Override
	public List<Qrcode> getQrList(String usernick) {
		List<Qrcode> list = qrcodeRepository.getQrList(usernick);
		return list;
	}

	
}
