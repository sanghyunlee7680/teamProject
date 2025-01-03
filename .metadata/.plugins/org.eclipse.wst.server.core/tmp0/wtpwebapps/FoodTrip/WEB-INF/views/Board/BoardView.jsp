<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.spring.domain.*" %>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html>
<head>
    <title>게시글 상세보기</title>
<link rel="stylesheet" href="/FoodTrip/resources/css/bootstrap.min.css">
</head>
<body>
	<%@ include file="../menu/menu.jsp" %>
    <div class="container">
        <% 
	        Board board = (Board) request.getAttribute("board");
	        List<Board> comments = (List<Board>) request.getAttribute("comments");
        	System.out.println("코멘트 : " + comments);
    	    for(int i=0; i<comments.size(); i++) {
    	    	int depth = comments.get(i).getDepth();
    	    	//System.out.println("조회뎁스" + depth);
    	    }
    	    BoardLike brk = (BoardLike)request.getAttribute("boardLike");
 			String brkNick = null;
    	    if(brk!=null){
    	    	brkNick = brk.getNickName();
    	    	System.out.println("들어옴 : " + brk.getNickName());
    	    }    	    
    	    
    	    System.out.println("세션아이디의 닉네임 : " + sessionId.getNickName());
    	    System.out.println("세션아이디와 좋아요 닉네임이 같지 않다면");
    	    System.out.println(sessionId.getNickName().equals(brkNick));
    	    System.out.println("좋아요 DB에 세션 닉이 없다면");
    	    System.out.println(!sessionId.getNickName().equals(brkNick));
    	    System.out.println("내용 : " + board.getContent());
        %>
		<!-- 게시글 부분 ( 제목, 내용, 작성자, 작성일, 수정일, 조회수, 좋아요 버튼기능 구현 ) -->
        <h1><%= board.getTitle() %></h1>
        <p><%if(board.getFileName() != null) { %>
     			  <img src="<%=request.getContextPath()%>/resources/images/<%=board.getFileName()%>" style="width:20%"/>
 			<% } %>
        </p>
        <p><%=board.getContent()%>
        	
        <p>
        	<small class="text-muted">
        			작성자: <%= board.getNickName()%> | 
        			작성일: <%= board.getCreateTime()%>  
        			<%if(board.getUpdateDay() != null){
        				out.println(" | 수정일: " + board.getUpdateDay());	
        			}%> | 
        			조회수: ${board.getViews()} |
        			좋아요: ${board.getLikes()}
        			<%if(sessionId.getNickName().equals(brkNick)){ %>
        			<button id="cancelBtn" data-brdNum="<%=board.getBrdNum()%>" data-nick="<%=sessionId.getNickName()%>">
        				<i class="fa-solid fa-heart" style="color:pink"></i>
        			</button>
        			<%}else if(!sessionId.getNickName().equals(brkNick)){ %>
        			<button id="likeBtn" data-brdNum="<%=board.getBrdNum()%>" data-nick="<%=sessionId.getNickName()%>">
        				<i class="fa-regular fa-heart"></i>
        			</button>
        			<%} %>
        	</small>
        </p>
        <!-- 게시글 수정/삭제 버튼 기능 구현 -->
        <% if (sessionId != null && sessionId.getNickName().equals(board.getNickName())) { %>
            <a href="/FoodTrip/board/updateBoard?num=<%= board.getBrdNum() %>" class="btn btn-primary">수정</a>
            <a href="/FoodTrip/board/deleteBoard?num=<%= board.getBrdNum() %>" class="btn btn-danger" onclick="return confirm('정말 삭제하시겠습니까?');">삭제</a>
        <% } %> 
        <!-- 게시글의 관리자 삭제 버튼 기능 구현 -->
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
        	if(comment.getDepth()==2 && !comment.getContent().equals("삭제된 메시지입니다")){
        %>	<!-- DB에 저장된 댓글의 내용이 "삭제된 메시지입니다"가 아닐때, 작성자, 내용, 작성일, 답글 기능 구현 -->
	       	<div class="mb-3" style="margin-left:20px;">
			    <p class="commentContent"><%= comment.getContent() %></p>
			    <p><small class="text-muted">작성자: <%= comment.getNickName() %> | 작성일: <%= comment.getCreateTime() %></small></p>	
				<button class="btn btn-sm btn-secondary replyButton" 
	        			data-id="<%= comment.getBrdNum() %>" data-depth="3">답글</button>
			    <!-- 로그인한 계정(=sessionId)가 댓글 작성자와 닉네임이 동일할 때, 수정 및 삭제 버튼 출력 -->
			    <% if (sessionId != null && sessionId.getNickName().equals(comment.getNickName())) { %>
			        <button class="btn btn-sm btn-secondary editComment" data-id="<%= comment.getBrdNum() %>">수정</button>
			        <button class="btn btn-sm btn-danger deleteComment" data-id="<%= comment.getBrdNum() %>">삭제</button>
			    <% } %>
			    <!-- 로그인한 계정(=sessionId)가 닉네임이 admin일 때, 관리자 삭제 버튼 기능 구현 -->
				<% if(sessionId != null && sessionId.getNickName().equals("admin")){ %>
		       		<button class="btn btn-sm btn-danger deleteComment" data-id="<%= comment.getBrdNum() %>">관리자 삭제</button>
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
        		else if(comment.getDepth()==3 && !comment.getContent().equals("삭제된 메시지입니다")){%>
        		<!-- DB에 저장된 답글의 내용이 "삭제된 메시지입니다"가 아닐때, 작성자, 내용, 작성일, 답글 기능 구현 -->
        		<div class="mb-3" style="margin-left:40px;">
				    <p class="commentContent"><%= comment.getContent() %></p>
				    <p><small class="text-muted">작성자: <%= comment.getNickName() %> | 작성일: <%= comment.getCreateTime() %></small></p>
					<button class="btn btn-sm btn-secondary replyButton" 
		        			data-id="<%= comment.getBrdNum() %>" data-depth="3">답글</button>
				    <!-- 로그인한 계정(=sessionId)가 답글 작성자와 닉네임이 동일할 때, 수정 및 삭제 버튼 출력 -->
				    <% if (sessionId != null && sessionId.getNickName().equals(comment.getNickName())) { %>
				        <button class="btn btn-sm btn-secondary editComment" data-id="<%= comment.getBrdNum() %>">수정</button>
				        <button class="btn btn-sm btn-danger deleteComment" data-id="<%= comment.getBrdNum() %>">삭제</button>
				    <% } %>
				    <!-- 로그인한 계정(=sessionId)가 닉네임이 admin일 때, 관리자 삭제 버튼 기능 구현 -->
					<% if(sessionId != null && sessionId.getNickName().equals("admin")){ %>
		       			<button class="btn btn-sm btn-danger deleteComment" data-id="<%= comment.getBrdNum() %>">관리자 삭제</button>
		       		<% } %>
				    <!-- 수정 입력 영역 (동적 추가) -->
				    <div class="editSection" style="display: none;">
				        <textarea class="form-control editTextarea"></textarea>
				        <button class="btn btn-sm btn-primary saveEdit" data-id="<%= comment.getBrdNum() %>">저장</button>
				        <button class="btn btn-sm btn-secondary cancelEdit">취소</button>
				    </div>
	    		</div>
		       	<hr>
		       	<!-- DB에 저장된 내용이 "삭제된 메시지입니다"일 때  삭제된 메시지입니다를 출력 / 댓글 및 수정, 삭제 버튼 출력x -->
		       	<%}else if(comment.getDepth()==3 && comment.getContent().equals("삭제된 메시지입니다")){ %>
		       		<div class="mb-3" style="margin-left:40px;">삭제된 메시지입니다</div>
		       		<hr>
		       	<%	}
	        	} %>

    <!-- JavaScript for 댓글 AJAX -->
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="/FoodTrip/resources/js/board.js?version=58" type="text/javascript"></script>
    <!-- Font Awesome -->
    <script src="https://kit.fontawesome.com/08b7540d84.js" crossorigin="anonymous"></script>
    </div>
</body>
</html>
