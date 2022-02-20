<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<div id="search">
	<form action="<%=request.getContextPath()%>/board/list.jsp">
		<select name="type">
			<option value="all">전체</option>
			<%for(String type : board_type){%>
			<option value="<%=type%>" <%if(type_ != null && type_.equals(type)) out.print("selected");%>><%=type%></option>
			<% }%>
		</select>
		<select name="searchType">
			<option value="title" <%if(searchType != null && searchType.equals("title")) out.print("selected");%>>제목</option>
			<option value="title_content" <%if(searchType != null && searchType.equals("title_content")) out.print("selected");%>>제목+내용</option>
			<option value="nickname" <%if(searchType != null && searchType.equals("nickname")) out.print("selected");%>>작성자</option>
		</select>
		<input type="text" name="searchVal" size="30" <%if(searchVal != null && !searchVal.equals("") && !searchVal.equals("null")) out.print("value='"+searchVal+"'");%>>
		<button>검색</button>
	</form>
</div>