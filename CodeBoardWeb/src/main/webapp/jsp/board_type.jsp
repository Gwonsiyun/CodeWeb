<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="boardWeb.util.*" %>
<%@ page import="boardWeb.vo.*" %>
<%@ page import="java.util.*" %>
<%@ page import="org.json.simple.*"%>
<%
	Connection conn	= null;
	PreparedStatement psmt = null;
	ResultSet rs	= null;
	
	ArrayList<String> arrayList = new ArrayList<>();
	List<String> board_type = arrayList ;
	
	try{
		conn = DBManager.getConnection();
		
		String sql = " select type_ from board a group by type_ ";
		
		psmt = conn.prepareStatement(sql);
		rs = psmt.executeQuery();
		
		
		while(rs.next()){
			board_type.add(rs.getString("type_"));
		}
	}catch(Exception e){
		e.printStackTrace();
	}finally{
		DBManager.close(psmt,conn,rs);
	} 
%>