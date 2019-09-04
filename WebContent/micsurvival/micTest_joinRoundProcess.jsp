<%@page import="dao.Contest_BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%

//세션정보 받아오기
String sessionid = (String)session.getAttribute("sessionid");
if(sessionid==null){
	//세션정보가 없으면 로그인페이지로 이동
	out.println("<script>alert('세션이 종료되었습니다. 로그인페이지로 이동합니다.');</script>");
	response.sendRedirect("../login/loginForm.jsp");
} else{
	out.println("<script>alert('로그인 아이디: "+sessionid+"');</script>");
	
}

String email = request.getParameter("email");
String subject = request.getParameter("subject");
String contents = request.getParameter("contents");
int fileseq = Integer.parseInt(request.getParameter("fileseq"));

//contest_board db에 저장
Contest_BoardDAO cdao = new Contest_BoardDAO();
cdao.insertContest_Board(subject, contents, sessionid, fileseq);

response.sendRedirect("micTest_round.jsp?r=1");
%>