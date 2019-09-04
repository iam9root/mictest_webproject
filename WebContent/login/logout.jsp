<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%
if(session.getAttribute("sessionid")!=null){
out.println("<script>alert('"+session.getAttribute("sessionid")+"님 로그아웃 되셨습니다.');</script>");

//세션삭제 및 페이지이동
session.removeAttribute("sessionid");
} else{
	out.println("<script>alert('이미 로그아웃 상태입니다.');</script>");
}
out.println("<script>location.href='../home/micTest.jsp'</script>");
//response.sendRedirect("../home/micTest.jsp");
%>