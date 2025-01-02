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
<!-- css files -->
<link href="/FoodTrip/resources/css/bootstrap.min.css?version=1332" rel='stylesheet' type='text/css' /><!-- bootstrap css -->
<link href="/FoodTrip/resources/css/css_slider.css?version=1321" rel='stylesheet' type='text/css' /><!-- custom css -->
<link href="/FoodTrip/resources/css/style.css?version=932" type="text/css" rel="stylesheet" media="all">
<script src="https://kit.fontawesome.com/08b7540d84.js" crossorigin="anonymous"></script><!-- fontawesome css -->
<!-- //css files -->
<meta charset="UTF-8">
<title>회원 가입</title>
</head>
<body>
    <div class="page">
       <div class="container_login">   
			<div class="homeLogo">
				<a href="/FoodTrip/" class="logo">
		           <img src="/FoodTrip/resources/images/Logo2.png" style="width:120px; height:50px;">               
		        </a>
			</div>
            <div class="loginForm">
               <div class="loginBox_add">
                  <div class="login">
                     <h3>회원가입</h3>
                  </div>
                  <form:form modelAttribute="addMem" method="post">
                     <div class="tablebox">   
                        <table>
                           <p class="updfont">Email:<form:input path="email" value="<%=email%>" class="inputBox_pw" readonly="true"/> 
                           <h4 style="color:gray;">인증완료!</h4>
                           <p class="updfont">비밀번호:<form:input path="password"  type="password" placeholder="Password" class="inputBox_pw"/>
                           <p class="updfont">닉네임 :<form:input path="nickName" id="nickName" placeholder="닉네임" class="inputBox_pw"/>
                           <button class="overlap" id="checkBtn" type="button">중복확인</button>
                           <div class="btnBox">
                              <p class="updfont">성별 : 
                                    <form:radiobutton path="gender" value="Man" checked="checked"/>남성
                                     <form:radiobutton path="gender" value="Woman"/>여성
                           </div>
                           <p class="updfont">나이 :
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
    </div>
   <!-- JavaScript for 댓글 AJAX -->
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="/FoodTrip/resources/js/Member.js?version=18" type="text/javascript"></script>
</body>
</html>