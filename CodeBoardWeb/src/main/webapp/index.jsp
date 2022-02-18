<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="boardWeb.util.*" %>
<%@ page import="java.util.*" %>
<%
	
	Connection conn	= null;
	PreparedStatement psmt = null;
	ResultSet rs	= null;
	ResultSet rsBoard = null;
	
	int rownum = 0;
	String title = "";
	String nickname ="";
	
	
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
	

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>code학습</title>
<link href="<%=request.getContextPath()%>/css/base.css" rel="stylesheet">
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
	<section>
		<%@ include file="/search_form.jsp" %>
		<div id="content">
		<!-- 게시판타입마다 미니게시판을 만들어주고 게시판 이름 클릭시 해당하는 게시판으로 이동 -->
		<%for(String type : board_type){%>
			<div class="miniBoard">
				<div id="type"><%=type %></div>
				<div id="miniBoard_content">
				
					<table>
						<thead>
							<tr>
								<th>글번호</th>
								<th>제목</th>
								<th>작성자</th>
							</tr>
						</thead>
						<tbody>
						<%
							ArrayList<Board> miniBoard = new ArrayList<>();
						
							sql = "SELECT e.* FROM( SELECT ROWNUM  rr, d.* FROM (SELECT c.* FROM (SELECT ROWNUM r , b.* FROM (select a.* from board a where type_ = ? and delyn='N' ORDER BY bidx) b ) c ORDER BY c.r desc) d)e WHERE rr <= 5 ";
							psmt = conn.prepareStatement(sql);
							psmt.setString(1,type);
							
							rsBoard = psmt.executeQuery(); 
							
							while(rsBoard.next()){
								Board temp = new Board();
								temp.setBidx(rsBoard.getInt("bidx"));
								temp.setMidx(rsBoard.getInt("midx"));
								temp.setType(rsBoard.getString("type_"));
								temp.setTitle(rsBoard.getString("title"));
								temp.setContent(rsBoard.getString("content"));
								temp.setNickname(rsBoard.getString("nickname"));
								temp.setCreateddate(rsBoard.getString("createddate"));
								temp.setRnum(rsBoard.getInt("r"));
								
								
								miniBoard.add(temp);
								
							}
						%>
						
						<%for(Board b : miniBoard){%>
							<tr>
								<td><%=b.getRnum() %></td>
								<td><%=b.getTitle() %></td>
								<td><%=b.getNickname() %></td>
							<tr>
						<% }%>
						</tbody>
					</table>
				</div>
			</div>
		<% }%>
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
		if(rsBoard!=null)rsBoard.close();
	} 
	
%>