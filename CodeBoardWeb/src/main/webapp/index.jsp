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
		
	})
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