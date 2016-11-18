<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="mainFunction.js"></script>

<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<link href="https://maxcdn.bootstrapcdn.com/bootswatch/3.3.7/paper/bootstrap.min.css" rel="stylesheet" integrity="sha384-awusxf8AUojygHf2+joICySzB780jVvQaVCAt1clU3QsyAitLGul28Qxb2r1e5g+" crossorigin="anonymous">
<title>Insert title here</title>
<script>
$(document).ready(function(){
	var flag = $("#flag").val();
	
	if(flag!="") {
		if(flag=="false") {
			alert("중복된 아이디입니다");
		} else {
			alert("회원가입이 완료되었습니다");
			self.close();
		}
	}
});

function inputCheckSpecial(obj){
	$.ajax({
		url : "../board/idoverlapcheck",
		type : "get",
		dataType : "text",
		data : { "id" : $("#id").val()},
		success : function (result){
			if(result == ""){
				$("#iddiv").text("O");
			}else {
				$("#iddiv").text("X");
			}
		}
	})
}

function checkpassword(){
	if($("#password").val() == $("#repassword").val()){
		$("#passworddiv").text("O");
	}else{
		$("#passworddiv").text("X");
	}
}

function register(){
	if($("#passworddiv").text()=="X"){
		alert("비밀번호확인");
		return;
	}
	$.ajax({
		url : "../board/register",
		type : "post",
		dataType : "text",
		data : { "id" : $("#id").val(), "password" : $("#password").val(), "email" : $("#email").val()},
		success : function(result){
			alert("등록되었습니다");
			self.close();
		},
		error : function(xhr, data, error){
			alert("가입할수없습니다.");
		}
	});
}

</script>
</head>
<body>
		<form action="../board/register" method="post">
			<table class="table table-striped table-hover ">
				<thead>
	                <tr>
 	                	<th class="danger" colspan="2" style="text-align:center">회원가입</th>
	                </tr>
                </thead>
                <tbody>
	                <tr>
	                    <td width="30%">아이디:</td>
	                    <td width="70%"><input type="text" id="id" name="id" placeholder="아이디" onchange="inputCheckSpecial(this)" style="float:left" required/><div id="iddiv" style="float:left"></div></td>
	
	                </tr>
	                <tr>
	                    <td width="30%">비밀번호:</td>
	                    <td width="70%"><input type="password" id="password" name="password" placeholder="비밀번호" style="float:left" required/><div id="passworddiv" style="float:left"></div></td>
	
	                </tr>
	                <tr>
	                    <td width="30%">비번재입력:</td>
	                    <td width="70%"><input type="password" id="repassword" name="repassword" onchange = "checkpassword()" required/></td>
	
	                </tr>
	                <tr>
	                    <td width="30%">E-MAIL</td>
	                    <td width="70%"><input type="text" id="email" name="email" placeholder="aaa@naver.com" required/></td>
	
	                </tr>
                </tbody>
            </table>
			<div align="center">
				<input type="button" value="가입" onclick="register()"/> <input type="reset" value="새로쓰기" />
				<input type="hidden" value="${flag }" id="flag">
			</div>
		</form>
</body>
</html>