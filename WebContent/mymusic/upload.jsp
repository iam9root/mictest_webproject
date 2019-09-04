<%@page import="dao.AlbumDAO"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="java.util.Enumeration"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="dao.uploadDAO" %>
<%@page import="vo.uploadVO" %>

<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
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

	/* String id = request.getParameter("id");
	out.print(id); // request.getParameter() 사용 불가  */
	
	String artist = "";
	String albumname = "";
	String musicname = "";

	String musicFileName = "";
	String albumImageName = "";
	String orgMusicFileName = "";
	String orgAlbumImageName = "";
	
	String file_path = "";
	
	String musicUploadPath = "";
	String albumUploadPath = "";
	
	String uploadPath = request.getRealPath("upload"); // upload는 폴더명 / 폴더의 경로를 구해옴
	
	System.out.println(uploadPath);

	try {
		MultipartRequest multi = new MultipartRequest( // MultipartRequest 인스턴스 생성(cos.jar의 라이브러리)
				request, 
				uploadPath, // 파일을 저장할 디렉토리 지정
				10 * 1024*1024, // 첨부파일 최대 용량 설정(bite) / 10mB / 용량 초과 시 예외 발생
				"utf-8", // 인코딩 방식 지정
				new DefaultFileRenamePolicy() // 중복 파일 처리(동일한 파일명이 업로드되면 뒤에 숫자 등을 붙여 중복 회피)
		);

		artist = multi.getParameter("artist"); // form의 name="id"인 값을 구함
		albumname = multi.getParameter("albumname");
		musicname = multi.getParameter("musicname");
		

		/* form의 <input type="file"> name값을 모를 경우 name을 구할때 사용
		Enumeration files=multi.getFileNames(); // form의 type="file" name을 구함
		String file1 =(String)files.nextElement(); // 첫번째 type="file"의 name 저장
		String file2 =(String)files.nextElement(); // 두번째 type="file"의 name 저장
		*/

		musicFileName = multi.getFilesystemName("file1"); // name=file1의 업로드된 시스템 파일명을 구함(중복된 파일이 있으면, 중복 처리 후 파일 이름)
		orgMusicFileName = multi.getOriginalFileName("file1"); // name=file1의 업로드된 원본파일 이름을 구함(중복 처리 전 이름)

		albumImageName = multi.getFilesystemName("file2");
		orgAlbumImageName = multi.getOriginalFileName("file2");
		
		musicUploadPath = uploadPath+"\\"+musicFileName;
		albumUploadPath = uploadPath+"\\"+albumImageName;
		
		/* uploadDAO dao = new uploadDAO();
		uploadVO vo = new uploadVO();
		
		vo.setArtist(artist);
		vo.setAlbumname(albumname);
		vo.setMusicname(musicname);
		vo.setMusicFileName(musicFileName);
		vo.setAlbumImageName(albumImageName);
		vo.setMusicUploadPath(musicUploadPath);
		vo.setAlbumUploadPath(albumUploadPath); */
		
		System.out.println(musicUploadPath);
		System.out.println(albumUploadPath);
		
	} catch (Exception e) {
		e.getStackTrace();
	} // 업로드 종료
	
	//db저장
	AlbumDAO adao = new AlbumDAO();
	adao.insertFile(1, musicUploadPath, musicname, artist, albumUploadPath, albumname, sessionid, musicFileName, albumImageName);
	
	response.sendRedirect("../mymusic/micTest_myalbum.jsp");
%>

<!-- 업로드 된 파일을 확인하는 폼으로 이동 / 위에서 구한 데이터를 hidden 방식으로 전송 -->
<html>
<body>
	<form action="uploadcheck.jsp" method="post">
		<input type="hidden" name="artist" value="<%=artist%>"> 
		<input type="hidden" name="albumname" value="<%=albumname%>">
		<input type="hidden" name="musicname" value="<%=musicname%>">  
		<input type="hidden" name="musicFileName" value="<%=musicFileName%>"> 
		<input type="hidden" name="albumImageName" value="<%=albumImageName%>"> 
		<input type="hidden" name="orgMusicFileName" value="<%=orgMusicFileName%>">
		<input type="hidden" name="orgAlbumImageName" value="<%=orgAlbumImageName%>">
		<input type="submit" value="업로드 확인">
	</form>
</body>
</html>