<%@page import="dao.MemberDAO"%>
<%@page import="vo.Contest_BoardVO"%>
<%@page import="dao.Contest_BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%
//contestNo에 맞는 c_like 증가, writer에 맞는 m_like 증가
int contestNo = Integer.parseInt(request.getParameter("contestNo"));
String writer = request.getParameter("writer");

Contest_BoardDAO cdao = new Contest_BoardDAO();
int result = cdao.setClike(contestNo);

MemberDAO mdao = new MemberDAO();
mdao.setMlike(writer);

response.sendRedirect("micTest_listenmusic.jsp?contestNo="+contestNo+"&lc=true");

%>