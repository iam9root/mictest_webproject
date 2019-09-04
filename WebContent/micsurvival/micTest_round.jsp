<%@page import="vo.MemberVO"%>
<%@page import="dao.MemberDAO"%>
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
<meta charset="EUC-KR">
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

<%
int round = Integer.parseInt(request.getParameter("r"));
%>

<!-- This is not part of Pen -->
<a class="me" href="https://codepen.io/uzcho_/pens/popular/?grid_type=list" target="_blank" style="color:#000"></a>
<div class="category"> 
<%
if(round==3){
	out.println("파이널라운드");
} else {
	out.println(round+"라운드");
}
%>
 </div>
<%
MemberDAO mdao = new MemberDAO();
MemberVO mvo = mdao.getMember(sessionid);
if((round==1) && (mvo.getUser_level()==0)){
%>
<div class='joinRound'> <input type=button name="joinRound" value="참가하기" onclick="location.href='micTest_joinRound.jsp'"></div>
<%
}
%>
<div class="album">
<%
//contest_board 테이블의 데이터 가져오기
Contest_BoardDAO cbdao = new Contest_BoardDAO();
AlbumDAO adao = new AlbumDAO();
ArrayList<Contest_BoardVO> cblist = cbdao.getContest_BoardList(round);

for(int i=0; i<cblist.size();i++){
	Contest_BoardVO vo = cblist.get(i);
	AlbumVO avo = adao.getAlbum(vo.getC_file());System.out.println(avo.getAlbum_name());
	
	out.println("<div class='album-item'>");
		out.println("<div class='img'>");
			out.println("<img class='roundImg' src='../upload/"+avo.getAlbum_name()+"'>");
		out.println("</div>");
		
		out.println("<div class='contents'>");
			out.println("<a href='micTest_listenmusic.jsp?contestNo="+vo.getContest_seq()+"&lc=false'>"+vo.getC_title()+"<br><br>"+vo.getC_contents()+"</a>");
		out.println("</div>");
		out.println("<div class='count' align='right'>");
			out.print("<h5><img src='../image/black_eye.png' width='20px' height='20px'> " + vo.getC_viewcount());
			out.println("&nbsp;&nbsp;&nbsp;<img src='../image/like.png' width='20px' height='20px'> " + vo.getC_like() + "</h5>");
		out.println("</div>");
		
	out.println("</div>");
}
}
%>

</div>
</body>
</html>