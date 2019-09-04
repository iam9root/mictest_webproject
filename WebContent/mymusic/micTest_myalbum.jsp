<%@page import="vo.MemberVO"%>
<%@page import="dao.MemberDAO"%>
<%@page import="vo.AlbumVO"%>
<%@page import="dao.AlbumDAO"%>
<%@page import="java.sql.*" %> <!-- DB사용을 위한 import -->
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>나만의 앨범</title>

<link href="micTest_myalbum_Css.css" rel="stylesheet" type="text/css">

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

<!-- This is not part of Pen -->
<a class="me" href="https://codepen.io/uzcho_/pens/popular/?grid_type=list" target="_blank" style="color:#000"></a>

<div class="album">
<h1>나만의 앨범</h1>
<%
request.setCharacterEncoding("UTF-8");
AlbumDAO adao = new AlbumDAO();
ArrayList<AlbumVO> percentlist = adao.getSingerPercent(sessionid);

double eachPercent = 0;
String eachSinger = "";
%>
<h4>
<%
for (int i=0; i<percentlist.size(); i++) {
	eachPercent = percentlist.get(i).getCountEachSinger();
	eachSinger = percentlist.get(i).getFile_singer();
	System.out.println(eachPercent + " : " + eachSinger);
	%>
	[<%= eachPercent%>% &nbsp; <%= eachSinger %>]&nbsp; 
<%
}
%>
를 소유한 당신입니다. </h4>

<!-- <h4>[30% 박효신] [30% 버스커 버스커] 를 소유한 당신입니다. </h4> -->
<!-- album 테이블에서 데이터 가져오기 -->
<%
request.setCharacterEncoding("UTF-8");
//AlbumDAO adao = new AlbumDAO();
ArrayList<AlbumVO> alist = adao.getAlbumList(sessionid);

String album_name = "";
String file_title = "";
String file_singer = "";
int file_seq = 0;
for (int i=0; i<alist.size(); i++) {
	album_name = alist.get(i).getAlbum_name();
	file_title = alist.get(i).getFile_title();
	file_singer = alist.get(i).getFile_singer();
	file_seq = alist.get(i).getFile_seq();
	%>
	<div class="album-item">
		<div><img class="myalbumImg" alt="myAlbum" src="../upload/<%= album_name %>" onerror="../image/no_image.png"></div>
		<div><h5><a href="micTest_listenmyalbum.jsp?file_seq=<%=file_seq %>"><%= file_title %></a></h5></div>
		<div><h5><%= file_singer %></h5></div>
	</div>
	<%
}
%>

</div>

<%} %>

</body>
</html>