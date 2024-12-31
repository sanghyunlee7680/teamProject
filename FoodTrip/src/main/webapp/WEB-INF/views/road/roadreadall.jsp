<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page session="false" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="/FoodTrip/resources/css/menu.css?version=7"/>
<link rel="stylesheet" href="/FoodTrip/resources/css/Marker.css?version=5"/>
<script src="https://kit.fontawesome.com/7676881a65.js" crossorigin="anonymous"></script>
</head>
<body>
<div class="container">
	<div class="menubar" id="addmBack">
		<%@ include file="../menu/menu.jsp" %>
 		<i class="fa-solid fa-route"></i>
		<span class="headTitle rdallTitle">전체 코스보기</span>
	</div>
	<div class="tabcontainer">
		<div class="tabBody">
			<span id="chinese">중식<img src="/FoodTrip/resources/images/tab_chinese.png"/></span>
			<span id="pasta">파스타<img src="/FoodTrip/resources/images/tab_pasta.png"/></span>
			<span id="chicken">치킨<img src="/FoodTrip/resources/images/tab_chicken.png"/></span>
			<span id="snack">분식<img src="/FoodTrip/resources/images/tab_snack.png"/></span>
			<span id="disert">카페/디저트<img src="/FoodTrip/resources/images/tab_disert.png"/></span>
		</div>
	</div>
	<div class="contentBody">
		<div class="mapContainer">
			<div id=map style="width:100%;height:800px;"></div>
		</div>
		<!-- 코스 리스트 -->
		<div class="courseBody">
			<!--<div>
				<button>중식</button>
				<button>파스타</button>
				<button>치킨</button>
				<button>분식</button>
				<button>카페/디저트</button>			
			</div>
			<h2>생성되어 있는 코스</h2>-->
			<div class="courseList">
				<ul id="placesList">
				
				</ul>
			</div>
		</div>
	</div>
	<%@ include file="../footer/footer.jsp" %>
</div>
	<script src="http://code.jquery.com/jquery-latest.min.js"></script>
	<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=ca31d06e7d0446fcb67025d7d71b84e6"></script>
	<script type="text/javascript">
	
	var myCourseObj = [];
	var courseObj=[];
	var markers = [];
	var sw = new kakao.maps.LatLng(35.0966621, 128.4888436),
		ne = new kakao.maps.LatLng(35.3108556, 128.8502120);
	
	//태그
	/*
		<span id="chinese">중식</span>	
		<span id="pasta">파스타</span>
		<span id="chicken">치킨</span>
		<span id="snack">분식</span>
		<span id="disert">카페/디저트</span>
	*/
	var spanChinese = document.querySelector('#chinese');
	var spanPasta = document.querySelector('#pasta');
	var spanChicken = document.querySelector('#chicken');
	var spanSnack = document.querySelector('#snack');
	var spanDisert = document.querySelector('#disert');
	
	//맵 변수
	var mapContainer;
	var map;
	
	//	오버레이 id
	var overId;	
	//	생성된 오버레이 배열
	var overlayAry= [];
	
	//	로그인한 유저의 세션정보 변수
	var session = "<%=sessionId %>";
	console.log("session : "+session);

	//	로그인한 유저의 닉네임
	var admin = "<%=adminCheck%>";

	//	코스 리스트의 부모 요소 (ul태그)
	var listEl = document.querySelector('#placesList');
	
	spanChinese.addEventListener("click", () => addList("chinese"));
	spanPasta.addEventListener("click", () => addList("pasta"));
	spanChicken.addEventListener("click", () => addList("chicken"));
	spanSnack.addEventListener("click", () => addList("snack"));
	spanDisert.addEventListener("click", () => addList("disert"));
	
	// url 가져오기
	var queryString = window.location.search;
	// URLSearchParams() 객체 생성
	var urlParam = new URLSearchParams(queryString);
	// 파라미터 가져오기
	var foodCategory = urlParam.get('foodCategory');
		
	
	getAllRoad();
	makeMap();
	
	// 처음 요청을 보내 모든 코스정보를 받아오는 함수
	function getAllRoad(){
		$.ajax({
			url : "readRoad",
			type : "post", 
			success : function(response){
				courseObj = response;
				console.log(courseObj);
				addList();
				if(foodCategory==="chinese"){
					spanChinese.click();
				}
				else if(foodCategory==="pasta"){
					spanPasta.click();
				}
				else if(foodCategory==="chicken"){
					spanChicken.click();
				}
				else if(foodCategory==="snack"){
					spanSnack.click();
				}
				else if(foodCategory==="disert"){
					spanDisert.click();
				}
			}
		});
	}
	
	// 지도 출력을 위한 기본적인 코드 -------- START
	function makeMap(){
		mapContainer = document.getElementById('map'); // 지도를 표시할 div 
		var mapOption = { 
	        center: new kakao.maps.LatLng(35.2538433, 128.6402609), // 지도의 중심좌표
	        level: 9 // 지도의 확대 레벨
	    };

		map = new kakao.maps.Map(mapContainer, mapOption); 
	}
	// 지도 출력을 위한 기본적인 코드 -------- END

	//리스트에 코스를 표시하는 함수
	function addList(cateParam){
		var title; 	
		listEl.innerHTML = "";
		//courseObj : 요청에 대한 응답 json 배열		
		for(var i=0; i<courseObj.length; i++){
			(function(index){
				var data = courseObj[index];
				var roadCate = data.roadId;
				roadCate = roadCate.substring(0,2);
				
				console.log(roadCate);
				if(roadCate == "CH" && cateParam == "chinese"){
					var list = createList(data);
					listEl.appendChild(list);
				}else if(roadCate == "CK" && cateParam == "chicken"){
					var list = createList(data);
					listEl.appendChild(list);
				}else if(roadCate == "PS" && cateParam == "pasta"){
					var list = createList(data);
					listEl.appendChild(list);
				}else if(roadCate == "DS" && cateParam == "disert"){
					var list = createList(data);
					listEl.appendChild(list);
				}else if(roadCate == "SN" && cateParam == "snack"){
					var list = createList(data);
					listEl.appendChild(list);
				}
			})(i);
		}
		if(listEl.innerHTML == ""){
			listEl.innerHTML = "생성된 코스가 없습니다..";
		}
	}
	
	//리스트 생성
	function createList(data){
		var courseName = [];
		for(var j=0; j<data.points.length; j++){
			courseName[j] = (j+1)+". "+data.points[j].pointName;
		}
		var courseString = courseName.join(" -> ");
		//console.log(courseAry);
		var cateStr = data.category;	//저장된 마커의 카테고리
		var cateHan;
		if(cateStr == "chicken"){
			cateHan = "치킨";
		}else if(cateStr == "pasta"){
			cateHan = "파스타";
		}else if(cateStr == "chinese"){
			cateHan = "중식";
		}else if(cateStr == "disert"){
			cateHan = "카페/디저트";
		}else if(cateStr == "snack"){
			cateHan = "분식";
		}		
		
		var list = document.createElement('li');
		list.setAttribute("id", "cslist");
		list.innerHTML = '<div>'
		                +data.description+'</div><h3>'+cateHan+'</h3><div>'
		                + courseString +'</div><br>'   
					    if(session !== "null" && admin === "admin"){            
					          list.innerHTML += '<div><a href="/FoodTrip/road/roadUpdate?id='
					          +data.roadId+'">수정</a>'+
					          '<a href="/FoodTrip/road/roadDelete?id='+data.roadId+'">삭제</a></div>'
					    }else if(session !== "null" && admin !== "admin" ){
					    	var btn = document.createElement('button');
					    	btn.setAttribute("class", "chbtn");
							btn.innerHTML = "코스 선택";							    	
					    	btn.addEventListener("click", () => choiceCourse(data.roadId));
					    	list.appendChild(btn);
					    }
		var vbtn = document.createElement('button');
    	vbtn.setAttribute("class", "viewbtn");
    	vbtn.innerHTML = "보기";
    	
    	vbtn.addEventListener("click", function(){
			viewMarker(data);					
		});
    	
    	var hr = document.createElement('hr');
    	list.appendChild(vbtn);
    	list.appendChild(hr);
    	
    	return list;
	}
	
	//코스 리스트를 클릭하면 마커가 지도에 보이게
	function viewMarker(data){ 
		//console.log(data);
		//console.log(data.points);
		markerRemove();
		var bounds = new kakao.maps.LatLngBounds(); 
		for(var i=0; i<data.points.length; i++){
			(function(index){	
				var ary = data.points;
				
			    bounds = new kakao.maps.LatLngBounds(), 
			    listStr = '';
			 
				 var placePosition = new kakao.maps.LatLng(ary[index].pointY, ary[index].pointX);
				// console.log(ary[i]);

				 var imageSrc = 'https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/marker_number_blue.png', // 마커 이미지 url, 스프라이트 이미지를 씁니다
			        imageSize = new kakao.maps.Size(36, 37),  // 마커 이미지의 크기
			        imgOptions =  {
			            spriteSize : new kakao.maps.Size(36, 691), // 스프라이트 이미지의 크기
			            spriteOrigin : new kakao.maps.Point(0, (index*46)+10), // 스프라이트 이미지 중 사용할 영역의 좌상단 좌표
			            offset: new kakao.maps.Point(13, 37) // 마커 좌표에 일치시킬 이미지 내에서의 좌표
			        },
			        markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize, imgOptions),
			            marker = new kakao.maps.Marker({
			            position: placePosition, // 마커의 위치
			            image: markerImage 
			        });
					//console.log(map);
					var overlay = createOverlay(marker, ary[i]);
					
					createMarkerEvent(overlay, marker);
					
					marker.setMap(map); // 지도 위에 마커를 표출합니다
					markers.push(marker);  // 배열에 생성된 마커를 추가합니다

				 bounds.extend(placePosition);	
			})(i);
		}
		
		//마지막 시점전환
		bounds = new kakao.maps.LatLngBounds(sw, ne); 
		map.setBounds(bounds);
	}
	
	function closeOverlayAll(){
		for(var i=0; i<overlayAry.length; i++){
			overlayAry[i].setMap(null);
		}
	}	
	
	function closeOverlay(id) {
		//console.log("close!");
		//console.log(overlayAry[id]);
		overlayAry[id].setMap(null);
	    //overlay.setMap(null);     
	}
	
	//중심 마커에 대한 이벤트
	function createMarkerEvent(overlay, marker){ 
           	kakao.maps.event.addListener(marker, 'click', function() {
	            	overlay.setMap(map);
           	});
	}
	
	//모든 마커 지우기 -- 마커 refresh
	function markerRemove(){
		console.log("rm IN");
		for ( var i = 0; i < markers.length; i++ ) {
			markers[i].setMap(null);
	    }
		markers = [];
	}
	
	//마커 오버레이 생성
	function createOverlay(marker, data){
		overId = overlayAry.length;
 
   		var content = '<div class="wrap">' + 
    	'    <div class="info">' + 
        '        <div class="title">' + 
        '            '+ data.pointName + 
        '            <div class="close" onclick="closeOverlay('+overId+')" title="닫기"></div>' + 
        '        </div>' + 
        '        <div class="body">' + 
        '            <div class="img">' +
        '                <img src="https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/thumnail.png" width="73" height="70">' +
        '           </div>' + 
        '            <div class="desc">' + 
        '                <div class="ellipsis">'+ data.address +'</div>' +  
        '                <div><a href='+ data.description  +' target="_blank" class="link">사이트이동</a></div>' + 
        '            </div>' + 
        '        </div>' + 
        '    </div>' +    
        '</div>';	            	
    	
        //	Create Overlay 
    	var overlay = new kakao.maps.CustomOverlay({
    	    content: content,
    	    //map: map,
    	    position: marker.getPosition()     
    	});
        
    	overlayAry.push(overlay);
		
    	return overlay;
	}

	
	//사용자가 선택했을 때 로드의 정보를 읽어야한다.
	function choiceCourse(id){
		//로그인 중인지	
		var result = getMyCourse(id);
		console.log(result);
		if(result == ""){
			for(var i=0; i<courseObj.length; i++){
				//id로 배열 내 요소 찾기
				if(courseObj[i].roadId===id){
					sendChoiceCourse(courseObj[i]);
					break;
				}
				//찾은 요소 하나만 컨트롤러로 보내기
			}
			alert("코스 선택 완료! 즐거운 여행되세요.");
		}else{
			alert("이미 선택하신 코스가 존재합니다 ! ");
		}
	}
	
	function sendChoiceCourse(roadDTO){
		//console.log(roadDTO);
		roadDTO.userNick = admin;
		$.ajax({
			url : "choiceRoad",
			type : "post",
			data : JSON.stringify(roadDTO),
			contentType : "application/json", 
			success : function(response){
				//alert("코스 생성 및 저장완료");
			}
		});
	}
	
	//	내가 가진 코스를 읽어오고 없으면 null
	function getMyCourse(id){
		var result;
		$.ajax({
			url : "readMyCourse",
			type : "post",
			data : JSON.stringify(admin),
			async : false,
			contentType : "application/json",
			success : function(response){
				console.log("resp");						
				console.log(response);
				if(response.endTime !== ""){
					console.log("response.roadId");
					console.log(response.roadId);
					console.log("id");
					console.log(id);
					if(response.roadId === id){
						alert("이미 완주한 코스입니다.");
						return 1;
					}
					console.log("비었다!");
					result = 0;
				}else if(response.endTime === ""){
					console.log("이미 코스가 존재한다.");
					result = 1;
				}
			}
		});
		return result;		
	}
	</script>
</body>
</html>