<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="boardWeb.util.*"%>
<%@ page import="boardWeb.vo.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>신미네르바 회원가입 페이지 입니다.</title>
<link href="<%=request.getContextPath() %>/css/base.css" rel="stylesheet">
<script src="<%=request.getContextPath() %>/js/jquery-3.6.0.min.js"></script>
<script>
      var idresult = true;
      function checkFn(type){
         var result = true;
         var checkId = /^[a-z]+[a-z0-9]{5,15}/g;
         var checkNick = /^[가-힣]{2,12}/g;
         var checkPwd = /^.*(?=^.{8,16}$)(?=.*\d)(?=.*[a-zA-Z])(?=.*[!@#$%^&+=]).*$/;
         var checkName = /^[가-힣a-zA-Z]/g;
         var checkYear = /^[0-9]{4}/g;
         var checkDate = /\d{1,2}/;
         var checkPhone = /^[0-9]{11,19}/g;
         var checkEmail = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;
         
         var idVal = $("#id").val();
         var nickVal = $("#nickname").val();
         var pwdVal1 = $("#pwd1").val();
         var pwdVal2 = $("#pwd2").val();
         var nameVal = $("#name").val();
         var yyVal = $("#yy").val();
         var mmVal = $("#mm option:selected").val();
         var ddVal = $("#dd").val();
         var phVal = $("#phoneNo").val();
         var emailVal = $("#email").val();
         if(type == 'id'){
            var joinId = idVal;
            var span = $("#id").next();
            if(idVal == ""){
               span.text("필수 정보입니다");
               span.css({"color" : "red", "display" : "inline"});
            }else if(!checkId.test(idVal)){
               span.text("5~15자의 영문 소문자, 숫자만 사용 가능합니다");
               span.css({"color" : "red", "display" : "inline"});
            }else{
               $.ajax({
                  url : "checkid.jsp",
                  type : "post",
                  data : "memberid="+joinId,
                  success : function(data){
                     var json = JSON.parse(data.trim());
                     if(json == ""){
                        span.text("멋진 아이디네요!");
                        span.css({"color" : "green", "display" : "inline"});
                        idresult = true;
                     }else {
                        span.text("이미 사용중이거나 탈퇴한 아이디입니다.");
                        span.css({"color" : "red", "display" : "inline"});
                        idresult = false;
                     }
                  }
               });
            }
         }else if(type == 'nickname'){
            var span = $("#nickname").next();
            if(nickVal == ""){
               span.text("필수 정보입니다");
               span.css({"color" : "red", "display" : "inline"});
            }else if(!checkNick.test(nickVal)){
               span.text("2~12자 한글만 사용 가능합니다.");
               span.css({"color" : "red", "display" : "inline"});
            }else{
               span.text("");
               span.css({"display" : "none"});
            }
         }else if(type == 'pass'){
            var span = $("#pwd1").next();
            if(pwdVal1 == ""){
               span.text("필수 정보입니다");
               span.css({"color" : "red", "display" : "inline"});
            }else if(!checkPwd.test(pwdVal1)){
               span.text("8~16자 영문 대 소문자, 숫자, 특수문자를 사용하세요.(&문자는 사용할수 없습니다.)");
               span.css({"color" : "red", "display" : "inline"});
            }else{
               span.text("");
               span.css({"display" : "none"});
            }
         }else if(type == 'passre'){
            var span = $("#pwd2").next();
            if(pwdVal2 == ""){
               span.text("필수 정보입니다");
               span.css({"color" : "red", "display" : "inline"});
            }else if(pwdVal1 != pwdVal2){
               span.text("비밀번호가 일치하지 않습니다.");
               span.css({"color" : "red", "display" : "inline"});
            }else{
               span.text("");
               span.css({"display" : "none"});
            }
         }else if(type == 'name'){
            var span = $("#name").next();
            if(nameVal == ""){
               span.text("필수 정보입니다");
               span.css({"color" : "red", "display" : "inline"});
            }else if(!checkName.test(nameVal)){
               span.text("한글과 영문 대 소문자를 사용하세요. (특수기호, 공백 사용 불가)");
               span.css({"color" : "red", "display" : "inline"});
            }else{
               span.text("");
               span.css({"display" : "none"});
            }
         }else if(type == 'birth'){
            var span = $("#birth_");
            if(yyVal == ""){
               span.text("태어난 년도 4자리를 정확하게 입력하세요.");
               span.css({"color" : "red", "display" : "inline"});
            }else if(!checkYear.test(yyVal)){
               span.text("태어난 년도 4자리를 정확하게 입력하세요.");
               span.css({"color" : "red", "display" : "inline"});
            }else{
               if(mmVal == "00"){
                  span.text("태어난 월을 선택하세요.");
                  span.css({"color" : "red", "display" : "inline"});
               }else{
                  if(ddVal == "0" || ddVal == "00"){
                     span.text("생년월일을 다시 확인해주세요.");
                     span.css({"color" : "red", "display" : "inline"});
                  }else if(ddVal == ""){
                     span.text("태어난 일(날짜) 2자리를 정확하게 입력하세요.");
                     span.css({"color" : "red", "display" : "inline"});
                  }else{
                     if(mmVal == "01" || mmVal == "03" || mmVal == "05" || mmVal == "07" || mmVal == "08" || mmVal == "10" || mmVal == "12"){
                        if(ddVal <= 31){
                           span.text("");
                           span.css({"display" : "none"});
                        }else{
                           span.text("생년월일을 다시 확인해주세요.");
                           span.css({"color" : "red", "display" : "inline"});
                        }
                     }else if(mmVal == "02"){
                        if(yyVal%4 == 0){
                           if(ddVal <= 29){
                              span.text("");
                              span.css({"display" : "none"});
                           }else{
                              span.text("생년월일을 다시 확인해주세요.");
                              span.css({"color" : "red", "display" : "inline"});
                           }
                        }else{
                           if(ddVal <= 28){
                              span.text("");
                              span.css({"display" : "none"});
                           }else{
                              span.text("생년월일을 다시 확인해주세요.");
                              span.css({"color" : "red", "display" : "inline"});
                           }
                        }
                     }else{
                        if(ddVal <= 30){
                           span.text("");
                           span.css({"display" : "none"});
                        }else{
                           span.text("생년월일을 다시 확인해주세요.");
                           span.css({"color" : "red", "display" : "inline"});
                        }
                     }
                  }
               }
            }
         }else if(type == 'month'){
            var span = $("#birth_");
            if(mmVal == "00"){
               span.text("태어난 월을 선택하세요.");
               span.css({"color" : "red", "display" : "inline"});
            }else if(mmVal != "00"){
               if(yyVal == ""){
                  span.text("태어난 년도 4자리를 정확하게 입력하세요.");
                  span.css({"color" : "red", "display" : "inline"});
               }else if(ddVal == ""){
                  span.text("태어난 일(날짜) 2자리를 정확하게 입력하세요.");
                  span.css({"color" : "red", "display" : "inline"});
               }else if(ddVal == "0" || ddVal == "00"){
                  span.text("생년월일을 다시 확인해주세요.");
                  span.css({"color" : "red", "display" : "inline"});
               }else{
                  if(mmVal == "01" || mmVal == "03" || mmVal == "05" || mmVal == "07" || mmVal == "08" || mmVal == "10" || mmVal == "12"){
                     if(ddVal <= 31){
                        span.text("");
                        span.css({"display" : "none"});
                     }else{
                        span.text("생년월일을 다시 확인해주세요.");
                        span.css({"color" : "red", "display" : "inline"});
                     }
                  }else if(mmVal == "02"){
                     if(yyVal%4 == 0){
                        if(ddVal <= 29){
                           span.text("");
                           span.css({"display" : "none"});
                        }else{
                           span.text("생년월일을 다시 확인해주세요.");
                           span.css({"color" : "red", "display" : "inline"});
                        }
                     }else{
                        if(ddVal <= 28){
                           span.text("");
                           span.css({"display" : "none"});
                        }else{
                           span.text("생년월일을 다시 확인해주세요.");
                           span.css({"color" : "red", "display" : "inline"});
                        }
                     }
                  }else{
                     if(ddVal <= 30){
                        span.text("");
                        span.css({"display" : "none"});
                     }else{
                        span.text("생년월일을 다시 확인해주세요.");
                        span.css({"color" : "red", "display" : "inline"});
                     }
                  }
               }
            }
         }else if(type == 'day'){
            var span = $("#birth_");
            if(ddVal == ""){
               span.text("태어난 일(날짜) 2자리를 정확하게 입력하세요.");
               span.css({"color" : "red", "display" : "inline"});
            }else if(!checkDate.test(ddVal)){
               span.text("생년월일을 다시 확인해주세요.");
               span.css({"color" : "red", "display" : "inline"});
            }else if(ddVal == "0" || ddVal =="00"){
               span.text("생년월일을 다시 확인해주세요.");
               span.css({"color" : "red", "display" : "inline"});
            }else{
               if(yyVal == ""){
                  span.text("태어난 년도 4자리를 정확하게 입력하세요.");
                  span.css({"color" : "red", "display" : "inline"});
               }else if(mmVal == "00"){
                  span.text("태어난 월을 선택하세요.");
                  span.css({"color" : "red", "display" : "inline"});
               }else{
                  if(mmVal == "01" || mmVal == "03" || mmVal == "05" || mmVal == "07" || mmVal == "08" || mmVal == "10" || mmVal == "12"){
                     if(ddVal <= 31){
                        span.text("");
                        span.css({"display" : "none"});
                     }else{
                        span.text("생년월일을 다시 확인해주세요.");
                        span.css({"color" : "red", "display" : "inline"});
                     }
                  }else if(mmVal == "02"){
                     if(yyVal%4 == 0){
                        if(ddVal <= 29){
                           span.text("");
                           span.css({"display" : "none"});
                        }else{
                           span.text("생년월일을 다시 확인해주세요.");
                           span.css({"color" : "red", "display" : "inline"});
                        }
                     }else{
                        if(ddVal <= 28){
                           span.text("");
                           span.css({"display" : "none"});
                        }else{
                           span.text("생년월일을 다시 확인해주세요.");
                           span.css({"color" : "red", "display" : "inline"});
                        }
                     }
                  }else{
                     if(ddVal <= 30){
                        span.text("");
                        span.css({"display" : "none"});
                     }else{
                        span.text("생년월일을 다시 확인해주세요.");
                        span.css({"color" : "red", "display" : "inline"});
                     }
                  }
               }
            }
         }else if(type == 'gender'){
            var span = $("#gender").next();
            if($("#gender option:selected").val() == "no"){
               span.text("필수 정보입니다");
               span.css({"color" : "red", "display" : "inline"});
            }else{
               span.text("");
               span.css({"display" : "none"});
            }
         }else if(type == 'addr'){
            var span = $("#addr").next();
            if($("#addr option:selected").val() == "선택"){
               span.text("필수 정보입니다");
               span.css({"color" : "red", "display" : "inline"});
            }else{
               span.text("");
               span.css({"display" : "none"});
            }
         }else if(type == 'phone'){
            var span = $("#phoneNo").next();
            if(phVal == ""){
               span.text("필수 정보입니다");
               span.css({"color" : "red", "display" : "inline"});
            }else if(!checkPhone.test(phVal)){
               span.text("연락처를 잘 입력하세요.");
               span.css({"color" : "red", "display" : "inline"});
            }else{
               span.text("");
               span.css({"display" : "none"});
            }
         }else if(type == 'email'){
            var joinEmail = emailVal;
            var span = $("#email").next();
            if(emailVal == ""){
               span.text("");
               span.css({"display" : "none"});
            }else if(!checkEmail.test(emailVal)){
               span.text("이메일 주소 형식이 올바르지 않습니다.");
               span.css({"color" : "red", "display" : "inline"});
            }else{
               span.text("");
               span.css({"display" : "none"});
            }
         }
      }
      function submitFn(){
         var result = true;
         var checkId = /^[a-z]+[a-z0-9]{5,15}/g;
         var checkNick = /^[가-힣]{2,12}/g;
         var checkPwd = /^.*(?=^.{8,16}$)(?=.*\d)(?=.*[a-zA-Z])(?=.*[!@#$%^&+=]).*$/;
         var checkName = /^[가-힣a-zA-Z]/g;
         var checkYear = /^[0-9]{4}/g;
         var checkDate =  /\d{1,2}/;
         var checkPhone = /^[0-9]{11,19}/g;
         var checkEmail = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;
         
         var idVal = $("#id").val();
         var nickVal = $("#nickname").val();
         var pwdVal1 = $("#pwd1").val();
         var pwdVal2 = $("#pwd2").val();
         var nameVal = $("#name").val();
         var yyVal = $("#yy").val();
         var mmVal = $("#mm option:selected").val();
         var ddVal = $("#dd").val();
         var phVal = $("#phoneNo").val();
         var emailVal = $("#email").val();
         
         var joinId = idVal;
         var span = $("#id").next();
         if(idVal == ""){
            span.text("필수 정보입니다");
            span.css({"color" : "red", "display" : "inline"});
            result = false;
         }else if(!checkId.test(idVal)){
            span.text("5~15자의 영문 소문자, 숫자만 사용 가능합니다");
            span.css({"color" : "red", "display" : "inline"});
            result = false;
         }
         span = $("#nickname").next();
         if(nickVal == ""){
            span.text("필수 정보입니다");
            span.css({"color" : "red", "display" : "inline"});
            result = false;
         }else if(!checkNick.test(nickVal)){
            span.text("2~12자 한글만 사용 가능합니다.");
            span.css({"color" : "red", "display" : "inline"});
            result = false;
         }else{
            span.text("");
            span.css({"display" : "none"});
         }
         
         span = $("#pwd1").next();
         if(pwdVal1 == ""){
            span.text("필수 정보입니다");
            span.css({"color" : "red", "display" : "inline"});
            result = false;
         }else if(!checkPwd.test(pwdVal1)){
            span.text("8~16자 영문 대 소문자, 숫자, 특수문자를 사용하세요.(&문자는 사용할수 없습니다.)");
            span.css({"color" : "red", "display" : "inline"});
            result = false;
         }else{
            span.text("");
            span.css({"display" : "none"});
         }
         
         span = $("#pwd2").next();
         if(pwdVal2 == ""){
            span.text("필수 정보입니다");
            span.css({"color" : "red", "display" : "inline"});
            result = false;
         }else if(pwdVal1 != pwdVal2){
            span.text("비밀번호가 일치하지 않습니다.");
            span.css({"color" : "red", "display" : "inline"});
            result = false;
         }else{
            span.text("");
            span.css({"display" : "none"});
         }
         
         span = $("#name").next();
         if(nameVal == ""){
            span.text("필수 정보입니다");
            span.css({"color" : "red", "display" : "inline"});
            result = false;
         }else if(!checkName.test(nameVal)){
            span.text("한글과 영문 대 소문자를 사용하세요. (특수기호, 공백 사용 불가)");
            result = false;
            span.css({"color" : "red", "display" : "inline"});
         }else{
            span.text("");
            span.css({"display" : "none"});
         }
         
         span = $("#birth_");
         if(yyVal == ""){
            span.text("태어난 년도 4자리를 정확하게 입력하세요.");
            span.css({"color" : "red", "display" : "inline"});
         }else if(!checkYear.test(yyVal)){
            span.text("태어난 년도 4자리를 정확하게 입력하세요.");
            span.css({"color" : "red", "display" : "inline"});
         }else{
            if(mmVal == "00"){
               span.text("태어난 월을 선택하세요.");
               span.css({"color" : "red", "display" : "inline"});
            }else{
               if(ddVal == "0" || ddVal == "00"){
                  span.text("생년월일을 다시 확인해주세요.");
                  span.css({"color" : "red", "display" : "inline"});
               }else if(ddVal == ""){
                  span.text("태어난 일(날짜) 2자리를 정확하게 입력하세요.");
                  span.css({"color" : "red", "display" : "inline"});
               }else{
                  if(mmVal == "01" || mmVal == "03" || mmVal == "05" || mmVal == "07" || mmVal == "08" || mmVal == "10" || mmVal == "12"){
                     if(ddVal <= 31){
                        span.text("");
                        span.css({"display" : "none"});
                     }else{
                        span.text("생년월일을 다시 확인해주세요.");
                        span.css({"color" : "red", "display" : "inline"});
                     }
                  }else if(mmVal == "02"){
                     if(yyVal%4 == 0){
                        if(ddVal <= 29){
                           span.text("");
                           span.css({"display" : "none"});
                        }else{
                           span.text("생년월일을 다시 확인해주세요.");
                           span.css({"color" : "red", "display" : "inline"});
                        }
                     }else{
                        if(ddVal <= 28){
                           span.text("");
                           span.css({"display" : "none"});
                        }else{
                           span.text("생년월일을 다시 확인해주세요.");
                           span.css({"color" : "red", "display" : "inline"});
                        }
                     }
                  }else{
                     if(ddVal <= 30){
                        span.text("");
                        span.css({"display" : "none"});
                     }else{
                        span.text("생년월일을 다시 확인해주세요.");
                        span.css({"color" : "red", "display" : "inline"});
                     }
                  }
               }
            }
         }
         
         span = $("#gender").next();
         if($("#gender option:selected").val() == "no"){
            span.text("필수 정보입니다");
            span.css({"color" : "red", "display" : "inline"});
            result = false;
         }else{
            span.text("");
            span.css({"display" : "none"});
         }
         
         span = $("#addr").next();
         if($("#addr option:selected").val() == "선택"){
            span.text("필수 정보입니다");
            span.css({"color" : "red", "display" : "inline"});
            result = false;
         }else{
            span.text("");
            span.css({"display" : "none"});
         }
         
         span = $("#phoneNo").next();
         if(phVal == ""){
            span.text("필수 정보입니다");
            span.css({"color" : "red", "display" : "inline"});
            result = false;
         }else if(!checkPhone.test(phVal)){
            span.text("연락처를 잘 입력하세요.");
            span.css({"color" : "red", "display" : "inline"});
            result = false;
         }else{
            span.text("");
            span.css({"display" : "none"});
         }
         span = $("#email").next();
         if(emailVal == ""){
            span.text("");
            span.css({"display" : "none"});
         }else if(!checkEmail.test(emailVal)){
            span.text("이메일 주소 형식이 올바르지 않습니다.");
            span.css({"color" : "red", "display" : "inline"});
            result = false;
         }else{
            span.text("");
            span.css({"display" : "none"});
         }
         
         if(result && idresult){
            document.frm.submit();
         }
      }
     function inputtext(obj){
 		console.log($(obj).attr('name'));
  	}
</script>
</head>
<body>
   <%@ include file="/header.jsp" %>
   <section>
      <form name="frm" action="joinOk.jsp" method="post" onsubmit="return false;" id="joinfrm">
         <div id="content">
            <div class=id>
               <h3><label for="id">아이디</label></h3>
               <input type="text" id="id" name="memberid" maxlength="20" onblur="checkFn('id')"><span></span>
            </div>
            <div class="password">
               <h3><label for="pwd1">비밀번호</label></h3>
               <input type="password" id="pwd1" name="memberpwd" maxlength="20" onblur="checkFn('pass')"><span></span>
            </div>
            <div class="passwordre">
               <h3><label for="pwd2">비밀번호 재확인</label></h3>
               <input type="password" id="pwd2" name="memberpwdre" maxlength="20" onblur="checkFn('passre')"><span></span>
            </div>
             <div class=nickname>
               <h3><label for="nickname">게임아이디</label></h3>
               <input type="text" id="nickname" name="nickname" maxlength="12" onblur="checkFn('nickname')"><span></span>
            </div>
            
            <div class="name">
               <h3><label for="name">이름</label></h3>
               <input type="text" id= "name" name="membername" maxlength="20" onblur="checkFn('name')"><span></span>
            </div>
            <h3><label for="yy">생년월일</label></h3>
            <div class="birth">
               <div class=bir_yy>
                  <input type="text" id="yy" name="birthyy" maxlength="4" placeholder="년4자()" onblur="checkFn('birth')"><span></span>
               </div>
               <div class="bir_mm">
                  <select name="birthmm" id="mm" onchange="checkFn('month')">
                     <option value="00" selected>월</option>
                     <option value="01">1</option>
                     <option value="02">2</option>
                     <option value="03">3</option>
                     <option value="04">4</option>
                     <option value="05">5</option>
                     <option value="06">6</option>
                     <option value="07">7</option>
                     <option value="08">8</option>
                     <option value="09">9</option>
                     <option value="10">10</option>
                     <option value="11">11</option>
                     <option value="12">12</option>
                  </select>
               </div>
               <div class="bir_dd">
                  <input type="text" id="dd" name="birthdd" maxlength="2" placeholder="일" onblur="checkFn('day')"><span></span>
               </div>
            </div>
            <p>
               <span id="birth_"></span>
            </p>
            <div class="gender">
               <h3><label for="gender">성별</label></h3>
                  <select name="gender" id="gender" onchange="checkFn('gender')">
                     <option value="no" selected>성별</option>
                     <option value="m">남</option>
                     <option value="f">여</option>
                     <option value="nosel">선택 안함</option>
                  </select><span></span>
            </div>
            <div class="addr">
               <h3><label for="addr">사는곳</label></h3>
                  <select name="addr" id="addr" onchange="checkFn('addr')" >
                        <option value="선택" selected>선택</option>
                        <option value="서울">서울</option>
                        <option value="부산">부산</option>
                        <option value="대구">대구</option>
                        <option value="인천">인천</option>
                        <option value="광주">광주</option>
                        <option value="대전">대전</option>
                        <option value="울산">울산</option>
                        <option value="강원">강원</option>
                        <option value="경기">경기</option>
                        <option value="경남">경남</option>
                        <option value="경북">경북</option>
                        <option value="전남">전남</option>
                        <option value="전북">전북</option>
                        <option value="제주">제주</option>
                        <option value="충남">충남</option>
                        <option value="충북">충북</option>
                    </select><span></span>
            </div>
            <div class="phoneNo">
               <h3><label for="phone">연락처</label></h3>
               <input type="tel" id="phoneNo" name="phone" placeholder="전화번호 입력" maxlength="16" onblur="checkFn('phone')"><span></span>
            </div>
            <div class="email">
               <h3><label for="email">이메일</label></h3>
               <input type="tel" id="email" name="email" placeholder="이메일 입력(이메일은 필수정보가 아닙니다.)" maxlength="30" onblur="checkFn('email')"><span></span>
            </div>
            <div class="join">
               <input type=submit id="btn_join" value="가입하기" onclick="submitFn()">
            </div>
            <div>
            <input type="text" id="123" name="123" value="123" onblur="inputtext(this)" size="30">
            </div>
         </div>
      </form>
   </section>
   <%@ include file="/footer.jsp" %>
</body>

</html>