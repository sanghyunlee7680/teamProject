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
<title>Insert title here</title>
<link rel="stylesheet" href="/FoodTrip/resources/css/menu.css?version=5"/>
<link rel="stylesheet" href="/FoodTrip/resources/css/Road.css?version=5"/>
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