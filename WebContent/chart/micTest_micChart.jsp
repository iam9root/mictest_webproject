<%@page import="vo.MelMusicVO"%>
<%@page import="dao.MelMusicDAO"%>
<%@ page import="java.sql.*" %> <!-- DB사용을 위한 import -->
<%@ page import="java.util.ArrayList" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>M.I.C. 인기차트</title>
<link href="micChart.css" rel="stylesheet" type="text/css">
<script src="jquery-3.2.1.min.js"></script>

<!-- 인기차트용 mel_music DB연결 jsp -->
<%
	request.setCharacterEncoding("UTF-8");
	String dbdriver = "oracle.jdbc.driver.OracleDriver";
	String dburl = "jdbc:oracle:thin:@localhost:1521:xe";
	String dbid = "mic";
	String dbpw = "mic";
	
	//vo객체 만들기
	MelMusicDAO mmdao = new MelMusicDAO(dbdriver, dburl, dbid, dbpw);
	ArrayList<MelMusicVO> mmlist = mmdao.popularChart();
	
%>
</head>
<body>

<%
//세션정보 받아오기
String sessionid = (String)session.getAttribute("sessionid");

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

<!-- M.I.C. 인기차트 (10개까지만 보여줄 예정) -->
<div class="micChart_wrap" align="center">
<h1 align="center">M.I.C. 인기차트 리스트 TOP10</h1>
<table width="1000px";>
	<caption>mic 인기차트 리스트</caption>
	<colgroup>
		<col style="width:70px;">
		<col style="width:80px;">
		<col style="width:120px;">
		<col style="width:100px;">
		<col style="width:180px;">
		<col style="width:100px;">
	</colgroup>
	<thead>
	<tr>
		<th>순위</th>
		<th colspan="2">곡제목</th>
		<th>가수명</th>
		<th>앨범</th>
		<th>부른사람수</th>
	</tr>
	</thead>
	<tbody class="chartbody">
	<%
		/* 인기차트 가져오기!!! */
		//int music_seq = 0;
		String real_title = "";
		String real_singer = "";
		String real_album = "";
		int numberofsingusers = 0;
		for(int i=0; i<mmlist.size(); i++) {
			if(i == 10) break;
			//music_seq = mmlist.get(i).getMusic_seq();
			real_title = mmlist.get(i).getReal_title();
			real_singer = mmlist.get(i).getReal_singer();
			real_album = mmlist.get(i).getReal_album();
			numberofsingusers = mmlist.get(i).getNumberofsingusers();
			//앨범이미지를 보여주기 위한 작업
			String[] splitarray = real_album.split(" - ");
			%>
			<tr>
				<td><%= i+1 %></td>
				<td><img alt="no image" src="../album_image/<%= splitarray[0] %>.jpg" onError="this.src='../album_image/no_image.png'" width="70px" height="50px"></td>
				<td><%= real_title %></td>
				<td><%= real_singer %></td>
				<td><%= real_album %></td>
				<td><%= numberofsingusers %></td>
			</tr>
			<%
		}
	%>
	</tbody>
</table>
</div>

</body>
</html>