<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link type="text/css" rel="stylesheet" href="../css/mainpage.css" />
<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<title>Insert title here</title>
</head>
<script>
$(document).ready(function(){
	$("#find").click(function(){
		if($("#genre").val() == ""){
			location.href= "../board/mainpage?field="+$("#field").val()+"&searchword="+$("#word").val();
		}else{
			location.href= "../board/mainpage?field="+$("#field").val()+"&searchword="+$("#word").val()+"&genre="+$("#genre").val();
		}
	});
});

function showdetail(bno){
	selectedwidth = 500;
	selectedheight = 400;
	selectedleft = (screen.width - selectedwidth)/2;
	selectedtop = (screen.height - selectedheight)/2;

	window.open('../board/detail?bno='+bno,'window_name','width='+selectedwidth+',height='+selectedheight+', left='+selectedleft+', top='+selectedtop+',location=no,status=no,scrollbars=yes');
}
</script>
<body>
<div id="wrap">
<%@ include file="toppart.jsp"%>
<%@ include file="leftpart.jsp"%>

<div id="content">
<input type="hidden" id="genre" value = "${genre }">
<table id="ctable">
	<tr>
		<th>번호</th>
		<th>제목</th>
		<th>분류</th>
		<th>작성자</th>
	</tr>
	<c:forEach items="${List}" var="boardVO">
		<tr>
			<td>${boardVO.bno}</td>
			<td><a href="javascript:showdetail(${boardVO.bno})">${boardVO.title}</a></td>
			<td>${boardVO.genre}</td>
			<td>${boardVO.writer}</td> 
		</tr>
	</c:forEach>
</table>
<br/>

<!-- 페이징  -->
<div align = "center">
		<c:if test="${pageMaker.prev }">
			<a href="../board/mainpage?page=${pageMaker.startPage -1 }">&laquo;</a>
		</c:if>
		<c:forEach begin="${pageMaker.startPage }" end="${pageMaker.endPage }" var="idx">
				<c:if test="${idx == pageMaker.cri.page}">
					${idx }&nbsp;
				</c:if>
				<c:if test="${idx != pageMaker.cri.page }">
					<a href="../board/mainpage?page=${idx}">${idx}&nbsp;</a>
				</c:if>
				
		</c:forEach>
		<c:if test="${pageMaker.next && pageMaker.endPage > 0}"> 
			<a href="../board/mainpage?page=${pageMaker.endPage +1}">&raquo;</a>
		</c:if>
</div>

<div id="footer" align="center">
	     <select id="field" name="field">
			<option value="title" id="title">제목</option>
			<option value="writer" id="writer">작성자</option>
		</select>
			<input type="text"id="word" name="word" />
			<input type="button" id="find" value="검색" /> 
			<c:if test="${login != null }">
				<input type="button" value="글쓰기"  onclick=
				"window.open('../board/filewrite','window_name','width=456, height=600,location=no,status=no,scrollbars=yes');">
			</c:if>
		</div>
	</div>
</div>
	
</body>
</html>