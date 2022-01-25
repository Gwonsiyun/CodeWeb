<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<title>SingUp</title>
		<script>
			/*function requiredInput(obj){
				var value = obj.value;
				if(value==""){
					var check = obj.parentElement.getElementsByClassName("check")[0];
					check.innerHTML = "*필수";
					check.style.color = "red";
					check.style.display = "inline";
				}else{
					var check = obj.parentElement.getElementsByClassName("check")[0];
					check.style.display = "none";
				}
			}*/
			var submitid=[];
			function reg(obj){
				var value = obj.value;
				var chk=obj.id;
				if(chk=="id"){
					var reg = /^[a-z]+[a-z0-9]{5,15}$/g;
				}else if(chk=="password"){
					var reg = /^(?=.*[a-zA-z])(?=.*[$`~!@$!%*#^?&\\(\\)\-_=+]).{8,16}$/g;
				}else if(chk=="name"){
					var reg = /^[가-힣]/g;
				}else if(chk=="email"){
					var reg = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/g;
				}else if(chk=="phone2"){
					var reg = /^[0-9]{3,4}/g;
				}else if(chk=="phone3"){
					var reg = /^[0-9]{4}/g;
				}else{
					var reg = "";
				}
				var check = obj.parentElement.getElementsByClassName("check")[0];
				if(value==""){
					check.innerHTML = "*필수";
					check.style.color = "red";
					check.style.display = "inline";
				}else if(!reg.test(value)){
					check.innerHTML = "*형식에 맞지 않음";
					check.style.color = "red";
					check.style.display = "inline";
				}else{
					check.style.display = "none";
				}
			}
			function pass(obj){
				var value = obj.value;
				var passValue = document.getElementById("password").value;
				var check = obj.parentElement.getElementsByClassName("check")[0];
				if(value==""){
					check.innerHTML = "*필수";
					check.style.color = "red";
					check.style.display = "inline";

				}else if(passValue!=obj.value){
					check.innerHTML = "*비밀번호가 다릅니다.";
					check.style.color = "red";
					check.style.display = "inline";
				}else{
					check.style.display = "none";
				}
			}
			function result(){
				var result=[];
				var check=document.getElementsByClassName("impor");
				for(var i=0; i<check.length; i++){
					check[i].focus();
					check[i].onfocus=function(){
						if(this.parentElement.getElementsByClassName("check")[0].style.display=="none"){
							result[i]=true;
						}else{
							result[i]=false;
						}
					}
				}
				console.log(result);
				var exutable = true;
				for(var i=0; i<result.length; i++){
					if(!result[i]){
						exutable=false;
						break;
					}
				}
				if(exutable){
					//document.frm.submit();
				}
			}
		</script>
		<style>
			body{
				margin:0px;
				background:#FAFAFA;
				font-family:Arial, "돋움", dotum, sans-serif;
				background: rgb(255,255,255);
			}
			section{
				width:500px;
				height:730px;
				text-align:center;
				margin:10vh auto;
				border-radius:5px;
			}
			form{
				width:55%;
				height:100%;
				margin:auto;
			}
			.header{
				margin-top: 30px;
				font-size:30px;
				padding:10px 0px;
				cursor:pointer;
			}
			.header:first-letter{
				font-weight:bold;
				color:red;
			}
			input{
				height:25px;
				width: 265px;
			}
		
			input[type=submit]{
				width:100%;
				height:40px;
				padding:0px;
			}
			.rows{
				width:100%;
				text-align:left;
			}
			.rows:not(.h){
				padding-bottom:15px;
			}
			div.id{
				text-align:left;
			}
			input[type=text].id{
				width:177px;
			}
			input[type=button].id{
				width:85px;
				height:36px;
				maign-top:2px;
				margin-bottom:0px;
			}
			.birth{
				width:80px;
			}
			.birth2{
				width:80px;
				height:30px;
			}
			input[type=radio]{
				width:30px;
				height:inherit;
			}
			#phone1{
				width:80px;
				height:30px;
			}
			#phone2, #phone3{
				width:80px;
			}
			.red{
				color:red;
			}
			.check{
				display:none;
				margin:10px;
				position:absolute;
				height:30px;
				font-size:9pt;
			}
		</style>
	</head>
	<body>
		<section>
			<form name="frm" action="#" method="post">
				<div class="header">SingUp</div>
				<div class="rows h">
					<label for="id">아이디<span class="red">*</span></label>
				</div>
				<div class="rows id">
					<input type="text" class="id impor" name="id" id="id" placeholder="아이디를 입력하세요." onblur="reg(this)">
					<input type="button" class="id" value="id 중복확인">
					<span class="check"></span>
				</div>
				<div class="rows h">
					<label for="password">비밀번호<span class="red">*</span></label>
				</div>
				
				<div class="rows">
					<input type="password" class="impor" name="password" id="password" placeholder="비밀번호를 입력하세요." onblur="reg(this)">
					<span class="check"></span>
				</div>
				<div class="rows h">
					<label for="passwordre">비밀번호 확인<span class="red">*</span></label>
				</div>
				<div class="rows">
					<input type="password" class="impor" name="passwordre" id="passwordre" placeholder="비밀번호를 다시 입력하세요." onblur="pass(this)">
					<span class="check"></span>
				</div>
				<div class="rows h">
					<label for="nickName">닉네임<span class="red">*</span></label>
				</div>
				<div class="rows">
					<input type="text" name="nickName">
				</div>
				<div class="rows h">
					<label for="name">이름<span class="red">*</span></label>
				</div>
				<div class="rows">
					<input type="text" class="impor" name="name" id="name" placeholder="이름을 입력하세요." onblur="reg(this)">
					<span class="check"></span>
				</div>
				<div class="rows h">
					<label for="birth1">생년월일</label>
				</div>
				<div class="rows">
					<input type="text" class="birth" name="birth1" id="birth1" placeholder="년(4자)" maxlength="4">&nbsp;
					<select class="birth2" name="birth2">
						<option value="00">월</option>
						<option value="01">1월</option>
						<option value="02">2월</option>
						<option value="03">3월</option>
						<option value="04">4월</option>
						<option value="05">5월</option>
						<option value="06">6월</option>
						<option value="07">7월</option>
						<option value="08">8월</option>
						<option value="09">9월</option>
						<option value="10">10월</option>
						<option value="11">11월</option>
						<option value="12">12월</option>
					</select>&nbsp;
					<input type="text" class="birth" name="birth3" id="birth3" placeholder="일">
				</div>
				<div class="rows h">
					<label for="gender">성별</label>
				</div>
				<div class="rows">
					<input type="radio" name="gender" id="gender" value="m">남자
					<input type="radio" name="gender" value="f">여자
				</div>
				<div class="rows h">
					<label for="email">이메일<span class="red">*</span></label>
				</div>
				<div class="rows">
					<input type="email" class="impor" name="email" id="email" placeholder="이메일을 입력하세요" onblur="reg(this)">
					<span class="check"></span>
				</div>
				<div class="rows h">
					<label for="phone1">연락처</label>
				</div>
				<div class="rows">
					<select name="phone1" id="phone1">
						<option value="010">010</option>
						<option value="010">011</option>
						<option value="010">016</option>
					</select>&nbsp;
					<input type="text" class="impor" name="phone2" id="phone2" placeholder="연락처2" maxlength="4" onKeyup="this.value=this.value.replace(/[^0-9]/g,'');" onblur="reg(this)">&nbsp;
					<input type="text" class="impor" name="phone3" id="phone3" placeholder="연락처3" maxlength="4" onKeyup="this.value=this.value.replace(/[^0-9]/g,'');" onblur="reg(this)">
					<span class="check"></span>
				</div>
				<div class="rows">
					<label>
						<input type="submit" value="회원가입" onclick="result();return false">
					</label>
				</div>
			</form>
		</section>
	</body>
</html>