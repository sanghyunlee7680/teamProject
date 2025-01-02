<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html>
<%
	String mailCheck = (String)request.getAttribute("true");
%>
<head>
<!-- css files -->
<link rel="stylesheet" href="/FoodTrip/resources/css/menu.css?version=1252"/>
<link href="/FoodTrip/resources/css/bootstrap.min.css?version=1332" rel='stylesheet' type='text/css' /><!-- bootstrap css -->
<link href="/FoodTrip/resources/css/css_slider.css?version=131" rel='stylesheet' type='text/css' /><!-- custom css -->
<link href="/FoodTrip/resources/css/style.css?version=912" type="text/css" rel="stylesheet" media="all">
<script src="https://kit.fontawesome.com/08b7540d84.js" crossorigin="anonymous"></script><!-- fontawesome css -->
<!-- //css files -->
<meta charset="UTF-8">
<title>이메일 인증</title>
</head>
<body>
	<!-- header -->
	<%@ include file="../menu/menu.jsp" %>
	<!-- //header -->
	<div class="banner" id="home">
		<div class="layer">
			<div class="container">
				<div class="row">	
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
												<form:input path="email" placeholder="Email" class="inputBox_pw"/>
											</th>
										</tr>
										<%if(mailCheck!=null){%>
										<tr>
											<th>
												<div class="loginError">
													<b>가입된 이메일이 존재합니다.</b>
												</div>
											</th>
										</tr>
										<%} %>
										<tr>
											<th>
												<div class="btnBox">
													<input type="submit" value="이메일인증" class="submitBtn"/>
												</div>
											</th>
										</tr>
									</table>
								</div>
							</form:form>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>