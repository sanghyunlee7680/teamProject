<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ page session="false" %>
<%@ page import ="java.util.ArrayList" %>
<%@ page import ="com.spring.domain.Member" %>
<%@ page import ="com.spring.domain.Road" %>
<%@ page import ="com.spring.domain.Marker" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="/FoodTrip/resources/css/menu.css?version=3"/>
<script src="https://kit.fontawesome.com/7676881a65.js" crossorigin="anonymous"></script>
<style>
	.courseList{
		width:100%;
		display:flex;
		
	}
	.contentBody{
		margin-top: 100px; 
		width:100%;
		display:flex;
		flex-direction:column;
		align-items:center;
	}
	/* 게시판 작성 뷰 CSS */
#board {
    width: 80%;
    margin: 0 auto;
    padding: 20px;
    background-color: #f9f9f9;
    border-radius: 8px;
    box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
    font-family: 'Arial', sans-serif;
}

#board p {
    margin: 10px 0;
    font-size: 16px;
    color: #333;
}

#board input[type="text"], 
#board textarea {
    width: 100%;
    padding: 10px;
    margin: 5px 0;
    font-size: 14px;
    border: 1px solid #ccc;
    border-radius: 4px;
    box-sizing: border-box;
}

#board input[readonly] {
    background-color: #e9ecef;
    color: #6c757d;
}

#board textarea {
    resize: none;
}

#board input[type="submit"] {
    display: block;
    width: 100px;
    padding: 12px;
    margin-top: 20px;
    font-size: 16px;
    color: #fff;
    background-color: #007bff;
    border: none;
    border-radius: 4px;
    cursor: pointer;
    transition: background-color 0.3s ease;
}

#board input[type="submit"]:hover {
    background-color: #0056b3;
}

.courseList {
    display: flex;
    align-items: center;
    gap: 10px;
    margin: 10px 0;
    padding: 10px;
    background-color: #e3f2fd;
    border-radius: 8px;
    font-size: 14px;
    color: #333;
    flex-wrap: wrap;
}

.courseList span {
    display: flex;
    align-items: center;
    font-size: 14px;
    font-weight: bold;
    color: #495057;
}

.courseList span i {
    margin: 0 5px;
    color: #007bff;
}

.courseList span:last-child i {
    display: none;
}

.placeholder {
    color: #6c757d;
}
</style>
</head>
<body>
<%
	Road road = (Road)request.getAttribute("road");
	
	if(road != null){
		System.out.println(road);
	}
		//	로드의 정보를 따로 가지고 감
%>	

<div class="container">
	<div class="menubar">
		<%@ include file="../menu/menu.jsp" %>
		<span>게시글 작성</span>
	</div>
	<div class="contentBody">
		<form:form modelAttribute="addBrd" method="post" id="board">
			<p>작성자 : <form:input path="nickName" value="<%=sessionId.getNickName()%>" readonly="true" />
			<p>제목 : <form:input path="title" placeholder="제목을 입력해주세요"/>
			<p>
				<% if(road != null){ 
					session.setAttribute("road", road); %>
					<p> 여행한 코스 : <%= road.getCategory() %>
					<p> 여행 시작일 : <%= road.getCreateTime() %>
					<p> 여행 종료일 : <%= road.getEndTime() %>
					<div class="courseList">
						<p> 내가 여행한 코스 : 
						<%ArrayList<Marker> ary = road.getPoints();
							 for(int i=0; i<ary.size(); i++){ %>
							<span> <%= i+1%>. <%= ary.get(i).getPointName() %>
								<%if(i != ary.size()-1) {%>
									<span><i class="fa-solid fa-right-long"></i></span>
								<%} %>
							</span>
							<%	}%>
					</div>
					<%} %>
				<p>내용 : 	
				<p><form:textarea path="content" cols="150" rows="30"/>
			<p>	<input type="submit" value="등록"/>
		</form:form>
	</div>
	<%@ include file="../footer/footer.jsp" %>
</div>
</body>
</html>