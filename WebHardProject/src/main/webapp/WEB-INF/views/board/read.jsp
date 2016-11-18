<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link type="text/css" rel="stylesheet" href="../css/reply.css" />
<script src="../js/write.js"></script>
<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<script type="text/javascript">

$(document).ready(function(){
var formObj = $("form[role='form']");
$(".btn_modify").on("click",function(){
		formObj.attr("action","../board/modify");
		formObj.attr("method","get");
		formObj.submit();
});
$(".btn_remove").on("click",function(){
	   var result = confirm('삭제 하시겠습니까?');

       if(result) {
    	   formObj.attr("action","../board/remove");
   		   formObj.submit();
   		
       } else {
    	   location.replace();   	
       }
	
	
		
});
$(".btn_primary").on("click",function(){
		self.location ="../board/community"
});
});

function registerreply(login, cbno){
	$("#registerparamone").val(cbno);
	$("#registerparamtwo").val(login);
	$("#registerparamthree").val($("#replycontent").val());
	$("#frm").submit();
	
	
	//location.href = "../board/registerreply?writer="+login+"&cbno="+cbno+"&content="+;
}

</script>
<title>Insert title here</title>
</head>
<div id="wrap">
<%@ include file="toppart.jsp"%>
	<br>
<%@ include file="leftpart.jsp"%>

<form role='form' method="post">
<input type="hidden" name="cbno" value="${communityVO.cbno}">
</form>
<div id="cwrite">
<table>
  <tr>
   <td>
    <table width="100%" cellpadding="0" cellspacing="0" border="0">
     <tr>
      <td width="5"></td>
      <td align="center">자유게시판</td>
      <td width="5"></td>
     </tr>
    </table>
   <table>
     <tr>
       <td>&nbsp;</td>
      <td align="center">이름</td>
      <td><input type="hidden" name="writer" value="${communityVO.writer}" readonly="readonly">${communityVO.writer}</td>
      <td>&nbsp;</td>
     </tr>
     <tr height="1" bgcolor="#dddddd"><td colspan="4"></td></tr>
    <tr>
      <td>&nbsp;</td>
      <td align="center">제목</td>
      <td><input type="text" name="title" size="50" maxlength="100" value="${communityVO.title}" readonly="readonly"></td>
      <td>&nbsp;</td>
     </tr>
      <tr height="1" bgcolor="#dddddd"><td colspan="4"></td></tr>
     <tr>
      <td>&nbsp;</td>
      <td align="center">내용</td>
      <td><textarea name="content" cols="50" rows="13" readonly="readonly"> ${communityVO.content}</textarea></td>
      <td>&nbsp;</td>
     </tr>
     <tr height="1" bgcolor="#dddddd"><td colspan="4"></td></tr>
     <tr height="1" bgcolor="#82B5DF"><td colspan="4"></td></tr>
     <tr align="center">
      <td>&nbsp;</td>
      <td colspan="3"> 
      <c:if test="${login ==communityVO.writer }">
          <button type="submit" class="btn_modify">수정</button>
 		<button type="submit" class="btn_remove">삭제</button>
      </c:if>

 		<button type="submit" class="btn_primary">목록으로</button>
     </tr>
    </table>
   </td>
  </tr>
 </table>
 
 <form id="frm" action = "../board/registerreply" method="post">
 	<input type="hidden" id="registerparamone" name="cbno" value="">
 	<input type="hidden" id="registerparamtwo" name="writer" value="">
 	<input type="hidden" id="registerparamthree" name="content" value="">
 </form>
 
	 <div>
	 <table class="replytable">
	 	<tbody>
	 	<c:forEach items ="${replylist}" var="reply">
	 	 	<tr>
	 			<td>${reply.writer}</td><td>${reply.content }</td><td>${reply.regdate }</td>
	 		</tr>
	 	</c:forEach>
		</tbody>
		<tfoot>
	 	<tr>
	 		<td colspan = "2"><input type="text" id="replycontent"></td>
	 		<td><input type="button" id="registerbtn" onclick="registerreply('${login}', '${communityVO.cbno }')" value="댓글달기"></td>
	 	</tr>	
	 	<tr>
	 		<td colspan ="2">
		 		 <div align="center">
					<c:if test="${pageMaker.prev }">
						<a href="../board/mainpage?page=${pageMaker.startPage -1 }&cbno=${communityVO.cbno}">&laquo;</a>
					</c:if>
					<c:forEach begin="${pageMaker.startPage }" end="${pageMaker.endPage }" var="idx">
							<c:if test="${idx == pageMaker.cri.page}">
								${idx }&nbsp;
							</c:if>
							<c:if test="${idx != pageMaker.cri.page }">
								<a href="../board/read?page=${idx}&cbno=${communityVO.cbno}">${idx}&nbsp;</a>
							</c:if>
							
					</c:forEach>
					<c:if test="${pageMaker.next && pageMaker.endPage > 0}"> 
						<a href="../board/read?page=${pageMaker.endPage +1}&cbno=${communityVO.cbno}">&raquo;</a>
					</c:if>
				</div>
	 		</td>
	 	</tr>
	 </tfoot>
	 </table>
	</div>
</div>
 </div>


</html> 
 