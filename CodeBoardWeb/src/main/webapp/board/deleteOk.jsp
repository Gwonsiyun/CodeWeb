<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*"%>
<%@ page import="boardWeb.util.*" %>
<%
	//out.print("<script>alert('수정완료!')</script>");//삭제여부 물어보고싶
	request.setCharacterEncoding("UTF-8");
	String bidx = request.getParameter("bidx");
	
	Connection conn = null;
	PreparedStatement psmt =null;

	

	try{
		conn = DBManager.getConnection();
		
		String sql = " update board set delyn='Y' where bidx= "+bidx;
		
		psmt = conn.prepareStatement(sql);
		
		int result = psmt.executeUpdate();
		
		response.sendRedirect("list.jsp");
		
	}catch(Exception e){
		e.printStackTrace();
	}finally{
		if(conn != null) conn.close();
		if(psmt != null) psmt.close();
	}
%>