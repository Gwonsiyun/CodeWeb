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
	
	ArrayList<String> arrayList = new ArrayList<>();
	List<String> board_type = arrayList ;
	int count = 0;
	try{
		conn = DBManager.getConnection();
		
		String sql = " select type_ from board a group by type_ ";
		
		psmt = conn.prepareStatement(sql);
		rs = psmt.executeQuery();
		
		while(rs.next()){
			board_type.add(rs.getString("type_"));
			count++;
		}
		
		sql = " select a.* from board a";
		
		psmt = conn.prepareStatement(sql);
		rs = psmt.executeQuery();
		
	

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<link href="<%=request.getContextPath()%>/css/base.css" rel="stylesheet">
<link href="<%=request.getContextPath()%>/css/route.css" rel="stylesheet">
<link href="<%=request.getContextPath()%>/css/table.css" rel="stylesheet">

</head>
<body>
	<%@ include file="/header.jsp" %>
	<%@ include file="/nav.jsp" %>
	<%@ include file="/board/route.jsp" %>
	<section>
	<div id="search">
		<form>
			<select>
				<option value="all">전체</option>
				<%for(String type : board_type){%>
				<option value="<%=type%>"><%=type%></option>
				<% }%>
			</select>
			<input type="text" name="type" size="30">
			<button>검색</button>
		</form>
	</div>
	<table>
		<thead>
			<tr>
				<th>글번호</th>
				<th>제목</th>
				<th>작성자</th>
				<th>시간</th>
			</tr>
		</thead>
		<tbody>
		<%while(rs.next()){%>
			<tr>
				<td><%=rs.getInt("bidx") %></td>
				<td><a href="view.jsp?bidx=<%=rs.getInt("bidx") %>"><%=rs.getString("title") %></a></td>
				<td><%=rs.getString("nickname") %></td>
				<td><%=rs.getString("createddate") %></td>
			</tr>
		<%}%>	
		</tbody>
	</table>
	
	</section>
	<%@ include file="/footer.jsp" %>

</body>
</html>
<%
	}catch(Exception e){
		e.printStackTrace();
	}finally{
		DBManager.close(psmt,conn,rs);
	} 
	
%>