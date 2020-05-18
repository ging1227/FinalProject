<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" isErrorPage="true"%>
<%@ page import="java.io.PrintWriter"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" 
	"http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>Error</title>
</head>
<body>
	<center>
		<h1>Error</h1>
		<%
		String ERROR_MSG = (String) request.getAttribute("errorMsg");
		response.setHeader("refresh", "5;http://localhost:8080/SpringMvcLoginSystem/");
		%>
		<h2><%=ERROR_MSG%></h2>
		
	</center>
</body>
</html>