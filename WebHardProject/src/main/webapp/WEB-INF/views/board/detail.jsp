<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="https://maxcdn.bootstrapcdn.com/bootswatch/3.3.7/
paper/bootstrap.min.css" rel="stylesheet" 
integrity="sha384-awusxf8AUojygHf2+joICySzB780jVvQaVCAt1clU3QsyAitLGul28Qxb2r1e5g+"
 crossorigin="anonymous">
<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<title>Insert title here</title>
</head>
<script>
	function changeshow(){
		$("#downloadletter").text("재 다운로드");
	}
	function deleteboard(bno){
		$.ajax({
			url: "../board/deleteboard",
			type : "post",
			dataType : "text",
			data : {bno : bno},
			success : function(data){
				alert("삭제되었습니다.");
				self.close();
				window.opener.location.href="../board/mainpage";
			}
		})
	}
</script>
<body>
	<table class="table table-striped table-hover ">
		<thead>
		<tr>
			<th>업로드번호</th><td>${boardvo.bno }</td><th>카테고리</th><td>${boardvo.genre }</td><th>업로더</th><td>${boardvo.writer }</td>
		</tr>
		<tr>
			<th>포인트</th><td>${boardvo.point}</td>
		</tr>
		</thead>
		<tbody>
			<tr class="success">
				<td colspan = "6" >
					<c:forEach items="${boardvofilelist}" var="boardfile">
					<div>
						<div style="float:left; width:50%;" >
							${boardfile.filename }&nbsp;&nbsp;&nbsp;&nbsp;
						</div>
						<div style="float:left; width:25%;  ">
							${boardfile.capacity }byte&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						</div>
						<div style="float:left; width:25%;  ">
							<c:if test="${login != null }">
								
								<c:if test="${userdownloadlist != null }">
									<c:forEach items="${userdownloadlist }" var="userdownvo">
										<c:choose>
											<c:when test="${userdownvo.bfno == boardfile.bfno }">
												<a id="downloadletter" href="../board/mydownload/${userdownvo.bfno },${userdownvo.filename}"  onclick="changeshow()">재 다운로드</a>
											</c:when>
											<c:otherwise>
												<a id="downloadletter" href="../board/download/${boardfile.bfno},${boardfile.filename},${boardvo.writer},${boardvo.bno},${boardfile.point}"  onclick="changeshow()">다운로드</a>
											</c:otherwise>
										</c:choose>
									</c:forEach>
								</c:if>
								<c:if test="${userdownloadlist == null }">
								${userdownloadlist }
									<a id="downloadletter" href="../board/download/${boardfile.bfno},${boardfile.filename},${boardvo.writer},${boardvo.bno},${boardfile.point}"  onclick="changeshow()">다운로드</a>
								</c:if>
							</c:if>
						</div>
					</div>	<br>
					</c:forEach>
				</td>
			</tr>
		
			<tr>
				<td colspan = "6">
					<div>
						${boardvo.content }<br>
						<c:forEach items="${boardvoimglist }" var="boardimg">
							<img src="../board/showimg?path=${boardimg.path }" style="width:100px; height:100px">
						</c:forEach>
					</div>
				</td>
			</tr>
		</tbody>
	</table>
	<div align="center">
		<c:if test="${boardvo.writer == login || grade == 'admin' }">
				<a href="javascript:deleteboard(${boardvo.bno })">삭제</a>
		</c:if>
	</div>
</body>
</html>