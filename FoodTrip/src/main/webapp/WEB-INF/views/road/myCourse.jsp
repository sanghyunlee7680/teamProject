<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<!-- 
<link rel="stylesheet" href="/FoodTrip/resources/css/menu.css?version=5"/>
-->
    <link href="/FoodTrip/resources/css/bootstrap.min.css?version=132" rel='stylesheet' type='text/css' /><!-- bootstrap css -->
    <link href="/FoodTrip/resources/css/css_slider.css?version=131" rel='stylesheet' type='text/css' /><!-- custom css -->
	<link href="/FoodTrip/resources/css/style.css?version=92" type="text/css" rel="stylesheet" media="all">
    <script src="https://kit.fontawesome.com/08b7540d84.js" crossorigin="anonymous"></script><!-- fontawesome css -->
	<!-- //css files -->
	<title>Welcome to FoodTrip</title>
<style>
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
    	margin:30px 0;
    	position:relative;
    	border:1px solid rgba(0,0,0,0.3);
    }
    #stampimg{
    	width:70px;
    	height:70px;
    	position:absolute;
    	top:10%;
    	left:50%;
    	opacity:0.7;
    }
    .endList, .pointList{
    	display:flex;
    	flex-direction:column;
    	align-items:center;
    }
    .mylist{
    	margin: 15px 0;
    	width: 70%;
    	border:1px solid rgba(0,0,0,0.3);
    	font-size:14px;
    	display:flex;
    	justify-content:space-between;
    }
    .infoBtn{
    	background-color:#ffffff;
    	border:1px solid rgba(0,0,0,0.3);
    }
    
    .newCourse{
    	color:#236430;
    }
</style>
</head>
<body>
<div class="container">
	<div class="menubar" id="myCouresBack">
		<%@ include file="../menu/menu.jsp" %>
		<span class="headTitle myCouresTitle">내 여행일지</span>
	</div>
	<div class="contentBox">
		<span>진행중인 코스</span>
		<ul class="pointList"></ul>
	</div>
	
	<div>
		<span>완주한 코스</span>
		<ul class="endList"></ul>
	</div>
	<%@ include file="../footer/footer.jsp" %>
</div>
	<script src="http://code.jquery.com/jquery-latest.min.js"></script>
	<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=ca31d06e7d0446fcb67025d7d71b84e6"></script>
	<script>
	
	//태그
	var msgBox = document.querySelector(".message");
	var pointList = document.querySelector(".pointList");
	var endList = document.querySelector(".endList");
	
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
	//isFinish();
	
	//	가장 먼저 읽어올 사용자 데이터
	function getMyCourse(){
		$.ajax({
			url : "readMyCourseList",
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
					myDTOary = response;
					listMake();
					//copyResp(response);
					console.log(myDTOary);
					//makeMap();
					//setMarkerOnMap(myDTO);
				}else{
					//생성한 코스가 없으면
					//map.innerHTML = "";
					emptyMsg(pointList);
					console.log("비었다.");
				}
			}
		});
	}
	
	//	사용자가 선택한 마커에 해당하는 qr정보를 가져옴
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

	//	리스트 생성
	function listMake(){
		var li = document.createElement('li');
		li.setAttribute("class", "mylist");
		//	완료한 코스에 대한 정보를 출력
		for(var i=0; i<myDTOary.length;i++){
			console.log("listmake in");
			//	endtime이 null이 아닌 것은 완주한 코스라는 것.
			console.log(myDTOary[i].endTime);
			if(myDTOary[i].endTime !== undefined){
				li.innerHTML = '<div><p>'+myDTOary[i].category +'</p>'+
							'<p>코스 시작일 : '+myDTOary[i].createTime+' </p>' + 
							'<p>코스 완주일 : '+myDTOary[i].endTime+' </p></div><div>' 
							;
				var div = document.createElement('div');
				var link = document.createElement('a');
				link.setAttribute("class", "infolink");
				link.setAttribute("class", "infolink");
				link.setAttribute("href", "/FoodTrip/road/myTravel");
				link.innerHTML ="여행기록 보기";
				//btn 이벤트 추가 필요
				
				div.appendChild(link);
				li.appendChild(div);				
				endList.appendChild(li);
			}else{
				//	여긴 진행중인 코스에 대해 출력
				li.innerHTML = '<div><p>'+myDTOary[i].category +'</p>'+
							'<p>코스 시작일 : '+myDTOary[i].createTime+' </p>' + 
							(myDTOary[i].endTime===undefined ? '<p>코스 완주일 : 진행 중 </p></div><div>' :'<p>코스 완주일 : '+myDTOary[i].endTime+' </p></div><div>'  );
				var div = document.createElement('div');
				var link = document.createElement('a');
				link.setAttribute("class", "infolink");
				link.setAttribute("href", "/FoodTrip/road/myTravel");
				link.innerHTML ="펼쳐 보기";
				//btn 이벤트 추가 필요
				
				div.appendChild(link);
				li.appendChild(div);				
				pointList.appendChild(li);
			}
		}
		console.log("empty before");
		if(pointList.innerHTML === ""){
			emptyMsg(pointList);
		}else if(endList.innderHTML === ""){
			emptyMsg(endList);
		}
	}

	//선택한 여행지가 없을 때 출력될 메시지들
	function emptyMsg(parent){
		var msg = document.createElement('h3');
		msg.innerHTML ="아직 여행이 시작되지 않았어요. ";	
		
		var link = document.createElement('a');
		link.setAttribute("href", "readRoad");
		link.setAttribute("class", "newCourse");
		link.innerHTML ="새로운 계획을 짜볼까요??";
		console.log("empty");
		
		parent.appendChild(msg);
		parent.appendChild(link);
	}
	
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
	</script>
</body>
</html>