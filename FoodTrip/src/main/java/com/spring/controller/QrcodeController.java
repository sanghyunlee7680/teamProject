package com.spring.controller;

import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.Gson;
import com.spring.domain.Marker;
import com.spring.domain.Member;
import com.spring.domain.Qrcode;
import com.spring.service.QrcodeService;

@Controller
@RequestMapping("qrcode")
public class QrcodeController {
	
	//	ajax 응답을 위한 Gson 객체
	Gson g = new Gson();
	
	//	qrcode의 serivce
	@Autowired
	private QrcodeService qrcodeService;	
	
	/*
	 * @Desc   : QR 코드를 통해 요청이 발생했을 때 받는 메서드, 로그인 폼을 제공하는 컨트롤러로 Redirect
	 * @Param  : id(String) , member(Member) 
	 * @Return : String 
	 * @Edit   : KYEONGMIN
	 * */
	@GetMapping("/qrRead")
	public String qrRead(@RequestParam String id, @ModelAttribute("mem") Member member) {
		System.out.println("marker id : "+id);
		//	id 는 마커의 id
		//	로그인 폼을 제공하는 컨트롤러로 id를 가지고 redirect   
		return "redirect:/member/login?id="+id;
	}
	
	/*
	 * @Desc   : QR을 통한 요청 발생 후 로그인 폼 -> 로그인 후 도착하는 메서드
	 * @Param  : id(String) , usernick(String), model(Model) 
	 * @Return : String 
	 * @Edit   : KYEONGMIN
	 * */
	@GetMapping("/qrCheck")
	public String qrCheck(@RequestParam String id, @RequestParam String usernick, Model model) {
		
		//	id 는 마커의 id
		Qrcode qc = new Qrcode();
		
		System.out.println("id : "+ id);
		System.out.println("usernick : "+ usernick);
		
		//	중간 지점 체크타임을 기록하기 위해 LocalDateTime사용
		LocalDateTime localDateTime = LocalDateTime.now();
		Timestamp date = Timestamp.valueOf(localDateTime);
		
		//	데이터 묶음
		qc.setMarkerId(id);
		qc.setUsernick(usernick);
		qc.setChecktime(date);
		//	시간 체크 및 마커 정보 가져오기.
		Marker marker = qrcodeService.checkMidTime(qc);
		
		//	데이터 담기
		model.addAttribute("qc", qc);
		model.addAttribute("marker", marker);
		
		return "road/checkSucc";
	}

	/*
	 * Ajax 요청에 따른 응답 메서드
	 * @Desc   : 내 코스를 출력할 때 달성한 지점을 표시 하기위해 달성한 마커가 무엇인지 가져오는 메서드
	 * @Param  : usernick(String) 
	 * @Return : ResponseEntity<String> 
	 * @Edit   : KYEONGMIN
	 * */
	@PostMapping("/getMyQr")
	@ResponseBody
	public ResponseEntity<String> getMyQrcode(@RequestBody String usernick){
		System.out.println("nick ? : "+usernick);
		//	ajax로 들어온 문자열은 " " [쌍따옴표]가 들어 있어서 처리
		String nick = usernick.replace('"', ' ');
		nick = nick.trim();
		System.out.println("바꿔줄래? : "+nick);
		
		//	내 코스에 해당하는 모든 QR을 가져온다.
		List<Qrcode> list = qrcodeService.getQrList(nick);
		
		String itemJson = g.toJson(list);
		System.out.println(itemJson);
		
		//	한글이 깨지지 않도록 처리
		HttpHeaders headers = new HttpHeaders();
		headers.setContentType(MediaType.APPLICATION_JSON);
		headers.set("Content-Type", "application/json; charset=UTF-8");
		
		return new ResponseEntity<>(itemJson, headers, HttpStatus.OK);
	}
	
}
