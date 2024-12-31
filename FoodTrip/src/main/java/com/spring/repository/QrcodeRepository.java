package com.spring.repository;

import java.util.List;

import com.spring.domain.Marker;
import com.spring.domain.Qrcode;
import com.spring.domain.Road;

public interface QrcodeRepository {
	//	중간 체크타임 기록 -- Service에서 Marker는 
	//	MarkerService를 호출하여 받기 때문에 여기의 return은 void이다.
	void checkMidTime(Qrcode qrcode);
	
	//	코스 선택 시, 코스 내 포함된 마커의 QR을 저장. (RoadService에서 호출)
	void setUserQr(Road road);
	
//	내 코스에 해당하는 QR을 전부 가져옴
	List<Qrcode> getQrList(String usernick);
}
