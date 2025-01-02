<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ page session="false" %>
<!DOCTYPE html>
<html>
<head>
<%
	String error = (String)request.getAttribute("error");
%>
<!-- css files -->
<link rel="stylesheet" href="/FoodTrip/resources/css/member.css?version=122"/>
<!-- //css files -->
<meta charset="UTF-8">
<title>로그인</title>
</head>
<body>
	<div class="page">
  <div class="container_login">
	<div class="homeLogo">
		<a href="/FoodTrip/" class="logo">
           <img src="/FoodTrip/resources/images/Logo2.png" style="width:120px; height:50px;">               
        </a>
	</div>
    <div class="left">
      <div class="login">Login</div>
      <div class="eula">Go on a FoodTrip
      	<%	if(error!=null){	%>
        		<b style="color:red; display:block">이메일 혹은 패스워드가 일치하지 않습니다.</b>	
        <%	}%>
      </div>
    </div>
    <div class="right">
      <svg viewBox="0 0 320 300">
        <defs>
          <linearGradient
                          inkscape:collect="always"
                          id="linearGradient"
                          x1="13"
                          y1="193.49992"
                          x2="307"
                          y2="193.49992"
                          gradientUnits="userSpaceOnUse">
            <stop
                  style="stop-color:#ff00ff;"
                  offset="0"
                  id="stop876" />
            <stop
                  style="stop-color:#ff0000;"
                  offset="1"
                  id="stop878" />
          </linearGradient>
        </defs>
        <path d="m 40,120.00016 239.99984,-3.2e-4 c 0,0 24.99263,0.79932 25.00016,35.00016 0.008,34.20084 -25.00016,35 -25.00016,35 h -239.99984 c 0,-0.0205 -25,4.01348 -25,38.5 0,34.48652 25,38.5 25,38.5 h 215 c 0,0 20,-0.99604 20,-25 0,-24.00396 -20,-25 -20,-25 h -190 c 0,0 -20,1.71033 -20,25 0,24.00396 20,25 20,25 h 168.57143" />
      </svg>
      <form:form modelAttribute="mem" class="form" method="post">
        <label for="email">Email</label>
        <form:input path="email" type="email" id="email" placeholder="Email"/>
        <label for="password">Password</label>
        <form:input path="password" type="password" id="password" placeholder="Password"/>
        <input type="submit" id="submit" value="로그인">
      </form:form>
    </div>
  </div>
</div>
<!-- anime.js 라이브러리 -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/animejs/3.2.1/anime.min.js"></script>
<script src="/FoodTrip/resources/js/Login.js?version=32" type="text/javascript"></script>
</body>
</html>