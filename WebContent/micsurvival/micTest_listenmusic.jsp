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
<meta charset="EUC-KR">
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
int contestNo = Integer.parseInt(request.getParameter("contestNo"));
String lc = request.getParameter("lc");

Contest_BoardDAO cbdao = new Contest_BoardDAO();
//viewcount++
if(lc.equals("false")){
	cbdao.setViewcount(contestNo);
}
//contest_board테이블에서 시퀀스에 맞는 정보들 가져오기
Contest_BoardVO cbvo = cbdao.getContest_Board(contestNo);


//file_seq가 cbvo.getC_file()에 맞는 파일경로를 알아오기 위해
AlbumDAO adao = new AlbumDAO();
AlbumVO avo = adao.getAlbum(cbvo.getC_file());
%>

<div class="firstsection">
	<div style="display: inline;">
		<div class="img" style="width: 500px; display:inline; float:left;">
			<img src="../upload/<%=avo.getAlbum_name()%>" style="width: 300px; height: 300px; margin-left: 50px;" />
		</div>
	
		<div style="display:inline; float:left;">
			<table style="text-align: center;">
				<tr>
					<td><img src='../image/white_eye.png' width='10px' height='20px'> <%=cbvo.getC_viewcount()%>&nbsp;&nbsp;&nbsp;
						<img src='../image/white_like.png' width='20px' height='20px'> <%=cbvo.getC_like() %>&nbsp;&nbsp;					
						<input type=button name="c_like" value="like" onclick="location.href='addC_like.jsp?contestNo=<%=cbvo.getContest_seq() %>&writer=<%=cbvo.getWriter() %>'"></td>
				</tr>
				<tr>
					<td style="padding: 10px;"><audio controls src='../upload/<%=avo.getFile_name() %>'></audio></td>
				</tr>
				<tr>
					<td>
					<%
						out.println(cbvo.getC_title()+"<br><br>");
						out.println(cbvo.getC_contents()+"<br><br>");
						out.print("<p class='wd'>"+cbvo.getWriter()+"&nbsp;&nbsp;&nbsp;");
						out.println(cbvo.getCdate()+"</p>");
					%></td>
				</tr>				
			</table>
		</div>
	</div>

</div>

<div class="secondsection">
<%
ReplyDAO rdao = new ReplyDAO();
ArrayList<ReplyVO> list = rdao.getReply(0, contestNo);
//int count = rdao.getCount(0,contestNo);

MemberDAO mdao = new MemberDAO();
MemberVO mvo = null;
%>
	<p style="margin: 50px;"> 댓글(<%=list.size() %>)</p>
	<div class='writereply'>
	<form action="ReplyProcess.jsp">
		<input type=hidden name="contestNo" value="<%=contestNo %>">
		<input type=hidden name="c_0_f_1" value="0">	
		
		<table style="border: solid #fff; padding: 10px; margin: auto;">
			<tr>
				<td rowspan="2">
				<%
				mvo=mdao.getMember(sessionid);
				if(mvo.getProfile_img()==null){
				%>
					<img src="../image/man-singing.png">
				<%
				} else{
				%>
					<img src="../upload/<%=mvo.getProfile_img() %>">
				<%
				}
				%>
				</td>
				<td><textarea rows="3" cols="100" name="cm_contents"></textarea></td>			
				<td><input type=submit value="입력"></td>
			</tr>
		</table>
	</form>
	</div>
	
	<div class="allreply">
		<table>
<%
		for(int i=0; i<list.size(); i++){	
			ReplyVO vo = list.get(i);
			mvo = mdao.getMember(vo.getWriter());
%>
			<tr>			
				<td rowspan="2" style="padding: 10px;">
			<%		if(mvo.getProfile_img()==null){		%>
					<img src="../image/man-singing.png">
			<%		} else {						
			%>
					<img src="../upload/<%=mvo.getProfile_img() %>">
			<%		}	%>
				</td>
				<td class="writer" style="padding: 10px;"><%=mvo.getNickname() %></td>
				<td rowspan="2" class="date" style="width: 200px; padding-right: 10px;"><%=vo.getCmdate() %></td>
			</tr>
			<tr>
				<td class="contents" style="width: 1000px; padding: 10px; text-align: left;"><%=vo.getCm_contents() %></td>
			</tr>
<%
		}
%>
		</table>
	</div>
</div>
</body>
</html>