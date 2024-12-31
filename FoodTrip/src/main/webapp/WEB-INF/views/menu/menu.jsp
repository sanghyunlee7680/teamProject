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


	<!-- google fonts -->
	<link href="//fonts.googleapis.com/css?family=Montserrat:100,100i,200,200i,300,300i,400,400i,500,500i,600,600i,700,700i,800,800i,900,900i" rel="stylesheet">
	<link href="//fonts.googleapis.com/css?family=Open+Sans:300,300i,400,400i,600,600i,700,700i,800,800i" rel="stylesheet">
	<!-- //google fonts -->

<!-- header -->
<header>
	<div class="container">
		<!-- nav -->
		<nav class="py-3 d-lg-flex">
			<div id="logo">
				<h1>
					<a href="/FoodTrip/" class="logo">
						<img src="/FoodTrip/resources/images/Logo2.png" style="width:170px; height:70px;">					
					</a>
				</h1>
			</div>
			<ul class="menu ml-auto mt-1" id="menublock">
				<li class="active">
                    <a href="#">푸드트립 소개</a>   	  
                </li>
				<li>
                    <a href="/FoodTrip/road/readRoad">투어리스트</a>  
                </li>
                <%
                if(sessionId != null && sessionId.getNickName() != null && !sessionId.getNickName().isEmpty() && !adminCheck.equals("admin"))
                {
                %>
                <li>
                    <a href="/FoodTrip/road/myTravellist">나의 여행</a>
                </li>
                <%} %>
                <li>
                        <a href="/FoodTrip/board/boards">커뮤니티</a>
                </li>
			</ul>
			<ul class="menu ml-auto mt-1">
			     <%
			     if(sessionId != null && sessionId.getNickName() != null && !sessionId.getNickName().isEmpty())
			     {
			     %>
				<li>
					<b class="nickfont"><%=sessionId.getNickName()%>님</b>
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
		</nav>
		<!-- //nav -->
	</div>
</header>