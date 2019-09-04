<%@page import="vo.EntrantVO"%>
<%@page import="dao.EntrantDAO"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%

String startdate = request.getParameter("startdate");
String finishdate = request.getParameter("finishdate");
int round = Integer.parseInt(request.getParameter("round"));
String names = request.getParameter("names");

String starts[] = startdate.split("/");
String realStartdate = starts[2]+"년"+starts[0]+"월"+starts[1]+"일";
String finishes[] = finishdate.split("/");
String realFinishdate = finishes[2]+"년"+finishes[0]+"월"+finishes[1]+"일";
EntrantDAO edao = new EntrantDAO();
int result = edao.updateEntrant(realStartdate, realFinishdate, round, names);

response.sendRedirect("micTest_progress.jsp");
%>