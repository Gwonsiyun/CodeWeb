<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="boardWeb.util.*" %>
<%@ page import="java.util.*" %>
<%

	Connection conn	= null;
	PreparedStatement psmt = null;
	ResultSet rs	= null;
	
	ArrayList<String> arrayList = new ArrayList<>();
	List<String> board_type = arrayList ;
	int count = 0;
	try{
		conn = DBManager.getConnection();
		
		String sql = " select type_ from board group by type_ ";
		
		psmt = conn.prepareStatement(sql);
		rs = psmt.executeQuery();
		
		while(rs.next()){
			board_type.add(rs.getString("type_"));
			count++;
		}
		
		sql = " select ? from board";
		psmt = conn.prepareStatement(sql);
		for(String type : board_type){
		psmt.setString(1,type);
		rs = psmt.executeQuery();
		}
	

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>code학습</title>
<link href="<%=request.getContextPath()%>/css/base.css" rel="stylesheet">
<script src="<%=request.getContextPath()%>/js/jquery-3.6.0.min.js"></script>
<script>
	$(document).ready(function() {
		
		//네비의 div클릭시 해당 div의 자식 span의 textcontent를 가져와서 list페이지로 이동하며 데이터를 보내는 쿼리문
		$('nav div div').click(function(){
			console.log($(this).children('span').text());
			location.href="<%=request.getContextPath()%>/board/list.jsp?type="+$(this).children('span').text();
		});
	});
	function(){
		
	}
</script>
</head>
<body>
	<%@ include file="/header.jsp" %>
	<%@ include file="/nav.jsp" %>
	<section>
		<div id="search">
			<form>
				<select name="board_searchType">
					<option value="all">전체</option>
					<%for(String type : board_type){%>
					<option value="<%=type%>"><%=type%></option>
					<% }%>
				</select>
				<select name="post_searchType">
					<option value="all">전체</option>
					<option value="title">제목</option>
					<option value="title_content">제목+내용</option>
					<option value="nickname">작성자</option>
				</select>
				<input type="text" name="type" size="30">
				<button>검색</button>
			</form>
		</div>
		<div id="content">
		<!-- 게시판타입마다 미니게시판을 만들어주고 게시판 이름 클릭시 해당하는 게시판으로 이동 -->
		<%for(String type : board_type){%>
			<div class="miniBoard">
				<div><%=type %></div>
				<div>
				<div></div>
				</div>
			</div>
		<% }%>
			
			<div class="miniBoard"></div>
			<div class="miniBoard"></div>
			<div class="miniBoard"></div>
			<div class="miniBoard"></div>
			<div class="miniBoard"></div>
		</div>
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