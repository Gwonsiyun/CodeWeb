<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<div id="search">
	<form action="<%=request.getContextPath()%>/board/list.jsp">
		<select name="type">
			<option value="all">전체</option>
			<%for(String type : board_type){%>
			<option value="<%=type%>"><%=type%></option>
			<% }%>
		</select>
		<select name="searchType">
			<option value="title">제목</option>
			<option value="title_content">제목+내용</option>
			<option value="nickname">작성자</option>
		</select>
		<input type="text" name="searchVal" size="30">
		<button>검색</button>
	</form>
</div>