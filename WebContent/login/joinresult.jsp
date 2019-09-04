<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
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
	String uploadPath = request.getRealPath("upload"); // upload는 폴더명 / 폴더의 경로를 구해옴
		MultipartRequest multi = new MultipartRequest( // MultipartRequest 인스턴스 생성(cos.jar의 라이브러리)
				request, uploadPath, // 파일을 저장할 디렉토리 지정
				10 * 1024 * 1024, // 첨부파일 최대 용량 설정(bite) / 10mB / 용량 초과 시 예외 발생
				"utf-8", // 인코딩 방식 지정
				new DefaultFileRenamePolicy() // 중복 파일 처리(동일한 파일명이 업로드되면 뒤에 숫자 등을 붙여 중복 회피)
		);
		System.out.println(multi.getParameter("email"));
		String email = multi.getParameter("email");
		String password = multi.getParameter("pw");
		String nickname = multi.getParameter("nickname");
		int birth = Integer.parseInt(multi.getParameter("birth"));
		int gender = Integer.parseInt(multi.getParameter("gender"));
		String profile = multi.getParameter("profile");
		//POST로 Input.html로부터 입력받은 내용을 변수화
		

		String profileUploadPath = "";		
		System.out.println("insertMember전");
		/* boolean loginresult = dao.insertBoard(vo); */
		LoginDAO dao = new LoginDAO();
		boolean checkEmail = dao.checkEmail(email);
		if (checkEmail == true) {
			/* result = "id : " + userid +  "반갑습니다."; */System.out.println("중복");
			out.println("중복된 이메일 주소입니다.");
		} else {
			/* result = "회원가입부터 하세요."; */	System.out.println("이제 insertMember");		
		//프사 업로드		
			String profileName = "";
			String orgprofileName = "";

			String file_path = "";

		//	String uploadPath = request.getRealPath("upload"); // upload는 폴더명 / 폴더의 경로를 구해옴

			//System.out.println(uploadPath);

			try {System.out.println("try안");	
				profileName = multi.getFilesystemName("profile"); // name=file1의 업로드된 시스템 파일명을 구함(중복된 파일이 있으면, 중복 처리 후 파일 이름)
				orgprofileName = multi.getOriginalFileName("profile"); // name=file1의 업로드된 원본파일 이름을 구함(중복 처리 전 이름)
				System.out.println("uploadPath");
				profileUploadPath = uploadPath + "\\" + profileName;
				System.out.println(profileUploadPath);
				
				//db저장			
				
				LoginVO vo = new LoginVO();
				vo.setEmail(email);
				vo.setPassword(password);
				vo.setNickname(nickname);
				vo.setBirthyear(birth);
				vo.setGender(gender);
				vo.setProfile_img(profileName);
				
				boolean insertresult = dao.insertMember(vo);

			} catch (Exception e) {
				e.getStackTrace();
			} // 업로드 종료
			response.sendRedirect("loginForm.jsp");
		}
	%>

	<script src="../jquery-3.2.1.min.js"></script>
	<script>
		$(document).ready(function() {

		});
	</script>
</body>
</html>