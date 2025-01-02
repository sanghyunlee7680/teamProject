<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>   
<%@ page session="false" %>
<%@ page import="com.spring.domain.Member" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="/FoodTrip/resources/css/menu.css?version=17" rel="stylesheet"/>
<title>회원 정보 수정</title>
</head>
<body>
	<div class="container">
		<div class="menubar">
			<%@ include file="../menu/menu.jsp" %>
		</div>
		<div class="loginForm">	
			<div class="loginBox">
				<div class="login">
					<h3><i class="fa-solid fa-user"></i>&nbsp;회원정보수정</h3>
				</div>	
				<form:form modelAttribute="updateMember" method="post">
					<table>
						<p class="updfont">Email:<form:input path="email" value="<%=sessionId.getEmail()%>" readonly="true" class="inputBox_pw"/> 
						<p class="updfont">비밀번호:<form:input path="password" type="password" value="<%=sessionId.getPassword() %>" class="inputBox_pw"/>
						<p class="updfont">닉네임 :<form:input path="nickName" value="<%=sessionId.getNickName()%>" class="inputBox_pw"/>						
						<button class="overlap" id="checkBtn" type="button" data-nick="<%=sessionId.getNickName()%>">중복확인</button>
						<p class="updfont">성별 :
							<div>
								<%
									String gender = sessionId.getGender();
								%>
								<form:radiobutton path="gender" value="man" checked="checked"/>남성 
								<form:radiobutton path="gender" value="woman"/>여성
							</div>
							<br>
					<p class="updfont">나이 : <form:input type="number" value="<%=sessionId.getAge() %>" path="age" class="inputBox_pw"/>
					</table>
					<br>
					<p>	<input type="submit" value="수정" class="submitBtn">
					<div class="delbox">
						<p class="updfont">	<a href="delete?email=<%=sessionId.getEmail()%>" id="deleteBtn">회원탈퇴</a>
					</div>
				</form:form>
			</div>
		</div>	
	</div>
	<!-- JavaScript for 댓글 AJAX -->
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="/FoodTrip/resources/js/Member.js?version=19" type="text/javascript"></script>
	<!-- Font Awesome -->
    <script src="https://kit.fontawesome.com/08b7540d84.js" crossorigin="anonymous"></script>
</body>
</html>