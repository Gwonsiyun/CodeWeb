<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>로그인 페이지</title>
	<link href="<%=request.getContextPath()%>/css/base.css" rel="stylesheet">
	<style>
		body{
			width:100%;
			height: 1000px;
			text-align: center;
		}
		#singIn{
			margin: 300px auto;
		}
		input{
			margin-bottom: 5px;
			width: 300px;
			height: 30px;
		}
		input[type="submit"]{
			width: 305px;
		}
		a[href="singUp.jsp"]{
			color: red;
		}
		
	</style>
</head>
<body>
<%@ include file="/header.jsp" %>
	<div id="singIn">
		<form action="singInOk.jsp" method="post">
			<h2>로그인</h2>
			<p>
				<input name="id" type="text" size="30" placeholder="아이디">
			</p>
			<p>
				<input name="pass" type="password" size="30" placeholder="비밀번호">
			</p>
				<input type="submit" value="로그인">
		</form>
		<div>계정이 없으신가요? <a href="singUp.jsp">회원가입</a></div>
		<div>계정 찾기는 지원하지 않습니다.</div>
	</div>
	<%@ include file="/footer.jsp" %>
</body>
</html>