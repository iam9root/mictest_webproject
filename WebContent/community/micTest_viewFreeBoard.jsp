<%@page import="vo.FreeBoardVO"%>
<%@page import="dao.FreeBoardDAO"%>
<%@ page import="java.sql.*" %> <!-- DB사용을 위한 import -->
<%@ page import="java.util.ArrayList" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시물 보기</title>
	<link href="micTest_freeboard_Css.css" rel="stylesheet" type="text/css">
<!-- 게시글을 보여주기 위한 DB연결 jsp -->
<%
	request.setCharacterEncoding("UTF-8");
	String dbdriver = "oracle.jdbc.driver.OracleDriver";
	String dburl = "jdbc:oracle:thin:@localhost:1521:xe";
	String dbid = "mic";
	String dbpw = "mic";
	
	//불러올 글번호를 받아와 글번호로 게시글 읽을 것임
	int idx = Integer.parseInt(request.getParameter("idx"));
	
	//vo객체 만들기
	FreeBoardDAO fbdao = new FreeBoardDAO(dbdriver, dburl, dbid, dbpw);
	ArrayList<FreeBoardVO> fblist = fbdao.viewBoard(idx);
	
%>
<!-- 보기 후 원래 게시판으로 연결 -->
<script type="text/javascript">
function gotoEachBoard(category) {
	if(category == 0) { //0이면 공지사항
		window.location = "mic_notice.jsp";
	} else if(category == 1) { //1이면 자유게시판
		window.location = "micTest_freeboard.jsp";
	} 
}
</script>

</head>
<body>
<%
//세션정보 받아오기
String sessionid = (String)session.getAttribute("sessionid");
if(sessionid==null){
	//세션정보가 없으면 로그인페이지로 이동
	out.println("<script>alert('세션이 종료되었습니다. 로그인페이지로 이동합니다.');</script>");
	response.sendRedirect("../login/loginForm.jsp");
} else{

%>
<a href="../home/micTest.jsp" style="text-decoration: none;">
<div class="text" id="main">
	M.I.C. TEST
</div>
</a>
<nav class="menu">
	<ol>
		<li class="menu-item"><a href="#0">M.I.C. Survival</a>
			<ol class="sub-menu">
				<li class="menu-item"><a href="../micsurvival/micTest_round.jsp?r=1">1 라운드</a></li>
				<li class="menu-item"><a href="../micsurvival/micTest_round.jsp?r=2">2 라운드</a></li>
				<li class="menu-item"><a href="../micsurvival/micTest_round.jsp?r=3">파이널 라운드</a></li>
				<li class="menu-item"><a href="../micsurvival/micTest_progress.jsp">진행사항</a></li>
			</ol>
		</li>
		<li class="menu-item"><a href="#0">명예의 전당</a>
			<ol class="sub-menu">
				<li class="menu-item"><a href="../honorplace/gold.jsp">Golden M.I.C.</a></li>
				<li class="menu-item"><a href="../honorplace/micTest_honor.jsp">파이널 진출자</a></li>
				<!-- <li class="menu-item"><a href="../honorplace/micTest_hot.jsp">H O T</a></li>
				<li class="menu-item"><a href="../honorplace/micTest_popuser.jsp">인기 사용자</a></li> -->
			</ol>
		</li>
		<li class="menu-item"><a href="#0">차트</a>
			<ol class="sub-menu">
				<li class="menu-item"><a href="https://www.melon.com/chart/" target="_blank">멜론 인기 차트</a></li>
				<li class="menu-item"><a href="../chart/micTest_micChart.jsp">M.I.C. 인기차트</a></li>
			</ol>
		</li>
		<li class="menu-item"><a href="#0">커뮤니티</a>
			<ol class="sub-menu">
				<li class="menu-item"><a href="../community/mic_notice.jsp">공지사항</a></li>
				<li class="menu-item"><a href="../community/micTest_freeboard.jsp">자유 게시판</a></li>
			</ol>
		</li>
		<li class="menu-item"><a href="#0">My Music</a>
			<ol class="sub-menu">
				<li class="menu-item"><a href="../mymusic/uploadForm.jsp">음악 업로드</a></li>
				<li class="menu-item"><a href="../mymusic/micTest_myalbum.jsp">나만의 앨범</a></li>
			</ol>
		</li>
		<li class="menu-item"><a href="#0">로그인</a>
			<ol class="sub-menu">
			<%
				if(sessionid == null){
			%>
				<li class="menu-item"><a href="../login/loginForm.jsp">로그인</a></li>
				<li class="menu-item"><a href="../login/joinForm.jsp">회원가입</a></li>
			<%} else {%>
				<li class="menu-item"><a href="../login/logout.jsp">로그아웃</a></li>
			<%}%>
			</ol>
		</li>
	</ol>
</nav>


<!-- 게시물 보기  -->
<div class="viewPage_wrap" align="center">
<%
		int seq =  fblist.get(0).getFree_board_seq();
		String title = fblist.get(0).getF_title();
		String writer = fblist.get(0).getWriter();
		String contents = fblist.get(0).getF_contents();
		int viewcount = fblist.get(0).getF_viewcount();
		String nickname = fblist.get(0).getNickname();
		int category = fblist.get(0).getCategory();
		System.out.println(category);
	%>
<% if (category == 0) { %>
	<h1 align="center" style="color: white; font-weight: bold;" >공지사항</h1>
<% } else if (category == 1) { %>
	<h1 align="center" style="color: white; font-weight: bold;" >자유게시판</h1>
<% } %>
<table class="viewtable">
	
	<tr>
	<td class="title" width="700px"><%= title %></td>
	<td class="writer" width="150px"><%= nickname %></td>
	<td class="viewcount" width="100px"><img src="../image/white_eye.png" width="20" height="20" align="center">  &nbsp;<%= viewcount %></td>
	</tr>
	<tr>
	<td class="contents" colspan="4" width="850px"><%= contents %></td>
	</tr>
</table>

<div class="viewPageButton"><!-- 목록보기 -->
	<input type=button value="목록" OnClick="gotoEachBoard(<%= category %>);">
	<input type=button value="수정" OnClick="window.location='micTest_boardModifyForm.jsp?idx=<%= seq %>&category=<%=category%>'">
	<input type=button value="삭제" OnClick="window.location='boarddeleteProcess.jsp?idx=<%= seq %>&category=<%=category%>'">
</div>
</div>
<%} %>
</body>
</html>