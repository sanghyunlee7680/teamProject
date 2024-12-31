package com.spring.service;

import java.util.List;

import com.spring.domain.Marker;
import com.spring.domain.Qrcode;
import com.spring.domain.Road;

public interface QrcodeService {
	//	중간 체크타임 기록
	Marker checkMidTime(Qrcode qrcode);

	//	코스 선택 시, 코스 내 포함된 마커의 QR을 저장. (RoadService에서 호출)	
	void setUserQr(Road road);
	
	//	내 코스에 해당하는 QR을 전부 가져옴
	List<Qrcode> getQrList(String usernick);
}
