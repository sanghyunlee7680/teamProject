<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.spring.domain.*" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<!DOCTYPE html>
<html>
<head>
    <title>게시글 상세보기</title>
<!-- 
<link rel="stylesheet" href="/FoodTrip/resources/css/bootstrap.min.css">
 -->
<link rel="stylesheet" href="/FoodTrip/resources/css/menu.css?version=3"/>
<style>
	.contentBody {
		width:80%;
		margin:0 auto;
	    padding: 20px;
	    font-family: Arial, sans-serif;
	}
	
	/* 제목 스타일 */
	.contentBody h1 {
	    font-size: 2rem;
	    font-weight: bold;
	    margin-bottom: 10px;
	}
	
	/* 작은 텍스트(작성자 정보 등) */
	.text-muted {
	    color: #6c757d;
	    font-size: 0.875rem;
	}
	
	/* 버튼 기본 스타일 */
	.btn {
	    display: inline-block;
	    font-weight: 400;
	    color: #fff;
	    text-align: center;
	    vertical-align: middle;
	    cursor: pointer;
	    padding: 0.375rem 0.75rem;
	    font-size: 1rem;
	    line-height: 1.5;
	    border-radius: 0.25rem;
	    text-decoration: none;
	    border: none;
	}
	
	/* 버튼 색상 정의 */
	.btn-primary {
	    background-color: #007bff;
	}
	.btn-primary:hover {
	    background-color: #0056b3;
	}
	
	.btn-danger {
	    background-color: #dc3545;
	}
	.btn-danger:hover {
	    background-color: #a71d2a;
	}
	
	.btn-warning {
	    background-color: #ffc107;
	    color: #212529;
	}
	.btn-warning:hover {
	    background-color: #e0a800;
	}
	
	.btn-secondary {
	    background-color: #6c757d;
	}
	.btn-secondary:hover {
	    background-color: #5a6268;
	}
	
	/* 소형 버튼 */
	.btn-sm {
	    font-size: 0.875rem;
	    padding: 0.25rem 0.5rem;
	}
	
	/* 텍스트 입력 스타일 */
	.form-control {
	    width: 100%;
	    padding: 0.375rem 0.75rem;
	    font-size: 1rem;
	    line-height: 1.5;
	    color: #495057;
	    background-color: #fff;
	    border: 1px solid #ced4da;
	    border-radius: 0.25rem;
	    box-sizing: border-box;
	    margin-bottom: 8px;
	}
	
	.form-control:focus {
	    border-color: #80bdff;
	    outline: 0;
	    box-shadow: 0 0 0 0.25rem rgba(38, 143, 255, 0.25);
	}
	
	/* 댓글 상자 및 여백 */
	.mb-2 {
	    margin-bottom: 8px;
	}
	
	.mb-3 {
	    margin-bottom: 16px;
	}
	
	/* 댓글 들여쓰기 */
	.commentContent {
	    margin-left: 20px;
	}
	
	/* 삭제된 메시지 스타일 */
	.deletedMessage {
	    margin-left: 20px;
	    color: #6c757d;
	    font-style: italic;
	}
	.textBox{
	    display: flex;
	    align-items: center;
	    gap: 10px;
	    margin: 10px 0;
	    padding: 10px;
	    border:1px solid rgba(0,0,0,0.3);
	    border-radius: 8px;
	    font-size: 14px;
	    color: #333;
	    flex-wrap: wrap;
	}
</style>
</head>
<body>
<div class="container">
	<div class="menubar">
			<%@ include file="../menu/menu.jsp" %>
	</div>
        <% 
	        Board board = (Board) request.getAttribute("board");
        	Road road = (Road) request.getAttribute("road");
	        List<Board> comments = (List<Board>) request.getAttribute("comments");
        	System.out.println("코멘트 : " + comments);
    	    for(int i=0; i<comments.size(); i++) {
    	    	int depth = comments.get(i).getDepth();
    	    	System.out.println("조회뎁스" + depth);
    	    }
        %>
	<div class="contentBody">
        <h1><%= board.getTitle() %></h1>
        <p><small class="text-muted">작성자: <%= board.getNickName() %> | 작성일: <%= board.getCreateTime() %></small></p>
        <p>
				<% if(road != null){ 
					session.setAttribute("road", road); %>
					
					<p> 여행한 코스 카테고리 : <%= road.getCategory() %>
					<div class="courseList">
						<p> <b>내가 여행한 코스 :</b> 
						<%ArrayList<Marker> ary = road.getPoints();
							 for(int i=0; i<ary.size(); i++){ %>
							<span> <%= i+1%>. <%= ary.get(i).getPointName() %>
								<%if(i != ary.size()-1) {%>
									
								<%} %>
							</span>
							<%	}%>
					</div>
					<p class="date"> 여행 시작일 : <%= road.getCreateTime() %>
					<p class="date"> 여행 종료일 : <%= road.getEndTime() %>
					<%} %>
		<div class="textBox">
        	<p><%= board.getContent() %></p>
        </div>
        <!-- 게시글 수정/삭제 버튼 -->
        <% if (sessionId != null && sessionId.getNickName().equals(board.getNickName())) { %>
            <a href="/FoodTrip/board/updateBoard?num=<%= board.getBrdNum() %>" class="btn btn-primary">수정</a>
            <a href="/FoodTrip/board/deleteBoard?num=<%= board.getBrdNum() %>&admin=0" class="btn btn-danger" onclick="return confirm('정말 삭제하시겠습니까?');">삭제</a>
        <% } %>
        
        <% if(sessionId != null && sessionId.getNickName().equals("admin")){ %>
        	<a href="/FoodTrip/board/deleteBoard?num=<%= board.getBrdNum()%>" class="btn btn-warning" onclick="return confirm('관리자 권한으로 삭제하시겠습니까?');">관리자 삭제</a>
        <% } %>
        <hr>

		<!-- 댓글 입력 -->
        <div>
            <textarea id="commentContent" class="form-control mb-2" placeholder="댓글을 입력하세요"></textarea>
            <button id="addComment" class="btn btn-primary" data-parent="<%=board.getBrdNum()%>" data-depth="2" data-nick="<%=sessionId.getNickName()%>">댓글 작성</button>
        </div>
        <hr>

        <!-- 댓글 목록 -->
        <h4>댓글</h4>
        <% for (int i = 0; i < comments.size(); i++) {
            Board comment = comments.get(i);
            //System.out.println("뎁스 : " + comment.getDepth());
        	if(comment.getDepth()==2 && !comment.getContent().equals("삭제된 메시지입니다") && !comment.getContent().equals("관리자에 의해 삭제된 메시지입니다")){
        %>
	       	<div class="mb-3" style="margin-left:20px;">
			    <p class="commentContent"><%= comment.getContent() %></p>
			    <p><small class="text-muted">작성자: <%= comment.getNickName() %> | 작성일: <%= comment.getCreateTime() %></small></p>	
				<button class="btn btn-sm btn-secondary replyButton" 
	        			data-id="<%= comment.getBrdNum() %>" data-depth="3">답글</button>
			    <!-- 수정 버튼 및 삭제 버튼 -->
			    <% if (sessionId != null && sessionId.getNickName().equals(comment.getNickName()) && !comment.getContent().equals("관리자에 의해 삭제된 메시지입니다") && !comment.getContent().equals("관리자에 의해 삭제된 메시지입니다")) { %>
			        <button class="btn btn-sm btn-secondary editComment" data-id="<%= comment.getBrdNum() %>">수정</button>
			        <button class="btn btn-sm btn-danger deleteComment" data-id="<%= comment.getBrdNum() %>" data-admin="2">삭제</button>
			    <% } %>
				<% if(sessionId != null && sessionId.getNickName().equals("admin") && !comment.getContent().equals("관리자에 의해 삭제된 메시지입니다")){ %>
		       		<button class="btn btn-sm btn-danger deleteComment" data-id="<%= comment.getBrdNum() %>" data-admin="1">관리자 삭제</button>
		       	<% } %>
			    <!-- 수정 입력 영역 (동적 추가) -->
			    <div class="editSection" style="display: none;">
			        <textarea class="form-control editTextarea"></textarea>
			        <button class="btn btn-sm btn-primary saveEdit" data-id="<%= comment.getBrdNum() %>">저장</button>
			        <button class="btn btn-sm btn-secondary cancelEdit">취소</button>
			    </div>
	    	</div>
	        <hr>
	        <%
	        }else if(comment.getDepth()==2 &&comment.getContent().equals("삭제된 메시지입니다")){%>
	        	<div class="mb-3" style="margin-left:20px;">삭제된 메시지입니다</div>
	        	<hr>
	        <% } 
	        else if(comment.getDepth()==2 && comment.getContent().equals("관리자에 의해 삭제된 메시지입니다")){%>
	        	<div class="mb-3" style="margin-left:20px;">관리자에 의해 삭제된 메시지입니다</div>
	        	<hr>
	        <%} 
        	else if(comment.getDepth()==3 && !comment.getContent().equals("삭제된 메시지입니다") && !comment.getContent().equals("관리자에 의해 삭제된 메시지입니다")){%>
        		<div class="mb-3" style="margin-left:40px;">
				    <p class="commentContent"><%= comment.getContent() %></p>
				    <p><small class="text-muted">작성자: <%= comment.getNickName() %> | 작성일: <%= comment.getCreateTime() %></small></p>
					<button class="btn btn-sm btn-secondary replyButton" 
		        			data-id="<%= comment.getBrdNum() %>" data-depth="3">답글</button>
				    <!-- 수정 버튼 및 삭제 버튼 -->
				    <% if (sessionId != null && sessionId.getNickName().equals(comment.getNickName()) && !comment.getContent().equals("관리자에 의해 삭제된 메시지입니다") && !comment.getContent().equals("관리자에 의해 삭제된 메시지입니다")) { %>
				        <button class="btn btn-sm btn-secondary editComment" data-id="<%= comment.getBrdNum() %>">수정</button>
				        <button class="btn btn-sm btn-danger deleteComment" data-id="<%= comment.getBrdNum() %>" data-admin="2">삭제</button>
				    <% } %>
					<% if(sessionId != null && sessionId.getNickName().equals("admin") && !comment.getContent().equals("관리자에 의해 삭제된 메시지입니다")){ %>
		       			<button class="btn btn-sm btn-danger deleteComment" data-id="<%= comment.getBrdNum() %>" data-admin="1">관리자 삭제</button>
		       		<% } %>
				    <!-- 수정 입력 영역 (동적 추가) -->
				    <div class="editSection" style="display: none;">
				        <textarea class="form-control editTextarea"></textarea>
				        <button class="btn btn-sm btn-primary saveEdit" data-id="<%= comment.getBrdNum() %>">저장</button>
				        <button class="btn btn-sm btn-secondary cancelEdit">취소</button>
				    </div>
	    		</div>
		       	<hr>
		       	<%}
        		else if(comment.getDepth()==3 && comment.getContent().equals("삭제된 메시지입니다")){ %>
		       		<div class="mb-3" style="margin-left:40px;">삭제된 메시지입니다</div>
		       		<hr>
		       	<%}
		       	else if(comment.getDepth()==3 && comment.getContent().equals("관리자에 의해 삭제된 메시지입니다")){%>
		        	<div class="mb-3" style="margin-left:40px;">관리자에 의해 삭제된 메시지입니다</div>
		        	<hr>
	        	<%} 
	        	} %>
	</div>
    <!-- JavaScript for 댓글 AJAX -->
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="/FoodTrip/resources/js/board.js?version=53" type="text/javascript"></script>
</div>
</body>
</html>
