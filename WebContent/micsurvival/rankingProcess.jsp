<%@page import="vo.Contest_BoardVO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="dao.Contest_BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%
//contest_board의 seq에 맞는 round 수정하기
Contest_BoardDAO cbdao = new Contest_BoardDAO();
//우승자
ArrayList<Contest_BoardVO> list3 = cbdao.getContest_BoardRankList(3);
if(list3 != null){
	Contest_BoardVO cbvo3 = null;
		
	for(int i=0; i<list3.size(); i++){
		cbvo3 = list3.get(i);
		if(i<1){
			cbdao.setRound(4, cbvo3.getContest_seq());
		} else{
			cbdao.setRound(33, cbvo3.getContest_seq());
		}
	}
}

//파이널라운드 진출자 수정
ArrayList<Contest_BoardVO> list2 = cbdao.getContest_BoardRankList(2);
Contest_BoardVO cbvo2 = null;

if(list2 != null){
	for(int i=0; i<list2.size(); i++){
		cbvo2 = list2.get(i);
		if(i<3){ //진출자
			cbdao.setRound(3, cbvo2.getContest_seq());
		} else{ //진출실패
			cbdao.setRound(0, cbvo2.getContest_seq());
		}
	}
}

//1라운드 순위 매기고 2라운드 진출 수정
ArrayList<Contest_BoardVO> list1 = cbdao.getContest_BoardRankList(1);
Contest_BoardVO cbvo = null;

if(list1 != null){
	for(int i=0; i<list1.size(); i++){
		cbvo = list1.get(i);
		if(i<10){
			cbdao.setRound(2, cbvo.getContest_seq());
		} else{
			cbdao.setRound(0, cbvo.getContest_seq());
		}
	}
}
	
response.sendRedirect("micTest_progress.jsp");

%>