<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.spring.domain.Board" %>
<%@ page import="com.spring.domain.BoardLike" %>
<!DOCTYPE html>
<html>
	<%
		int pageNum = (Integer) request.getAttribute("pageNum");
	    int totalPage = (Integer) request.getAttribute("totalPage");
		System.out.println("JSP토탈페이지 : " +  totalPage);
		System.out.println("JSP페이지넘 : " + pageNum);
	%>

<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%@ include file="../menu/menu.jsp" %>
	<div>전체</div>
	<div>
		<table border="1">
			<tr>
				<th>번호</th>
				<th>제목</th>
				<th>작성자</th>
				<th>조회   |   좋아요</th>
				<th>작성날짜</th>
			</tr>
			<%
			 	List<Board> brd = (List<Board>) request.getAttribute("boardList");
				for(int j=0; j<brd.size(); j++){
					Board notice = brd.get(j);
					long parent = notice.getParentNum();
					
			%>
						<tr>
							<td><%=notice.getBrdNum() %></td>
							<td><a href="./BoardView?num=<%=notice.getBrdNum()%>&pageNum=<%=pageNum%>"><%=notice.getTitle() %></a></td>
							<td><%=notice.getNickName() %></td>
							<td><i class="fa-solid fa-users"></i> <%=notice.getViews() %> | <i class="fa-solid fa-heart" style="color:pink"></i><%=notice.getLikes() %>
							</td>
							<td><%=notice.getCreateTime() %></td>
						</tr>
			<%
				}
			%>
				</table>
				<div>
					<%for(int i=1; i<=totalPage; i++){%>
						<a href="/board/boards?pageNum=<%=i %>">
						<%if(pageNum == i){ %>
							<font color='4C5317'><b>[<%=i %>]</b></font>
						<%}else{ %>
							<font color='4C5317'>[<%=i %>]</font>
						<%} %>
					</a>
				    <%} %>			
		</div>
		<div>
			<a href="./addBoard">글쓰기</a>
		</div>
	</div>
	<!-- JavaScript for 댓글 AJAX -->
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="/FoodTrip/resources/js/board.js?version=46" type="text/javascript"></script>
    <!-- Font Awesome -->
    <script src="https://kit.fontawesome.com/08b7540d84.js" crossorigin="anonymous"></script>
</body>
</html>