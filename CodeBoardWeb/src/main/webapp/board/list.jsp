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
	String searchType= request.getParameter("searchType");
	String searchVal= request.getParameter("searchVal");
	String type_ = request.getParameter("type");
	String nowPage= request.getParameter("nowPage");
	if(nowPage==null){
		nowPage="1";
	}
	
	//현재페이지의 url을 파리미터까지 세션에 담기
	String page_url = request.getRequestURL().toString();
	session.setAttribute("page_url", page_url+"?type="+type_+"&searchType="+searchType+"&searchVal="+searchVal+"&nowPage="+nowPage);
	
	int nowPageI = 1;
	if(nowPage != null){
		nowPageI = Integer.parseInt(nowPage);
	}
	
	if(type_==null||type_==""||type_=="null"||type_.equals("null")||type_.equals("전체글")){
		type_="all";
	}
	if(type_!=null && type_.equals("공지사항")){
		type_="NOTICE";
	}
	
	conn	= null;
	psmt = null;
	rs	= null;
	
	
	int count = 0;
	
	
	PagingUtil paging = null;
	try{
		conn = DBManager.getConnection();
		String sql = "";
		
		if(type_!=null&&type_.equals("all")){
			sql = "select count(*) as total from (SELECT ROWNUM r,b.* FROM board b where delyn = 'N' order by bidx desc) c";
		}else if(type_!=null){
			sql = " SELECT count(*) as total FROM( SELECT ROWNUM  rr, d.* FROM (SELECT c.* FROM (SELECT ROWNUM r , b.* FROM (select a.* from board a where type_ = '"+type_+"' and delyn='N' ORDER BY bidx) b ) c ORDER BY c.r desc) d)e";
		}
		if(searchVal!=null && !searchVal.equals("") && !searchVal.equals("null")){
			if(searchType.equals("title")){
				sql += " where title like '%"+searchVal+"%'";
			}else if(searchType.equals("nickname")){
				sql += " where nickname like '%"+searchVal+"%'";
			}else if(searchType.equals("title_content")){
				sql += " where title like '%"+searchVal+"%' or content like '%"+searchVal+"%'";
			}
		}
		psmt = conn.prepareStatement(sql);
		rs = psmt.executeQuery();
		
		int total =0;
		if(rs.next()){
			total = rs.getInt("total");
		}
		
		paging = new PagingUtil(total,nowPageI,10);
		
		sql = " select * from ";
		sql += " (select rownum rrr , f.* from";
		if(type_!=null&&type_.equals("all")){
			sql += "(select c.*,TO_CHAR(createdDate,'YYYY-MM-DD') dt from (SELECT ROWNUM r,b.* FROM board b where delyn = 'N' order by bidx) c";
		}else if(type_!=null){
			sql += "(SELECT e.*,TO_CHAR(createdDate,'YYYY-MM-DD') dt FROM (SELECT ROWNUM  rr, d.* FROM (SELECT c.* FROM (SELECT ROWNUM r , b.* FROM (select a.* from board a where type_ = '"+type_+"' and delyn='N' ORDER BY bidx) b ) c ORDER BY c.r desc) d)e";
		}
		if(searchVal!=null && !searchVal.equals("") && !searchVal.equals("null")){
			if(searchType.equals("title")){
				sql += " where upper(title) like upper('%"+searchVal+"%')";
			}else if(searchType.equals("nickname")){
				sql += " where upper(nickname) like upper('%"+searchVal+"%')";
			}else if(searchType.equals("title_content")){
				sql += " where upper(title) like upper('%"+searchVal+"%') or upper(content) like upper('%"+searchVal+"%')";
			}
		}
		
		sql += " order by bidx desc ) f)";
		sql += " where rrr>="+paging.getStart()+" and rrr<="+paging.getEnd(); 
		
		
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
	<section id="listPage_section">
	<div id="search">
		<%@ include file="/search_form.jsp" %>
	</div>
	<table id="board">
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
				<td><%=rs.getInt("r") %></td>
				<td><a href="view.jsp?bidx=<%=rs.getInt("bidx") %>&type=<%=rs.getString("type_")%>"><%=rs.getString("title") %></a></td>
				<td><%=rs.getString("nickname") %></td>
				<td><%=rs.getString("dt") %></td>
			</tr>
		<%}%>	
		</tbody>
	</table>
	
	<div id="pagingArea">
		<%if(paging.getStartPage()>1){ %>
			<a href="list.jsp?nowPage=<%=paging.getStartPage()-1%>&searchType=<%=searchType%>&searchVal=<%=searchVal%>">&lt;</a>
			
			
		<%} %>	
		
		<%for(int i= paging.getStartPage(); i<=paging.getEndPage();i++){ 
			if(i == paging.getNowPage()){
		%>
			<b><%= i %></b>
		<% 		
			}else{
		%>
			<a href="list.jsp?nowPage=<%=i%>&searchType=<%=searchType%>&searchVal=<%=searchVal%>&type=<%=type_%>"><%= i %></a>
			<%} %>
			
		<%} %>
		
		<%if(paging.getEndPage() != paging.getLastPage()){ %>
			<a href="list.jsp?nowPage=<%=paging.getNowPage()+1%>&searchType=<%=searchType%>&searchVal=<%=searchVal%>&type=<%=type_%>">&gt;</a>
			
			
		<%} %>
	</div>
	
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