<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%> 
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="/FoodTrip/resources/css/menu.css?version=4"/>
<link rel="stylesheet" href="/FoodTrip/resources/css/Marker.css?version=6"/>
<script src="https://kit.fontawesome.com/7676881a65.js" crossorigin="anonymous"></script>
</head>
<body>
	<div class="container">	
		<div class="menubar">
			<%@ include file="../menu/menu.jsp" %>
			<i class="fa-solid fa-location-dot" id="headIcon"></i>&nbsp; <span class="headTitle addmTitle">마커 생성</span>
		</div>
		<div class="description">
			<p> * 마커 등록은 키워드 검색 시 목록에 출력되는 한 페이지(15개)가 배열로 저장됩니다.
			<p> * 한 페이지 당 15개, 총 3페이지가 제공되며 페이지를 넘길 때마다 저장되므로 따로 저장하지 않아도 됩니다. 
			<p> * 넣으려는 마커를 검색 후 등록 버튼을 누르면 등록된 마커가 하나씩 서버로 저장되게 됩니다. 이 때 다른 동작을 하시면 오류가 날 수 있습니다.
		</div>
		<div class="contentBody">
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
			</div>
			<div class="inputForm">
				<form onsubmit="return false;">
					<table>
						<tr>
							<td><label>마커ID</label></td>
							<td><input id="markerId"/></td>
						</tr>
						<tr>
							<td><label>좌표 X</label></td>
							<td><input id="pointX"/></td>
						</tr>
						<tr>
							<td><label>좌표 Y</label></td>
							<td><input id="pointY"/></td>
						</tr>
						<tr>
							<td><label>카테고리</label></td>
							<td><input id="category"/></td>
						</tr>
						<tr>
							<td><label>장소명</label></td>
							<td><input id="pointName"/></td>
						</tr>
						<tr>
							<td><label>전화번호</label></td>
							<td><input id="phone"/></td>
						</tr>
						<tr>
							<td><label>주소</label></td>
							<td><input id="address"/></td>
						</tr>
						<tr>
							<td><label>URL</label></td>
							<td><input id="urlText"/><a href="#" id="urlLink" target="_blank"><i class="fa-solid fa-link"></i></a></td>
						</tr>
						<tr>
							<td><button id="sendData">전송</button></td>
						</tr>
						<tr class="countRow">
							<td>현재 <span class="count"></span>개 저장 중</td>						
						</tr>
					</table>
				</form>
			</div>
		</div>
		<%@ include file="../footer/footer.jsp" %>
	</div>
	<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=ca31d06e7d0446fcb67025d7d71b84e6&libraries=services"></script>
	<script src="http://code.jquery.com/jquery-latest.min.js"></script>
	<script>
	
	// input 태그 
	var id = document.querySelector("#markerId");
	var px = document.querySelector("#pointX");
	var py = document.querySelector("#pointY");
	var cate = document.querySelector("#category");
	var pn = document.querySelector("#pointName");
	var ph = document.querySelector("#phone");
	var addr = document.querySelector("#address");
	var urlText = document.querySelector("#urlText");
	var urlLink = document.querySelector("#urlLink");
	var countView = document.querySelector(".count");
	
	var send = document.querySelector("#sendData");
	var insertKeyword = document.querySelector("#keyword");
	var saveKeyword;
	var overlays = [];
	var overlay;
	var overlay_num;
	// 마커를 담을 배열입니다
	var markers = [];
	//dto 매핑 객체
	var dtoObjAry = [];
	var dtoObj ={
			//"inputdata":"",
			"markerId":"",
			"pointX":"",
			"pointY":"",
			"category":"",
			"pointName":"",
			"phone":"",
			"address":"",
	};
	
	
	makeMap();
	
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

	// 장소 검색 객체를 생성합니다
	var ps = new kakao.maps.services.Places();  

	// 검색 결과 목록이나 마커를 클릭했을 때 장소명을 표출할 인포윈도우를 생성합니다
	var infowindow = new kakao.maps.InfoWindow({zIndex:1});

	
	//이벤트 할당
	send.addEventListener('click', sendAllData);

	//setInsertKey();
	// 키워드로 장소를 검색합니다
	searchPlaces();

	// 키워드 검색을 요청하는 함수입니다
	function searchPlaces() {
		
	    var keyword = insertKeyword.value;
	    
	    if (!keyword.replace(/^\s+|\s+$/g, '')) {
	    //    alert('키워드를 입력해주세요!');
	        return false;
	    }
	    
	    //dtoObj.inputdata = keyword;
	    // 장소검색 객체를 통해 키워드로 장소검색을 요청합니다
	    ps.keywordSearch( keyword, placesSearchCB); 
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
	        (function(marker, data) {
	        	overlay_num = overlays.length;
				setDTO(data);					//여기서 목록에 요소 하나씩 dto로 추가된다.
				//console.log(data);
	            kakao.maps.event.addListener(marker, 'click', function() {
	            	var content = '<div class="wrap">' + 
	            	'    <div class="info">' + 
	                '        <div class="title">' + 
	                '            '+ data.place_name + 
	                '            <div class="close" onclick="closeOverlay('+overlay_num+')" title="닫기"></div>' + 
	                '        </div>' + 
	                '        <div class="body">' + 
	                '            <div class="img">' +
	                '                <img src="https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/thumnail.png" width="73" height="70">' +
	                '           </div>' + 
	                '            <div class="desc">' + 
	                '                <div class="ellipsis">'+ data.road_address_name +'</div>' +  
	                '                <div><a href='+ data.place_url  +' target="_blank" class="link">사이트이동</a></div>' + 
	                '            </div>' + 
	                '        </div>' + 
	                '    </div>' +    
	                '</div>';	            	
	            	
	            	overlay = new kakao.maps.CustomOverlay({
	            	    content: content,
	            	   // map: map,
	            	    position: marker.getPosition()       
	            	});
	            	overlays.push(overlay);
	            	overlay.setMap(map);
	            });
	        })(marker, places[i]);
			
	        //	키워드 검색 리스트에 추가
	        fragment.appendChild(itemEl);
	    }
		
	    // 검색결과 항목들을 검색결과 목록 Element에 추가합니다
	    listEl.appendChild(fragment);
	    menuEl.scrollTop = 0;

	    // 검색된 장소 위치를 기준으로 지도 범위를 재설정합니다
	    map.setBounds(bounds);
	}

	function closeOverlay(num) {
	    overlays[num].setMap(null);     
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
	    	urlText.href = data.place_url;
	    	urlLink.href = data.place_url;
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
			urlText.value = data.place_url;
			urlLint.href = data.place_url;
			//setDTO(data);
		});
	}
	
	function setDTO(data){
		var dtoObj = {};
		//dtoObj.markerId:data.place_name,
		dtoObj.pointX = data.x;
		dtoObj.pointY = data.y;
		dtoObj.category = data.category_name;
		dtoObj.pointName = data.place_name;
		dtoObj.phone = data.phone;
		dtoObj.address = data.address_name;
		dtoObj.urlText = data.place_url;
		dtoObjAry.push(dtoObj);
		//console.log(dtoObjAry);
		//console.log(dtoObjAry.length);
		countView.innerHTML = dtoObjAry.length;
	}
	
	function sendAllData(){
		console.log(dtoObjAry.length);
		console.log(dtoObjAry);
		/*
		for(var i=0; i<dtoObjAry.length; i++){
        	//setDTO(data);
        	//	여기서 ajax로 하나씩 보낸다.
        	sendData(dtoObjAry[i]);
		}*/
		sendData(dtoObjAry);
		dtoObjAry=[];
	}
	
	function sendData(dtoOne){
		$.ajax({
			url : "/FoodTrip/marker/addMarker",
			type : "post",
			data : JSON.stringify(dtoOne),
			contentType : "application/json",
			success : function(response){
				if(response){
					alert("마커가 정상적으로 입력되었습니다.");  
				}else{
					alert("마커 데이터가 이미 존재합니다.");
				}
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