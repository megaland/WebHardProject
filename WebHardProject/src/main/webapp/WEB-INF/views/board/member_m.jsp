<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="../css/member-style.css" rel="stylesheet" type="text/css">
<script src="mainFunction.js"></script>
<link href="https://maxcdn.bootstrapcdn.com/bootswatch/3.3.7/
paper/bootstrap.min.css" rel="stylesheet" 
integrity="sha384-awusxf8AUojygHf2+joICySzB780jVvQaVCAt1clU3QsyAitLGul28Qxb2r1e5g+"
 crossorigin="anonymous">
<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<title>Insert title here</title>
<script>
$(document).ready(function(){
	$("#modify").click(function(){
		$.ajax({
			url : "../board/modifymember",
			type : "post",
			headers :{
				"Content-Type" : "application/json",
				"X-HTTP-Method-Override" : "POST"
			},
			dataType : "text",
			data : JSON.stringify({"id" : $("#userid").val(), "password" : $("#password").val() , "email" : $("#email").val()}),
			success : function(data){
				if(data=="SUCCESS"){
					self.close();
				}
			}
		});
	});
	
	$("#deleteid").click(function(){
		if(confirm("정말로 탈퇴하시겠습니까?")==true){
			var password = prompt("패스워드를 입력해주세요");
			$.ajax({
				url : "../board/deleteid",
				type : "post",
				dataType : "text",
				data : {"id" : $("#userid").val(), "password" : password},
				success : function(data){
					if(data=="SUCCESS"){
						window.opener.location.href = "../board/mainpage";
						self.close();
					}
				}
			});
			
		}
	});
});
function checkpassword(){
	if($("#password").val() == $("#repassword").val()){
		$("#passworddiv").text("O");
	}else{
		$("#passworddiv").text("X");
	}
}

</script>
</head>
<body>
		<form action="" method="post">
			<table class="table table-striped table-hover ">
				<thead>
	                <tr>
 	                	<th class="danger" colspan="2" style="text-align:center">회원수정</th>
	                </tr>
                </thead>
                <tbody>
	                <tr>
	                    <td width="30%">아이디:</td>
	                    <td width="70%"><input type="hidden" id="userid" value="${uservo.id }">${uservo.id }<div id="iddiv" style="float:left"></div></td>
						
	                </tr>
	                <tr>
	                    <td width="30%">비밀번호:</td>
	                    <td width="70%"><input type="password" id="password" name="password" placeholder="비밀번호" style="float:left" required/><div id="passworddiv" style="float:left"></div></td>
	
	                </tr>
	                <tr>
	                    <td width="30%">비번재입력:</td>
	                    <td width="70%"><input type="password" id="repassword" name="repassword" placeholder="비밀번호" onchange = "checkpassword()" required/></td>
	
	                </tr>
	                <tr>
	                    <td width="30%">E-MAIL</td>
	                    <td width="70%"><input type="text" id="email" name="email" required value="${uservo.email }"/></td>
	
	                </tr>
                </tbody>
            </table>
			<div align="center">
				<input type="button" id="modify" value="수정"/> <input type="reset" value="새로쓰기" /><input type="button" id="deleteid" value="탈퇴">
			</div>
		</form>
</body>
</html>