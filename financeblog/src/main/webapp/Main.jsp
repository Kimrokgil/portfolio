<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import ="java.io.PrintWriter" %>
<%@ page import ="bbs.BbsDAO" %>
<%@ page import ="bbs.Bbs"  %>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width", initial-scale="1">
<link rel="stylesheet" href="css/bootstrap.css">
<link rel="stylesheet" href="css/custom.css">

<title>세계 경제 뉴스</title>
</head>
<body>
	<%
// 		메인 페이지로 이동했을 때 세션값확인
		String userID = null;
		if(session.getAttribute("userID") != null){
			userID = (String)session.getAttribute("userID");
		}
		
		int boardID = 1;
		if (request.getParameter("boardID") != null){
			boardID = Integer.parseInt(request.getParameter("boardID"));
		}
		
		int pageNumber = 1 ; 
		if(request.getParameter("pageNumber") != null) {
			pageNumber = Integer.parseInt(request.getParameter("pageNumber"));
		}
	%>
	<nav class="navbar navbar-default"> <!-- 네비게이션 -->
		<div class="navbar-header"> <!--  네비게이션 상단 부분 -->
			<button type ="button" class="navbar-toggle collapsed"
				data-toggle="collapse" data-target="#bs-example-navbar-collapse-1"
				aria-expanded="false">
				<!-- 이 삽줄 버튼은 화면이 좁아지면 우측에 나타난다 -->
				<span class="icon-bar"></span>
				<span class="icon-bar"></span>
				<span class="icon-bar"></span>
			</button>
<!-- 			상단 바에 제목이 나타나고 클릭하면 main 페이지로 이동 -->
			<a class ="navbar-brand" href ="Main.jsp">경제뉴스 포럼</a>
		</div>
		<!--  게시판 제목 이름 옆네 나타나는 메뉴 영역 -->
		<div class="collpase navbar-collpase" id="bs-example-navbar-collpase-1">
			<ul class="nav navbar-nav">
				<li class="active"><a href="Main.jsp">홈</a></li>
				<% if (boardID == 1){ %>
				<li><a href="Bbs.jsp?boardID=1">국내</a></li>
				<li><a href="Bbs.jsp?boardID=2">국외</a></li>
				<%} else if(boardID == 2){ %>
				<li><a href="Bbs.jsp?boardID=1">국내</a></li>
				<li><a href="Bbs.jsp?boardID=2">국외</a></li>
				<%
				} 
				%>
				<li><a href="Rate.jsp">환율 계산기</a></li>
			</ul>
				
					<%
// 						로그인 하지 않았을 떄 보여지는 화면
						if(userID == null) {
					%>
<!-- 						헤더 우측에 나타나는 드랍다운 영역 -->
					<ul class="nav navbar-nav navbar-right">
						<li class="dropdown">
							<a href="#" class="dropdown-toggle"
								data-toggle="dropdown" role="button" aria-haspopup="true"
								aria-expanded="false">접속하기<span class="caret"></span></a>
<!-- 								드랍다운 아이템 영역  -->
							<ul class="dropdown-menu">
								<li><a href="Login.jsp">로그인</a></li>
								<li><a href="Join.jsp">회원가입</a></li>
							</ul>
						</li>	
					</ul>	
					<% 	
// 						로그인이 되어 있는 상태에서 보여주는 화면
						} else {						
					%>
						<!-- 						헤더 우측에 나타나는 드랍다운 영역 -->
					<ul class="nav navbar-nav navbar-right">
						<li class="dropdown">
							<a href="#" class="dropdown-toggle"
								data-toggle="dropdown" role="button" aria-haspopup="true"
								aria-expanded="false">회원관리<span class="caret"></span></a>
							<ul class="dropdown-menu">
								<li><a href="LogoutAction.jsp">로그아웃</a></li>
							</ul>
						</li>	
					</ul>	
					<% 
						}
					%>	
		</div>
	</nav>
<!--         메인 페이지 영역 시작  -->
	<div class="container">
		<div class="jumbotron">
			<div class="container">
				<h1> 경제 뉴스 블로그</h1>
				<p> 국내외 경제 뉴스 포럼 </p>
			</div>
		</div>
	<!-- <iframe src="https://www.kita.net/cmmrcInfo/ehgtGnrlzInfo/rltmEhgt.do" > -->	
	</div>
	

<!--  메인페이지 이미지 삽입 영역 -->
	<div class="container" >
		<div id="myCarousel" class="carousel slide" data-ride="carousel">
			<ol class="carousel-indicators" >
           		<li data-target="#myCarousel" data-slide-to="0" class="active"></li>
                <li data-target="#myCarousel" data-slide-to="0"></li>
                <li data-target="#myCarousel" data-slide-to="0"></li>
            </ol>
			
			<div class="carousel-inner" >
				<div class="item active"  >
					<img src="images/1.jpg" >
				</div>
				<div class="item">
					<img src="images/2.jpg" >
				</div>
				<div class="item">
					<img src="images/3.jpg" >
				</div>
			</div>
			<a class="left carousel-control" href="#myCarousel" data-slide="prev">
				<span class="glyphicon glyphicon-chevron-left"></span>
			</a>
			<a class="right carousel-control" href="#myCarousel" data-slide="next">
				<span class="glyphicon glyphicon-chevron-right"></span>
			</a>
		</div>
	</div>
	<!--  메인 페이지 영역 끝 -->
<!-- 	부트스트랩 참조 영역 -->
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="js/bootstrap.js"></script>
</body>
<footer>
<label class="switch-button pull-right">
	<input type="checkbox"/>
    <span class="onoff-switch"></span>
</label>

</footer>
</html>




















