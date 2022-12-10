<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width", initial-scale="1">
<link rel="stylesheet" href="css/bootstrap.css">
<title>경제뉴스 포럼</title>
</head>
<body>
	<nav class="navbar navbar-default">
		<div class="navbar-header">
			<button type ="button" class="navbar-toggle collapsed"
				data-toggle="collapse" data-target="#bs-example-navbar-collapse-1"
				aria-expanded="false">
				<span class="icon-bar"></span>
				<span class="icon-bar"></span>
				<span class="icon-bar"></span>
			
			</button>
			<a class ="navbar-brand" href ="Main.jsp">경제뉴스 포럼</a>
		</div>
		
		<div class = "collapse navbar-collapse" id="bs-example-navbar-collapse-1">
			<ul class = "nav navbar-nav">
				<li><a href="Main.jsp">홈</a></li>
				<li><a href="Bbs.jsp">게시판</a></li>
				<li><a href="Rate.jsp">환율 계산기</a></li>
			</ul>
			<ul class="nav navbar-nav navbar-right">
				<li class = "dropdown">
					<a  href ="#" class = "dropdown-toggle"
						data-toggle = "dropdown" role="button" aria-haspopup="true"
						aria-expanded="false">접속하기<span class="caret"></span></a>
					
					<ul class="dropdown-menu">
						<li class="active"><a href="Login.jsp">로그인</a></li>
						<li><a href="Join.jsp">회원가입</a></li>
					</ul>
				</li>		
			</ul>
		</div>
	</nav>
<!-- 	회원가입양식  -->
	<div class = "container">
		<div class="col-lg-4">
		<!-- 점보트론은 특정 컨텐츠 , 정보를 두드러지게 하기위한 큰박스 -->
			<div class = "jumbotron" style="padding-top: 20px">
				<form method="post" action="JoinAction.jsp">
					<h3 style="text-align: center;"> 회원가입</h3>
					<div class = "form-group">
						<input type="text" class="form-control" placeholder="아이디" name="userID" maxlength="20">
					</div>				
					<div class = "form-group">
						<input type="password" class="form-control" placeholder="비밀번호" name="userPassword" maxlength="20">
					</div>
					<div class = "form-group" >
						<input type="text" class="form-control" placeholder="주소" name="userAddress" maxlength="300"> 
					</div>
					<div class = "form-group" >
						<input type="tel" class="form-control" placeholder="폰 번호( '-'미포함)" name="userPhone_number" size="11"> 
					</div>
					<input type="submit" class="btn btn-primary form-control" value="회원가입">				
				</form>
			</div>
		</div>
	</div>

<!-- 	부트스트랩 참조 영역 -->
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="js/bootstrap.js"></script>
</body>
</html>