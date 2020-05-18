<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>GetUpdateMail</title>
<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
</head>
<body>
<form action="<c:url value="/login.return" />" method="get" id="form1">
		<button type="submit">.</button>
	</form>
	
<script type="text/javascript">
	$(function(){
		alert("請至信箱收取修改密碼信!");
		form1.submit();
	})
</script>
</body>
</html>