<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>자유게시판 글쓰기</title>
<script src="jquery-3.2.1.min.js"></script>

<!-- 아래 입력 양식 폼을 등록 jsp(boardInsertProcess.jsp)로 전달 -->
<script>
function writeCheck() {
	var form = document.writeForm; //form태그 name
	
	if(!form.board_subject.value) {//form태그에 name속성값이 비어있을 때 
		alert("제목이 입력되지 않았습니다."); //경고창 띄움
		form.board_subject.focus(); //form에 포커스
		return;
	}
	if(!form.board_content.value) {
		alert("내용이 입력되지 않았습니다.");
		form.board_content.focus();
		return;
	}
	
	//form 전달
	form.submit();
}
</script>

<link href="micTest_freeboard_Css.css" rel="stylesheet" type="text/css">

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

<!-- 자유게시판 글쓰기 -->

<div class="boardwrite_wrap" align="center">
<h1>글쓰기</h1>

<!-- 글쓰기 폼 -->
<form action="boardInsertProcess.jsp" method="get" name="writeForm">
<%-- <input type="hidden" name="board_id" value="${sessionScope.sessionID}"> --%>
<table>
<caption>글쓰기</caption>
	<colgroup>
		<col style="width:150px;">
		<col style="width:1000px;">
	</colgroup>
	<tr>
		<td id="title">작성자</td>
		<%-- <td><%= sessionid %></td> --%>
		<td>
		<input name="board_writer" type="hidden" size="100" maxlength="150" value="<%= sessionid %>" /><%= sessionid %>
		</td>
	</tr>
	<tr>
		<td id="title">제목</td>
		<td>
		<input name="board_subject" type="text" size="100" maxlength="150"/>
		</td>        
	</tr>
	<tr>
		<td id="title">내용</td>
		<td>
		<textarea name="board_content" cols="100px" rows="30px"></textarea>            
		</td>        
	</tr>
	<tr align="center" valign="middle">
		<td colspan="5">
			<input type="button" value="전체지우기" >
			<input type="button" value="확인" id="boardinsert" OnClick="javascript:writeCheck();">
		</td>
	</tr>
</table>  
<!-- category : 1이면 자유게시판 -->
<input type="hidden" value="1" name="category"/>  
</form>
</div>
<%} %>
</body>
</html>