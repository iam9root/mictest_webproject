<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>회원가입</title>
    
    <link href="micTestCss.css" rel="stylesheet" type="text/css">
</head>

<body>
<%
//세션정보 받아오기
String sessionid = (String)session.getAttribute("sessionid");
if(sessionid==null){
} else{
	out.println("<script>alert('로그인 아이디: "+sessionid+"');</script>");
	
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

<div style="width:400px; color:#fff; border:solid 2px #fff; margin: auto; margin-top:300px;">
    <form action="joinresult.jsp" method="post" enctype="multipart/form-data" class="joinform">
    <table style="margin: auto; text-align: center;">
    	<tr>
    		<td style="padding: 10px;">이메일</td>
    		<td style="padding: 10px;"><input type="text" name="email" id="email"></td>
    	</tr>
    	<tr>
    		<td style="padding: 10px;">비밀번호</td>
    		<td style="padding: 10px;"><input type="password" name="pw" id="pw"></td>
    	</tr>
    	<tr>
    		<td style="padding: 10px;">닉네임</td>
    		<td style="padding: 10px;"> <input type="text" name="nickname" id="nickname"></td>
    	</tr>
    	<tr>
    		<td style="padding: 10px;">태어난 연도</td>
    		<td style="padding: 10px;"><input type="text" name="birth" id="birth"></td>
    	</tr>
    	<tr>
    		<td style="padding: 10px;">성별</td>
    		<td style="padding: 10px;"><input type="text" name="gender" id="gender"></td>
    	</tr>
    	<tr>
    		<td style="padding: 10px;">프로필사진</td>
    		<td style="padding: 10px;"><input type="file" name="profile" id="profile"></td>
    	</tr>
    	<tr>
    		<td style="padding: 10px;"><input type="submit" value="가입"></td>
    		<td style="padding: 10px;"><input type="button" value="취소" onclick="location.href='javascript:history.back()'"></td>
    	</tr>
    </table>
    </form>
</div>
</body>

</html>