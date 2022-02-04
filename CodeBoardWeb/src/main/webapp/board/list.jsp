<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="boardWeb.util.*" %>
<%@ page import="java.util.*" %>
<%
	String type_ = request.getParameter("type");

	Connection conn	= null;
	PreparedStatement psmt = null;
	ResultSet rs	= null;
	
	ArrayList board_type = new ArrayList();
	try{
		conn = DBManager.getConnection();
		
		String sql = " select * from board grup by type";
		
		psmt = conn.prepareStatement(sql);
		rs = psmt.executeQuery();
		
		
	}catch(Exception e){
		e.printStackTrace();
	}finally{
		DBManager.close(psmt,conn,rs);
	}

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%@ include file="/header.jsp" %>
	<%@ include file="/nav.jsp" %>
	<%@ include file="/board/route.jsp" %>
	<div id="search">
		<form>
			<select>
				<option value="all">전체</option>
				<option></option>
				<option></option>
				<option></option>
				<option></option>
				<option></option>
				<option></option>
			</select>
		</form>
	</div>
	
	
	
	<%@ include file="/footer.jsp" %>

</body>
</html>