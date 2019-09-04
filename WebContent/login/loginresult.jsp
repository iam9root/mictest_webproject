<%@page import="vo.LoginVO"%>
<%@page import="dao.LoginDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<%
if(session.getAttribute("sessionid")==null){
	if(request.getParameter("id").equals("") || request.getParameter("pw").equals("")){
		out.println("<script>alert('아이디와 비밀번호를 입력하세요'); location.href='loginForm.jsp'</script>");
	} else {
		String userid = request.getParameter("id");
		String userpw = request.getParameter("pw");
		
		//member테이블 조회
		
		String driver = "oracle.jdbc.driver.OracleDriver";
		String url = "jdbc:oracle:thin:@localhost:1521:xe";
		String account = "mic";
		String pw = "mic";
		String result = "";
	
		LoginDAO dao = new LoginDAO();
		LoginVO vo = new LoginVO(userid, userpw);
		/* boolean loginresult = dao.insertBoard(vo); */
		boolean loginresult = dao.login(vo);
		if(loginresult == true){
			/* result = "id : " + userid +  "반갑습니다."; */
			response.sendRedirect("../home/micTest.jsp");
			session.setAttribute("sessionid", userid);
		} else{
			/* result = "회원가입부터 하세요."; */
			out.println("<script>alert('회원정보가 틀립니다.'); location.href='loginForm.jsp'</script></script>");
		}
	}
} else {
	out.println("<script></script>");
}
%>

<script src="../jquery-3.2.1.min.js"></script>
<script>

$(document).ready(function(){
		
		
		
	});
</script>
</body>
</html>