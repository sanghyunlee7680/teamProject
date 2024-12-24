<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ page session="false" %>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="/FoodTrip/resources/css/member.css?version=33">
<meta charset="UTF-8">
<title>로그인</title>
</head>
<body>
	<div class="container">
		<div class="loginForm">
			<div class="loginBox">
				<div class="login">
					<h3>로그인</h3>
				</div>
					<form:form modelAttribute="mem" method="post">
					<div class="tablebox">
						<table>
							<tr>
								<th>
									<form:input path="email1" class="inputBox" placeholder="Email"/>					
									 @ <form:select path="email2" class="inputBox">
											<option>naver.com</option>
											<option>daum.net</option>
											<option>gmail.com</option>
											<option>nate.com</option>
									</form:select>														
								</th>			
							</tr>
							<tr>
								<th>
									<form:input path="password" type="password" class="inputBox_pw" placeholder="Password"/>							
								</th>
							</tr>
						</table>
					</div>
					<%
						String error = (String)request.getAttribute("error");
						if(error!=null){
					%>
						<div class="loginError">
							<b>이메일 혹인 비밀번호가 일치하지 않습니다.</b><br/>
						</div>
						<%} %>
					<div class="btnBox">
						<input type="submit" value="로그인" class="submitBtn">
					</div>
					<div class="addBtn" onclick="location.href='/FoodTrip/member/email'">
						<a href="email">회원가입</a>
					</div>
				</form:form>
			</div>
		</div>	
	</div>
</body>
</html>