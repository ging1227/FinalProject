<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ActionSuccess</title>
<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
</head>
<body>

	
<script type="text/javascript">
	$(function(){
		alert("啟動帳號成功！可以進行登入了");
		document.location.href="http://localhost:8080/FinalProject/login.return"
	})
</script>
</body>
</html>