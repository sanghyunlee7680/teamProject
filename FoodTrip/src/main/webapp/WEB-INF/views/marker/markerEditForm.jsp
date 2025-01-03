<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.spring.domain.*" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<!-- 
<link rel="stylesheet" href="/FoodTrip/resources/css/menu.css?version=3"/>
<link rel="stylesheet" href="/FoodTrip/resources/css/Marekr.css?version=3"/>
 -->
    <link href="/FoodTrip/resources/css/bootstrap.min.css?version=132" rel='stylesheet' type='text/css' /><!-- bootstrap css -->
    <link href="/FoodTrip/resources/css/css_slider.css?version=131" rel='stylesheet' type='text/css' /><!-- custom css -->
	<link href="/FoodTrip/resources/css/style.css?version=92" type="text/css" rel="stylesheet" media="all">
    <script src="https://kit.fontawesome.com/08b7540d84.js" crossorigin="anonymous"></script><!-- fontawesome css -->
	<!-- //css files -->
	<title>Welcome to FoodTrip</title>
</head>
<body>
	<%
		Marker marker = (Marker)request.getAttribute("marker");
		String pointName = null;
		if(marker != null){
			pointName = marker.getPointName();
		}
	%>

<div class="navColorbg">
	<%@ include file="../menu/menu.jsp" %>	
</div>
<div class="container">
</div>
	<div class="map_wrap">
	    <div id="map" style="width:100%;height:100%;position:relative;overflow:hidden;"></div>
	
	    <div id="menu_wrap" class="bg_white">
	        <div class="option">
	            <div>
	                <form onsubmit="searchPlaces(); return false;">
	                    키워드 : <input type="text" id="keyword" size="15"> 
	                    <button type="submit">검색하기</button> 
	                </form>
	            </div>
	        </div>
	        <hr>
	        <ul id="placesList"></ul>
	        <div id="pagination"></div>
	    </div>
	    <div class="inputForm">
		    <form onsubmit="return false;">
		    	<table>
					<tr>
						<td><label>마커ID</label></td>
						<td><input id="markerId" value="<%=marker.getmarkerId() %>" readOnly/></td>
					</tr>
					<tr>
						<td><label>좌표 X</label></td>
						<td><input id="pointX" value="<%=marker.getPointX() %>"/></td>
					</tr>
					<tr>
						<td><label>좌표 Y</label></td>
						<td><input id="pointY" value="<%=marker.getPointY() %>"/></td>
					</tr>
					<tr>
						<td><label>카테고리</label></td>
						<td><input id="category" value="<%=marker.getCategory() %>"/></td>
					</tr>
					<tr>
						<td><label>장소명</label></td>
						<td><input id="pointName" value="<%=marker.getPointName() %>"/></td>
					</tr>
					<tr>
						<td><label>전화번호</label></td>
						<td><input id="phone" value="<%=marker.getPhone() %>"/></td>
					</tr>
					<tr>
						<td><label>주소</label></td>
						<td><input id="address" value="<%=marker.getAddress() %>"/></td>
					</tr>
					<tr>
						<td><a href="<%=marker.getUrlText()%>" id="urlData" target="_blank">사이트</a></td>
						<td><input id="urlText" value="<%=marker.getUrlText()%>"/></td>
						
					</tr>
					<tr>
					<tr>	
						<td><button id="sendbtn" class="btn btn-primary">수정</button></td>
					</tr>
				</table>
			</form>
		</div>
	</div>
	<div>
		
	</div>
	<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=ca31d06e7d0446fcb67025d7d71b84e6&libraries=services"></script>
	<script src="http://code.jquery.com/jquery-latest.min.js"></script>
	<script>
	//맵 변수
	var mapContainer;
	var map;
	
	// input 태그 
	var id = document.querySelector("#markerId");
	var px = document.querySelector("#pointX");
	var py = document.querySelector("#pointY");
	var cate = document.querySelector("#category");
	var pn = document.querySelector("#pointName");
	var ph = document.querySelector("#phone");
	var addr = document.querySelector("#address");
	var urlText = document.querySelector("#urlText");
	var desc = document.querySelector("#description");
	var send = document.querySelector("#sendbtn");
	var insertKeyword = document.querySelector("#keyword");

	var editData = "<%=pointName%>";
	var markerurl = "<%=marker.getUrlText()%>";
	console.log(markerurl);
	var saveKeyword;
	// 마커를 담을 배열입니다
	var markers = [];
	//dto 매핑 객체
	var dtoObj ={
			"inputdata":"",
			"markerId":"",
			"pointX":"",
			"pointY":"",
			"category":"",
			"pointName":"",
			"phone":"",
			"address":"",
			"description":""
	};
	

	

	// 장소 검색 객체를 생성합니다
	var ps = new kakao.maps.services.Places();  

	// 검색 결과 목록이나 마커를 클릭했을 때 장소명을 표출할 인포윈도우를 생성합니다
	var infowindow = new kakao.maps.InfoWindow({zIndex:1});

	
	//이벤트 할당
//	var send = document.querySelector("#sendbtn");
	send.addEventListener('click', updateData);
	
	makeMap();
	//	수정하려는 마커 찍기
	setMarker();	
	
	// 키워드로 장소를 검색합니다
	searchPlaces();

	
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
	//	처음 왔을 때 출력
	function setMarker(){
		var dtoObj ={
				"markerId":"<%= marker.getmarkerId()%>",
				"pointX":"<%= marker.getPointX()%>",
				"pointY":"<%= marker.getPointY()%>",
				"category":"<%= marker.getCategory()%>",
				"pointName":"<%= marker.getPointName()%>",
				"phone":"<%= marker.getPhone()%>",
				"address":"<%= marker.getAddress()%>",
				"urlText":"<%= marker.getUrlText()%>"
		};
		console.log(dtoObj);
		addMarker(dtoObj);
	}
	
	// 키워드 검색을 요청하는 함수입니다
	function searchPlaces() {
		
	    var keyword = insertKeyword.value;
	    
	    if (!keyword.replace(/^\s+|\s+$/g, '')) {
	    //    alert('키워드를 입력해주세요!');
	        return false;
	    }
	    
	    //dtoObj.inputdata = keyword;
	    // 장소검색 객체를 통해 키워드로 장소검색을 요청합니다
	    ps.keywordSearch(keyword, placesSearchCB); 
	}

	// 장소검색이 완료됐을 때 호출되는 콜백함수 입니다
	/*
			여기서 마커들의 배열을 받아온다.
	*/	
	function placesSearchCB(data, status, pagination) {
	    if (status === kakao.maps.services.Status.OK) {

	        // 정상적으로 검색이 완료됐으면
	        // 검색 목록과 마커를 표출합니다
	        displayPlaces(data);

	        // 페이지 번호를 표출합니다
	        displayPagination(pagination);

	    } else if (status === kakao.maps.services.Status.ZERO_RESULT) {

	        alert('검색 결과가 존재하지 않습니다.');
	        return;

	    } else if (status === kakao.maps.services.Status.ERROR) {

	        alert('검색 결과 중 오류가 발생했습니다.');
	        return;

	    }
	}

	// 검색 결과 목록과 마커를 표출하는 함수입니다
	function displayPlaces(places) {

	    var listEl = document.getElementById('placesList'), 
		    menuEl = document.getElementById('menu_wrap'),
		    fragment = document.createDocumentFragment(), 
		    bounds = new kakao.maps.LatLngBounds(), 
		    listStr = '';
	    
	    // 검색 결과 목록에 추가된 항목들을 제거합니다
	    removeAllChildNods(listEl);

	    // 지도에 표시되고 있는 마커를 제거합니다
	    removeMarker();
	    
	    for ( var i=0; i<places.length; i++ ) {
	    	
	        // 마커를 생성하고 지도에 표시합니다
	        var placePosition = new kakao.maps.LatLng(places[i].y, places[i].x);
//	            marker = addMarker(placePosition, i),
			//마커 생성 --- (원본)함수구현
			var imageSrc = 'https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/marker_number_blue.png', // 마커 이미지 url, 스프라이트 이미지를 씁니다
		        imageSize = new kakao.maps.Size(36, 37),  // 마커 이미지의 크기
		        imgOptions =  {
		            spriteSize : new kakao.maps.Size(36, 691), // 스프라이트 이미지의 크기
		            spriteOrigin : new kakao.maps.Point(0, (i*46)+10), // 스프라이트 이미지 중 사용할 영역의 좌상단 좌표
		            offset: new kakao.maps.Point(13, 37) // 마커 좌표에 일치시킬 이미지 내에서의 좌표
		        },
		        markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize, imgOptions),
		            marker = new kakao.maps.Marker({
		            position: placePosition, // 마커의 위치
		            image: markerImage 
		        });
	
			    marker.setMap(map); // 지도 위에 마커를 표출합니다
			    markers.push(marker);  // 배열에 생성된 마커를 추가합니다

	            itemEl = getListItem(i, places[i]); // 검색 결과 항목 Element를 생성합니다
     			
	            //********************  함수 삽입 ********************
	            // 마커 클릭 시, 위치 정보가 input태그에 바로 삽입될 수 있게하는 함수
	            setInputValue(marker, places[i]);
				
	            setEventList(itemEl, places[i]);

	            
	        // 검색된 장소 위치를 기준으로 지도 범위를 재설정하기위해
	        // LatLngBounds 객체에 좌표를 추가합니다
	        bounds.extend(placePosition);

	        // 마커와 검색결과 항목에 mouseover 했을때
	        // 해당 장소에 인포윈도우에 장소명을 표시합니다
	        // mouseout 했을 때는 인포윈도우를 닫습니다
	        (function(marker, title) {
	            kakao.maps.event.addListener(marker, 'mouseover', function() {
	                displayInfowindow(marker, title);
	            });

	            kakao.maps.event.addListener(marker, 'mouseout', function() {
	                infowindow.close();
	            });

	            itemEl.onmouseover =  function () {
	                displayInfowindow(marker, title);
	            };

	            itemEl.onmouseout =  function () {
	                infowindow.close();
	            };
	        })(marker, places[i].place_name);
	        
	        
	        fragment.appendChild(itemEl);
	    }
		
	    // 검색결과 항목들을 검색결과 목록 Element에 추가합니다
	    listEl.appendChild(fragment);
	    menuEl.scrollTop = 0;

	    // 검색된 장소 위치를 기준으로 지도 범위를 재설정합니다
	    map.setBounds(bounds);
	}
	
	function addMarker(data){
		var bounds = new kakao.maps.LatLngBounds(); 
		var placePosition = new kakao.maps.LatLng(data.pointY, data.pointX);
		//마커 생성 --- (원본)함수구현

       	marker = new kakao.maps.Marker({
            position: placePosition, // 마커의 위치
        });
		
	    marker.setMap(map); // 지도 위에 마커를 표출합니다
	    bounds.extend(placePosition);
	    map.setBounds(bounds);
	}

	// 검색결과 항목을 Element로 반환하는 함수입니다
	function getListItem(index, places) {

	    var el = document.createElement('li'),
	    itemStr = '<span class="markerbg marker_' + (index+1) + '"></span>' +
	                '<div class="info">' +
	                '   <h5>' + places.place_name + '</h5>';

	    if (places.road_address_name) {
	        itemStr += '    <span>' + places.road_address_name + '</span>' +
	                    '   <span class="jibun gray">' +  places.address_name  + '</span>';
	    } else {
	        itemStr += '    <span>' +  places.address_name  + '</span>'; 
	    }
	                 
	      itemStr += '  <span class="tel">' + places.phone  + '</span>' +
	                '</div>';           

	    el.innerHTML = itemStr;
	    el.className = 'item';

	    return el;
	}

	// 마커를 생성하고 지도 위에 마커를 표시하는 함수입니다
	// 원래 함수로 사용하고 있었으나 현재는 밖으로 꺼내 사용하지 않고 있음
/*	
	function addMarker(position, idx, title) {
	    var imageSrc = 'https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/marker_number_blue.png', // 마커 이미지 url, 스프라이트 이미지를 씁니다
	        imageSize = new kakao.maps.Size(36, 37),  // 마커 이미지의 크기
	        imgOptions =  {
	            spriteSize : new kakao.maps.Size(36, 691), // 스프라이트 이미지의 크기
	            spriteOrigin : new kakao.maps.Point(0, (idx*46)+10), // 스프라이트 이미지 중 사용할 영역의 좌상단 좌표
	            offset: new kakao.maps.Point(13, 37) // 마커 좌표에 일치시킬 이미지 내에서의 좌표
	        },
	        markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize, imgOptions),
	            marker = new kakao.maps.Marker({
	            position: position, // 마커의 위치
	            image: markerImage 
	        });

	    marker.setMap(map); // 지도 위에 마커를 표출합니다
	    markers.push(marker);  // 배열에 생성된 마커를 추가합니다

	    return marker;
	}
*/
	// 지도 위에 표시되고 있는 마커를 모두 제거합니다
	function removeMarker() {
	    for ( var i = 0; i < markers.length; i++ ) {
	        markers[i].setMap(null);
	    }   
	    markers = [];
	}

	// 검색결과 목록 하단에 페이지번호를 표시는 함수입니다
	function displayPagination(pagination) {
	    var paginationEl = document.getElementById('pagination'),
	        fragment = document.createDocumentFragment(),
	        i; 

	    // 기존에 추가된 페이지번호를 삭제합니다
	    while (paginationEl.hasChildNodes()) {
	        paginationEl.removeChild (paginationEl.lastChild);
	    }

	    for (i=1; i<=pagination.last; i++) {
	        var el = document.createElement('a');
	        el.href = "#";
	        el.innerHTML = i;

	        if (i===pagination.current) {
	            el.className = 'on';
	        } else {
	            el.onclick = (function(i) {
	                return function() {
	                    pagination.gotoPage(i);
	                }
	            })(i);
	        }

	        fragment.appendChild(el);
	    }
	    paginationEl.appendChild(fragment);
	}

	// 검색결과 목록 또는 마커를 클릭했을 때 호출되는 함수입니다
	// 인포윈도우에 장소명을 표시합니다
	function displayInfowindow(marker, title) {
	    var content = '<div style="padding:5px;z-index:1;">' + title + '</div>';

	    infowindow.setContent(content);
	    infowindow.open(map, marker);
	}

	 // 검색결과 목록의 자식 Element를 제거하는 함수입니다
	function removeAllChildNods(el) {   
	    while (el.hasChildNodes()) {
	        el.removeChild (el.lastChild);
	    }
	}

	function setEventList(list, data){
		list.onclick = function(){
	        pn.value = data.place_name;
	    	px.value = data.x;
	    	py.value = data.y;
	    	addr.value = data.address_name;
	    	ph.value = data.phone;
	    	cate.value = data.category_name;
	    	urldata.href = data.place_url;
	    	setDTO(data);
	     };
	}
	 
	function setInputValue(marker, data){
		/*
		Document data 
			이름					타입			설명
			id					String		장소 ID
			place_name			String		장소명, 업체명
			category_name		String		카테고리 이름
			category_group_code	String		중요 카테고리만 그룹핑한 카테고리 그룹 코드
			category_group_name	String		중요 카테고리만 그룹핑한 카테고리 그룹명
			phone				String		전화번호
			address_name		String		전체 지번 주소
			road_address_name	String		전체 도로명 주소
			x					String		X 좌표값, 경위도인 경우 longitude (경도)
			y					String		Y 좌표값, 경위도인 경우 latitude(위도)
			place_url			String		장소 상세페이지 URL
			distance			String		중심좌표까지의 거리 (단, x,y 파라미터를 준 경우에만 존재)
			단위 meter
		*/	
		kakao.maps.event.addListener(marker,'click', function(){
			//id.value = data.id;
			pn.value = data.place_name;
			px.value = data.x;
			py.value = data.y;
			addr.value = data.address_name;
			ph.value = data.phone;
			cate.value = data.category_name;
			urldata.href = data.place_url;
			desc.value = data.place_url;
			setDTO(data);
		});
	} 
	function setDTO(data){
		dtoObj.markerId = data.markerId,
		dtoObj.pointX = data.x;
		dtoObj.pointY = data.y;
		dtoObj.category = data.category_name;
		dtoObj.pointName = data.place_name;
		dtoObj.phone = data.phone;
		dtoObj.address = data.address_name;
		dtoObj.urlText = data.place_url;
	}	
	
	function setDTObefore(){
		console.log(id.value);
		dtoObj.markerId = id.value;
		dtoObj.pointX = px.value;
		dtoObj.pointY = py.value;
		dtoObj.category = cate.value;
		dtoObj.pointName = pn.value;
		dtoObj.phone = ph.value;
		dtoObj.address = addr.value;
		dtoObj.urlText = urlText.value;
	}	
	
	function updateData(event){
		 event.preventDefault();
		 setDTObefore();
		$.ajax({
			url : "/FoodTrip/marker/editexecute",
			type : "post",
			data : JSON.stringify(dtoObj),
			contentType : "application/json",
			success : function(response){
				alert("마커 수정완료");
				console.log(response);
				location.href="/FoodTrip/marker/readalljson"
				//insertKeyword.value = response.inputdata;
				//$("#keyword").val(response.inputdata);
			},
			error : function(){
				alert("마커 입력 에러")
			}
		});
	}
	
	function setInsertKey(){
		insertKeyword.value = saveKeyword;
	}
	</script>
	
</body>
</html>