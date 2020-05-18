<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Logout</title>
<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
</head>

<body>
<c:remove var="identity" scope="session" />


	
	<div id="content" style="text-align: center;">
		<h1 id="out">已登出</h1>
	</div>
	
	<form action="<c:url value="/index.return" />" method="get" id="form1">
		<button type="submit">.</button>
	</form>

<script type="text/javascript">
	$(function(){
		alert("您已經登出，將幫您導回首頁");
		form1.submit();
	})
</script>

</body>
</html>