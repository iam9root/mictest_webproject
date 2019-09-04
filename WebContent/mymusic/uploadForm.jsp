<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="uploadForm.css" rel="stylesheet" type="text/css">
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


<div class="uploadform">

	<form action="upload.jsp" method="post" enctype="multipart/form-data" class="uploadform">
		
		가수 <br> <input type="text" name="artist"><br>
		앨범 이름 <br> <input type="text" name="albumname"><br>
		노래 제목 <br> <input type="text" name="musicname"><p>
		음악첨부 <p>
		<div class="filebox">
		<label for="ex_file">음악</label>
  		<input type="file" id="ex_file" name="file1"></div><br>
		앨범 이미지 첨부 <p>
		<div class="filebox">
		<label for="ex_file">앨범사진</label>
		<input type="file" id="ex_file" name="file2"></div><br>
		<br><br><br><br>
		<input type="submit" value="업로드">

	</form>


</div>

<%} %>
</body>
</html>