<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="boardWeb.util.*" %>
<%
	request.setCharacterEncoding("UTF-8");
	String searchType_ = request.getParameter("searchType");
	String searchValue_ = request.getParameter("searchValue");
	String type_ = request.getParameter("type");
	
	String bidx = request.getParameter("bidx");

	
	
	Connection conn = null;
	PreparedStatement psmt = null;
	ResultSet rs = null;
	
	String title_ = "";
	String content_ = "";
	
	try{
		
		conn = DBManager.getConnection();
		
		String sql = " select * from board where bidx="+bidx;
		
		psmt = conn.prepareStatement(sql);
		rs = psmt.executeQuery();
		
		if(rs.next()){
			title_ = rs.getString("title");
			content_ = rs.getString("content");
		}
		
	}catch(Exception e){
		e.printStackTrace();
	}finally{
		if(conn != null) conn.close();
		if(psmt != null) psmt.close();
		if(rs != null) rs.close();
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="<%=request.getContextPath()%>/css/base.css" rel="stylesheet">
</head>
<body>
	<%@ include file="/header.jsp" %>
	<section>
		<h2>게시글 수정</h2>
		<article>
			<form action="modifyOk.jsp" method="post">
				<input type="hidden" name="bidx" value="<%=bidx %>">
				<input type="hidden" name="type" value="<%=type_ %>">
				<table border="1" width="70%">
					<tr>
						<th>글제목</th>
						<td colsqan="3"><input type="text" size="50" name="title" value="<%=title_%>"></td>
					</tr>
					<tr height = "300px">
						<th>내용</th>
						<td colspan="3"><textarea name="content"><%=content_ %></textarea></td>
					</tr>
				</table>
				<button type="button" onclick="location.href='view.jsp?bidx=<%=bidx%>&type=<%=type_%>&searchType=<%=searchType_%>&searchValue=<%=searchValue_%>'">취소</button>
				<button type="submit">저장</button>
			</form>
		</article>
	</section>
	<%@ include file="/footer.jsp" %>
</body>
</html>