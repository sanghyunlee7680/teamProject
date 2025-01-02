<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.spring.domain.Member" %>
<!DOCTYPE html>
<html>
<%
	int pageNum = (Integer) request.getAttribute("pageNum");
	int totalPage = (Integer) request.getAttribute("totalPage");
	System.out.println("페이지넘 : " + pageNum);
	System.out.println("토탈페이지 : " + totalPage);
	int memberline = (Integer) request.getAttribute("memberline");
	List<Member> list = (List<Member>)request.getAttribute("memberList");
%>
<head>
<link rel="stylesheet" href="/FoodTrip/resources/css/menu.css?version=35">
<meta charset="UTF-8">
<title>전체 회원 관리</title>
</head>
<body>
	<div class="container">
		<div class="menubar">
			<%@ include file="../menu/menu.jsp" %>
			<h1>회원관리</h1>
		</div>
		<!-- 테이블 -->
        <div class="table-container">
            <table class="member-table">
                <thead>
                    <tr>
                        <th>이메일</th>
                        <th>닉네임</th>
                        <th>성별</th>
                        <th>나이</th>
                        <th>뱃지</th>
                        <th>가입날짜</th>
                        <th>삭제</th>
                    </tr>
                </thead>
                <tbody>
                    <% for (Member member : list) { %>
                    <tr>
                        <td><%= member.getEmail() %></td>
                        <td><%= member.getNickName() %></td>
                        <td><%= member.getGender() %></td>
                        <td><%= member.getAge() %></td>
                        <td><%= member.getBadgeName() %></td>
                        <td><%= member.getJoinDay() %></td>
                        <td>
                            <a href="/FoodTrip/member/deleteMember?email=<%=member.getEmail()%>" class="delete-btn">삭제</a>
                        </td>
                    </tr>
                    <% } %>
                </tbody>
            </table>
        </div>

        <!-- 페이지네이션 -->
        <div class="pagination">
            <% for (int i = 1; i <= totalPage; i++) { %>
                <a href="/FoodTrip/member/allMembers?pageNum=<%= i %>&memberline=<%= memberline %>" 
                   class="<%= pageNum == i ? "page-link active" : "page-link" %>">
                    [<%= i %>]
                </a>
            <% } %>
        </div>

        <!-- 정렬 링크 -->
        <div class="sort-options">
            <a href="./allMembers?pageNum=1&memberline=1" class="<%= memberline == 1 ? "sort-btn active" : "sort-btn" %>">
                가입 날짜 순
            </a>
            <a href="./allMembers?pageNum=1&memberline=2" class="<%= memberline == 2 ? "sort-btn active" : "sort-btn" %>">
                가나다 순
            </a>
        </div>
    </div>
</body>
</html>