<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link type="text/css" rel="stylesheet" href="../css/write.css" />
<script src="../js/write.js"></script>
<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<script type="text/javascript">
$(document).ready(function(){
var formObj = $("form[role='form']");
$(".btn_modify").on("click",function(){
	formObj.submit();
});

$(".btn_primary").on("click",function(){
	self.location = "../board/community"
	});
});
</script>
<title>Insert title here</title>
</head>
<div id="wrap">
<%@ include file="toppart.jsp"%>
	<br>
<%@ include file="leftpart.jsp"%>


<form role='form' method="post">
<div id="cwrite">
<table>
  <tr>
   <td>
    <table width="100%" cellpadding="0" cellspacing="0" border="0">
     <tr>
      <td width="5"></td>
      <td align="center">수정하기</td>
      <td width="5"></td>
     </tr>
    </table>
   <table>
     <tr>
      <td>&nbsp;</td>
      <td align="center">이름</td>
      <td>${communityVO.writer}</td>
      <td>&nbsp;</td>
     </tr>
     <tr height="1" bgcolor="#dddddd"><td colspan="4"></td></tr>
    <tr>
      <td>&nbsp;</td>
      <td align="center">제목</td>
      <td><input type="text" name="title" size="50" maxlength="100" value="${communityVO.title}"></td>
      <td>&nbsp;</td>
     </tr>
      <tr height="1" bgcolor="#dddddd"><td colspan="4"></td></tr>
     <tr>
      <td>&nbsp;</td>
      <td align="center">내용</td>
      <td><textarea name="content" cols="50" rows="13"> ${communityVO.content}</textarea></td>
      <td>&nbsp;</td>
     </tr>
     <tr height="1" bgcolor="#dddddd"><td colspan="4"></td></tr>
     <tr height="1" bgcolor="#82B5DF"><td colspan="4"></td></tr>
     <tr align="center">
      <td>&nbsp;</td>
      <td colspan="2"> <button type="submit" class="btn_modify">저장</button>
 		<button type="submit" class="btn_primary">취소</button>
      <td>&nbsp;</td>
     </tr>
    </table>
   </td>
  </tr>
 </table>

 </div>
</form>
</div>
</html> 
 