<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="boardWeb.vo.*" %>
<%@ page import="boardWeb.util.*" %>
<%
	Member login = (Member)session.getAttribute("loginUser");
%>
<%
	request.setCharacterEncoding("UTF-8");

	String title_ = request.getParameter("title");
	String content_  = request.getParameter("content");
	String type_  = request.getParameter("type");

	
	Connection conn	= null;
	PreparedStatement psmt = null;
	ResultSet rs = null;
	
	try{
		conn = DBManager.getConnection();
		

		String sql= " insert into board(type_,bidx,title,content,nickname,midx) values('"+type_+"',bidx_seq.nextval,?,?,?,?)";

		
		psmt = conn.prepareStatement(sql);
		psmt.setString(1,title_);
		psmt.setString(2,content_);
		psmt.setString(3,login.getNickname());
		psmt.setInt(4,login.getMidx());
		
		psmt.executeUpdate();
		
		sql = "SELECT MAX(bidx) FROM board";
		psmt = conn.prepareStatement(sql);
		rs = psmt.executeQuery();
		
		int max=0;
		while(rs.next()){
			max=rs.getInt("MAX(bidx)");
		}
		response.sendRedirect("view.jsp?bidx="+max+"&type="+type_);
		
	}catch(Exception e){
		e.printStackTrace();
	}finally{
		DBManager.close(psmt,conn,rs);
	}


%>