<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="com.spring.domain.Member" %>
<%@ page session="false" %>
<%
   HttpSession session = request.getSession(false);
   Member sessionId = null;
   String adminCheck = null;
   if(session != null){
      sessionId = (Member)session.getAttribute("sessionId");
      // sessionId 가 null이 아닐 때만 getNickName() 호출
      if(sessionId != null){
      adminCheck = (String)sessionId.getNickName();
      System.out.println("닉네임 : " + sessionId.getNickName());
      System.out.println("참거짓 : " + sessionId != null);
      System.out.println("참거짓 : " + adminCheck.equals("admin"));         
      }
   }
%>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Dancing+Script:wght@400..700&family=Noto+Serif+KR:wght@200..900&family=Yeon+Sung&display=swap" rel="stylesheet">

<div class="menuContainer">
   <div id="menublock">
   	  <div>
		  <a href="/FoodTrip/" class="logo">
				<img src="/FoodTrip/resources/images/Logo2.png" style="width:170px; height:70px;">
		  </a>
	  </div> 
	   <ul>
	   	  <li>
		   	  <a href="#">푸드트립 소개</a>   	  
	   	  </li>
	   	  <li>
		      <a href="/FoodTrip/road/readRoad">투어리스트</a>  
	   	  </li>
	   	  <%
          if(sessionId != null && sessionId.getNickName() != null && !sessionId.getNickName().isEmpty() && !adminCheck.equals("admin"))
          {
          %>
             <a href="/FoodTrip/road/myTravellist">나의 여행</a>
          <%} %>
	   	  <li>
	      		<a href="/FoodTrip/board/boards">커뮤니티</a>
	   	  </li>
	   </ul>
  	   <ul id="menublock">
      <%
      if(sessionId != null && sessionId.getNickName() != null && !sessionId.getNickName().isEmpty())
      {
      %>
      		<div class="nickfont"><%=sessionId.getNickName()%>님</div>
	      	<li>
		         <a href="/FoodTrip/member/logout">로그아웃</a>
	      	</li>
	      	<li>
	      		<a href="/FoodTrip/member/update">회원정보수정</a>
	      	</li>
	      	<%if(sessionId!=null && adminCheck.equals("admin"))
	      	{ %>
		      	<li class="dropdown">
			        <a href="#">관리자</a>
			        <div class="dropSub">
			        	<a href="/FoodTrip/member/allMembers">전체회원조회</a>
				      	<a href="/FoodTrip/marker/test">마커 생성</a>
					    <a href="/FoodTrip/marker/readalljson">마커 전체 가져오기</a>
					    <a href="/FoodTrip/road/makeRoad">코스 생성</a>
			        </div>
			    </li>  
	      <%}
      	}else{%>
			<li>
		         <a href="/FoodTrip/member/login">로그인</a>
			</li>
			<li>
		         <a href="/FoodTrip/member/email">회원가입</a>
			</li>
      <%} %>
      </ul>
   </div>
</div>