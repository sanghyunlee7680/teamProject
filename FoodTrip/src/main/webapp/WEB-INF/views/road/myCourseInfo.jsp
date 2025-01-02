<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<!-- 
<title>Insert title here</title>
<link rel="stylesheet" href="/FoodTrip/resources/css/menu.css?version=5"/>
<link rel="stylesheet" href="/FoodTrip/resources/css/Marker.css?version=5"/> -->
<link rel="stylesheet" href="/FoodTrip/resources/css/menu.css?version=132"/>
    <link href="/FoodTrip/resources/css/bootstrap.min.css?version=132" rel='stylesheet' type='text/css' /><!-- bootstrap css -->
    <link href="/FoodTrip/resources/css/css_slider.css?version=131" rel='stylesheet' type='text/css' /><!-- custom css -->
	<link href="/FoodTrip/resources/css/style.css?version=92" type="text/css" rel="stylesheet" media="all">
    <script src="https://kit.fontawesome.com/08b7540d84.js" crossorigin="anonymous"></script><!-- fontawesome css -->
	<!-- //css files -->
	<title>Welcome to FoodTrip</title>
<style>

	.message{
		text-align:center;
		line-height:100px;
	}
	.contentBox{
		height:100%;
	}
	.wrap {position: absolute;left: 0;bottom: 40px;width: 288px;height: 132px;margin-left: -144px;text-align: left;overflow: hidden;font-size: 12px;font-family: 'Malgun Gothic', dotum, '돋움', sans-serif;line-height: 1.5;}
    .wrap * {padding: 0;margin: 0;}
    .wrap .info {width: 286px;height: 120px;border-radius: 5px;border-bottom: 2px solid #ccc;border-right: 1px solid #ccc;overflow: hidden;background: #fff;}
    .wrap .info:nth-child(1) {border: 0;box-shadow: 0px 1px 2px #888;}
    .info .title {padding: 5px 0 0 10px;height: 30px;background: #eee;border-bottom: 1px solid #ddd;font-size: 18px;font-weight: bold;}
    .info .close {position: absolute;top: 10px;right: 10px;color: #888;width: 17px;height: 17px;background: url('https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/overlay_close.png');}
    .info .close:hover {cursor: pointer;}
    .info .body {position: relative;overflow: hidden;}
    .info .desc {position: relative;margin: 13px 0 0 90px;height: 75px;}
    .desc .ellipsis {overflow: hidden;text-overflow: ellipsis;white-space: nowrap;}
    .desc .jibun {font-size: 11px;color: #888;margin-top: -2px;}
    .info .img {position: absolute;top: 6px;left: 5px;width: 73px;height: 71px;border: 1px solid #ddd;color: #888;overflow: hidden;}
    .info:after {content: '';position: absolute;margin-left: -12px;left: 50%;bottom: 0;width: 22px;height: 12px;background: url('https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/vertex_white.png')}
    .info .link {color: #5085BB;}
    
    .pointList{
    	margin:0;
    	height:100px;
    	list-style:none;
    	text-align:left;
    }
    .courselist{
    	margin:10px 0;
    	position:relative;
    	border:1px solid rgba(0,0,0,0.3);
    	font-family: "Dongle", serif;
	  	font-weight: 400;
	 	font-style: normal;
	 	font-size:30px;
    }
    #stampimg{
    	width:50px;
    	height:50px;
    	position:absolute;
    	top:10%;
    	right:0px;
    	opacity:0.7;
    	z-index:-1;
    }
    .mylist{
    	margin: 15px 0;
    	width: 70%;
    	border:1px solid rgba(0,0,0,0.3);
    	font-size:14px;
    	display:flex;
    	justify-content:space-between;
    }
    .addrText{
    	font-size:20px;
    }
    .giveup{
    	display:block;
    	background-color:red;
    	color:white;
    	width:100px;
    	height:25px;
    	border-radius:5px;
    	text-align:center;
    }
    .review{
        display:block;
    	background-color:green;
    	color:white;
    	width:100px;
    	height:25px;
    	border-radius:5px;
    	text-align:center;
    }
</style>
</head>
<body>
<div class="container">
	<div class="menubar" id="myCouresBack">
		<%@ include file="../menu/menu.jsp" %>
		<span class="headTitle myCouresTitle">내 여행일지</span>
	</div>
	<div class="description">
	
	</div>
	<div class="contentBody">
		<div class="mapBox">
			<div id=map style="width:100%;height:800px;"></div>
		</div> 
		<div class="contentBox">
			<ul class="pointList"></ul>
		</div>
	</div>
	<%@ include file="../footer/footer.jsp" %>
</div>
	<script src="http://code.jquery.com/jquery-latest.min.js"></script>
	<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=ca31d06e7d0446fcb67025d7d71b84e6"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/html2canvas/1.4.1/html2canvas.min.js"></script>
	<script>
	
	//태그
	var pointList = document.querySelector(".pointList");
	
	//맵 변수
	var mapContainer;
	var map;
	
	//사용자 닉네임
	var userNick = "<%=adminCheck%>";
	console.log(userNick);
	
	var myDTOary = [];
	
	//내 코스 dto
	var myDTO = {
			"roadId":"",
			"userNick":"",
			"courseSize":"",
			"category":"",
			"points":[]
	};
	
	var sendDTO = {
		"roadId" : "",
		"userNick" : ""
	};
	
	var qrInfolist = [];
	
	//	마커가 순서대로 찍힐 때 마커에 나타나는 숫자
	var indexG;
	
	//	지도에 표시되는 마커들의 배열
	var markers = [];
	
	//	생성된 오버레이 배열
	var overlayAry= [];
	
	var sw = new kakao.maps.LatLng(35.180809, 128.547572),
		ne = new kakao.maps.LatLng(35.251352, 128.731078);
	
	getMyCheck();
	getMyCourse();

	//	가장 먼저 읽어올 사용자 데이터
	function getMyCourse(){
		$.ajax({
			url : "readMyCourse",
			type : "post",
			data : JSON.stringify(userNick),
			async : false,
			contentType : "application/json",
			success : function(response){
				//console.log(response);
				if(response !== ""){
					//만약 생성한 코스가 있으면 
					console.log("응답");
				//	console.log(response);
					myDTO = response;
					//	listMake();
					//copyResp(response);
					//console.log(myDTOary);
					makeMap();
					setMarkerOnMap(myDTO);
					var li = isFinish();
					console.log("finish ? ")
					console.log(li);
					pointList.appendChild(li);
				}else{
					//생성한 코스가 없으면
					//map.innerHTML = "";
					emptyMsg(pointList);
					console.log("비었다.");
				}
			}
		});
	}
	
	// 
	function getMyCheck(){
		$.ajax({
			url : "/FoodTrip/qrcode/getMyQr",
			type : "post",
			data : JSON.stringify(userNick),
			async : false,
			contentType : "application/json",
			success : function(response2){
				console.log("resp2");
				qrInfolist = response2;
				console.log(qrInfolist);
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
	
	
	//	Copy My Course 
	function copyResp(orgData){
		//마커정보
		myDTO.roadId = orgData.roadId;
		myDTO.userNick = orgData.userNick;
		myDTO.courseSize = orgData.courseSize;
		myDTO.category = orgData.category;
		for(var i=0; i<orgData.courseSize; i++){
			myDTO.points[i] = orgData.points[i];	
		}
	}
	
	//	가져온 road하나의 정보를 풀어 해당 로드의 정보를 맵에 표시
	function setMarkerOnMap(road){
		for(var i=0; i<road.courseSize; i++){
			(function(index){
				var data = road.points[i];
				 addMarker(data, index);
			})(i);
		}
	}
	
	//	해당 마커가 끝난 마커인지
	function isFinish(){
		var endnum=0;
		var li;
		//	qr 리스트만큼 반복
		for(var i=0; i<qrInfolist.length; i++){
			//	만약 qr 리스트의 요소 중 하나의 멤버(key)개수가 2보다 크고(2보다 크다는 것은 checktime이 존재한다는 것.) 
			//	checktime 키의 value가 null이 아니면  ---> endnum 증가  
			if(Object.keys(qrInfolist[i]).length>3 && qrInfolist[i].checktime !== null){				
				console.log("다 했네");
				endnum++;
			}
		}
		console.log("endnum");
		console.log(endnum);
		console.log("qrInfolist.length-1");
		console.log(qrInfolist.length-1);
		if(endnum === (qrInfolist.length)){
			console.log("모든 코스 완주");
			li = document.createElement('li');
			var review = document.createElement('a');
			review.setAttribute("href", "/FoodTrip/board/addBoard?usernick="+userNick+"&roadId="+myDTO.roadId);
			review.innerHTML = "리뷰 남기기";
			review.setAttribute("class", "review");
			li.appendChild(review);
		}else{
			li = document.createElement('li');
			var giveup = document.createElement('a');
			giveup.setAttribute("class", "giveup");
			giveup.setAttribute("href", "");
			giveup.innerHTML = "코스 포기";
			li.appendChild(giveup);
		}
		return li;
	}
	
	function addMarker(data, index){
		var place = data;						
		var idx = index;
		var change = false;
	 	//indexG = useMarker.length;			//	마커에 나타나는 숫자 표시를 위한 index
		//console.log(place.pointX);
		var bounds = new kakao.maps.LatLngBounds(sw, ne);
		var placePosition = new kakao.maps.LatLng(place.pointY ,place.pointX);
		//	marker 생성에 필요한 부분
   	 	
       	//console.log(qrInfolist[index]);
        var imageSrc;
        var imgOptions;
        //console.log("checkpoint . 1");
        if(place.markerId === qrInfolist[idx].markerId){
        	//console.log("checkpoint . 2");
        	//console.log(Object.keys(qrInfolist[index]).length);
        	//	해당 마커가 완주한 마커인지 아닌지 ---- 객체의 멤버(key)의 개수를 세어 완주했는지 안했는지 판별
        	if(Object.keys(qrInfolist[index]).length>3){	
        		if((qrInfolist.length-1)===idx){
        			console.log(data);
        			//alert('마지막 마커까지 모두 도착했습니다.');
        			sendDTO.roadId = myDTO.roadId;
        			sendDTO.userNick = myDTO.userNick;
        			finalEndTime();
        		}
        		//console.log("checkpoint . 3");
       			imageSrc = 'http://localhost:8080/FoodTrip/resources/images/checked.png', // 마커 이미지 url, 스프라이트 이미지를 씁니다
           		imgOptions =  {
      	            offset: new kakao.maps.Point(13, 37) // 마커 좌표에 일치시킬 이미지 내에서의 좌표
      	        };
       			change= true;
        	}else{
            //console.log("checkpoint . 4");
           	imageSrc = 'https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/marker_number_blue.png', // 마커 이미지 url, 스프라이트 이미지를 씁니다
           	imgOptions =  {
      	   		//	이미지가 배열처럼 쭉 있는데, 그 안에서 이미지 크기를 조정해서 사용하는 것
				spriteSize : new kakao.maps.Size(36, 691), // 스프라이트 이미지의 크기
      	        spriteOrigin : new kakao.maps.Point(0, (idx*46)+10), // 스프라이트 이미지 중 사용할 영역의 좌상단 좌표
      	        offset: new kakao.maps.Point(13, 37) // 마커 좌표에 일치시킬 이미지 내에서의 좌표
				};
           	}
        }
       
        var imageSize = new kakao.maps.Size(36, 37);  // 마커 이미지의 크기
        
        var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize, imgOptions),
            marker = new kakao.maps.Marker({
            position: placePosition,	//	마커의 위치
            image: markerImage				            
        });	// <------  marker 생성에 필요한 부분(END)
		
   	 	var baseOverlay = createOverlay(marker, place, idx, change);
   	 	createMarkerEvent(baseOverlay, marker);
	    marker.setMap(map); 			//	지도 위에 마커를 표출합니다
	   	markers.push(marker);  			//	배열에 생성된 마커를 추가합니다
	   	var list = document.createElement('li');
	   	list.setAttribute("id", "point"+idx);
	   	list.setAttribute("class", "courselist");
	   	var img;
	   	var pointname = document.createElement('p');
	   	pointname.innerHTML = (idx+1)+". "+place.pointName;
	   	var pointaddr = document.createElement('p');
	   	pointaddr.innerHTML = place.address;
	   	pointaddr.setAttribute("class", "addrText");
	   	list.appendChild(pointname);
	   	list.appendChild(pointaddr);
	   	if(change===true){
	   		img = document.createElement('img');
	   		img.setAttribute("src", "/FoodTrip/resources/images/finishstamp.png");
	   		img.setAttribute("id", "stampimg");
	   		pointaddr.innerHTML += "<p>달성 시간 : "+ qrInfolist[index].checktime;  		
	   		list.appendChild(img);
	   	}
	   	pointname.addEventListener("click", () => markerView(idx, place));
	   	pointList.appendChild(list);
	
	  	bounds.extend(placePosition);
	    map.setBounds(bounds);
	}
	
	function markerView(index, data){
		var bounds = new kakao.maps.LatLngBounds();
		var placePosition = new kakao.maps.LatLng(data.pointY ,data.pointX);
		
		bounds.extend(placePosition);
		map.panTo(bounds);
		//map.setBounds(bounds);
	}
	
	
	function createOverlay(marker, data, idx, change){
		overId = overlayAry.length;

   		var content = '<div class="wrap">' + 
    	'    <div class="info">' + 
        '        <div class="title">' + 
        '            '+ data.pointName + 
        '            <div class="close" onclick="closeOverlay('+overId+')" title="닫기"></div>' + 
        '        </div>' + 
        '        <div class="body">' + 
        '            <div class="img">' +
        (change === true ? '                <img src="/FoodTrip/resources/images/finishstamp.png" width="73" height="70">' : '                <img src="https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/thumnail.png" width="73" height="70">') +       
        '           </div>' + 
        '            <div class="desc">' + 
        '                <div class="ellipsis">'+ data.address +'</div>' +  
        '                <div><a href='+ data.urlText  +' target="_blank" class="link">사이트이동</a></div>' +
        (change === true ? ' 				 <div>달성 시간 : '+qrInfolist[idx].checktime+'</div>'	: '')
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
	
	function createMarkerEvent(overlay, marker){ 
       	kakao.maps.event.addListener(marker, 'click', function() {
            	overlay.setMap(map);
       	});
	}
	function closeOverlay(id) {
		overlayAry[id].setMap(null);   
	}
	
	//	마지막 지점까지 전부 도달했는지
	function finalEndTime(){
		$.ajax({
			url : "endTime",
			type: "post",
			data: JSON.stringify(sendDTO),
			contentType: "application/json",
			sucess : function(response){
				console.log("잘갔다왔다.");
			}			
		});
	}
	
	function sendReview(){
				
	}
	</script>
</body>
</html>