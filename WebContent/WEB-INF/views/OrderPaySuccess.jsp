<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>OrderPaySuccess</title>
<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
</head>
<body>
<form action="<c:url value="/index.return" />" method="get" id="form1">
		<button type="submit">.</button>
	</form>
	
<script type="text/javascript">
	$(function(){
		alert("訂單建立成功！請至會員訂單頁面查詢");
		form1.submit();
	})
</script>
</body>
</html>