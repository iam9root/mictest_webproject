<%@page import="vo.FreeBoardVO"%>
<%@page import="dao.FreeBoardDAO"%>
<%@ page import="java.sql.*" %> <!-- DB사용을 위한 import -->
<%@ page import="java.util.ArrayList" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>글수정</title>
<script src="jquery-3.2.1.min.js"></script>
<link href="micTest_freeboard_Css.css" rel="stylesheet" type="text/css">

<!-- 아래 입력 양식 폼을 등록 jsp(boardInsertProcess.jsp)로 전달 -->
<script>
function modifyCheck() {
	var form = document.modifyForm; //form태그 name
	
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
<!-- 게시글을 보여주기 위한 DB연결 jsp -->
<%
	request.setCharacterEncoding("UTF-8");
	String dbdriver = "oracle.jdbc.driver.OracleDriver";
	String dburl = "jdbc:oracle:thin:@localhost:1521:xe";
	String dbid = "mic";
	String dbpw = "mic";
	
	//불러올 글번호를 받아와 글번호로 게시글 읽을 것임
	int idx = Integer.parseInt(request.getParameter("idx"));
	
	//vo객체 만들기
	FreeBoardDAO fbdao = new FreeBoardDAO(dbdriver, dburl, dbid, dbpw);
	ArrayList<FreeBoardVO> fblist = fbdao.viewBoard(idx);
	
%>
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

<!-- 자유게시판 글수정 -->

<div class="boardwrite_wrap" align="center">
<h1>글수정</h1>

<!-- 글쓰기 폼 -->
<form action="boardmodifyProcess.jsp" method="get" name="modifyForm">
<%-- <input type="hidden" name="board_id" value="${sessionScope.sessionID}"> --%>
<input type="hidden" name="idx" value="<%= idx %>">

<table>
<caption>글쓰기</caption>
	<colgroup>
		<col style="width:150px;">
		<col style="width:1000px;">
	</colgroup>
	<%
		int seq =  fblist.get(0).getFree_board_seq();
		String title = fblist.get(0).getF_title();
		String writer = fblist.get(0).getWriter();
		String contents = fblist.get(0).getF_contents();
		int viewcount = fblist.get(0).getF_viewcount();
		int category = fblist.get(0).getCategory();
	%>
	<tr>
		<td id="title">작성자</td>
		<%-- <td>${sessionScope.sessionID}</td> --%>
		<td>
		<%= writer %><input type="hidden" name="board_writer" value="<%= writer %>" size="100" maxlength="150" />
		</td>
	</tr>
	<tr>
		<td id="title">제목</td>
		<td>
		<input name="board_subject" type="text" size="100" maxlength="150" value="<%= title %>"/>
		</td>        
	</tr>
	<tr>
		<td id="title">내용</td>
		<td>
		<textarea name="board_content" cols="100px" rows="30px"><%= contents %></textarea>            
		</td>        
	</tr>
	<tr align="center" valign="middle">
		<td colspan="5">
			<input type="button" value="취소" OnClick="javascript:history.back(-1)"><!-- 뒤로가기 -->
			<input type="button" value="수정" id="boardmodify" OnClick="javascript:modifyCheck();">
		</td>
	</tr>
</table>  
<!-- category : 0이면 공지사항 / 1이면 자유게시판 -->
<input type="hidden" value="<%= category %>" name="category" id="category"/>
</form>
</div>
<%} %>
</body>
</html>