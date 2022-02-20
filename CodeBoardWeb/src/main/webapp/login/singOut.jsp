<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String page_url = (String)session.getAttribute("page_url");
	session.invalidate();
	response.sendRedirect(page_url);

%>