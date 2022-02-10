<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="boardWeb.util.*"%>
<%@ page import="boardWeb.vo.*"%>
<%
	String id = request.getParameter("id");
	String pass = request.getParameter("pass");
	
	Connection conn = null;
	PreparedStatement psmt = null;
	ResultSet rs = null;
	
	try{
		conn = DBManager.getConnection();
		
		String sql = " select * from member where id=? and pass=? and delyn='N'";
		
		psmt = conn.prepareStatement(sql);
		psmt.setString(1,id);
		psmt.setString(2,pass);
		
		rs = psmt.executeQuery();
		Member m = null;
		
		if(rs.next()){
			
			m = new Member();
			m.setMidx(rs.getInt("midx"));
			m.setMemberid(rs.getString("id"));
			m.setMembername(rs.getString("nickname"));
			
			session.setAttribute("loginUser",m);
			
		}
		
		if(m != null){
			response.sendRedirect(request.getContextPath());
		}else{
			response.sendRedirect("singIn.jsp");
		}
		
	}catch(Exception e){
		e.printStackTrace();
	}finally{
		DBManager.close(psmt, conn , rs);
	}

%>