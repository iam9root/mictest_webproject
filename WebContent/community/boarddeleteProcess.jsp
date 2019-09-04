<%@page import="vo.FreeBoardVO"%>
<%@page import="dao.FreeBoardDAO"%>
<%@ page import="java.sql.*" %> <!-- DB사용을 위한 import -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="jquery-3.2.1.min.js"></script>

</head>
<body>
<!-- DB에 게시글 집어넣을 것임!!!!!!!!!!!!!!!!!!!!!!!!!! -->
<%
	request.setCharacterEncoding("UTF-8");
	String dbdriver = "oracle.jdbc.driver.OracleDriver";
	String dburl = "jdbc:oracle:thin:@localhost:1521:xe";
	String dbid = "mic";
	String dbpw = "mic";
	//삭제할 글의 글번호와 카테고리 번호
	int fb_idx = Integer.parseInt(request.getParameter("idx"));
	int category = Integer.parseInt(request.getParameter("category"));
	
	//vo객체로 저장
	FreeBoardVO fbvo = new FreeBoardVO();
	fbvo.setCategory(category);
	FreeBoardDAO fbdao = new FreeBoardDAO(dbdriver, dburl, dbid, dbpw);
	fbdao.freeBoardDelete(fb_idx);
%>
<script type="text/javascript">
	self.window.alert("해당 글을 삭제하였습니다.");
	<%
	if(category == 0) { //0이면 공지사항%>
		location.href="mic_notice.jsp";
	<%} else { //1이면 자유게시판%>
		location.href="micTest_freeboard.jsp";
	<%}
	%>
</script>
</body>
</html>