<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="boardWeb.util.*" %>
<%@ page import="java.util.*" %>
<%@ include file="/jsp/board_type.jsp" %>
<%
	Member login = (Member)session.getAttribute("loginUser");
%>
<%
	String board_searchType= request.getParameter("board_searchType");
	String post_searchType= request.getParameter("post_searchType");
	String searchVal= request.getParameter("searchVal");
	String type_ = request.getParameter("type");
	System.out.println(board_searchType);
	System.out.println(post_searchType);
	System.out.println(searchVal);
	System.out.println(type_);
	
	if(type_==null||type_==""){
		type_="all";
	}
	if(type_!=null && type_.equals("공지사항")){
		type_="NOTICE";
	}
	
	conn	= null;
	psmt = null;
	rs	= null;
	
	
	int count = 0;
	
	ArrayList<Board> board = new ArrayList<>();
	try{
		conn = DBManager.getConnection();
		String sql = "";
		/* String sql = " select type_ from board a group by type_ ";
		
		psmt = conn.prepareStatement(sql);
		rs = psmt.executeQuery();
		
		while(rs.next()){
			board_type.add(rs.getString("type_"));
			count++;
		} */
		if(board_searchType!=null){
			sql = " SELECT e.*,TO_CHAR(createdDate,'YYYY-MM-DD') dt FROM( SELECT ROWNUM  rr, d.* FROM (SELECT c.* FROM (SELECT ROWNUM r , b.* FROM (select a.* from board a where type_ = ? and delyn='N' ORDER BY bidx) b ) c ORDER BY c.r desc) d)e";
			psmt = conn.prepareStatement(sql);
			psmt.setString(1,board_searchType);
		}else if(type_.equals("all")){
			sql = "select c.*,TO_CHAR(createdDate,'YYYY-MM-DD') dt from (SELECT ROWNUM r,b.* FROM board b where delyn = 'N' order by bidx desc) c";
			psmt = conn.prepareStatement(sql);
		}else{
			sql = " SELECT e.*,TO_CHAR(createdDate,'YYYY-MM-DD') dt FROM( SELECT ROWNUM  rr, d.* FROM (SELECT c.* FROM (SELECT ROWNUM r , b.* FROM (select a.* from board a where type_ = ? and delyn='N' ORDER BY bidx) b ) c ORDER BY c.r desc) d)e";
			
			psmt = conn.prepareStatement(sql);
			psmt.setString(1,type_);
			
		}
		if(post_searchType!=null && !post_searchType.equals("") && !post_searchType.equals("null")){
			if(post_searchType.equals("title")){
				sql += " where title like '%"+post_searchType+"%'";
			}else if(post_searchType.equals("nickname")){
				sql += " where nickname like '%"+post_searchType+"%'";
			}else if(post_searchType.equals("title_content")){
				sql += " where title like '%"+post_searchType+"%' and nickname like '%"+post_searchType+"%'";
			}
			
		}
		rs = psmt.executeQuery();
		while(rs.next()){
			Board temp = new Board();
			temp.setBidx(rs.getInt("bidx"));
			temp.setMidx(rs.getInt("midx"));
			temp.setType(rs.getString("type_"));
			temp.setTitle(rs.getString("title"));
			temp.setContent(rs.getString("content"));
			temp.setNickname(rs.getString("nickname"));
			temp.setCreateddate(rs.getString("dt"));
			temp.setRnum(rs.getInt("r"));
			
			
			board.add(temp);
			
		}

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<link href="<%=request.getContextPath()%>/css/base.css" rel="stylesheet">
<link href="<%=request.getContextPath()%>/css/route.css" rel="stylesheet">
<link href="<%=request.getContextPath()%>/css/table.css" rel="stylesheet">
<script src="<%=request.getContextPath()%>/js/jquery-3.6.0.min.js"></script>
<script>
	$(document).ready(function() {
		
		//네비의 div클릭시 해당 div의 자식 span의 textcontent를 가져와서 list페이지로 이동하며 데이터를 보내는 쿼리문
		$('nav div div').click(function(){
			console.log($(this).children('span').text());
			location.href="<%=request.getContextPath()%>/board/list.jsp?type="+$(this).children('span').text();
		});
	});
	
</script>
</head>
<body>
	<%@ include file="/header.jsp" %>
	<%@ include file="/nav.jsp" %>
	<%@ include file="/route.jsp" %>
	<section>
	<div id="search">
		<form>
			<%if(type_=="all"){ %>
			<select name="board_searchType">
				<option value="all">전체</option>
				<%for(String type : board_type){%>
				<option value="<%=type%>"><%=type%></option>
				<% }%>
			</select>
			<%} %>
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
		<%for(Board b : board){%>
			<tr>
				<td><%=b.getRnum() %></td>
				<td><a href="view.jsp?bidx=<%=b.getBidx() %>&type=<%=b.getType()%>"><%=b.getTitle() %></a></td>
				<td><%=b.getNickname() %></td>
				<td><%=b.getCreateddate() %></td>
			</tr>
		<%}%>	
		</tbody>
	</table>
	
	
		<%if(login != null){%>
		<%if(type_.equals("NOTICE") && login.getGrade().equals("R")){ %>
		<button onclick="location.href='insert.jsp?type=<%=type_%>'">글쓰기</button>
		<%}else if(!type_.equals("NOTICE")){ %>
		<button onclick="location.href='insert.jsp?type=<%=type_%>'">글쓰기</button>
		<%} %>
		<%}%>
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