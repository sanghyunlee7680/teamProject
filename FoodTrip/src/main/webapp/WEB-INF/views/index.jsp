<%@ page isELIgnored="false" language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page session="false" %>
<%@ page import="com.spring.domain.Member" %>
<html>
<head>
	<!-- css files 
	<link rel="stylesheet" href="/FoodTrip/resources/css/menu.css?version=132"/>-->
    <link href="/FoodTrip/resources/css/bootstrap.min.css?version=132" rel='stylesheet' type='text/css' /><!-- bootstrap css -->
    <link href="/FoodTrip/resources/css/css_slider.css?version=131" rel='stylesheet' type='text/css' /><!-- custom css -->
	<link href="/FoodTrip/resources/css/style.css?version=92" type="text/css" rel="stylesheet" media="all">
    <script src="https://kit.fontawesome.com/08b7540d84.js" crossorigin="anonymous"></script><!-- fontawesome css -->
	<!-- //css files -->
	<title>Welcome to FoodTrip</title>
</head>
<body>
	<!-- header -->
<div class="navBg">
	<%@ include file="./menu/menu.jsp" %>
</div>
	<%
		//System.out.println("칭호? : " + sessionId.getBadgeName());
	%>
	<!-- //header -->
	<!-- banner -->
	<div class="banner" id="home">
		<div class="layer">
			<div class="container">
				<div class="row">
					<div class="col-md-6 banner-text-w3ls">
						<!-- banner slider-->
						<div class="csslider infinity" id="slider1">
							<input type="radio" name="slides" checked="checked" id="slides_1" />
							<input type="radio" name="slides" id="slides_2" />
							<input type="radio" name="slides" id="slides_3" />
							<input type="radio" name="slides" id="slides_4" />		
							<input type="radio" name="slides" id="slides_5" />
							<ul class="banner_slide_bg">
								<li>
									<div class="container-fluid">
											<div class="w3ls_banner_txt">
											<h3 class="b-w3ltxt text-capitalize">푸드트립</h3>
											<h4><span class="fa fa-bowl-food" aria-hidden="true"></span>중식로드</h4>
										<p><a href="/FoodTrip/road/readRoad?foodCategory=chinese" ><span class="fa fa-play" aria-hidden="true" style="color:orange"></span>시작하기</a><p>
										</div>
									</div>
								</li>
								<li>
									<div class="container-fluid">
										<div class="w3ls_banner_txt">
											<h3 class="b-w3ltxt text-capitalize">푸드트립</h3>
											<h4><span class="fa fa-burger" aria-hidden="true"></span>양식로드</h4>
										<p><a href="/FoodTrip/road/readRoad?foodCategory=pasta"><span class="fa fa-play" aria-hidden="true" style="color:orange"></span>시작하기</a><p>	
										</div>
									</div>
								</li>
								<li>
									<div class="container-fluid">
										<div class="w3ls_banner_txt">
											<h3 class="b-w3ltxt text-capitalize">푸드트립</h3>
											<h4><span class="fa fa-drumstick-bite" aria-hidden="true"></span>치킨로드</h4>
											<p><a href="/FoodTrip/road/readRoadfoodCategory=chicken"><span class="fa fa-play" aria-hidden="true" style="color:orange"></span>시작하기</a><p>
										</div>
									</div>
								</li>
								<li>
									<div class="container-fluid">
										<div class="w3ls_banner_txt">
											<h3 class="b-w3ltxt text-capitalize">푸드트립</h3>
											<h4><span class="fa fa-cookie-bite" aria-hidden="true"></span>스낵로드</h4>
											<p><a href="/FoodTrip/road/readRoadfoodCategory=snack"><span class="fa fa-play" aria-hidden="true" style="color:orange"></span>시작하기</a><p>
										</div>
									</div>
								</li>
								<li>
									<div class="container-fluid">
										<div class="w3ls_banner_txt">
											<h3 class="b-w3ltxt text-capitalize">푸드트립</h3>
											<h4><span class="fa fa-martini-glass-citrus" aria-hidden="true"></span>디저트로드</h4>
											<p><a href="/FoodTrip/road/readRoadfoodCategory=disert"><span class="fa fa-play" aria-hidden="true" style="color:orange"></span>시작하기</a><p>
										</div>
									</div>
								</li>
							</ul>
							<div class="navigation">
								<div>
									<label for="slides_1"></label>
									<label for="slides_2"></label>
									<label for="slides_3"></label>
									<label for="slides_4"></label>
									<label for="slides_5"></label>
								</div>
							</div>
						</div>
						<!-- //banner slider-->		
					</div>
					<div class="col-md-6 banner-text-w3ls">
						<div class="container-fluid ml-lg-5">
							<div class="padding">
								<%if(sessionId==null){ %>
								<form action="#" method="post">
									<!-- <h5 class="mb-3">Choose Road and go on a food trip!!</h5> -->
									<h5 class="mb-3">go on a food trip!!</h5>
									<div class="form-style-w3layout">
										<button class="btn" type="button" id="loginbtn">로그인하기</button>
										&nbsp;
										<button class="btn" type="button" id="addbtn" style="background-color:gray">회원가입</button>
									</div>
								</form>
								<%}else if(sessionId!=null){ %>
										<h4 style="color:white; font-size:16px;"><%=sessionId.getNickName()%>님, 반갑습니다.</h4>
									<%if(sessionId.getBadgeName()!=null){ %>
										<b style="color:orange; font-size:16px"><%=sessionId.getBadgeName()%></b>
									<%}else{%>		
										<b style="color:orange; font-size:16px">칭호 없음</b>
									<%} %>
								<%} %>
							</div>
						</div>
					</div>	
				</div>
			</div>
		</div>
	</div>
</body>
	<script>
		var loginbtn = document.querySelector("#loginbtn");
		var addbtn = document.querySelector("#addbtn");
		
		console.log(loginbtn);
		console.log(addbtn);
		
		loginbtn.addEventListener('click', loginClick);
		addbtn.addEventListener('click', addClick);
		function loginClick(){
			location.href='/FoodTrip/member/login';		
		}
		
		function addClick(){
			location.href='/FoodTrip/member/email';
		}
	</script>
</html>
