<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>測試串綠界頁面</title>
</head>
<body>
	<form method="POST" action="<c:url value='/order/pay'/>">
		<div >
			<div >
				orderNo:<input type="text" id="orderNo" name="orderNo"  >
				amount:<input type="text" id="amount" name="amount">
			</div>
			<input type="submit" value="Send"/>
			
		</div>
	</form>
	<form method="POST" action="<c:url value='/ordersBymIdTest'/>">
		<div >
			<div >
			測試用
				orderNo:<input type="text" id="orderNo" name="orderNo"  >
				amount:<input type="text" id="amount" name="amount">
			</div>
			<input type="submit" value="Send"/>
			
		</div>
	</form>
</body>
</html>