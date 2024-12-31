package com.spring.controller;

import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
import com.spring.domain.Road;
import com.spring.service.MarkerService;
import com.spring.service.MemberService;
import com.spring.service.RoadService;

@Controller
@RequestMapping("/road")
public class RoadController {
	
	private static final String cateChicken = "CK";		//	Chicken	-- 치킨
	private static final String cateChinese = "CH";		//	Chinese	-- 중식
	private static final String catePasta = "PS";		//	Pasta	-- 양식
	private static final String cateDisert = "DS";		//	Disert	-- 카페/디저트
	private static final String cateSnack = "SN";		//	Snack	-- 분식
	
	Gson g = new Gson();
		
	@Autowired
	private RoadService roadService;
	
	/*
	 * @Desc   : 관리자가 코스를 생성하기 위한 뷰로 이동하는 메서드
	 * @Param  : -
	 * @Return : String 
	 * @Edit   : KYEONGMIN
	 * */	
	@GetMapping("/makeRoad")
	public String createRoad() {
		return "road/roadMake";
	}
	
	
	//-------   CREATE   -------
	/* 
	 * Ajax로 요청 및 응답
	 * @Desc   : 관리자가 코스 생성 뷰 이동 -> 코스를 모두 완성하고 생성 요청이 발생 했을 때 매핑되는 메서드
	 * @Param  : map(Map<String, Object>)
	 * @Return : String 
	 * @Edit   : KYEONGMIN
	 * */
	@PostMapping("/addCourse")
	@ResponseBody
	public String addCourse(@RequestBody Map<String, Object> map) {
		System.out.println("add Course IN");
		System.out.println(map);
		
		//	데이터 묶음
		Road road = new Road();
		
		road.setCategory((String)map.get("category"));
		road.setUserNick((String)map.get("user"));
		road.setCourseSize((int)map.get("courseSize"));
		road.setDescription((String)map.get("description"));
		System.out.println("course size: "+road.getCourseSize());
		
		//	plan은 마커 리스트의 key
		List<String> planlist = (List<String>)map.get("plan");
		//	List를 String[] 형태로 변환
		String[] planary = planlist.toArray(new String[0]);
		
		road.setCourse(planary);
		
		System.out.println(road.getCourse()[1]);
		
		//	카테고리에 따른 id 부여
		String getCate = road.getCategory();
		System.out.println(getCate);
		/*
			<option value="chicken">치킨</option>
			<option value="chinese">중식</option>
			<option value="pasta">파스타</option>
			<option value="snack">분식</option>
			<option value=disert>디저트</option>		
		*/
		if(getCate.equals("chicken")) {
			road.setRoadId(cateChicken);
		}else if(getCate.equals("chinese")) {
			road.setRoadId(cateChinese);
		}else if(getCate.equals("pasta")) {
			road.setRoadId(catePasta);
		}else if(getCate.equals("snack")) {
			road.setRoadId(cateSnack);
		}else if(getCate.equals("disert")) {
			road.setRoadId(cateDisert);
		}

		roadService.roadCreate(road);
		
		return "success";
	}
	
	/* 
	 * Ajax로 요청 및 응답
	 * @Desc   : 사용자가 코스를 선택했을 때 매핑되는 메서드. 
	 * @Param  : map(Map<String, Object>)
	 * @Return : String 
	 * @Edit   : KYEONGMIN
	 * */
	@PostMapping("/choiceRoad")
	@ResponseBody
	public String choiceRoad(@RequestBody Map<String, Object> map) {

		//System.out.println(map);
		//	데이터 묶음
		Road road = new Road();
		
		road.setRoadId((String)map.get("roadId"));
		road.setUserNick((String)map.get("userNick"));
		road.setCourseToString((String)map.get("courseToString"));
		road.setCourseSize((int)map.get("courseSize"));
		road.setCategory((String)map.get("category"));
		
		//	관리자가 아닐 때 코스 시작시간을 기록
		if(!road.getUserNick().equals("admin")) {
			LocalDateTime localDateTime = LocalDateTime.now();
			Timestamp date = Timestamp.valueOf(localDateTime);
			road.setCreateTime(date);
		}else if(road.getUserNick().equals("admin")){
			//	관리자는 여행 할 수 없음
			return null;
		}
		System.out.println("DB가기 전 : "+ road);
		
		roadService.roadCreate(road);
		
		return "success";
	}
	
	
	//-------   READ   -------

	/* 
	 * @Desc   : 모든 코스를 출력하는 뷰로 이동하기 위한 메서드
	 * @Param  : -
	 * @Return : String 
	 * @Edit   : KYEONGMIN
	 * */
	@GetMapping("/readRoad")
	public String getAllRoad() {
		System.out.println("get all road IN");
		
		return "road/roadreadall";
	}

	/* 
	 * Ajax로 요청 및 응답
	 * @Desc   : 모든 코스를 출력하는 뷰로 이동 후 모든 코스를 ajax를 통해 요청이 발생하면 매핑되어 응답을 반환하는 메서드
	 * @Param  : -
	 * @Return : ResponseEntity<String> 
	 * @Edit   : KYEONGMIN
	 * */
	@PostMapping("/readRoad")
	@ResponseBody
	public ResponseEntity<String> getAllRoadResult() {
		//	저장된 코스 정보를 전부 가져온다.
		List<Road> list = roadService.roadReadAll();
		System.out.println("readAll list get");
		System.out.println("list size : "+list.size());

		//	JSON형태로 주기 위해 변환
		String listJson = g.toJson(list);
		System.out.println(listJson);
		
		//한글 깨짐 방지
		HttpHeaders headers = new HttpHeaders();
		headers.setContentType(MediaType.APPLICATION_JSON);
		headers.set("Content-Type", "application/json; charset=UTF-8");
		
		return new ResponseEntity<>(listJson, headers, HttpStatus.OK);
	}
	
	
	//-------   UPDATE   -------
	/* 
	 * @Desc   : 코스 수정을 위한 뷰로 이동하는 메서드
	 * @Param  : roadId(String), model(Model)
	 * @Return : String
	 * @Edit   : KYEONGMIN
	 * */
	@GetMapping("/roadUpdate")
	public String roadupdate(@RequestParam("id") String roadId, Model model) {
		System.out.println("수정 : "+roadId);
		model.addAttribute("id", roadId);
		return "road/roadEditForm";
	}
	
	
	/* 
	 * Ajax로 요청 및 응답
	 * @Desc   : 코스 수정을 위해 선택한 코스 하나만 가져오는 메서드. 
	 * @Param  : roadId(String)
	 * @Return : ResponseEntity<String>
	 * @Edit   : KYEONGMIN
	 * */
	@PostMapping("/readOneRoad")
	@ResponseBody
	public ResponseEntity<String> oneRoad(@RequestBody String rid){
		System.out.println("하나 줄래 ? : "+rid);

		String id = rid.replace('"', ' ');
		id = id.trim();
		System.out.println("바꿔줄래? : "+id);
		
		Road road = roadService.roadReadOne(id); 
		//	JSON 형태로 전달하기 위한 변환
		String itemJson = g.toJson(road);
		
		System.out.println("가져온 하나 : "+ itemJson);
		//한글 깨짐 방지
		HttpHeaders headers = new HttpHeaders();
		headers.setContentType(MediaType.APPLICATION_JSON);
		headers.set("Content-Type", "application/json; charset=UTF-8");
		
		return new ResponseEntity<>(itemJson, headers, HttpStatus.OK);
	}
	
	

	/* 
	 * @Desc   : 사용자가 완주 또는 진행 중인 모든 코스 중 하나를 선택하여 보기 위해 이동하는 메서드
	 * @Param  : -
	 * @Return : String
	 * @Edit   : KYEONGMIN
	 * */
	@GetMapping("/myTravel")
	public String myTravelInfo() {
		
		return "road/myCourseInfo";
	}
	
	
	/* 
	 * Ajax로 요청 및 응답
	 * @Desc   : 
	 * @Param  : -
	 * @Return : String
	 * @Edit   : KYEONGMIN
	 * */
	@PostMapping("readMyCourse")
	@ResponseBody
	public ResponseEntity<String> readMyCourse(@RequestBody String userNick) {
		
		//System.out.println(userNick);
		String nick = userNick.replace('"', ' ');
		nick = nick.trim();
		System.out.println(nick);
		
		Road road = roadService.readMyCourse(nick);
		System.out.println(road);
		
		if(road == null) {
			return null;
		}
		System.out.println("존재해? : "+road.getUserNick());
	
		String respItem = g.toJson(road);
		
		HttpHeaders headers = new HttpHeaders();
		headers.setContentType(MediaType.APPLICATION_JSON);
		headers.set("Content-Type", "application/json; charset=UTF-8");
		
		return new ResponseEntity<>(respItem, headers, HttpStatus.OK);
	}
	
	/* 
	 * @Desc   : 사용자가 완주 또는 진행 중인 모든 코스를 리스트로 보기 위한 뷰로 이동하는 메서드
	 * @Param  : -
	 * @Return : String
	 * @Edit   : KYEONGMIN
	 * */
	@GetMapping("/myTravellist")
	public String myTravelList() {
		
		return "road/myCourse";
	}
	
	/* 
	 * Ajax로 요청 및 응답
	 * @Desc   : 사용자가 완주 또는 진행 중인 모든 코스를 리스트로 보기 위한 뷰로 이동하는 메서드
	 * @Param  : userNick(String)
	 * @Return : ResponseEntity<String>
	 * @Edit   : KYEONGMIN
	 * */
	@PostMapping("readMyCourseList")
	@ResponseBody
	public ResponseEntity<String> readMyCourseList(@RequestBody String userNick) {
		
		//System.out.println(userNick);
		String nick = userNick.replace('"', ' ');
		nick = nick.trim();
		System.out.println(nick);
		
		List<Road> list = roadService.readMyCourseList(nick);

		System.out.println("get list : "+list);
		HttpHeaders headers = new HttpHeaders();
		headers.setContentType(MediaType.APPLICATION_JSON);
		headers.set("Content-Type", "application/json; charset=UTF-8");
		
		if(list.isEmpty()) {
			System.out.println("list가 비었어");
			return null;
		}
		
		
		String respItem = g.toJson(list);
		
		return new ResponseEntity<>(respItem, headers, HttpStatus.OK);
	}
	
	//	check Finish Coures
	@PostMapping("/checkFinished")
	@ResponseBody
	public String checkFinished(@RequestBody String usernick) {
		System.out.println("usernick in checkFinished : "+usernick);
		
		List<String> roadname = roadService.checkFinished(usernick);
		
		return "";
	}
	
	
	//-------   UPDATE   -------
	@PostMapping("/roadUpExe")
	@ResponseBody
	public String roadUpdateExecute(@RequestBody Map<String, Object> map) {
		System.out.println("update IN : "+map);
		
		Road road = new Road();
		road.setRoadId((String)map.get("roadId"));
		road.setCategory((String)map.get("category"));
		road.setCourseSize((int)map.get("courseSize"));
		List<String> planlist = (List<String>)map.get("plan");
		String[] planary = planlist.toArray(new String[0]);
		road.setCourse(planary);
		System.out.println(road.getRoadId());
//		System.out.println(road.getCourseToString());
		roadService.roadUpdate(road);
		
		return "end"; 
	}
	
	//	사용자가 최종 목적지까지 도착 후 시간을 업데이트
	@PostMapping("/endTime")
	@ResponseBody
	public String roadEndTiemSet(@RequestBody Map<String, Object> map) {
		//System.out.println(usernick);
		
		LocalDateTime localDateTime = LocalDateTime.now();
		Timestamp date = Timestamp.valueOf(localDateTime);
		Road road = new Road();
		road.setEndTime(date);
		road.setUserNick((String)map.get("userNick"));
		road.setRoadId((String)map.get("roadId"));
		
		roadService.roadEndTimeUpdate(road);
		
		return "success";
	}
	

	//-------   DELETE   -------
	@GetMapping("/roadDelete")
	public String roaddelete(@RequestParam("id") String id) {
		System.out.println("삭제할 id : "+id);
		
		roadService.roadDelete(id);		
		
		return "redirect:readRoad";
	}
	
	
}
