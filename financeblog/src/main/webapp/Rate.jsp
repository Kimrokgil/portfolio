<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import ="java.io.PrintWriter" %>
<%@ page import ="bbs.BbsDAO" %>
<%@ page import ="bbs.Bbs"  %>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<meta name="viewport" content="width=device-width", initial-scale="1">
	<link rel="stylesheet" href="css/bootstrap.css">
	<link rel="stylesheet" href="css/custom.css">
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
  <title> 환율 계산기</title>
</head>
<body>
	<%
// 		메인 페이지로 이동했을 때 세션값확인
		String userID = null;
		if(session.getAttribute("userID") != null){
			userID = (String)session.getAttribute("userID");
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
				<li><a href="Main.jsp">홈</a></li>
				<li><a href="Bbs.jsp?boardID=1&pageNumber=1">국내</a></li>
				<li><a href="Bbs.jsp?boardID=2&pageNumber=1">국외</a></li>
				<li class="active"><a href="Rate.jsp">환율 계산기</a></li>
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
<!-- 							드랍다운 아이템 영역 -->
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
	<%
	  double result = 0;
	  double num=0;
	  String unit1 ="";
	  String unit2 ="";
	  
	  
	
	  if (request.getMethod().equals("POST")) {
	    num = Double.parseDouble(request.getParameter("num"));
	    String country1 = request.getParameter("country1");
	    String country2 = request.getParameter("country2");
	
	    if (country1.equals("Dollar")) {
	      unit1="USD";
	    } else if (country1.equals("Korea")) {
	      unit1="원";
	    } else if (country1.equals("Japan")) {
	      unit1="JPY";
	    } else if (country1.equals("Europe")) {
	      unit1="EUR";
	    }
	
	    if (country2.equals("Dollar")) {
	      unit2="USD";
	    } else if (country2.equals("Korea")) {
	      unit2="원";
	    } else if (country2.equals("Japan")) {
	      unit2="JPY";
	    } else if (country2.equals("Europe")) {
	      unit2="EUR";
	    }
	
	    if (country1.equals("Dollar")) {
	
	      if (country2.equals("Dollar")) {
	        result = num*1;
	
	      } else if (country2.equals("Japan")) {
	        result = num *143.11;
	      } else if (country2.equals("Europe")) {
	        result =num *1;
	      } else if (country2.equals("China")) {
	        result = num *7.01;
	      } else if (country2.equals("Korea")){
	        result = num *1388.59;
	      }
	
	    } else if (country1.equals("Japan")) {
	      if (country2.equals("Dollar")) {
	        result = num*0.01;
	
	      } else if (country2.equals("Japan")) {
	        result = num *1;
	      } else if (country2.equals("Europe")) {
	        result = num *0.01;
	      } else if (country2.equals("China")) {
	        result = num *0.05;
	      } else if (country2.equals("Korea")) {
	        result = num *9.54;
	      }
	    } else if (country1.equals("Europe")) {
	      if (country2.equals("Dollar")) {
	        result = num*1;
	
	      } else if (country2.equals("Japan")) {
	        result = num *139.26;
	      } else if (country2.equals("Europe")) {
	        result =num *1;
	      } else if (country2.equals("China")) {
	        result = num *6.78;
	      } else if (country2.equals("Korea")) {
	        result = num *1328.31;
	      }
	    } else if (country1.equals("China")) {
	      if (country2.equals("Dollar")) {
	        result = num*0.15;
	
	      } else if (country2.equals("Japan")) {
	        result = num *20.55;
	      } else if (country2.equals("Europe")) {
	        result =num *0.15;
	      } else if (country2.equals("China")) {
	        result = num *1;
	      } else if (country2.equals("Korea")) {
	        result = num *196.08;
	      }
	    } else if (country1.equals("Korea")) {
	      if (country2.equals("Dollar")) {
	        result = num*0.00072;
	      } else if (country2.equals("Japan")) {
	        result = num *0.1;
	      } else if (country2.equals("Europe")) {
	        result =(num*11) *0.00072;
	      } else if (country2.equals("China")) {
	        result = num *0.005;
	      } else if (country2.equals("Korea")) {
	        result = num*1;
	      }
	    }
	  }
	%>
	<div align="center">
	  <h1>환율 계산기</h1>
	  <hr>
	  <form name="form1" method="post">
	
	    보유통화
	    <select name="country1">
	      <option >Dollar</option>
	      <option selected>Japan</option>
	      <option>Europe</option>
	      <option>China</option>
	      <option>Korea</option>
	    </select>
	    환전통화
	
	    <input type="text" name="num" width=200 size="5">
	    <select name="country2">
	      <option selected>Dollar</option>
	      <option>China</option>
	      <option>Japan</option>
	      <option>Europe</option>
	      <option>Korea</option>
	    </select>
	    <input type="submit" value="계산" class="btn btn-info" name="B1">
	    <input type="reset" value="다시 입력" class="btn btn-alert" name="B2">
	  </form>
	  <hr>
	  계산결과 :
	  <br>
	
	  <%=num%><%=unit1%>은 <%=result%><%=unit2%>
	</div>
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="js/bootstrap.js"></script>
</body>
</html>