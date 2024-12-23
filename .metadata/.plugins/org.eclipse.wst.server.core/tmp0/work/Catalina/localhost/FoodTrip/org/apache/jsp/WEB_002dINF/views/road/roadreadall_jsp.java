/*
 * Generated by the Jasper component of Apache Tomcat
 * Version: Apache Tomcat/9.0.97
 * Generated at: 2024-12-23 00:13:03 UTC
 * Note: The last modified time of this file was set to
 *       the last modified time of the source file after
 *       generation to assist with modification tracking.
 */
package org.apache.jsp.WEB_002dINF.views.road;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import com.spring.domain.Member;

public final class roadreadall_jsp extends org.apache.jasper.runtime.HttpJspBase
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
    _jspx_imports_classes = new java.util.LinkedHashSet<>(2);
    _jspx_imports_classes.add("com.spring.domain.Member");
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
      out.write("<!DOCTYPE html>\r\n");
      out.write("<html>\r\n");
      out.write("<head>\r\n");
      out.write("<meta charset=\"UTF-8\">\r\n");
      out.write("<title>Insert title here</title>\r\n");
      out.write("<link rel=\"stylesheet\" href=\"/FoodTrip/resources/css/menu.css\"/>\r\n");
      out.write("<style>\r\n");
      out.write("   .contain{\r\n");
      out.write("      display:flex;\r\n");
      out.write("   }\r\n");
      out.write("</style>\r\n");
      out.write("</head>\r\n");
      out.write("<body>\r\n");
      out.write("   ");
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
      out.write("<div class=\"contain\">\r\n");
      out.write("   <div id=map style=\"width:100%;height:550px;\">\r\n");
      out.write("      <!-- 지도 공간  -->\r\n");
      out.write("      \r\n");
      out.write("   </div>\r\n");
      out.write("   <!-- 코스 리스트 -->\r\n");
      out.write("   <div>\r\n");
      out.write("      <h2>생성되어 있는 코스</h2>\r\n");
      out.write("      <ul id=\"placesList\">\r\n");
      out.write("      \r\n");
      out.write("      </ul>\r\n");
      out.write("   </div>\r\n");
      out.write("</div>\r\n");
      out.write("   <script src=\"http://code.jquery.com/jquery-latest.min.js\"></script>\r\n");
      out.write("   <script type=\"text/javascript\" src=\"//dapi.kakao.com/v2/maps/sdk.js?appkey=a8fb3e9990ea2c741f7c154e957f99be\"></script>\r\n");
      out.write("   <script type=\"text/javascript\">\r\n");
      out.write("   var courseObj=[];\r\n");
      out.write("   var markers = [];\r\n");
      out.write("   var sw = new kakao.maps.LatLng(35.0966621, 128.4888436),\r\n");
      out.write("      ne = new kakao.maps.LatLng(35.3108556, 128.8502120);\r\n");
      out.write("   \r\n");
      out.write("   var session = \"");
      out.print(sessionId );
      out.write("\";\r\n");
      out.write("   console.log(session);\r\n");
      out.write("   var admin = \"");
      out.print(adminCheck);
      out.write("\";\r\n");
      out.write("   console.log(admin);\r\n");
      out.write("   //var userNick = session.getNickName();\r\n");
      out.write("   //console.log(userNick);\r\n");
      out.write("   var listEl = document.querySelector('#placesList');\r\n");
      out.write("   // 지도 출력을 위한 기본적인 코드 -------- START\r\n");
      out.write("   var mapContainer = document.getElementById('map'), // 지도를 표시할 div \r\n");
      out.write("       mapOption = { \r\n");
      out.write("           center: new kakao.maps.LatLng(35.2538433, 128.6402609), // 지도의 중심좌표\r\n");
      out.write("           level: 9 // 지도의 확대 레벨\r\n");
      out.write("       };\r\n");
      out.write("   \r\n");
      out.write("   // 지도를 표시할 div와  지도 옵션으로  지도를 생성합니다\r\n");
      out.write("   var map = new kakao.maps.Map(mapContainer, mapOption); \r\n");
      out.write("   // 지도 출력을 위한 기본적인 코드 -------- END\r\n");
      out.write("   \r\n");
      out.write("   getAllRoad();\r\n");
      out.write("      \r\n");
      out.write("   // 처음 요청을 보내 모든 코스정보를 받아오는 함수\r\n");
      out.write("   function getAllRoad(){\r\n");
      out.write("      $.ajax({\r\n");
      out.write("         url : \"readRoad\",\r\n");
      out.write("         type : \"post\", \r\n");
      out.write("         success : function(response){\r\n");
      out.write("            courseObj = response;\r\n");
      out.write("            console.log(courseObj);\r\n");
      out.write("            addList();\r\n");
      out.write("         }\r\n");
      out.write("         \r\n");
      out.write("      });\r\n");
      out.write("   }\r\n");
      out.write("   \r\n");
      out.write("   function sendChoiceCourse(){\r\n");
      out.write("      $.ajax({\r\n");
      out.write("         url : \"selectRoad\",\r\n");
      out.write("         type : \"post\",\r\n");
      out.write("         data : JSON.stringify(),\r\n");
      out.write("         contentType : \"application/json\", \r\n");
      out.write("         success : function(response){\r\n");
      out.write("            alert(\"코스 생성 및 저장완료\");\r\n");
      out.write("         }\r\n");
      out.write("      });\r\n");
      out.write("   }\r\n");
      out.write("   \r\n");
      out.write("   //리스트에 코스를 표시하는 함수\r\n");
      out.write("   function addList(){\r\n");
      out.write("      //courseObj : 요청에 대한 응답 json 배열      \r\n");
      out.write("      for(var i=0; i<courseObj.length; i++){\r\n");
      out.write("         \r\n");
      out.write("         (function(index){\r\n");
      out.write("            var data = courseObj[index];\r\n");
      out.write("            //console.log(data);\r\n");
      out.write("         //   var courseAry = data.points;\r\n");
      out.write("            var courseName = [];\r\n");
      out.write("            for(var j=0; j<data.points.length; j++){\r\n");
      out.write("               courseName[j] = data.points[j].pointName;\r\n");
      out.write("            }\r\n");
      out.write("            var courseString = courseName.join(\" -> \");\r\n");
      out.write("            //console.log(courseAry);\r\n");
      out.write("            var list = document.createElement('li');\r\n");
      out.write("            list.setAttribute(\"id\", \"cslist\");\r\n");
      out.write("            list.innerHTML = '<div>'+data.category+'</div><br><div>'\r\n");
      out.write("                            +data.description+'</div><br><h3>코스</h3><div>'\r\n");
      out.write("                            + courseString +'</div><br>'   \r\n");
      out.write("                         if(session != null && admin === \"admin\"){            \r\n");
      out.write("                               list.innerHTML += '<div><a href=\"/FoodTrip/road/roadUpdate?id='\r\n");
      out.write("                               +data.roadId+'\">수정</a><a href=\"/FoodTrip/road/roadDelete?id='\r\n");
      out.write("                               +data.roadId+'\">삭제</a></div>'\r\n");
      out.write("                         }else if(session != null && admin !== \"admin\"){\r\n");
      out.write("                            //선택하는 html 태그 추가   \r\n");
      out.write("                            list.innerHTML += '<button class=\"chbtn\" onclick=\"choiceCourse('+'");
      out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${data.roadId}", java.lang.String.class, (javax.servlet.jsp.PageContext)_jspx_page_context, null));
      out.write("'+')\">코스 선택</button>'\r\n");
      out.write("                         }\r\n");
      out.write("            /*\r\n");
      out.write("            list.innerHTML = '<div>'+data.category+'</div><br><div>'\r\n");
      out.write("                        +data.description+'</div><br><h3>코스</h3><div>'\r\n");
      out.write("                        + courseString +'</div><br>'\r\n");
      out.write("                        +'<div><a href=\"/FoodTrip/road/roadUpdate?id='\r\n");
      out.write("                        +data.roadId+'\">수정</a><a href=\"/FoodTrip/road/roadDelete?id='\r\n");
      out.write("                        +data.roadId+'\">삭제</a></div>';\r\n");
      out.write("            */\r\n");
      out.write("            list.addEventListener(\"click\", function(){\r\n");
      out.write("               viewMarker(data);               \r\n");
      out.write("            });\r\n");
      out.write("            listEl.appendChild(list);\r\n");
      out.write("         })(i);\r\n");
      out.write("         \r\n");
      out.write("      }\r\n");
      out.write("   }\r\n");
      out.write("   \r\n");
      out.write("   //코스 리스트를 클릭하면 마커가 지도에 보이게\r\n");
      out.write("   function viewMarker(data){ \r\n");
      out.write("      //console.log(data);\r\n");
      out.write("      //console.log(data.points);\r\n");
      out.write("      markerRemove();\r\n");
      out.write("      var bounds = new kakao.maps.LatLngBounds(); \r\n");
      out.write("      for(var i=0; i<data.points.length; i++){\r\n");
      out.write("         (function(index){   \r\n");
      out.write("            var ary = data.points;\r\n");
      out.write("            \r\n");
      out.write("             bounds = new kakao.maps.LatLngBounds(), \r\n");
      out.write("             listStr = '';\r\n");
      out.write("          \r\n");
      out.write("             var placePosition = new kakao.maps.LatLng(ary[index].pointY, ary[index].pointX);\r\n");
      out.write("            // console.log(ary[i]);\r\n");
      out.write("\r\n");
      out.write("             var imageSrc = 'https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/marker_number_blue.png', // 마커 이미지 url, 스프라이트 이미지를 씁니다\r\n");
      out.write("                 imageSize = new kakao.maps.Size(36, 37),  // 마커 이미지의 크기\r\n");
      out.write("                 imgOptions =  {\r\n");
      out.write("                     spriteSize : new kakao.maps.Size(36, 691), // 스프라이트 이미지의 크기\r\n");
      out.write("                     spriteOrigin : new kakao.maps.Point(0, (index*46)+10), // 스프라이트 이미지 중 사용할 영역의 좌상단 좌표\r\n");
      out.write("                     offset: new kakao.maps.Point(13, 37) // 마커 좌표에 일치시킬 이미지 내에서의 좌표\r\n");
      out.write("                 },\r\n");
      out.write("                 markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize, imgOptions),\r\n");
      out.write("                     marker = new kakao.maps.Marker({\r\n");
      out.write("                     position: placePosition, // 마커의 위치\r\n");
      out.write("                     image: markerImage \r\n");
      out.write("                 });\r\n");
      out.write("               //console.log(map);\r\n");
      out.write("                marker.setMap(map); // 지도 위에 마커를 표출합니다\r\n");
      out.write("                markers.push(marker);  // 배열에 생성된 마커를 추가합니다\r\n");
      out.write("\r\n");
      out.write("             bounds.extend(placePosition);   \r\n");
      out.write("         })(i);\r\n");
      out.write("      }\r\n");
      out.write("      \r\n");
      out.write("      //마지막 시점전환\r\n");
      out.write("      bounds = new kakao.maps.LatLngBounds(sw, ne); \r\n");
      out.write("      map.setBounds(bounds);\r\n");
      out.write("   }\r\n");
      out.write("   \r\n");
      out.write("   //모든 마커 지우기 -- 마커 refresh\r\n");
      out.write("   function markerRemove(){\r\n");
      out.write("      console.log(\"rm IN\");\r\n");
      out.write("      for ( var i = 0; i < markers.length; i++ ) {\r\n");
      out.write("         markers[i].setMap(null);\r\n");
      out.write("         //useMarker[i].setMap(null);\r\n");
      out.write("         //console.log(userMarker);\r\n");
      out.write("       }\r\n");
      out.write("      markers = [];\r\n");
      out.write("   }\r\n");
      out.write("   \r\n");
      out.write("   //사용자가 선택했을 때 로드의 정보를 읽어야한다.\r\n");
      out.write("   function choiceCourse(id){\r\n");
      out.write("      console.log(id);\r\n");
      out.write("   }\r\n");
      out.write("   \r\n");
      out.write("   </script>\r\n");
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