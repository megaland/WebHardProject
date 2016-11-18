<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link type="text/css" rel="stylesheet" href="../css/mainpage.css" />
<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<script>
$(document).ready(function(){
	$("#logout").click(function(){
		location.href="../board/logout";
	});
	$("#modify").click(function(){
		selectedwidth = 300;
		selectedheight = 330;
		selectedleft = (screen.width - selectedwidth)/2;
		selectedtop = (screen.height - selectedheight)/2;
		window.open('../board/member_m?id='+$("#modifyid").val(),'window_name','width='+selectedwidth+',height='+selectedheight+', left='+selectedleft+', top='+selectedtop+',location=no,status=no,scrollbars=yes');
	});
	$("#join").click(function(){
		selectedwidth = 300;
		selectedheight = 330;
		selectedleft = (screen.width - selectedwidth)/2;
		selectedtop = (screen.height - selectedheight)/2;
		window.open('../board/member_j','window_name','width='+selectedwidth+',height='+selectedheight+', left='+selectedleft+', top='+selectedtop+',location=no,status=no,scrollbars=yes');
	});
});

function mydownload(id){
	selectedwidth = 350;
	selectedheight = 330;
	selectedleft = (screen.width - selectedwidth)/2;
	selectedtop = (screen.height - selectedheight)/2;
	window.open('../board/mydownpage?id='+id,'window_name','width='+selectedwidth+',height='+selectedheight+', left='+selectedleft+', top='+selectedtop+',location=no,status=no,scrollbars=yes');
}

</script>
</head>
<body>
	<div id="side">
		<div id="left">
			<fieldset id="fieldset"  style="width:150px">
				<legend>로그인</legend>
				<form action="../board/login" method="post">
					<table>
						<c:if test = "${login == null }">
						<tr>
							<td><label for="id">ID:</label></td>
							<td><input type="text" id="id" name="id" placeholder="아이디"
								size="10" /></td>
						</tr>
						<tr>
							<td><label for="pw">PW:</label></td>
							<td><input type="password" id="pw" name="pw"
								placeholder="비밀번호" size="10" /></td>
						</tr>
						<tr>
							<td><input type="submit" id="login" value="Login"/></td>
							<td><input type="button" id="join" value="Join" >
							 </td>
							 
						</tr>
						<tr >
							<td colspan="2"><input type="checkbox" id="remember" name="remember">remember</td>
						</tr>
						</c:if>
						<c:if test="${login != null }">
							id : ${login }<br>
							grade : ${grade }<br>
							point : ${point }<br>
							<input type="button" id="logout" value="logout">
							<input type="button" id="modify" value="modify" >
							<input type="hidden" id="modifyid" value="${login }">
						</c:if>
					</table>
				</form>
			</fieldset>
			<p>
		</div>
		<ul id="list">
			<li><a href="../board/community">자유게시판</a></li>
			<c:if test="${login != null }">
					<li><a href="javascript:mydownload('${login }')">내가 받은 파일 목록</a></li>
			</c:if>
		</ul>
	</div>

</body>
</html>