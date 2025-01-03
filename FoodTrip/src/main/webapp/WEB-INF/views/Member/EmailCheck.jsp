<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html>
<%
	String mailCheck = (String)request.getAttribute("true");
%>
<head>
<!-- css files -->
<link href="/FoodTrip/resources/css/member.css?version=112" rel='stylesheet' type='text/css' />
<script src="https://kit.fontawesome.com/08b7540d84.js" crossorigin="anonymous"></script><!-- fontawesome css -->
<!-- //css files -->
<meta charset="UTF-8">
<title>이메일 인증</title>
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
      <div class="login">이메일 인증</div>
      <div class="eula">이메일 인증이 필요합니다.<br> 이메일을 입력해 주세요.
        <%if(mailCheck!=null){%>
        	<br>
			<b class="loginError" style="color:red">가입된 이메일이 존재합니다.</b>
		<%}%>
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
      <form:form modelAttribute="email" class="form" method="post">
        <label for="email">Email</label>
        <form:input path="email" id="email" type="email" placeholder="Email" />
        <button type="button" id="submit" class="submitEmail" >이메일 인증</button>
      </form:form>
    </div>
  </div>
</div>
<!-- anime.js 라이브러리 -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/animejs/3.2.1/anime.min.js"></script>
<script src="/FoodTrip/resources/js/Login.js?version=535" type="text/javascript"></script>
<script>
	document.addEventListener('DOMContentLoaded', function() {
    var subBtn = document.querySelector(".submitEmail");
    console.log("버튼 : " + subBtn);

    subBtn.addEventListener('click', function() {
    	var emailInput = document.querySelector('input[name="email"]'); // name 속성으로 선택
    	var emailname = emailInput.value;
        console.log("함수 : " + emailname);
        if (!emailname) {
            console.log("왜안들어가지?");
            alert("이메일을 입력해주세요.");
            return;
        }
        document.querySelector('.form').submit(); // 폼 제출
    });
});	
</script>
</body>

</html>