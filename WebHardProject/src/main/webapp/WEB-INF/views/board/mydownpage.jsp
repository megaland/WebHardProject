<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<link href="https://maxcdn.bootstrapcdn.com/bootswatch/3.3.7/paper/bootstrap.min.css" rel="stylesheet" integrity="sha384-awusxf8AUojygHf2+joICySzB780jVvQaVCAt1clU3QsyAitLGul28Qxb2r1e5g+" crossorigin="anonymous">
<title>Insert title here</title>
<script>
function showdetail(bno){
	selectedwidth = 500;
	selectedheight = 400;
	selectedleft = (screen.width - selectedwidth)/2;
	selectedtop = (screen.height - selectedheight)/2;

	window.open('/board/detail?bno='+bno,'_blank','width='+selectedwidth+',height='+selectedheight+', left='+selectedleft+', top='+selectedtop+',location=no,status=no,scrollbars=yes');
}
</script>
</head>
<body>
	<table class="table table-striped table-hover ">
		<thead>
			<tr>
				<th>다운날짜</th><th>파일명</th><th style="width:20%">재다운로드</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${userdownlist }" var="userdownloadvo">
				<tr>
					<td>${userdownloadvo.regdate }</td>
					<td><a href="javascript:showdetail(${userdownloadvo.bno})">${userdownloadvo.filename }</a></td>
					<td>
						<a href="../board/mydownload/${userdownloadvo.bfno },${userdownloadvo.filename}">
							<c:if test="${userdownloadvo.filename !=null}">재다운로드</c:if>
						</a>
					</td>
				</tr>
			</c:forEach>

		</tbody>
	</table>
</body>
</html>