<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<title>회원가입</title>
		<link href="<%=request.getContextPath()%>/css/base.css" rel="stylesheet">
		<link href="<%=request.getContextPath()%>/css/singUp.css" rel="stylesheet">
		<script src="<%=request.getContextPath() %>/js/jquery-3.6.0.min.js"></script>
		<script>
			var checkid = false;
			var checkid2 = false;
			var checkpassword = false;
			var checkpasswordre = false;
			var checkname = false;
			var checkbirth = false;
			var checkemail = false;
			var checkphone = false;

			function maxLengthCheck(obj){
			    if (obj.value.length > obj.maxLength){
			      	obj.value = obj.value.slice(0, obj.maxLength);
			    }    
		  	}
			function checkFn(obj){
				var reg = "";
				var value = $(obj).val();
				var name = $(obj).attr("name");
				var span = $(obj).parent().children('.check');
				var span2 = $(obj).parent().children('.check2');
				switch(name){
					case "id": reg = /^[a-z]+[a-z0-9]{4,14}/g; break;
					case "password": reg = /^.*(?=^.{8,16}$)(?=.*\d)(?=.*[a-zA-Z])(?=.*[!@#$%^&+=]).*$/; break;
					case "name": reg = /^[가-힣a-zA-Z]/g; break;
					case "nickName": reg = /^[가-힣a-zA-Z]/g; break;
					case "birth": reg = /^(19[0-9][0-9]|20\d{2})(0[1-9]|1[0-2])(0[1-9]|[1-2][0-9]|3[0-1])$/; break;
					case "email": reg = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i; break;
					case "phone": reg = /^\d{3}\d{3,4}\d{4}$/; break;
				}
				if(value == ""){
					span2.css({"display" : "none"});
					span.text("필수입력");
					span.css({"color" : "red", "display" : "inline"});
					$(obj).css({"border" : "3px solid red"});
					switch(name){
						case "id": 
							checkid = false; 
							break;
						case "password": 
							checkpassword = false; 
							break;
						case "name": 
							checkname = false; 
							break;
						case "birth": 
							checkbirth = false; 
							break;
						case "email": 
							checkemail = false; 
							break;
						case "phone": 
							checkphone = false; 
							break;
					}
				}else if(!reg.test(value)){
					span.css({"display" : "none"});
					$(obj).css({"border" : "3px solid red"});
					switch(name){
						case "id": 
							span2.text("5~15자 영문 소문자, 숫자를 모두사용하세요.");
							span2.css({"color" : "red", "display" : "inline", "font-size" : "0.5em"});
							checkid = false; 
							break;
						case "password": 
							span2.text("8~16자 영문 대 소문자, 숫자, 특수문자를 모두사용하세요.");
							span2.css({"color" : "red", "display" : "inline", "font-size" : "0.5em"});
							checkpassword = false; 
							break;
						case "name": 
							span2.text("한글, 영문사용");
							span2.css({"color" : "red", "display" : "inline", "font-size" : "0.5em"});
							checkname = false; 
							break;
						case "birth": 
							span2.text("8자리 숫자만 입력하여 주세요 예)19970813");
							span2.css({"color" : "red", "display" : "inline", "font-size" : "0.5em"});
							checkbirth = false; 
							break;
						case "email": 
							span2.text("이메일양식에 맞지 않습니다.");
							span2.css({"color" : "red", "display" : "inline", "font-size" : "0.5em"});
							checkemail = false; 
							break;
						case "phone": 
							span2.text("숫자만 입력하여 주세요.");
							span2.css({"color" : "red", "display" : "inline", "font-size" : "0.5em"});
							checkphone = false; 
							break;
					}
				}else{
					span.css({"display" : "none"});
					span2.css({"display" : "none"});
					$(obj).css({"border" : "3px solid green"});
					switch(name){
						case "id": 
							checkid = true; 
							break;
						case "password": 
							checkpassword = true; 
							break;
						case "name": 
							checkname = true; 
							break;
						case "birth": 
							checkbirth = true; 
							break;
						case "email": 
							checkemail = true; 
							break;
						case "phone": 
							checkphone = true; 
							break;
					}
				}
			}
			function pass(obj){
				var pass = $('#password').val();
				var valus = $(obj).val();
				var span = $(obj).parent().children('.check');
				var span2 = $(obj).parent().children('.check2');
				if(valus==""){
					span2.css({"display" : "none"});
					$(obj).css({"border" : "3px solid red"});
					span.text("필수입력");
					span.css({"color" : "red", "display" : "inline"});
					checkpasswordre = false;
				}else if(valus!=pass){
					span.css({"display" : "none"});
					$(obj).css({"border" : "3px solid red"});
					span2.text("비밀번호가 다릅니다.");
					span2.css({"color" : "red", "display" : "inline", "font-size" : "0.5em"});
					checkpasswordre = false;
				}else{
					span.css({"display" : "none"});
					span2.css({"display" : "none"});
					$(obj).css({"border" : "3px solid green"});
					checkpasswordre = true;
				}
			}
			function singUp(){
				console.log($('#id_check'));
				if(!checkid||!checkpassword||!checkpasswordre||!checkname||!checkbirth||!checkemail||!checkphone){
					$('.impor').blur();
				}else if(!checkid2){
					$('#id_check').click();
				}else{
					$('form').submmit();
				}
			}
			function id_check_fn(obj){
				var id=$('#id').val();
				var span = $(obj).parent().children('.check');
				if(id!=""){
					$.ajax({
	                  	url : "checkid.jsp",
	                  	type : "get",
	                  	data : "id="+id,
	                 	success : function(data){
							if(data!=0){
								$(obj).prev().css({"border" : "3px solid red"});
								span.text("중복이거나 탈퇴한 아이디입니다.");
								span.css({"color" : "red", "display" : "inline"});
								checkid2 = false;
							}else if(data==0){
								$(obj).prev().css({"border" : "3px solid green"});
								span.text("회원가입 할 수 있는 아이디 입니다.");
								span.css({"color" : "green", "display" : "inline"});
								checkid2 = true;
							}else{
								console.log("알수없는 오류");
								checkid2 = false;
							}
	                  	
	                 	}
	               });
				}else{
					$(obj).prev().css({"border" : "3px solid red"});
					span.text("아이디는 비워둘 수 없습니다.");
					span.css({"color" : "red", "display" : "inline"});
					checkid2 = false;
				}
			}
			
			
		</script>
		
	</head>
	<body>
		<%@ include file="/header.jsp" %>
		<section>
			<form name="frm" action="singUpOk.jsp" method="post">
				<div class="header">회원가입</div>
				<div class="rows h">
					<label for="id">아이디<span class="red">*</span></label>
				</div>
				<div class="rows id">
					<input type="text" class="id impor" name="id" id="id" placeholder="아이디를 입력하세요." onblur="checkFn(this)">
					<input type="button" class="id" id="id_check" value="id 중복확인" onclick="id_check_fn(this)">
					<span class="check"></span><br>
					<span class="check2"></span>
				</div>
				<div class="rows h">
					<label for="password">비밀번호<span class="red">*</span></label>
				</div>
				
				<div class="rows">
					<input type="password" class="impor" name="password" id="password" placeholder="8~16자 영문 대 소문자, 숫자, 특수문자를 모두사용하세요." onblur="checkFn(this)">
					<span class="check"></span><br>
					<span class="check2"></span>
				</div>
				<div class="rows h">
					<label for="passwordre">비밀번호 확인<span class="red">*</span></label>
				</div>
				<div class="rows">
					<input type="password" class="impor" name="passwordre" id="passwordre" placeholder="비밀번호를 다시 입력하세요." onblur="pass(this)">
					<span class="check"></span><br>
					<span class="check2"></span>
				</div>
				<div class="rows h">
					<label for="nickName">닉네임<span class="red">*</span></label>
				</div>
				<div class="rows">
					<input type="text" class="impor" name="nickName" placeholder="한글및 영어" onblur="checkFn(this)">
					<span class="check"></span><br>
					<span class="check2"></span>
				</div>
				<div class="rows h">
					<label for="name">이름<span class="red">*</span></label>
				</div>
				<div class="rows">
					<input type="text" class="impor" name="name" id="name" placeholder="이름을 입력하세요." onblur="checkFn(this)">
					<span class="check"></span><br>
					<span class="check2"></span>
				</div>
				<div class="rows h">
					<label for="birth">생년월일<span class="red">*</span></label>
				</div>
				<div class="rows">
					<input type="number" class="impor" name="birth" id="birth" placeholder="8자리 숫자만 입력하여주세요" maxlength="8" onblur="checkFn(this)" oninput="maxLengthCheck(this)">
					<span class="check"></span><br>
					<span class="check2"></span>
				</div>
				<div class="rows h">
					<label for="gender">성별<span class="red">*</span></label>
				</div>
				<div class="rows">
					<input type="radio" name="gender" id="gender" value="m">남자
					<input type="radio" name="gender" value="f">여자
				</div>
				<div class="rows h">
					<label for="email">이메일<span class="red">*</span></label>
				</div>
				<div class="rows">
					<input type="email" class="impor" name="email" id="email" placeholder="이메일을 입력하세요" onblur="checkFn(this)">
					<span class="check"></span><br>
					<span class="check2"></span>
				</div>
				<div class="rows h">
					<label for="phone">연락처<span class="red">*</span></label>
				</div>
				<div class="rows">
					<input type="text" class="impor" name="phone" id="phone" placeholder="숫자만 입력하여주세요" maxlength="11" onblur="checkFn(this)">
					<span class="check"></span><br>
					<span class="check2"></span>
				</div>
				<div class="rows">
					<label>
						<input type="submit" value="회원가입" onclick="singUp();return false">
					</label>
				</div>
			</form>
		</section>
		<%@ include file="/footer.jsp" %>
	</body>
</html>