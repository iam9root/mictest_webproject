<%@page import="dao.MemberDAO"%>
<%@page import="vo.MemberVO"%>
<%@page import="java.util.ArrayList"%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<link href="micTestCss.css" rel="stylesheet" type="text/css">


</head>
<body>

<%
//세션정보 받아오기
String sessionid = (String)session.getAttribute("sessionid");
MemberDAO mdao = new MemberDAO();
ArrayList<MemberVO> mlist = mdao.getMemberlist();
%>
<a href="../home/micTest.jsp" style="text-decoration: none;">
<div class="text" id="main">
	M.I.C. TEST
</div>
</a>
<nav class="menu">
	<ol>
		<li class="menu-item"><a href="#0">M.I.C. Survival</a>
			<ol class="sub-menu">
				<li class="menu-item"><a href="../micsurvival/micTest_round.jsp?r=1">1 라운드</a></li>
				<li class="menu-item"><a href="../micsurvival/micTest_round.jsp?r=2">2 라운드</a></li>
				<li class="menu-item"><a href="../micsurvival/micTest_round.jsp?r=3">파이널 라운드</a></li>
				<li class="menu-item"><a href="../micsurvival/micTest_progress.jsp">진행사항</a></li>
			</ol>
		</li>
		<li class="menu-item"><a href="#0">명예의 전당</a>
			<ol class="sub-menu">
				<li class="menu-item"><a href="../honorplace/gold.jsp">Golden M.I.C.</a></li>
				<li class="menu-item"><a href="../honorplace/micTest_honor.jsp">파이널 진출자</a></li>
				<!-- <li class="menu-item"><a href="../honorplace/micTest_hot.jsp">H O T</a></li>
				<li class="menu-item"><a href="../honorplace/micTest_popuser.jsp">인기 사용자</a></li> -->
			</ol>
		</li>
		<li class="menu-item"><a href="#0">차트</a>
			<ol class="sub-menu">
				<li class="menu-item"><a href="https://www.melon.com/chart/" target="_blank">멜론 인기 차트</a></li>
				<li class="menu-item"><a href="../chart/micTest_micChart.jsp">M.I.C. 인기차트</a></li>
			</ol>
		</li>
		<li class="menu-item"><a href="#0">커뮤니티</a>
			<ol class="sub-menu">
				<li class="menu-item"><a href="../community/mic_notice.jsp">공지사항</a></li>
				<li class="menu-item"><a href="../community/micTest_freeboard.jsp">자유 게시판</a></li>
			</ol>
		</li>
		<li class="menu-item"><a href="#0">My Music</a>
			<ol class="sub-menu">
				<li class="menu-item"><a href="../mymusic/uploadForm.jsp">음악 업로드</a></li>
				<li class="menu-item"><a href="../mymusic/micTest_myalbum.jsp">나만의 앨범</a></li>
			</ol>
		</li>
		<li class="menu-item"><a href="#0">로그인</a>
			<ol class="sub-menu">
			<%
				if(sessionid == null){
			%>
				<li class="menu-item"><a href="../login/loginForm.jsp">로그인</a></li>
				<li class="menu-item"><a href="../login/joinForm.jsp">회원가입</a></li>
			<%} else {%>
				<li class="menu-item"><a href="../login/logout.jsp">로그아웃</a></li>
			<%}%>
			</ol>
		</li>
	</ol>
</nav>


<div class="image">
	<img src="../image/man-singing.png" width="250" height="250">
</div>

<script src="../jquery-3.2.1.min.js" ></script>
<script type="text/javascript">
/* @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ 이 스크립트는 모두 리더보드 표꺼 @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@*/
(function ($) {
	var FakePoller = function(options, callback){
		var defaults = {
			frequency: 60,
			limit: 10
		};
		this.callback = callback;
		this.config = $.extend(defaults, options);
		<%
		String nick="";
		for(int i=0;i<mlist.size();i++){
			MemberVO mvo = mlist.get(i);
			if(i==mlist.size()){
				nick += "\'";
				nick += mvo.getNickname();
				nick += "\'";
			}else {
				nick += "\'";
				nick += mvo.getNickname();
				nick += "\',";
			}
		%>
			this.list=[
				<%=nick %>
			];
			/* this.list = [
				'Game of Thrones',
				'The Walking Dead',
				'Survivor',
				'Dead Like Me',
				'Being Human',
				'American Idol',
				'X Factor',
				'Firefly',
				'SGU',
				'Battlestar Galactica',
				'Farscape',
				'The Mentalist',
				'True Blood',
				'Dexter',
				'Rick Astley'
			]; */
		<%
		}
		
		%>		
	}

	
	FakePoller.prototype.getData = function() {		
		var results = [];
/* 	@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@	*/
	  	<%
		ArrayList<MemberVO> mclist2 = new ArrayList<MemberVO>();
		for(int i=0; i<mlist.size(); i++){
			mclist2.add(mlist.get(i));
		}
		%>

		<%
		String like_result="";
		for(int i=0;i<mclist2.size();i++){
			int like = mclist2.get(i).getM_like(); 
			if(i==(mclist2.size()-1)){

				like_result += mclist2.get(i).getM_like();

			}else {

				like_result += mclist2.get(i).getM_like();
				like_result += ",";
			}
			%>
			this.like_list=[<%=like_result%>];
		
			
		<%}
 			System.out.println(like_result);
 			
		%>
		
		/* 	@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@	*/		
		
				
		

		for (var i = 0, len = this.list.length; i < len; i++) {
			results.push({
				name: this.list[i],
				count: this.like_list[i]
			});
		}
		return results;
	};
	FakePoller.prototype.processData = function() {
		return this.sortData(this.getData()).slice(0, this.config.limit);
	};

	FakePoller.prototype.sortData = function(data) {
		return data.sort(function(a, b) {
			return b.count - a.count;
		});
	};
	FakePoller.prototype.start = function() {
		var _this = this;
		this.interval = setInterval((function() {
			_this.callback(_this.processData());
		}), this.config.frequency * 1000);
		this.callback(this.processData());
		return this;
	};
	FakePoller.prototype.stop = function() {
		clearInterval(this.interval);
		return this;
	};
	window.FakePoller = FakePoller;

	var Leaderboard = function (elemId, options) {
		var _this = this;
		var defaults = {
			limit:10,
			frequency:15
		};
		this.currentItem = 0;
		this.currentCount = 0;
		this.config = $.extend(defaults,options);

		this.$elem = $(elemId);
		if (!this.$elem.length)
			this.$elem = $('<div>').appendTo($('body'));

		this.list = [];
		this.$content = $('<ul>');
		this.$elem.append(this.$content);

		this.poller = new FakePoller({frequency: this.config.frequency, limit: this.config.limit}, function (data) {
			if (data) {
				if(_this.currentCount != data.length){
					_this.buildElements(_this.$content,data.length);
				}
				_this.currentCount = data.length;
				_this.data = data;
				_this.list[0].$item.addClass('animate');
			}
		});

		this.poller.start();
	};

	Leaderboard.prototype.buildElements = function($ul,elemSize){
		var _this = this;
		$ul.empty();
		this.list = [];

		for (var i = 0; i < elemSize; i++) {
			var item = $('<li>')
				.on("animationend webkitAnimationEnd oAnimationEnd",eventAnimationEnd.bind(this) )
				.appendTo($ul);
			this.list.push({
               $item: item,
               $name: $('<span class="name">Loading...</span>').appendTo(item),
               $count: $('<span class="count">Loading...</span>').appendTo(item)
           });
		}

		function eventAnimationEnd (evt){
			this.list[this.currentItem].$name.text(_this.data[this.currentItem].name);
			this.list[this.currentItem].$count.text(_this.data[this.currentItem].count);
			this.list[this.currentItem].$item.removeClass('animate');
			this.currentItem = this.currentItem >= this.currentCount - 1 ? 0 : this.currentItem + 1;
			if (this.currentItem != 0) {
				this.list[this.currentItem].$item.addClass('animate');
			}
		}
	};

	Function.prototype.bind = function(){
		var fn = this, args = Array.prototype.slice.call(arguments),
			object = args.shift();
		return function(){
			return fn.apply(object,args.concat(Array.prototype.slice.call(arguments)));
		};
	};

	window.Leaderboard = Leaderboard;
	//Helper
	function rnd (min,max){
		min = min || 100;
		if (!max){
			max = min;
			min = 1;
		}
		return	Math.floor(Math.random() * (max-min+1) + min);
	}

	function numberFormat(num) {
		return num.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
	}
})(jQuery);

$(document).ready(function ($) {
	var myLeaderboard = new Leaderboard(".content", {limit:8,frequency:8});
});



</script>

<div class='leaderboard'>
    <h1><span>Leader Board</span></h1>
    <div class="content"></div>
</div>

</body>
</html>