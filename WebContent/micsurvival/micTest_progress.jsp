<%@page import="vo.MemberVO"%>
<%@page import="dao.MemberDAO"%>
<%@page import="vo.EntrantVO"%>
<%@page import="dao.EntrantDAO"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
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

<a class="me" href="https://codepen.io/uzcho_/pens/popular/?grid_type=list" target="_blank" style="color:#000"></a>
<div class="category"> 진출자 명단 </div>

<div class="progress">
<!-- 관리자일 경우만 버튼 보임 -->
<%
MemberDAO mdao = new MemberDAO();
MemberVO mvo = mdao.getMember(sessionid);

int user_level=mvo.getUser_level();

if(user_level==1){
	out.print("<input type=button value='명단 수정' onclick=\"location.href='micTest_progressform.jsp'\">");	
	out.print("<input type=button value='라운드 적용' onclick=\"location.href='rankingProcess.jsp'\">");
}
%>
<p>
<%
EntrantDAO edao = new EntrantDAO();
EntrantVO evo2 = edao.getEntrant(2);
EntrantVO evo3 = edao.getEntrant(3);
EntrantVO evo4 = edao.getEntrant(4);

if(evo2==null || evo3==null || evo4==null){
%>
	진출자가 없습니다.
<%
} else {
%>
<%=evo2.getStartdate() %> ~ <%=evo2.getFinishdate() %> <br><br><br><br>
2라운드 진출자는 <%=evo2.getNames() %>입니다.<br><br>
파이널라운드 진출자는 <%=evo3.getNames() %>입니다.<br><br>
우승자는 <%=evo4.getNames() %>입니다.<br>

</p>

<%} %>

</div>
<%} %>
</body>
</html>
