<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="com.spring.domain.Member" %>
<%@ page session="false" %>
<%
   HttpSession session = request.getSession(false);
   Member sessionId = null;
   String adminCheck = null;
   if(session != null){
      sessionId = (Member)session.getAttribute("sessionId");
	   if(sessionId != null){
	      adminCheck = (String)sessionId.getNickName();
	      System.out.println("게시글 작성 폼 세션 널아님!!");
	      System.out.println("닉네임 : " + sessionId.getNickName());
	      System.out.println("참거짓 : " + sessionId != null);
	      System.out.println("참거짓 : " + adminCheck.equals("admin"));
	   }
   }
%>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Nanum+Gothic&display=swap" rel="stylesheet">

<div class="menuContainer">
	<div class="menublock">
		<a href="/FoodTrip/">홈</a>
	</div>
<%   if(sessionId != null && adminCheck.equals("admin")){ %>
	<div id="menublock">
		<a href="/FoodTrip/member/allMembers">전체 회원 관리</a>
		<a href="/FoodTrip/marker/addMarker">마커 생성</a>
		<a href="/FoodTrip/marker/readalljson">마커 전체 가져오기</a>
		<a href="/FoodTrip/road/makeRoad">코스 생성</a>
	</div>
   <%} %>
   <div id="menublock">
      <a href="/FoodTrip/road/readRoad">전체 코스보기</a>
      <%   if(sessionId != null && adminCheck != null){ %>
      	<a href="/FoodTrip/road/myTravellist">나의 여행</a>
      <%} %>
      <a href="/FoodTrip/board/boards">커뮤니티</a>
   </div>
   <div id="menublock">
      <%
      if(sessionId != null && sessionId.getNickName() != null && !sessionId.getNickName().isEmpty()){
      %>
      	 <span> <%= sessionId.getNickName() %> 님</span>
         <a href="/FoodTrip/member/logout">로그아웃</a>
         <a href="/FoodTrip/member/update">회원정보수정</a>
      <%}else{%>
         <a href="/FoodTrip/member/login">로그인</a>
         <a href="/FoodTrip/member/email">회원가입</a>
      <%} %>
   </div>
</div>