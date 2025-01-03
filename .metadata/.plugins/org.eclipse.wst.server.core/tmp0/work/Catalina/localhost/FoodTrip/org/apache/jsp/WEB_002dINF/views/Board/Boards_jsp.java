/*
 * Generated by the Jasper component of Apache Tomcat
 * Version: Apache Tomcat/9.0.97
 * Generated at: 2024-12-20 07:33:23 UTC
 * Note: The last modified time of this file was set to
 *       the last modified time of the source file after
 *       generation to assist with modification tracking.
 */
package org.apache.jsp.WEB_002dINF.views.Board;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import java.util.List;
import com.spring.domain.Board;
import com.spring.domain.BoardLike;
import com.spring.domain.Member;

public final class Boards_jsp extends org.apache.jasper.runtime.HttpJspBase
    implements org.apache.jasper.runtime.JspSourceDependent,
                 org.apache.jasper.runtime.JspSourceImports {

  private static final javax.servlet.jsp.JspFactory _jspxFactory =
          javax.servlet.jsp.JspFactory.getDefaultFactory();

  private static java.util.Map<java.lang.String,java.lang.Long> _jspx_dependants;

  static {
    _jspx_dependants = new java.util.HashMap<java.lang.String,java.lang.Long>(1);
    _jspx_dependants.put("/WEB-INF/views/menu/menu.jsp", Long.valueOf(1734570015218L));
  }

  private static final java.util.Set<java.lang.String> _jspx_imports_packages;

  private static final java.util.Set<java.lang.String> _jspx_imports_classes;

  static {
    _jspx_imports_packages = new java.util.LinkedHashSet<>(4);
    _jspx_imports_packages.add("javax.servlet");
    _jspx_imports_packages.add("javax.servlet.http");
    _jspx_imports_packages.add("javax.servlet.jsp");
    _jspx_imports_classes = new java.util.LinkedHashSet<>(6);
    _jspx_imports_classes.add("java.util.List");
    _jspx_imports_classes.add("com.spring.domain.Board");
    _jspx_imports_classes.add("com.spring.domain.Member");
    _jspx_imports_classes.add("com.spring.domain.BoardLike");
  }

  private volatile javax.el.ExpressionFactory _el_expressionfactory;
  private volatile org.apache.tomcat.InstanceManager _jsp_instancemanager;

  public java.util.Map<java.lang.String,java.lang.Long> getDependants() {
    return _jspx_dependants;
  }

  public java.util.Set<java.lang.String> getPackageImports() {
    return _jspx_imports_packages;
  }

  public java.util.Set<java.lang.String> getClassImports() {
    return _jspx_imports_classes;
  }

  public javax.el.ExpressionFactory _jsp_getExpressionFactory() {
    if (_el_expressionfactory == null) {
      synchronized (this) {
        if (_el_expressionfactory == null) {
          _el_expressionfactory = _jspxFactory.getJspApplicationContext(getServletConfig().getServletContext()).getExpressionFactory();
        }
      }
    }
    return _el_expressionfactory;
  }

  public org.apache.tomcat.InstanceManager _jsp_getInstanceManager() {
    if (_jsp_instancemanager == null) {
      synchronized (this) {
        if (_jsp_instancemanager == null) {
          _jsp_instancemanager = org.apache.jasper.runtime.InstanceManagerFactory.getInstanceManager(getServletConfig());
        }
      }
    }
    return _jsp_instancemanager;
  }

  public void _jspInit() {
  }

  public void _jspDestroy() {
  }

  public void _jspService(final javax.servlet.http.HttpServletRequest request, final javax.servlet.http.HttpServletResponse response)
      throws java.io.IOException, javax.servlet.ServletException {

    if (!javax.servlet.DispatcherType.ERROR.equals(request.getDispatcherType())) {
      final java.lang.String _jspx_method = request.getMethod();
      if ("OPTIONS".equals(_jspx_method)) {
        response.setHeader("Allow","GET, HEAD, POST, OPTIONS");
        return;
      }
      if (!"GET".equals(_jspx_method) && !"POST".equals(_jspx_method) && !"HEAD".equals(_jspx_method)) {
        response.setHeader("Allow","GET, HEAD, POST, OPTIONS");
        response.sendError(HttpServletResponse.SC_METHOD_NOT_ALLOWED, "JSP들은 오직 GET, POST 또는 HEAD 메소드만을 허용합니다. Jasper는 OPTIONS 메소드 또한 허용합니다.");
        return;
      }
    }

    final javax.servlet.jsp.PageContext pageContext;
    final javax.servlet.ServletContext application;
    final javax.servlet.ServletConfig config;
    javax.servlet.jsp.JspWriter out = null;
    final java.lang.Object page = this;
    javax.servlet.jsp.JspWriter _jspx_out = null;
    javax.servlet.jsp.PageContext _jspx_page_context = null;


    try {
      response.setContentType("text/html; charset=UTF-8");
      pageContext = _jspxFactory.getPageContext(this, request, response,
      			null, false, 8192, true);
      _jspx_page_context = pageContext;
      application = pageContext.getServletContext();
      config = pageContext.getServletConfig();
      out = pageContext.getOut();
      _jspx_out = out;

      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("<!DOCTYPE html>\r\n");
      out.write("<html>\r\n");
      out.write("	");

		int pageNum = (Integer) request.getAttribute("pageNum");
	    int totalPage = (Integer) request.getAttribute("totalPage");
		System.out.println("JSP토탈페이지 : " +  totalPage);
		System.out.println("JSP페이지넘 : " + pageNum);
	
      out.write("\r\n");
      out.write("\r\n");
      out.write("<head>\r\n");
      out.write("<meta charset=\"UTF-8\">\r\n");
      out.write("<title>Insert title here</title>\r\n");
      out.write("</head>\r\n");
      out.write("<body>\r\n");
      out.write("	");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");

   HttpSession session = request.getSession(false);
   Member sessionId = null;
   String adminCheck = null;
   if(session != null){
      sessionId = (Member)session.getAttribute("sessionId");
      adminCheck = (String)sessionId.getNickName();
      System.out.println("게시글 작성 폼 세션 널아님!!");
      System.out.println("닉네임 : " + sessionId.getNickName());
      System.out.println("sessionIdCheck : " + sessionId != null);
      System.out.println("adminCheck : " + adminCheck.equals("admin"));
   }

      out.write("\r\n");
      out.write("\r\n");
      out.write("<div style=\"display:flex\">\r\n");
   if(sessionId != null && adminCheck.equals("admin")){ 
      out.write("\r\n");
      out.write("   <div id=\"menublock\">\r\n");
      out.write("      <a href=\"/FoodTrip/marker/test\">마커 생성</a>\r\n");
      out.write("      <a href=\"/FoodTrip/marker/readalljson\">마커 전체 가져오기</a>\r\n");
      out.write("      <a href=\"/FoodTrip/road/makeRoad\">코스 생성</a>\r\n");
      out.write("   </div>\r\n");
      out.write("   ");
} 
      out.write("\r\n");
      out.write("   <div id=\"menublock\">\r\n");
      out.write("      <a href=\"/FoodTrip/road/readRoad\">코스 전체보기</a>\r\n");
      out.write("      <a href=\"/FoodTrip/board/boards\">리뷰게시판</a>\r\n");
      out.write("   </div>\r\n");
      out.write("   <div id=\"menublock\">\r\n");
      out.write("      ");

      if(sessionId != null && sessionId.getNickName() != null && !sessionId.getNickName().isEmpty()){
      
      out.write("\r\n");
      out.write("         <a href=\"/FoodTrip/member/logout\">로그아웃</a>\r\n");
      out.write("         <a href=\"/FoodTrip/member/update\">회원정보수정</a>\r\n");
      out.write("      ");
}else{
      out.write("\r\n");
      out.write("         <a href=\"/FoodTrip/member/login\">로그인</a>\r\n");
      out.write("         <a href=\"/FoodTrip/member/email\">회원가입</a>\r\n");
      out.write("      ");
} 
      out.write("\r\n");
      out.write("   </div>\r\n");
      out.write("</div>");
      out.write("\r\n");
      out.write("	<div>전체</div>\r\n");
      out.write("	<div>\r\n");
      out.write("		<table border=\"1\">\r\n");
      out.write("			<tr>\r\n");
      out.write("				<th>번호</th>\r\n");
      out.write("				<th>제목</th>\r\n");
      out.write("				<th>작성자</th>\r\n");
      out.write("				<th>조회   |   좋아요</th>\r\n");
      out.write("				<th>작성날짜</th>\r\n");
      out.write("			</tr>\r\n");
      out.write("			");

			 	List<Board> brd = (List<Board>) request.getAttribute("boardList");
				for(int j=0; j<brd.size(); j++){
					Board notice = brd.get(j);
					long parent = notice.getParentNum();
					
			
      out.write("\r\n");
      out.write("						<tr>\r\n");
      out.write("							<td>");
      out.print(notice.getBrdNum() );
      out.write("</td>\r\n");
      out.write("							<td><a href=\"./BoardView?num=");
      out.print(notice.getBrdNum());
      out.write("&pageNum=");
      out.print(pageNum);
      out.write('"');
      out.write('>');
      out.print(notice.getTitle() );
      out.write("</a></td>\r\n");
      out.write("							<td>");
      out.print(notice.getNickName() );
      out.write("</td>\r\n");
      out.write("							<td><i class=\"fa-solid fa-users\"></i> ");
      out.print(notice.getViews() );
      out.write(" | <i class=\"fa-solid fa-heart\" style=\"color:pink\"></i>");
      out.print(notice.getLikes() );
      out.write("\r\n");
      out.write("							</td>\r\n");
      out.write("							<td>");
      out.print(notice.getCreateTime() );
      out.write("</td>\r\n");
      out.write("						</tr>\r\n");
      out.write("			");

				}
			
      out.write("\r\n");
      out.write("				</table>\r\n");
      out.write("				<div>\r\n");
      out.write("					");
for(int i=1; i<=totalPage; i++){
      out.write("\r\n");
      out.write("						<a href=\"/board/boards?pageNum=");
      out.print(i );
      out.write("\">\r\n");
      out.write("						");
if(pageNum == i){ 
      out.write("\r\n");
      out.write("							<font color='4C5317'><b>[");
      out.print(i );
      out.write("]</b></font>\r\n");
      out.write("						");
}else{ 
      out.write("\r\n");
      out.write("							<font color='4C5317'>[");
      out.print(i );
      out.write("]</font>\r\n");
      out.write("						");
} 
      out.write("\r\n");
      out.write("					</a>\r\n");
      out.write("				    ");
} 
      out.write("			\r\n");
      out.write("		</div>\r\n");
      out.write("		<div>\r\n");
      out.write("			<a href=\"./addBoard\">글쓰기</a>\r\n");
      out.write("		</div>\r\n");
      out.write("	</div>\r\n");
      out.write("	<!-- JavaScript for 댓글 AJAX -->\r\n");
      out.write("	<script src=\"https://code.jquery.com/jquery-3.6.0.min.js\"></script>\r\n");
      out.write("    <script src=\"/FoodTrip/resources/js/board.js?version=46\" type=\"text/javascript\"></script>\r\n");
      out.write("    <!-- Font Awesome -->\r\n");
      out.write("    <script src=\"https://kit.fontawesome.com/08b7540d84.js\" crossorigin=\"anonymous\"></script>\r\n");
      out.write("</body>\r\n");
      out.write("</html>");
    } catch (java.lang.Throwable t) {
      if (!(t instanceof javax.servlet.jsp.SkipPageException)){
        out = _jspx_out;
        if (out != null && out.getBufferSize() != 0)
          try {
            if (response.isCommitted()) {
              out.flush();
            } else {
              out.clearBuffer();
            }
          } catch (java.io.IOException e) {}
        if (_jspx_page_context != null) _jspx_page_context.handlePageException(t);
        else throw new ServletException(t);
      }
    } finally {
      _jspxFactory.releasePageContext(_jspx_page_context);
    }
  }
}
