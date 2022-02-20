<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String type123=type_;
	if(type_==null||type_==""||type_=="null"||type_=="all"||type_.equals("all")){
		type123="전체글";
	}else if(type_=="NOTICE"){
		type123="공지사항";
	}
%>
<div id="route">
	<div id="detailedRoute">Home > <%=type123%></div>
	<div id="page"><%=type123%></div>
</div>
