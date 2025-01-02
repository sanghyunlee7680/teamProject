<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.spring.domain.*" %>
<%@ page import="java.time.*" %>
<%@ page import="java.time.format.*" %>
<%@ page import="java.sql.*" %>
<%@ page session="false" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<!-- 
<link rel="stylesheet" href="/FoodTrip/resources/css/menu.css?version=5"/>
<link rel="stylesheet" href="/FoodTrip/resources/css/Road.css?version=5"/>
-->

    <link href="/FoodTrip/resources/css/bootstrap.min.css?version=132" rel='stylesheet' type='text/css' /><!-- bootstrap css -->
    <link href="/FoodTrip/resources/css/css_slider.css?version=131" rel='stylesheet' type='text/css' /><!-- custom css -->
	<link href="/FoodTrip/resources/css/style.css?version=92" type="text/css" rel="stylesheet" media="all">
    <script src="https://kit.fontawesome.com/08b7540d84.js" crossorigin="anonymous"></script><!-- fontawesome css -->
	<!-- //css files -->
	<title>Welcome to FoodTrip</title>
</head>
<body>
<div class="container">
	<%@ include file="../menu/menu.jsp" %>

	<%
		Qrcode qc = (Qrcode)request.getAttribute("qc");
		Marker marker = (Marker)request.getAttribute("marker");
		
		LocalDateTime dateTime = qc.getChecktime().toLocalDateTime();
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
        String formattedDate = dateTime.format(formatter);
	%>
	<div class="contentBody">
		<div class="userData">
			<p><%= qc.getUsernick() %>님! </p>
			<p><%= marker.getPointName() %>에</p>
			<p><%= formattedDate%> 도착 !</p>
			
			<a href="/FoodTrip/road/myTravel">내 코스로 바로 가기</a>
			<img src="http://localhost:8080/FoodTrip/resources/images/finishstamp.png" class="backImg"/>
		</div>
	</div>
</div>
</body>
</html>