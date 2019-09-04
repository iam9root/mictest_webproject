<%@page import="vo.AlbumVO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="dao.AlbumDAO"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>Insert title here</title>
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
<div class="category"> 참가신청 </div>

<div align="center">
<form action="micTest_joinRoundProcess.jsp" method="get">
<table style="border:solid 2px #fff; color: #fff;">
	<tr>
		<td>작성자</td>
		<td><input type="text" name="email" value="<%=sessionid %>" readonly></td>		
	</tr>
	<tr>
		<td>제목</td>
		<td><input type="text" name="subject"></td>		
	</tr>
	<tr>
		<td>내용</td>
		<td><textarea name="contents"></textarea></td>		
	</tr>
	<tr>
		<td>파일선택</td>	<!-- 업로드한 파일중.. -->
		<td><select name="fileseq">
<%
	AlbumDAO adao = new AlbumDAO();
	ArrayList<AlbumVO> list = adao.getAlbumList(sessionid);
	for(int i=0; i<list.size();i++){
		out.println("<option value="+list.get(i).getFile_seq()+">"+list.get(i).getFile_title()+"</option>");
	}
%>
			</select></td>		
	</tr>
	<% if(list.size()!=0){ %>
	<tr>
		<td colspan="2" style="text-align: center"><input type="submit" value="확인">
			<input type="button" value="취소" onclick="location.href='javascript:history.back()'"></td>
	</tr>
	<%} %>
</table>
</form>
</div>
</body>
</html>