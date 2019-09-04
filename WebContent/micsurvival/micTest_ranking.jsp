<%@page import="vo.AlbumVO"%>
<%@page import="dao.AlbumDAO"%>
<%@page import="vo.Contest_BoardVO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="dao.Contest_BoardDAO"%>
<%@page import="vo.MemberVO"%>
<%@page import="dao.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>Insert title here</title>
<link href="micTestCss.css" rel="stylesheet" type="text/css">
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

<p>
<div style="display: inline; ">
<!-- 1라운드 순위 -->
<table style="display: inline; float:left; margin-left: 100px; margin-top: 100px; color: #fff; border: solid 2px #fff; border-collapse: collapse; text-align: center;">
	<caption>1라운드 순위</caption>
	<tr>
		<th style="border: solid 2px #fff">순위</th>
		<th style="border: solid 2px #fff">닉네임</th>
		<th style="border: solid 2px #fff">부른 노래</th>
		<th style="border: solid 2px #fff">like</th>
	</tr>
	<%
	MemberDAO mdao = new MemberDAO();
	MemberVO mvo = null;
	Contest_BoardDAO cbdao = new Contest_BoardDAO();
	ArrayList<Contest_BoardVO> list1 = cbdao.getContest_BoardRankList(1);
	Contest_BoardVO cbvo = null;
	AlbumDAO adao = new AlbumDAO();
	AlbumVO avo = null;
	int size=10;
	if(list1.size()<10){
		size=list1.size();
	}
	for(int i=0; i<size; i++){
		cbvo = list1.get(i);
		mvo = mdao.getMember(cbvo.getWriter());	
		avo = adao.getAlbum(cbvo.getC_file());
	%>	
	<tr>
		<td style="border: solid 2px #fff"><%=i+1 %></td>
		<td style="border: solid 2px #fff"><%=mvo.getNickname() %></td>
		<td style="border: solid 2px #fff; width: 100px;"><%=avo.getFile_name() %></td>
		<td style="border: solid 2px #fff"><%=cbvo.getC_like() %></td>
	</tr>
	<%
	}
	%>
</table>

<!-- 2라운드 순위 -->
<table style="display: inline; float: left; margin-left: 250px; margin-top: 100px; color: #fff; border: solid 2px #fff; border-collapse: collapse; text-align: center;">
	<caption>2라운드 순위</caption>
	<tr>
		<th style="border: solid 2px #fff">순위</th>
		<th style="border: solid 2px #fff">닉네임</th>
		<th style="border: solid 2px #fff">부른 노래</th>
		<th style="border: solid 2px #fff">like</th>
	</tr>
	<%
	ArrayList<Contest_BoardVO> list2 = cbdao.getContest_BoardRankList(2);
	cbvo = null;
	size=10;
	if(list2.size()<10){
		size = list2.size();
	}
	for(int i=0; i<size; i++){
		cbvo = list2.get(i);
		mvo = mdao.getMember(cbvo.getWriter());	
		avo = adao.getAlbum(cbvo.getC_file());
	%>
	<tr>
		<td style="border: solid 2px #fff"><%=i+1 %></td>
		<td style="border: solid 2px #fff"><%=mvo.getNickname() %></td>
		<td style="border: solid 2px #fff; width: 100px;"><%=avo.getFile_name() %></td>
		<td style="border: solid 2px #fff"><%=cbvo.getC_like() %></td>
	</tr>
	<%
	}	
	%>
</table>
</div>
<%} %>
</body>
</html>