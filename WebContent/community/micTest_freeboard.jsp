<%@page import="vo.FreeBoardVO"%>
<%@page import="dao.FreeBoardDAO"%>
<%@ page import="java.sql.*" %> <!-- DB사용을 위한 import -->
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.text.SimpleDateFormat,java.util.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>자유게시판</title>

<link href="micTest_freeboard_Css.css" rel="stylesheet" type="text/css">
<script type="text/javascript">
function boardWriteForm() {
	location.href="micTest_boardWriteForm.jsp";
}
</script>

<%
	request.setCharacterEncoding("UTF-8");
	String dbdriver = "oracle.jdbc.driver.OracleDriver";
	String dburl = "jdbc:oracle:thin:@localhost:1521:xe";
	String dbid = "mic";
	String dbpw = "mic";
	
	Class.forName(dbdriver);
	Connection conn = DriverManager.getConnection(dburl, dbid, dbpw);

	///////////////////////// paging 처리 /////////////////////////////
	final int ROWSIZE = 10;	//한페이지에 보일 게시물 수
	final int BLOCK = 5;	//아래에 보일 페이지 최대개수 1~10/11~20 식으로 고정
	
	int pg = 1; //기본 페이지값
	
	if(request.getParameter("pg")!=null) {//받아온 pg값이 있을때, 다른페이지일때
		pg = Integer.parseInt(request.getParameter("pg"));//pg값 저장
	}
	
	int start = (pg*ROWSIZE) - (ROWSIZE-1);//해당페이지에서 시작번호(step2)
	int end = (pg*ROWSIZE);//해당페이지에서 끝번호(step2)
	
	int allPage = 0;//전체 페이지수
	
	int startPage = ((pg-1)/BLOCK*BLOCK)+1;	 //시작블럭숫자 (1~10페이지일경우 1, 11~20일경우 11)
	int endPage = ((pg-1)/BLOCK*BLOCK)+BLOCK;//끝 블럭 숫자 (1~10페이지일경우 10, 11~20일경우 20)
	
	//총 게시글 수
	int total = 0;
	String pagingSql = "select count(*) from FREE_BOARD where category = 1";
	PreparedStatement ps = conn.prepareStatement(pagingSql);
	ResultSet rs = ps.executeQuery();
	if(rs.next()) {
		total = rs.getInt(1);
	}
	
	//총페이지 결정 (total=26이고 4개씩 보려면 [26/4+1=7]페이지 필요)
	allPage = (int)Math.ceil(total/(double)ROWSIZE);
	if(endPage > allPage) {
		endPage = allPage;
	}
	System.out.println("freeboard total 게시글 : " + total + "개");
%>

<!-- 게시물 목록을 보여주기 위한 DB연결 jsp -->
<%
	
	//vo객체 만들기
	FreeBoardDAO fbdao = new FreeBoardDAO(dbdriver, dburl, dbid, dbpw);
	ArrayList<FreeBoardVO> fblist = fbdao.freeBoardList(start, end, total);
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


<!-- 자유게시판 리스트 -->
<div class="freeboard" align="center">
<h1 align="center" style="color: white; font-weight: bold;" >자유게시판</h1>
<table style="color:white; " >
<caption>자유게시판</caption>
	<colgroup>
		<col style="width:70px;">
		<col style="width:700px;">
		<col style="width:100px;">
		<col style="width:150px;">
		<col style="width:70px;">
	</colgroup>
	<thead>
	<tr>
		<th>번호</th>
		<th>제목</th>
		<th>작성자</th>
		<th>작성일</th>
		<th>조회수</th>
	</tr>
	</thead>
	<tbody class="freeboard_body">
	<%
		/* 자유게시판 리스트 가져오기!!!!!!!!!!! */
		int fb_idx = 0;
		String fb_title = "";
		String fb_writer = "";
		String fb_date = "";
		int fb_viewcount = 0;
		String fb_nickname = "";
		int fb_boardnum = 0;
		int fb_category = 1;
		for(int i=0; i<fblist.size(); i++) {
			fb_idx = fblist.get(i).getFree_board_seq();
			fb_title = fblist.get(i).getF_title();
			fb_writer = fblist.get(i).getWriter();
			fb_date = fblist.get(i).getFdate();
			fb_viewcount = fblist.get(i).getF_viewcount();
			fb_nickname = fblist.get(i).getNickname();
			fb_boardnum = fblist.get(i).getBoardNum();

			/* Date date = new Date(); 
			SimpleDateFormat simpleDate = new SimpleDateFormat("yyyy-MM-dd"); 
			String year = (String)simpleDate.format(date);  */
			String yea = fb_date.substring(0,10);
			%>
			<tr>
				<td class="txtnum"><%= total-fb_boardnum+1 %></td>
				<td class="title"><a href="micTest_viewFreeBoard.jsp?idx=<%=fb_idx%>"><%= fb_title %></td>
				<td class="writer"><%= fb_nickname %></td>
				<td class="date"><%= fb_date %></td>
				<td class="hit"><%= fb_viewcount %></td>
			</tr>
			<%
		}
	%>
	
	</tbody>
</table>

<!-- 글쓰기 버튼 -->
<div id="writebuttondiv" style="position:relative; top:30px; text-align:right;">
<!-- 로그인될때 글쓰기 버튼 보이기 -->
<%-- <c:if test="${sessionScope.sessionID!=null}">
            <input type="button" value="글쓰기" onclick="writeForm()">
        </c:if>    --%>
<input type="button" value="글쓰기" id="writebutton" name="writebutton" onclick="boardWriteForm()" />
</div><br>
<div id="pageForm">페이지 번호</div>
<div id="pageNum" style="color:white;">
<%
	if(pg>BLOCK) {
		%>
		[<a href="micTest_freeboard.jsp?pg=1">◁◁ </a>]
		[<a href="micTest_freeboard.jsp?pg=<%=startPage-1%>">◁</a>]
		<%
	}
	%>
	
	<%
	for(int i=startPage; i<=endPage; i++){
		if(i == pg){
	%>
		<u><b>[<%=i %>]</b></u>
		<%
		}else{
		%>
			[<a href="micTest_freeboard.jsp?pg=<%=i %>"><%=i %></a>]
		<%
		}
	}
	%>
		
	<%
	if(endPage<allPage){
	%>
		[<a href="micTest_freeboard.jsp?pg=<%=endPage+1%>">▷</a>]
		[<a href="micTest_freeboard.jsp?pg=<%=allPage%>">▷▷</a>]
	<%
	}
%>
</div>

<br>
<!-- <div id="searchForm">검색 라인
	<form>
    	<select name="opt">
        	<option value="0">제목</option>
        	<option value="1">내용</option>
        	<option value="2">제목+내용</option>
			<option value="3">글쓴이</option>
		</select>
	<input type="text" size="20" name="condition"/>&nbsp;
	<input type="submit" value="검색"/>
    </form>    
</div> -->

</div>

<%} %>

</body>
</html>