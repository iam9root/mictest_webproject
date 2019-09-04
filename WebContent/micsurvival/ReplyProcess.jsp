<%@page import="dao.ReplyDAO"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>Insert title here</title>
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

int board_seq = Integer.parseInt(request.getParameter("contestNo"));
int cf = Integer.parseInt(request.getParameter("c_0_f_1"));
String cm_contents = request.getParameter("cm_contents");

ReplyDAO rdao = new ReplyDAO();
rdao.insertComment(cf, board_seq, cm_contents, sessionid);

response.sendRedirect("micTest_listenmusic.jsp?contestNo="+board_seq+"&lc=true");
%>
</body>
</html>