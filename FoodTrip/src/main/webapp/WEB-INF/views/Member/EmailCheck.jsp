<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html>
<%
	String mailCheck = (String)request.getAttribute("true");
%>
<head>
<link rel="stylesheet" href="/FoodTrip/resources/css/member.css?version=33">
<meta charset="UTF-8">
<title>이메일 인증</title>
</head>
<body>
	<div class="container">
		<div class="loginForm">
			<div class="loginBox">
				<div class="login">
					<h3>이메일 인증</h3>
				</div>
				<form:form modelAttribute="email" method="post">
				<div class="tablebox">
					<table>
						<tr>
							<th>
								<form:input path="email1" placeholder="Email" class="inputBox"/> @
								<form:select path="email2" class="inputBox">
									<option value="naver.com">naver.com</option>
									<option value="daum.net">daum.net</option>
									<option value="gmail.com">gmail.com</option>
									<option value="nate.com">nate.com</option>
								</form:select>
							</th>
						</tr>
					</table>
				</div>
				<%if(mailCheck!=null){%>
				<div class="loginError">
					<b>가입된 이메일이 존재합니다.</b>
				</div>
				<%} %>
				<div class="btnBox">
					<input type="submit" value="이메일인증" class="submitBtn"/>
				</div>
				</form:form>
			</div>
		</div>
	</div>
</body>
</html>