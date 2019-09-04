<%@page import="vo.AlbumVO"%>
<%@page import="dao.AlbumDAO"%>
<%@page import="vo.MemberVO"%>
<%@page import="dao.MemberDAO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="vo.Contest_BoardVO"%>
<%@page import="dao.Contest_BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
<link href="micTestCss.css" rel="stylesheet" type="text/css">
<link href="micTest_myalbum_Css.css" rel="stylesheet" type="text/css">
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<link rel="stylesheet" href="/resources/demos/style.css">
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<script>
  	$( function() {
  		$( "#startdate" ).datepicker();
  	});
  
	$( function() {
		$( "#finishdate" ).datepicker();
	} );
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

<a class="me" href="https://codepen.io/uzcho_/pens/popular/?grid_type=list" target="_blank" style="color:#000"></a>
<div class="category"> 명단수정폼 </div>
<div class="progressform">
<form action="micTest_prgprocess.jsp">
<table class="pftable">
	<tr>
		<td> 시작날짜 </td>
		<td> <input type=text name="startdate" id="startdate" readonly></td>
	</tr>
	<tr>
		<td> 종료날짜 </td>
		<td> <input type=text name="finishdate" id="finishdate" readonly></td>
	</tr>
	<tr>
		<td> 라운드선택 </td>
		<td> <select name="round">
				<option value="2">2라운드</option>
				<option value="3">파이널라운드</option>
				<option value="4">우승자</option>
			 </select>
		</td>
	</tr>
	<tr>
		<td rowspan="2"> 진출자 명단 </td>
		<td rowspan="2"> <textarea name="names"></textarea></td>
	</tr>
	<tr>
	</tr>
	<tr>
		<td colspan="2" style="text-align: center;"> <input type=submit value='수정'> 
		<% String location = "micTest_progress.jsp"; %>
		&nbsp;&nbsp;&nbsp; <input type=button value='취소' onclick="location.href='<%=location %>'"></td>
	</tr>
</table>
</form>
</div>
<p>
<div style="display: inline;">
<!-- 1라운드 순위 -->
<table style="display: inline; float:left;  margin-left: 650px; margin-right: 100px; margin-top: 100px; color: #fff; border: solid 2px #fff; border-collapse: collapse; text-align: center;">
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
	for(int i=0; i<list1.size(); i++){
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
<table style="display: inline; float: left; margin-left: 100px; margin-right: 100px; margin-top: 100px; color: #fff; border: solid 2px #fff; border-collapse: collapse; text-align: center;">
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
	for(int i=0; i<list2.size(); i++){
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