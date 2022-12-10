<%@page import="java.io.PrintWriter" %>
<%@page import = "bbs.BbsDAO" %>
<%@page import = "bbs.Bbs" %>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("utf-8"); %>
<jsp:useBean id ="bbs" class="bbs.Bbs" scope="page" />
<jsp:setProperty name="bbs" property="bbsTitle"/>
<jsp:setProperty name="bbs" property="bbsContent"/>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>경제뉴스 포럼</title>
</head>
<body>
	<%
	//		현재 세션상태를 체크
		String userID = null;
		if(session.getAttribute("userID") != null ){
			userID = (String)session.getAttribute("userID");
		}
	
	//		로그인 한 사람만 글을 쓸수 있도록 코드를 수정한다
		
		int boardID = 0;
		if (request.getParameter("boardID") != null){
			boardID = Integer.parseInt(request.getParameter("boardID"));
		}	
		
		if(userID == null){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('로그인을 하세요.')");
			script.println("location.href='Login.jsp'");
			script.println("</script>");
		}
		
		
// 		글이 유효한지 판별
		 
		int bbsID = 0 ;
		if(request.getParameter("bbsID") != null ) {
			bbsID = Integer.parseInt(request.getParameter("bbsID"));	
		}
		if(bbsID == 0) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('유효하지 않은 글입니다.')");
			script.println("location.href='Bbs.jsp?boardID="+boardID+"\'");
			script.println("</script>");
		}
		//해당 'bbsID' 에 대한 게시글을 가져온 다음 세션을 통하여 작성자 본인이 맞는지 체크한다.
		
		if(!userID.equals(bbs.getUserID())) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('권한이 없습니다.')");
			script.println("location.href='Bbs.jsp?boardID="+boardID+"\'");
			script.println("</script>");
		
		}else {
// 		입력이 안된 부분이 있는지 체크한다.	
			if(bbs.getBbsTitle().equals("") ||bbs.getBbsContent().equals("")) {
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('입력이 안 된 사항이 있습니다.')");
				script.println("history.back()");
				script.println("</script>");
			}else {
	// 			정상적으로 입력이 되었다면 글쓰기 로직을 수행한다
				BbsDAO bbsDAO = new BbsDAO();
				int result = bbsDAO.update(bbsID, bbs.getBbsTitle(), bbs.getBbsContent());
				if(result == -1) {
						PrintWriter script = response.getWriter();
						script.println("<script>");
						script.println("alert('글 수정하기에 실패했습니다.')");
						script.println("history.back()");
						script.println("</script>");
// 		글쓰기가 정상적으로 실행되면 알림창을 띄우고 게시판 메인으로 이동한다
				}else{
						PrintWriter script = response.getWriter();
						script.println("<script>");
						script.println("alert('글 수정하기 성공')");
						script.println("location.href='Bbs.jsp?boardID="+boardID+"\'");
						script.println("</script>");
					}
				}
			}
	%> 
</body>

</html>