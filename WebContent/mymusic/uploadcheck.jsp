<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%	request.setCharacterEncoding("utf-8"); // 인코딩 타입 설정 %>
<%  // upload.jsp(hidden)로 부터 넘어온 값들을 구함
	String artist = request.getParameter("artist");
	String albumname = request.getParameter("albumname");
	String musicname = request.getParameter("musicname");
	String orgMusicFileName = request.getParameter("orgMusicFileName");
	String orgAlbumImageName = request.getParameter("orgAlbumImageName");
	String albumImageName = request.getParameter("albumImageName");
	String musicfilename = request.getParameter("musicfilename");
	
%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	가수 : <%=artist %><br>
	앨범이름 : <%=albumname %><br>
	노래제목 : <%=musicname%><br>
	첨부파일(클릭시 다운로드)<br>
	<!-- download.jsp 파일로 저장된 파일의 이름을 넘겨줌 -->
	- 음악 파일 : <a href="download.jsp?fileName=<%=musicfilename%>"><%=orgMusicFileName %></a><br>
	- 앨범 이미지 파일 : <a href="download.jsp?fileName=<%=albumImageName%>"><%=orgAlbumImageName %></a><br>
</body>
</html>
