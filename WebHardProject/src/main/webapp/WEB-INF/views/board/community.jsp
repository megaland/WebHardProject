<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link type="text/css" rel="stylesheet" href="../css/mainpage.css" />
<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<title>Insert title here</title>
<script type="text/javascript">
	function check() {
		if (document.search.keyword.value == "") {
			alert("검색어를 입력하세요.");
			document.search.keyword.focus();
			return;
		}
		location.href = "../board/community?keyword="+$("#keyword").val()+"&field="+$("#field").val();
	}
</script>
</head>
<div id="wrap">
	<%@ include file="toppart.jsp"%>
	<%@ include file="leftpart.jsp"%>

	<div id="content">
		<table id="ctable">
			<thead>
				<tr>
					<th>번호</th>
					<th>제목</th>
					<th>작성자</th>
					<th>등록일</th>
					<th>조회수</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${CList}" var="communityVO">
					<tr>
						<td>${communityVO.cbno}</td>
						<td><a href='../board/read?cbno=${communityVO.cbno}'>${communityVO.title}</a></td>
						<td>${communityVO.writer}</td>
						<td>${communityVO.regdate}</td>
						<td>${communityVO.count}</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
		
		<div align = "center">
			<c:if test="${pageMaker.prev }">
				<a href="../board/community?page=${pageMaker.startPage -1 }">&laquo;</a>
			</c:if>
			<c:forEach begin="${pageMaker.startPage }" end="${pageMaker.endPage }" var="idx">
					<c:if test="${idx == pageMaker.cri.page}">
						${idx }&nbsp;
					</c:if>
					<c:if test="${idx != pageMaker.cri.page }">
						<a href="../board/community?page=${idx}">${idx}w&nbsp;</a>
					</c:if>
					
			</c:forEach>
			<c:if test="${pageMaker.next && pageMaker.endPage > 0}"> 
				<a href="../board/community?page=${pageMaker.endPage +1}">&raquo;</a>
			</c:if>
		</div>
		
		
		<br />
		<div id="footer" align="center">
			<form action="" name="search" method="post">
				<select id="field" name="field">
					<option value="title"
						<c:if test="${'title'==field}">selected</c:if>>제목</option>
					<option value="name" <c:if test="${'name'==field}">selected</c:if>>작성자</option>
				</select> <input type="text" size="20" id="keyword" name="keyword">
				<input type="button" value="검색" onclick="check()" />
				<c:if test="${login != null }"><button type="button" onclick="location.href='cwrite' ">글쓰기</button></c:if>
			</form>

		</div>

	</div>
</div>
</html>