<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ page session="false" %>
<!DOCTYPE html>
<html>
<%
	String email = (String)request.getAttribute("email");
	System.out.println("폼에서이메일 : " + email);
%>
<head>
<link rel="stylesheet" href="/FoodTrip/resources/css/member.css?version=33">
<link rel="stylesheet" href="/FoodTrip/resources/css/menu.css?version=33">
<meta charset="UTF-8">
<title>회원 가입</title>
</head>
<body>
	<div class="container">	
	<%@ include file="../menu/menu.jsp" %>
		<div class="loginForm">
			<div class="loginBox">
				<div class="login">
					<h3>회원가입</h3>
				</div>
				<form:form modelAttribute="addMem" method="post">
				<div class="tablebox">	
					<table>
						<form:input path="email" value="<%=email%>" class="inputBox_pw" readonly="true"/> 
						<h4>인증완료</h4> 
						<form:input path="password"  type="password" placeholder="Password" class="inputBox_pw"/>
						<form:input path="nickName" id="nickName" placeholder="닉네임" class="inputBox_pw"/>
						<button class="overlap" id="checkBtn" type="button">중복확인</button>
						<div class="btnBox">
							<p>성별 : <form:radiobutton path="gender" value="Man" checked="checked"/>남성
									 <form:radiobutton path="gender" value="Woman"/>여성
						</div>
						<form:input type="number" path="age" class="inputBox_pw" value="나이" placeholder="나이"/>
						<div class="btnBox">
							<input type="submit" value="회원가입" disabled class="submitBtn">
						</div>
					</table>
				</div>	
				</form:form>
			</div>
		</div>
	</div>	
	<!-- JavaScript for 댓글 AJAX -->
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="/FoodTrip/resources/js/Member.js?version=18" type="text/javascript"></script>
</body>
</html>