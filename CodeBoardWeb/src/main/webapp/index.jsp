<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>code학습</title>
<link href="<%=request.getContextPath()%>/css/base.css" rel="stylesheet">
<script src="<%=request.getContextPath()%>/js/jquery-3.6.0.min.js"></script>
<script>
	$(document).ready(function() {
		//네비의 div클릭시 해당 div의 textcontent를 가져와서 list페이지로 이동하며 데이터를 보내는 쿼리문
		$('nav div div').click(function(){
			console.log($(this).text());
			location.href="<%=request.getContextPath()%>/board/list.jsp?type="+$(this).text();
		});
	});
</script>
</head>
<body>
	<%@ include file="/header.jsp" %>
	<%@ include file="/nav.jsp" %>
	<section>
		<div id="content">
			<div class="miniBoard"></div>
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