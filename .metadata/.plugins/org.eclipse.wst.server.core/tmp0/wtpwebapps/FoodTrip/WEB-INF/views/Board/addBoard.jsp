<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ page session="false" %>
<%@ page import ="com.spring.domain.Member" %>

<!DOCTYPE html>
<html>
<head>
<style>
    #previewImage {
        border: 1px solid #ccc;
        padding: 5px;
        max-height: 300px;
        object-fit: contain; /* 이미지 비율 유지 */
    }
</style>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%@ include file="../menu/menu.jsp" %>
	<form:form modelAttribute="addBrd" method="post" enctype="multipart/form-data">
		<p>닉네임 : <form:input path="nickName" value="<%=sessionId.getNickName()%>" readonly="true" />
		<p>제목 : <form:input path="title" placeholder="제목을 입력해주세요"/>
		<p>내용 : 
			<p> <form:textarea path="content" cols="100" rows="30"/>
		<p>이미지 첨부:
        <form:input path="image" type="file" id="imageUpload" accept="image/*" multiple="multiple" />
			<div id="previewContainer">
	            <img id="previewImage" style="max-width: 300px; display: none;" />
	        </div>	
		<p>	<input type="submit" value="등록"/>
	</form:form>
	
	<!-- JavaScript for 댓글 AJAX -->
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="/FoodTrip/resources/js/board.js?version=34" type="text/javascript"></script>
</body>
</html>