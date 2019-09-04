<%@page import="vo.MemberVO"%>
<%@page import="dao.MemberDAO"%>
<%@page import="vo.ReplyVO"%>
<%@page import="dao.ReplyDAO"%>
<%@page import="vo.AlbumVO"%>
<%@page import="dao.AlbumDAO"%>
<%@page import="vo.Contest_BoardVO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="dao.Contest_BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>Insert title here</title>
<link href="micTest_myalbum_Css.css" rel="stylesheet" type="text/css">
<link href="micTest_listenmusic_Css.css" rel="stylesheet" type="text/css">
</head>
<body>

<%
//세션정보 받아오기
String sessionid = (String)session.getAttribute("sessionid");
if(sessionid==null){
	//세션정보가 없으면 로그인페이지로 이동
	out.println("<script>alert('세션이 종료되었습니다. 로그인페이지로 이동합니다.');</script>");
	response.sendRedirect("../login/loginForm.jsp");
}

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
<div class="category">  </div>
<%
//contestNo 파라미터(db에선 contest_seq) 받아오기
int file_seq = Integer.parseInt(request.getParameter("file_seq"));

AlbumDAO adao = new AlbumDAO();
AlbumVO avo = adao.getAlbum(file_seq);
%>

<div class="firstsection">
	<div style="display: inline;">
		<div class="img" style="width: 500px; display:inline; float:left;">
			<img src="../upload/<%=avo.getAlbum_name()%>" style="width: 300px; height: 300px; margin-left: 50px;" />
		</div>
	
		<div style="display:inline; float:left;">
			<table style="text-align: center;">
				<tr>
					<td><br><br></td>
				</tr>
				<tr>
					<td style="padding: 10px;"><audio controls src='../upload/<%=avo.getFile_name() %>'></audio></td>
				</tr>
				<tr>
					<td>
					<%
						out.println(avo.getFile_title()+"<br><br>");
						out.println(avo.getFile_singer()+"</p>");
					%></td>
				</tr>				
			</table>
		</div>
	</div>

</div>
</body>
</html>