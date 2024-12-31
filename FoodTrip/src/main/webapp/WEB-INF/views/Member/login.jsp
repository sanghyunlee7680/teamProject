<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ page session="false" %>
<!DOCTYPE html>
<html>
<head>
<!-- css files -->
<link rel="stylesheet" href="/FoodTrip/resources/css/menu.css?version=1252"/>
<link href="/FoodTrip/resources/css/bootstrap.min.css?version=1332" rel='stylesheet' type='text/css' /><!-- bootstrap css -->
<link href="/FoodTrip/resources/css/css_slider.css?version=131" rel='stylesheet' type='text/css' /><!-- custom css -->
<link href="/FoodTrip/resources/css/style.css?version=912" type="text/css" rel="stylesheet" media="all">
<script src="https://kit.fontawesome.com/08b7540d84.js" crossorigin="anonymous"></script><!-- fontawesome css -->
<!-- //css files -->
<meta charset="UTF-8">
<title>로그인</title>
</head>
<body>
	<!-- header -->
	<%@ include file="../menu/menu.jsp" %>
	<!-- //header -->
	<div class="banner" id="home" >
		<div class="layer">
			<div class="container">
				<div class="row">			
					<div class="loginForm">
						<div class="loginBox">
							<form:form modelAttribute="mem" method="post">
								<div class="tablebox">
									<table>
										<tr>
											<th>
												<div class="login">
													<h3><i class="fa-solid fa-user"></i>&nbsp;로그인</h3>
												</div>
											</th>
										</tr>
										<tr>
											<th>
												<form:input path="email" class="inputBox_pw" placeholder="Email"/>																		
											</th>			
										</tr>
										<tr>
											<th>
												<form:input path="password" type="password" class="inputBox_pw" placeholder="Password"/>							
											</th>
										</tr>
										<%
											String error = (String)request.getAttribute("error");
											if(error!=null){
										%>
										<tr>
											<th>
												<div class="loginError">
													<b>이메일 혹인 비밀번호가 일치하지 않습니다.</b><br/>
												</div>
											</th>
										</tr>	
										<%} %>
										<tr>
											<th>
												<div class="btnBox">
													<input type="submit" value="로그인" class="submitBtn">
												</div>
											</th>
										</tr>
										<tr>
											<th>
												<div class="addBtn" onclick="location.href='/FoodTrip/member/email'">
													<a href="email">회원가입</a>
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
	<!-- //header -->
	</div>
</body>
</html>