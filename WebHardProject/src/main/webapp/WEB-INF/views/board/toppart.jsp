<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link type="text/css" rel="stylesheet" href="../css/mainpage.css" />
<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<title>WebHard</title>
</head>

<body>
	<div id="header">
		<a href="../board/mainpage"><img src="../image/webhard.png" /></a>
	<br/>
	</div>
	
	<div id="navbar">
		<hr id="hrbar">
		<nav id="topMenu">
		<ul>
			<li class="topMenuLi"><a class="menuLink" href="../board/mainpage">전체</a></li>
			<li>|</li>
			<li class="topMenuLi"><a class="menuLink" href="../board/mainpage?genre=영화">영화</a></li>
			<li>|</li>
			<li class="topMenuLi"><a class="menuLink" href="../board/mainpage?genre=드라마">드라마</a></li>
			<li>|</li>
			<li class="topMenuLi"><a class="menuLink" href="../board/mainpage?genre=음악">음악</a></li>
			<li>|</li>
			<li class="topMenuLi"><a class="menuLink" href="../board/mainpage?genre=유틸">유틸</a></li>
		</ul>
		</nav>
	</div>
	<br>
</body>
</html>




