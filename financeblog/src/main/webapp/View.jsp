<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import ="java.io.PrintWriter" %>
<%@ page import ="bbs.Bbs" %>
<%@ page import ="bbs.BbsDAO" %>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<!-- 화면최적화 -->
<meta name="viewport" content="width=device-width", initial-scale="1">
<!-- 루트폴더에 부트스트랩을 참조하는 링크 -->
<link rel="stylesheet" href="css/bootstrap.css">
<title>경제뉴스 포럼</title>
</head>
<body>
	<%
// 		메인 페이지로 이동했을 때 세션값에 값이 담겨있는지 체크
		String userID = null;
		if(session.getAttribute("userID") != null){
			userID = (String)session.getAttribute("userID");
		}
// 		bbsID를 초기화 시키고 
// 		'bbsID'라는 데이터가 넘어온 것이 존재한다면 캐스팅을 하여 변수에 담는다.
		int bbsID = 0;
		if(request.getParameter("bbsID") != null ) {
			bbsID = Integer.parseInt(request.getParameter("bbsID"));
		}
		int boardID = 0;
		if (request.getParameter("boardID") != null){
			boardID = Integer.parseInt(request.getParameter("boardID"));
		}
		
// 		만약 넘어온 데이터가 없다면 
		if(bbsID == 0) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('유효하지 않은 글입니다')");
			script.println("location.href='Bbs.jsp'");
			script.println("</script>");
		}

// 		유효한 글이라면 구체적인 정보를 'bbs' 라는 인스턴스에 답는다.
		Bbs bbs = new BbsDAO().getBbs(bbsID);
		
		
	%>
	<nav class="navbar navbar-default">  <!--네비게이션  -->
		<div class="navbar-header"> <!-- 네비게이션 상단 부분 -->
		<!--  네비게이션 상단 박스 영역 -->
			<button type ="button" class="navbar-toggle collapsed"
				data-toggle="collapse" data-target="#bs-example-navbar-collapse-1"
				aria-expanded="false">
				
<!-- 				삼선 버튼은 화면이 좁아지면 우측에 나타난다. -->
				<span class="icon-bar"></span>
				<span class="icon-bar"></span>
				<span class="icon-bar"></span>
			</button>
<!-- 			상단 바에 제목이 나타나고 클릭하면 main 페이지로 이동 -->
			<a class ="navbar-brand" href ="Main.jsp">경제 뉴스 포럼</a>
		</div>
<!-- 		게시판 제목 이름 옆에 나타나는 메뉴영역 -->
		<div class="collapse navbar-collapse" id = "bs-example-navbar-collpase-1">
			<ul class = "nav navbar-nav">
				<li><a href="Main.jsp">홈</a></li>
					<% if (boardID == 1){ %>
				<li class="active"><a href="Bbs.jsp?boardID=1">국내</a></li>
				<li><a href="Bbs.jsp?boardID=2">국외</a></li>
				<%} else if(boardID == 2){ %>
				<li><a href="Bbs.jsp?boardID=1">국내</a></li>
				<li class="active"><a href="Bbs.jsp?boardID=2">국외</a></li>
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
<!-- 네비게이션 끝 -->
<!-- 게시판 글보기 양식 영역 시작 -->

	<div class="container">
		<div class="row">
				<table class="table table-striped" style="text-align:center; border:1px; solid #dddddd">
					<thead>
						<tr> 
							<th colspan="2" style ="background-color: #eeeeee; text-align: center;">게시판 글보기 </th>
						</tr>
					</thead>
					<tbody>	
						<tr>
							<td style="width: 20%;">글 제목</td>
							<td colspan="2"><%=bbs.getBbsTitle().replaceAll(" ","&nbsp;").replaceAll("<","&It;").
												replaceAll(">","8gt;").replaceAll("\n","<br>") %></td>
						</tr>							
						<tr>
							<td>작성자</td>
							<td colspan="2"><%=bbs.getUserID() %></td>
						</tr>
						<tr>
							<td>작성일자</td>
							<td colspan="2"><%=bbs.getBbsDate().substring(0, 11) + bbs.getBbsDate().substring(11, 13) +"시" +
												bbs.getBbsDate().substring(14, 16) + "분" %></td>
						</tr>
						<tr>
							<td>내용</td>
							<td colspan ="2" style="height:200px; text-align:left;">
							<%=bbs.getBbsContent().replaceAll(" ","&nbsp;").replaceAll("<","&It;").
									replaceAll(">","8gt;").replaceAll("\n","<br>") %></td>
						</tr>
					</tbody>	
				</table>		
				<a href="Bbs.jsp?boardID=<%=boardID %>" class="btn btn-primary" >목록</a>
				<%
						if(userID != null && userID.equals(bbs.getUserID())) {
				%>
								<a onclick="return corfirm('정말로 삭제하시겠습니까?')" href="DeleteAction.jsp?bbsID=<%=bbsID%>&boardID=<%=boardID %>" class="btn btn-primary pull-right">삭제</a>
								<a href="Update.jsp?bbsID=<%= bbsID %>&boardID=<%=boardID%>" class="btn btn-primary pull-right">수정</a>
								
				<%
						}
				%>	
		</div>
	</div>
	
<!-- 게시판 메인 페이지 영역 끝 -->

<!-- 	부트스트랩 참조 영역 -->
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="js/bootstrap.js"></script>
</body>
</html>