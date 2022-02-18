<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="boardWeb.util.*" %>
<%@ page import="org.json.simple.*"%>
<%@ page import="java.util.*" %>
<%
	Connection conn	= null;
	PreparedStatement psmt = null;
	ResultSet rs	= null;

	int rownum = 0;
	String title = "";
	String nickname ="";

	try{
		conn = DBManager.getConnection();
		
		String sql = " select type_ from board group by type_ ";
		
		psmt = conn.prepareStatement(sql);
		rs = psmt.executeQuery();
		
		JSONArray list = new JSONArray();
		while(rs.next()){
			JSONObject jObj = new JSONObject();
			jObj.put("type",rs.getString("type_"));
			list.add(jObj);
		}
		
		session.setAttribute("type",list);
	}catch(Exception e){
		e.printStackTrace();
	}finally{
		DBManager.close(psmt,conn,rs);
	} 
%>