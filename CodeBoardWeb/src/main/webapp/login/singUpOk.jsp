<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="boardWeb.util.*"%>
<%@ page import="boardWeb.vo.*"%>
<%
	request.setCharacterEncoding("UTF-8");

	String id = request.getParameter("id");
	String pass  = request.getParameter("password");
	String nickname  = request.getParameter("nickName");
	String name_ = request.getParameter("name");
	String birthday  = request.getParameter("birth");
	String gender  = request.getParameter("gender");
	String email  = request.getParameter("email");
	String phone  = request.getParameter("phone");
	
	Connection conn = null;
	PreparedStatement psmt = null;
	ResultSet rs = null;
	
	try{
		conn = DBManager.getConnection();
		
		String sql= " insert into member(midx,id,pass,nickname,name_,birthday,gender,email,phone) values(midx_seq.nextval,?,?,?,?,?,?,?,?)";
		
		psmt = conn.prepareStatement(sql);
		psmt.setString(1,id);
		psmt.setString(2,pass);
		psmt.setString(3,nickname);
		psmt.setString(4,name_);
		psmt.setString(5,birthday);
		psmt.setString(6,gender);
		psmt.setString(7,email);
		psmt.setString(8,phone);
		
		
		int result = psmt.executeUpdate();
		
		response.sendRedirect("singIn.jsp");
		
	}catch(Exception e){
		e.printStackTrace();
	}finally{
		if(conn != null) conn.close();
		if(psmt != null) psmt.close();
	}


%>