<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="/FoodTrip/resources/css/menu.css?version=3"/>
<link rel="stylesheet" href="/FoodTrip/resources/css/Marker.css?version=3"/>
<style>
</style>
</head>
<body>
<div class="container">
	<div class="menubar" id="rdmakeBack">
		<%@ include file="../menu/menu.jsp" %>
		<span class="headTitle rdmkTitle">코스 만들기</span>
	</div>
	<div class="description">
		<p> * 서버에 저장된 전체 마커로 코스를 구성할 수 있습니다.
		<p> * 카테고리 분류는 크게 3가지(관광지 / 식당 / 숙소)이며 식당의 경우 음식 카테고리를 분류하여 출력할 수 있습니다.
		<p> * 카테고리를 클릭 후 원하는 마커를 '코스에 추가' 버튼을 누르면 지도에 표시되며 표시된 순서대로 코스가 구성됩니다.
		<p> * 코스 중간에 삽입/수정은 불가능합니다. 코스 중간에 지점 변경을 원하시면 리셋 버튼을 눌러 초기화 후 다시 삽입해주세요.
	</div>
	<div id="menu">
		<button id="create">코스 생성</button>
		<button id="reset">리셋</button>
		<select id="choice">
			<option value="all">전체</option>
			<option value="chicken">치킨</option>
			<option value="chinese">중식</option>
			<option value="pasta">파스타</option>
			<option value="snack">분식</option>
			<option value="disert">디저트</option>
		</select>
	</div>
	<div class="contentBody">
		<div class="listBox">
			<div class="tablist">
				<button class="tourtab" id="TU">관광지</button>
				<button class="resttab" id="RS">식당</button>
				<button class="staytab" id="HT">숙소</button>
			</div>	
			<div class="listbody">
				<div class="listblock">
					<ul class="mklist">
	
					</ul>
				</div>
			</div>
		</div>
			<div class="mapBox">
				<div id=map style="width:100%;height:800px;">
					<!-- 지도 공간  -->
					
				</div>
				<div class="channel" >
				
				</div>
			</div>
			<div class="mylistBox">
			<!-- 
				<div class="tablist">
					<button class="tourtab" id="TU">관광지</button>
					<button class="resttab" id="RS">식당</button>
					<button class="staytab" id="HT">숙소</button>
				</div>
			-->
				<div>
					내가 선택한 장소
				</div>	
				<div class="mylistbody">
					<div class="mylistblock">
						<ul class="mymklist">
		
						</ul>
					</div>
				</div>
			</div>
		</div>
		<div>
			코스에 대한 설명 : 
			<textarea cols="100" rows="10" id="description"></textarea>
		</div>
	
		<%@ include file="../footer/footer.jsp" %>
	
</div>
	<script src="http://code.jquery.com/jquery-latest.min.js"></script>
	<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=ca31d06e7d0446fcb67025d7d71b84e6"></script>
	<script>
	
	//맵 변수
	var mapContainer;
	var map;
	
	//태그 관련 
	//	select 태그 
	var choice = document.querySelector("#choice");
	
	//	ul 태그 : 선택한 카테고리의 리스트가 들어갈 부모
	var tourParents = document.querySelector(".tourlist");
	var stayParents = document.querySelector(".staylist");
	var restParents = document.querySelector(".restlist");
	var mkParents = document.querySelector(".mklist");
	var mymkParents = document.querySelector(".mymklist");
	
	//	button 태그 : 선택하는 리스트 카테고리 변경
	var tourTab = document.querySelector(".tourtab");
	var restTab = document.querySelector(".resttab");
	var stayTab = document.querySelector(".staytab");
	
	//	div 태그 : 선택한 순서대로 경로가 표시
	var channel = document.querySelector(".channel");
	
	//	임시 사용자(관리자) : 여기서 사용자의 닉네임을 받아와 관리자인지 아닌지를 구분해야함
	var userNick = "admin";
	
	//		
	var existNum = false;
	
	//	리셋 버튼	
	var rsbtn = document.querySelector("#reset");
	//	코스를 모두 만든 후 DB에 저장하는 생성버튼
	var create = document.querySelector("#create");
	//	코스에 대한 설명을 첨부할 수 있는 textarea
	var desc = document.querySelector("#description");
	
	//	오버레이 id
	var overId;	
	//	마커가 순서대로 찍힐 때 마커에 나타나는 숫자
	var indexG;
	//	오버레이 생성 시 담을 변수
	//var overlay;
	//	생성된 오버레이 배열
	var overlayAry= [];
	
	//원 반경을 표시하는 변수
	let activeCircle = null;
	//반경 내 마커만 저장하는 배열
	var circleMarkers = [];
	
	
	//	dto 배열	: Marker DTO들의 집합
	var dtoList = [];
	//var useDtoList = [];
	//	Marker DTO : 여기서 Marker는 맵에 표시되는 마커가 아닌 맵에 표시되는 마커의 정보를 담고 있는 DTO, DB 내 marker Table의 한 필드
	var dtoObj = {
		"inputdata":"",
		"markerId":"",
		"pointX":"",
		"pointY":"",
		"category":"",
		"pointName":"",
		"phone":"",
		"address":"",
		"urltext":""
	};
	
	//	지도에 표시되는 마커들의 배열
	var markers = [];  
	//	코스 생성을 위해 사용된 마커들이 저장되는 배열
	var useMarker = [];
	
	//	ajax로 보내기 위한 DTO : DB 내 road Table의 한 필드
	var sendObj = {
			"user":"",
			"plan":[],
			"createtime":"",
			"endtime":"",
			"category":"",
			"courseSize":"",
			"description":""
	};
	
	//	각 요소 이벤트 할당
	rsbtn.addEventListener("click", markerRemove);
	create.addEventListener("click", planCreate);
	tourTab.addEventListener("click",() => listFilter(event));
	restTab.addEventListener("click",() => listFilter(event));
	stayTab.addEventListener("click",() => listFilter(event));
	
	//1. 가장 먼저 실행되는 함수, 마커 리스트를 출력 및 지도표시
	getAllMarker();	
	makeMap();
	
	var sw = new kakao.maps.LatLng(35.180809, 128.547572),
    	ne = new kakao.maps.LatLng(35.251352, 128.731078);
	
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


	/*
	 *	처음 로딩 시 DB에 저장된 모든 마커를 가져와 리스트로 출력해주는 함수
	*/
	function getAllMarker(){
		$.ajax({
			url : "/FoodTrip/marker/readMkAll",
			type : "get",
			success: function(response) {
		        //console.log(response);  // 응답 구조를 확인
				JSON.stringify(response);
				//tourParents.innerHTML = "";
		        // 응답이 배열인지 확인하고, 배열이 비어있지 않으면 첫 번째 항목을 사용
		        if (Array.isArray(response) && response.length > 0) {
		        	copyMk(response);
		        	//addElements(dtoList);
		        	//tourFilter();
		        } else {
		            console.log("응답이 비어있거나 배열이 아닙니다.");
		        }
		    },
		    error: function(xhr, status, error) {
		        //console.error("AJAX 요청 실패:", error);
		        console.log("상태:", status);
		        //console.log("응답 텍스트:", xhr.responseText);
		    }
		});
	}
		
	//	response로 받아온 string을 js 객체배열로 복사
	function copyMk(markerlist){
		//console.log(markerlist.length);
		for(var i=0; i<markerlist.length; i++){
			(function(index){
			//객체를 새로 생성하지 않으면 참조 오류가 생긴다.
			var dtoObj ={
				"markerId":markerlist[index].markerId,
				"pointX": markerlist[index].pointX,
			    "pointY": markerlist[index].pointY,
				"category":markerlist[index].category,
				"pointName":markerlist[index].pointName,
				"phone":markerlist[index].phone,
				"address": markerlist[index].address,
				"urltext":markerlist[index].urlText
			};

			dtoList.push(dtoObj);
			})(i);
		}
	}
	
	
	//필터로 탭을 누르면 해당하는 것만 출력
	function listFilter(event){
		mkParents.innerHTML ="";
		//console.log("event");
		//console.log(event);
		var me = event.target.id;
		console.log(me);
		//rmAllMarker(baseMarkers);
		//rmCircleMarker();
		for(var i=0; i<dtoList.length; i++)
		{
			(function(index){
				//1. 어떤 것을 출력할지 필터부터.
				var dataOne = dtoList[index];
				var cate = dataOne.markerId.substring(0,2);
				if(cate == me){
				//2. 필터로 걸러진 것만 출력		
					//console.log(cate);
					addElements(cate, dataOne);
					//addMarker(cate, dataOne);
				}else if(cate == me){
					addElements(cate, dataOne);
					//addMarker(dataOne);
				}else if(cate == me){
					addElements(cate, dataOne);
					//addMarker(cate, dataOne);
				}
			})(i);	
		}
	}
	
	//처음 리스트 생성	
	function addElements(cate, data){
		var dataOne = data;
		var list = document.createElement('li');
		list.setAttribute("class", "listCh");

		//여기서 숙소, 음식점, 관광지를 분류하여 출력
		var cate = dataOne.markerId.substring(0,2);
		var cateFull = dataOne.category;
		var str1 = cateFull.replaceAll('>', ',');
		var str2 = str1.split(',');
		var cateStr = str2[1].trim();
		var compare;
		
		//식당 부분만 조건식으로 구분
		if(cate == "RS"){
			if(cateStr == "치킨"){
				compare = "chicken";
			}else if(cateStr == "양식"){
				compare = "pasta";
			}else if(cateStr == "중식"){
				compare = "chinese";
			}else if(cateStr == "카페" || cateStr == "간식"){
				compare = "disert";
			}else if(cateStr == "분식"){
				compare = "snack";
			}
			
			//console.log("listcate : "+ compare);
			//console.log("choice : "+ choice.value);
			if(choice.value==="all"){
				listMake(list, dataOne);
				mkParents.appendChild(list);
			}else if(compare === choice.value){
				listMake(list, dataOne);
				mkParents.appendChild(list);
			}
		}else{	//식당이 아닌 부분은 전부 출력
			listMake(list, dataOne);
			mkParents.appendChild(list);
		}
	}
	
	//리스트 만들기
	function listMake(list, data){
		//console.log(data.description);
		var cateFull = data.category;
		var str1 = cateFull.replaceAll('>', ',');
		var str2 = str1.split(',');
		var cateStr = str2[1].trim();
		var styleId;
		
		if(cateStr === "관광"){
			styleId = "category_tu";
		}else if(cateStr === "숙박"){
			styleId = "category_ht";
		}else{
			styleId = "category_rs";		
		}
		
		list.innerHTML="<a href='"+data.urltext+"'class='pointName' target='_blank'>"
		+ data.pointName + "</a><div class='category' id='"+styleId+"'>"+cateStr
		+"</div><div class='addr'>"+ data.address +"</div>";
		
		var div = document.createElement('div');
		div.setAttribute("class", "btnList");
		
		//div.innerHTML = "<a href='/FoodTrip/marker/markerUpdate?id="+data.markerId+"'>수정</a>";
		
		var btn = document.createElement('button');
		var hr = document.createElement('hr');
		btn.addEventListener("click", () => addMarker(data));
		btn.innerHTML = "코스에 추가";
		div.appendChild(btn);
		
		list.appendChild(div);
		list.appendChild(hr);
		//list.innerHTML += `</div>`;
	}	
	
//	선택 시 내가 선택한 리스트에 입력
	function addMyList(data, index){
		
		var cateFull = data.category;
		var str1 = cateFull.replaceAll('>', ',');
		var str2 = str1.split(',');
		var cateStr = str2[1].trim();
		var styleId;
		
		if(cateStr === "관광"){
			styleId = "category_tu";
		}else if(cateStr === "숙박"){
			styleId = "category_ht";
		}else{
			styleId = "category_rs";		
		}

		//내가 선택한 것에 대한 리스트를 생성
		var list = document.createElement('li');
		list.setAttribute("class", "listCh");
		list.setAttribute("id", indexG);	//리스트 삭제를 위한 인덱스부여
		list.innerHTML="<a href='"+data.urltext+"'class='pointName' target='_blank'>"
		+ data.pointName + "</a><div class='category' id='"+styleId+"'>"+cateStr
		+"</div><div class='addr'>"+ data.address +"</div>";
		
		var div = document.createElement('div');
		div.setAttribute("class", "btnList");
		
		var btn = document.createElement('button');
		var hr = document.createElement('hr');
		btn.addEventListener("click", () => rmMarker(event, data));
		btn.innerHTML = "코스에서 삭제";
		btn.setAttribute("id", index);
		div.appendChild(btn);
		
		list.appendChild(div);
		list.appendChild(hr);
		
		return list;
	}

	//	오버레이 생성
	function createOverlay(marker, data){
		overId = overlayAry.length;
	//	console.log("overlay data ");

   		var idx = dtoList.indexOf(data);

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
        '                <div><a href='+ data.urltext  +' target="_blank" class="link">사이트이동</a></div>' + 
        (existNum === true ? '<button onclick="addMarker('+idx+')">등록</button>' : '') + 
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
	
	//	원 내에 생성된 마커에 대한 이벤트
	function createSubMarkerEvent(overlay, marker){ 
       	kakao.maps.event.addListener(marker, 'click', function() {
            	overlay.setMap(map);
       	});
	}
	
	//	중심 마커에 대한 이벤트
	function createMarkerEvent(overlay, marker, data){ 
           	kakao.maps.event.addListener(marker, 'click', function() {
        			getRangeRestTour(marker, data);
	            	overlay.setMap(map);
           	});
	}
	
	//	모든 오버레이 닫기	
	function closeOverlayAll(){
		for(var i=0; i<overlayAry.length; i++){
			overlayAry[i].setMap(null);
		}
	}	
	
	//	x키를 눌렀을 때 해당하는 오버레이만 닫기
	function closeOverlay(id) {
		//console.log("close!");
		//console.log(overlayAry[id]);
		overlayAry[id].setMap(null);
	    //overlay.setMap(null);     
	}
	
	
	
	
	
	
	function addMarker(data){
		rmAllMarker(circleMarkers);			//	생성되어 있는 반경 내 마커를 전부 제거
		var place = data;						
		if (activeCircle) {					//	만약 생성되어 있는 원이 있다면 제거
	        activeCircle.setMap(null);
	    }
		if(useMarker.length>=8){			//	추가하려는 마커가 최대 갯수를 초과하는지
			alert("코스는 최대 8개까지 가능합니다 !");
			return;
		}
		if((typeof data) === "number"){		//	표시하려는 마커가 베이스 마커인지 반경 내 마커인지
			//alert("정수입니다.");
			place = dtoList[data];
		}
	 	indexG = useMarker.length;			//	마커에 나타나는 숫자 표시를 위한 index
		//console.log(place.pointX);
		var bounds = new kakao.maps.LatLngBounds(sw, ne);
		var placePosition = new kakao.maps.LatLng(place.pointY ,place.pointX);
		//kakao.maps.LatLngBounds() 내 파라미터를 주지 않으면 빈 공간을 생성한다.

	   	//	중복검사  ?  0   :   1
	   	var result = isDuplicate(place);		
	   	
		//	중복이 아니면 true
	   	if(result==0){
	   	 	var imageSrc = 'https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/marker_number_blue.png', // 마커 이미지 url, 스프라이트 이미지를 씁니다
	        imageSize = new kakao.maps.Size(36, 37),  // 마커 이미지의 크기
	        imgOptions =  {
	   	 		//	이미지가 배열처럼 쭉 있는데, 그 안에서 이미지 크기를 조정해서 사용하는 것
	            spriteSize : new kakao.maps.Size(36, 691), // 스프라이트 이미지의 크기
	            spriteOrigin : new kakao.maps.Point(0, (indexG*46)+10), // 스프라이트 이미지 중 사용할 영역의 좌상단 좌표
	            offset: new kakao.maps.Point(13, 37) // 마커 좌표에 일치시킬 이미지 내에서의 좌표
	        },
	        markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize, imgOptions),
	            marker = new kakao.maps.Marker({
	            position: placePosition,	//	마커의 위치
	            image: markerImage				            
	        });
	   	 	closeOverlayAll();
	   	 	var baseOverlay = createOverlay(marker, place);
	   	 	createMarkerEvent(baseOverlay, marker, place);
		    marker.setMap(map); 			//	지도 위에 마커를 표출합니다
		   	markers.push(marker);  			//	배열에 생성된 마커를 추가합니다
		   	useMarker.push(place);			//	사용자가 지정한 마커가 순서대로 배열에 저장
		   	var list = addMyList(place, indexG);
		   	mymkParents.appendChild(list);
		   	var orderIdx = useMarker.length;
		   	
		   	courseOrder(orderIdx, place);
	   	 	
		   	bounds.extend(placePosition);
		    map.setBounds(bounds);
	   	}else{
	   		//	중복이면 false
	   		alert("이미 추가된 코스입니다 !!");
	   		return;
	   	}
		
	    if (markers.length > 1) {
	    	var position = marker.getPosition();
	        map.panTo(position);
	    } else {
	        map.setCenter(placePosition); // 마커가 하나면 중앙 설정
	    }
	}
	
	function courseOrder(idx, data){
		var div = document.createElement('div');
	   	div.innerHTML = idx +". "+ data.pointName;
   	 	channel.appendChild(div);
	}
	

	function addMarkerInCircle(cate, img, data){
		//console.log(circleMarkers);
		var placePosition = new kakao.maps.LatLng(data.pointY, data.pointX);
		var imgfile;
		if(img == "치킨"){
			imgfile = "chicken";
		}else if(img == "양식"){
			imgfile = "pasta";
		}else if(img == "중식"){
			imgfile = "chinese";
		}else if(img == "카페" || img == "간식"){
			imgfile = "disert";
		}else if(img == "분식"){
			imgfile = "snack";
		}
		
		var imageSrc = "/FoodTrip/resources/images/"+imgfile+".png", // 마커 이미지 url, 스프라이트 이미지를 씁니다	
	        imageSize = new kakao.maps.Size(38, 38),  // 마커 이미지의 크기
	        imgOptions =  {	      
	            offset: new kakao.maps.Point(13, 37) // 마커 좌표에 일치시킬 이미지 내에서의 좌표
	        };
      	//console.log("imageSrc");
		//console.log(imageSrc);
		markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize, imgOptions),
	        marker = new kakao.maps.Marker({
	        map : map,
	        position: placePosition, // 마커의 위치
	        image: markerImage				            
	    });	
		
		//	클릭한 마커와 반경 내 마커가 동일한 마커일 경우 출력하지 않게 하기 위해 
		existNum = true;
		var subOverlay = createOverlay(marker, data);
		existNum = false;
		createSubMarkerEvent(subOverlay, marker);
		/*
		kakao.maps.event.addListener(marker, 'click', function () {
			
		});
		*/
		 
		 return marker;
	}
	
	//	코스에서 삭제 시 다시 그려주는 메서드
	function setMyMarker(data, index){

		//console.log(data);
		indexG = useMarker.length; 
		var place = data;
		
		var placePosition = new kakao.maps.LatLng(place.pointY, place.pointX);
		
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
	    marker.setMap(map); 	// 지도 위에 마커를 표출합니다
	   	markers.push(marker);   // 배열에 생성된 마커를 추가합니다
	   	closeOverlayAll();
   	 	var baseOverlay = createOverlay(marker, place);
   	 	createMarkerEvent(baseOverlay, marker, place);

	   	courseOrder(index+1, data);
	//  console.log(useMarker);
	   	//useMarker.push(myMarker[index]);		//사용자가 지정한 마커가 순서대로 배열에 저장
	//	console.log(markers);

		//console.log(useMarker);
	}
	
	function rmMarker(event, data){
		//어떤 마커를 지울지 알아야한다. 배열이니까 인덱스로 접근해보자
		var idx=0;
		var tg = event.target.id;
		if (activeCircle) {
	       activeCircle.setMap(null);
	    }
		closeOverlayAll();
		//var tgParent = tg.parentElement;
		//console.log(tgParent);
		//1. 리스트에서 제거
		var listAll = mymkParents.querySelectorAll('li');
		//console.log(listAll);
		
		listAll.forEach(function(list){
			console.log(list);
			console.log(list.id);
			//console.log(targetId);
			if(list.id === tg){
				console.log("in!");
				mymkParents.removeChild(list);
				useMarker.splice(idx,1);
			}
			idx++;
		});
		//2. 마커에서 제거 --> 제거 후 새로 그려야함
		rmAllMarker(markers);
		channel.innerHTML = "";
		for(var j=0; j<useMarker.length; j++){
			setMyMarker(useMarker[j], j);
			//courseOrder(j);
		}
		
	}
	
	
	
	//마커 삭제하기
	function rmAllMarker(markers){
		//console.log("markers.length");
		//console.log(markers.length);
		for(var k=0; k<markers.length; k++){
			markers[k].setMap(null);	
		}
		markers.length = 0;
		//markers = [];
	}
	
	//리셋 버튼 클릭 시 맵에 존재하는 모든 마커 삭제
	function markerRemove(){
		closeOverlayAll();
		channel.innerHTML = "";
		mymkParents.innerHTML = "";
		console.log("rm IN");
		
		if (activeCircle) {
			activeCircle.setMap(null);
		}
		rmAllMarker(circleMarkers);
		rmAllMarker(markers);
		for ( var i = 0; i < markers.length; i++ ) {
			markers[i].setMap(null);
			//useMarker[i].setMap(null);
			//console.log(userMarker);
	    }   
		useMarker.length = 0;
		indexG=0;
		//console.log(markers);
		makeMap();
	}
	
	function removeOverlay(){
		for(var i=0; i<overlayAry.length; i++){
			overlayAry[i].setMap(null);
		}
		overlayAry.length = 0;
	}
	
	/*
		배열 내에 같은 마커가 있는지 없는지 검사
		return : 0 중복 없음 , 1 중복
	*/
	function isDuplicate(data){
		//console.log(data);
		var compared = 0;
	//	console.log("useMarker.length"+ useMarker.length);
		if(useMarker.length <= 0){
			return 0;
		}else{
			for(var i=0; i<useMarker.length; i++){
			//	console.log(data.markerId +" | " + useMarker[i].markerId);
				if(data.markerId !== useMarker[i].markerId){
					console.log("diff data push");
				}else{
					console.log("Same data ...  continue ");
					return 1;
				}		
			}
		}
		return 0;
	}
	
	//	코스 생성 클릭 시 컨트롤러로 전송
	function planCreate(){
		
		if(choice.value==="all"){
			alert("카테고리를 지정해주세요!!");
			return;
		}
		
		var data = new Date();
		sendObj.user = userNick;
		console.log("userncik : "+ sendObj.user);
		for(var i=0; i<useMarker.length; i++){
			sendObj.plan[i] = useMarker[i].markerId;
		}		
		//sendObj.createtime = data.toLocaleString(); //사용자가 생성했을 때
		sendObj.createtime = "";
		sendObj.endtime = "";
		sendObj.category = choice.value;
		sendObj.courseSize = useMarker.length;
		sendObj.description = desc.value;
		$.ajax({
			url : "/FoodTrip/road/addCourse",
			type : "post",
			data : JSON.stringify(sendObj),
			contentType : "application/json",
			success : function(response){
				if(response === "success"){
					alert("코스 생성 및 저장완료");
					closeOverlayAll();
					markerRemove();
					objReset();
				}else{
					alert("코스 생성 실패");
				}
			}
		});
	}
	
	function objReset(){
		sendObj.user = "";
		sendObj.plan = [];		
		//sendObj.createtime = data.toLocaleString(); //사용자가 생성했을 때
		sendObj.createtime = "";
		sendObj.endtime = "";
		sendObj.category = "";
		sendObj.courseSize = "";
	}
	
	function getRangeRestTour(marker, data){
		markersByCircle(marker, data);
		//console.log(data.pointX, data.pointY);
		//console.log("rm circle before");
		console.log("3. range check");
		rmAllMarker(circleMarkers);
		var exist = false;
		var x = data.pointX;
		var y = data.pointY;
		var positionX;
		var positionY;	
		var selectValue = choice.value;
		//dtoList는 마커 전체 리스트
		for(var i=0; i<dtoList.length; i++){
			//	카테고리 코드 찾기
			(function(index){
				var cate = dtoList[index].markerId.substring(0,2);
				//카테고리 분할
				var cateFull = dtoList[index].category;
				var str1 = cateFull.replaceAll('>', ',');
				var str2 = str1.split(',');
				var imgname = str2[1].trim();
				//console.log("============ imgname : "+imgname);
				var filterName;
				 
				var viewdata = dtoList[index];
				positionX = viewdata.pointX;
				positionY = viewdata.pointY;
				
				if(imgname == "치킨"){
					filterName = "chicken";
				}else if(imgname == "양식"){
					filterName = "pasta";
				}else if(imgname == "중식"){
					filterName = "chinese";
				}else if(imgname == "카페" || imgname == "간식"){
					filterName = "disert";
				}else if(imgname == "분식"){
					filterName = "snack";
				}
				
				var exist = useMarker.indexOf(data);
				//console.log("data ex?");
				//console.log(exist);
				//	음식점 출력
				var km = haversineDistance(x, y, positionX, positionY);
				if(km <= 0.69){
					//console.log("filterName : "+filterName);
					//console.log("selectValue : "+selectValue);
					//console.log(((filterName == selectValue) === true ? 'true' : 'false'));
					if(filterName == selectValue){
					var same = false;
					//console.log(choice.value);
					//위도 경도 조건 
						//console.log("*****************in : "+  filterName);
						for(var q=0; q<useMarker.length; q++){
							if(useMarker[q]==viewdata){
								same = true;
								break;
							}
						}
						if(same !== true){
							var cMarker = addMarkerInCircle(cate, imgname ,viewdata);
							circleMarkers.push(cMarker);
						}
					}
				}
			})(i);
		}
	}
	
	function markersByCircle(marker, data) {	//marker는 클릭한 마커
		const radius = 1000; // 반경 1km (미터 단위)
	    const centerPosition = marker.getPosition();	//마커의 포지션
		//console.log("2. circle make");
	    
	    //원이 존재하면 삭제
	    if (activeCircle) {
	        activeCircle.setMap(null);
	    }
	    
	    // 원 객체 생성
	    const circle = new kakao.maps.Circle({
	        center: centerPosition, // 원의 중심좌표
	        radius: radius, 		// 반경 (미터 단위)
	        strokeWeight: 2,
	        strokeColor: '#75B8FA',
	        strokeOpacity: 1,
	        strokeStyle: 'solid',
	        fillColor: '#CFE7FF',
	        fillOpacity: 0.5
	    });

	    //클릭한 마커로 화면을 이동하는데 쓰이는 변수
	    var viewPosition = marker.getPosition();
	    var bounds = new kakao.maps.LatLngBounds();

	    bounds.extend(viewPosition);
	    var padding = 0.01; // 여백 정도를 설정 (값을 조정해 멀리 보이도록 설정)

	 	// 마커 위치를 기준으로 상하좌우에 약간의 거리 추가
	 	bounds.extend(new kakao.maps.LatLng(viewPosition.getLat() + padding, viewPosition.getLng() + padding)); // 북동쪽
		bounds.extend(new kakao.maps.LatLng(viewPosition.getLat() - padding, viewPosition.getLng() - padding)); // 남서쪽

        map.panTo(viewPosition);
        map.setBounds(bounds);

	    circle.setMap(map); // 원을 지도에 표시
	    activeCircle = circle;
	}
	
	// Haversine 공식에 따른 두 점 간 거리 계산 함수	
	function haversineDistance(lat1, lon1, lat2, lon2) {
		const R = 6371;
	    const toRad = (value) => (value * Math.PI) / 180;

	    const dLat = toRad(lat2 - lat1);
	    const dLon = toRad(lon2 - lon1);

	    const a = Math.sin(dLat / 2) ** 2 +
	              Math.cos(toRad(lat1)) * Math.cos(toRad(lat2)) *
	              Math.sin(dLon / 2) ** 2;

	    const c = 2 * Math.asin(Math.sqrt(a));
	    
	    return R * c; // 거리 (킬로미터)
	}
	</script>
</body>
</html>