<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="boardWeb.util.*"%>
<%
	String id=request.getParameter("id");

	Connection conn = null;
	PreparedStatement psmt = null;
	ResultSet rs = null;
	
	try{
		conn = DBManager.getConnection();
		
		String sql= " select * from member where id=?";
		
		psmt = conn.prepareStatement(sql);
		psmt.setString(1,id);
		
		
		int result = psmt.executeUpdate();
		System.out.println(result);
		out.println(result);
		
	}catch(Exception e){
		e.printStackTrace();
	}finally{
		if(conn != null) conn.close();
		if(psmt != null) psmt.close();
	}
%>