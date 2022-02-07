<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="boardWeb.vo.*" %>
<%
	Member m = (Member)session.getAttribute("loginUser");
%> 
<header>
	<h1 id="mainmove"><a href="<%=request.getContextPath()%>">code 학습</a></h1>
	<%if(m == null){ %>
	<div class="loginArea">
		<a href="<%=request.getContextPath()%>/login/singIn.jsp">로그인</a>
		|
		<a href="<%=request.getContextPath()%>/login/singUp.jsp">회원가입</a>
	</div>
	<% 
	}else{
		if(m.getMidx()==1){
	%>
		<div class="loginArea">
			<a href="<%=request.getContextPath()%>/login/singOut.jsp">로그아웃</a>
			|
			<a href="<%=request.getContextPath()%>/login/myPage.jsp">관리자페이지</a>
		</div>
		<%}else{%>
		<div class="loginArea">
			<a href="<%=request.getContextPath()%>/login/singOut.jsp">로그아웃</a>
			|
			<a href="<%=request.getContextPath()%>/login/myPage.jsp">마이페이지</a>
		</div>
		<%} %>
	<%} %>
</header>