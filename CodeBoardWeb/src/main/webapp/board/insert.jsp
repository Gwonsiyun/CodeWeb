<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "boardWeb.vo.*" %>
<%@ include file="/jsp/board_type.jsp" %>
<%
	Member login = (Member)session.getAttribute("loginUser");
%>
<%
	String type_  = request.getParameter("type");
	
%>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="<%=request.getContextPath()%>/css/base.css" rel="stylesheet">
<script src="<%=request.getContextPath()%>/js/jquery-3.6.0.min.js"></script>
</head>
<body>
	<%@ include file="/header.jsp" %>
	<section>
		<h2>게시글 등록</h2>
		<article>
			<form action="insertOk.jsp" method="post">
				<table border="1">
					<tr>
						<th>제목</th>
						<td><input type="text" name="title"></td>
					</tr>
					<tr>
						<th>게시판</th>
						<td>
						<select name="type">
							<%for(String type : board_type){%>
								<%if(!type.equals("NOTICE")||login.getGrade().equals("R")) {%>
								<option value="<%=type%>"><%=type%></option>
								<%} %>
							<%}%>
						</select>
						</td>
					</tr>
					<tr height="300">
						<th>내용</th>
						<td><textarea name="content" rows="15"></textarea></td>
					</tr>
				</table>
				<input type="button" value="취소" onclick="location.href='list.jsp?type=<%=type_%>'">
				<input type="submit" value="등록">
			</form>
		</article>
	</section>
	<%@ include file="/footer.jsp" %>
</body>
</html>