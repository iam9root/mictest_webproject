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
	
	//요청값 받아오기
	String title = request.getParameter("board_subject"); //제목의 name값
	String contents = request.getParameter("board_content");//내용의 name값
	String writer = request.getParameter("board_writer");
	int category = Integer.parseInt(request.getParameter("category"));
	
	//vo객체로 저장
	//String f_title, String f_contents, String writer
	FreeBoardVO fbvo = new FreeBoardVO(title, contents, writer);
	fbvo.setCategory(category);
	FreeBoardDAO fbdao = new FreeBoardDAO(dbdriver, dburl, dbid, dbpw);
	String result = fbdao.freeBoardInsert(fbvo);
%>
<script type="text/javascript">
	self.window.alert("작성한 글이 등록되었습니다.");
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