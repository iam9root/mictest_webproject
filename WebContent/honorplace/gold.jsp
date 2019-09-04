<%@page import="vo.goldVO"%>
<%@page import="dao.goldDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>

<head>
  <meta charset="UTF-8">
  <title>GOLDEN M.I.C.</title>
  <meta name="viewport" content="width=device-width, initial-scale=1"><link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/normalize/5.0.0/normalize.min.css">
<link rel="stylesheet" href="../honorplace/gold.css">
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

<div class="micking_title"><h1>제 1회 GOLDEN M.I.C. 주인공</h1>
	  </div>

<div class="album">
	<div class="wrapper">
	  <div class="hummingbird js-3dbox">
	    <div class="body">
	      <div class="back"></div>
	      <div class="head">
	      	<div class="nape"></div>
			<div class="beak"></div>
	      </div>
	    </div>
	    
	    <div class="platform">GOLDEN M.I.C.</div>
	    <!-- <div class="title2">GOLDEN M.I.C.</div> -->
	  </div>
	  <%
	  goldDAO gdao = new goldDAO();
	  goldVO gvo2 = gdao.goldMic();
	  /* golden mic 가져오기 */
	  String gm_name="";
	  String gmart_name="";
	  String gmmusic_name="";
	  String gmfile_name="";

	  gm_name=gvo2.getNick();
	  gmart_name=gvo2.getArtist_Name();
	  gmmusic_name=gvo2.getMusic_Name();
	  gmfile_name=gvo2.getFile_name();
	  %>
	  <div class="micking"><h2><%=gm_name %></h2>
	  <h3><%=gmart_name %> - <%=gmmusic_name %></h3>
	  
	  <audio src="../upload/<%=gmfile_name %>" controls> 이 브라우저는 HTML5를 지원하지 않습니다.</audio>
	  </div>
	</div>
	
</div>

</body>
</html>