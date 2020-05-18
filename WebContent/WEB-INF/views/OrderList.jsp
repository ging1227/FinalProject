<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>訂單查詢</title>
<!-- JQuery -->
<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>

<!-- TWzipcode -->
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/2.0.0/jquery.min.js"></script>

<!-- style -->
<link
	href="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css"
	rel="stylesheet" id="bootstrap-css">
<script
	src="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>
<script
	src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>

<link rel="stylesheet"
	href="https://use.fontawesome.com/releases/v5.0.8/css/all.css">

<link rel="stylesheet"
	href="<%=request.getContextPath()%>/static/css/update.css">

<!-- /彈跳視窗 -->
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css"
	integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T"
	crossorigin="anonymous">

<script src="https://code.jquery.com/jquery-3.4.1.js"
	integrity="sha256-WpOohJOqMqqyKL9FccASB9O0KwACQJpFTUBLTYOVvVU="
	crossorigin="anonymous">
	
</script>

<script
	src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"
	integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM"
	crossorigin="anonymous"></script>
<!-- 彈跳視窗/ -->
<style>
#span-right {
	float: right;
}
</style>
</head>
<style>
body {
	opacity: 0;
}

.bar {
	padding-right: 0 !important;
}

div {
	display: block;
}

.menu_Style {
	height: 1000px;
	width: 300px;
	float: left;
}

#content {
	width: 600px;
}

#content table {
	background-color: #dadfe1;
}

#content table .content_tr .list {
	color: #333;
	background-color: #FFF7E6;
}

#header_Style {
	font-size: 32px;
	font-family: 'Noto Sans TC', sans-serif;
	padding-left: 235px;
	margin: auto;
}

.update_contain {
	margin: 20px 20% 20px 20%;
	overflow: auto;
	background-color: #DADFE1;
	border: 1px solid #DADFE1;
	border-radius: 15px;
	z-index: -1;
}

#update-header {
	margin-top: 30px;
	margin-bottom: 30px;
}
.menu_Style1 {
    height: 820px;
    width: 380px;
    float: left;
    margin-top: 30px;
    margin-left: 20px;
}
</style>
<body onload="document.body.style.opacity='1'">
	<%@ include file="./fragment/indexTOP.jsp"%>
	<form:form id="orderTable">
		<!-- <jsp:include page="/WEB-INF/views/fragment/indexBOTTOM.jsp" />-->
		<div id="update-contain" class="update_contain">
			<%@ include file="./fragment/userMenu.jsp"%>
			
			<div id="update-header" class="menu_Style1">
				<span id="header_Style">查詢訂單</span>
				<div id="content" class="table100-body js-pscroll">
					<table style="border: 2px #dadfe1 solid;" cellpadding="6"
						border='1'>
						<c:forEach var="order" items="${orders}">
							<tbody>
								<tr class="row100 head">
									<th class="cell100 column1 font-weight-bold"
										style="border-style: none;padding: 20px 6px 0px 6px;">訂單編號</th>
									<th class="cell100 column2 font-weight-bold"
										style="border-style: none;padding: 20px 6px 0px 6px;">建立日期</th>
									<th class="cell100 column2 font-weight-bold"
										style="border-style: none;padding: 20px 6px 0px 6px;">總金額</th>
									<th class="cell100 column2 font-weight-bold"
										style="border-style: none;padding: 20px 6px 0px 6px;">付款方式</th>
									<th class="cell100 column2 font-weight-bold"
										style="border-style: none;padding: 20px 6px 0px 6px;">明細</th>
									<th class="cell100 column2 font-weight-bold"
										style="border-style: none;padding: 20px 6px 0px 6px;"><span
										style="font-size: 1.4em;" class="fa fa-pencil-square-o"></span></th>
								</tr>
								<tr class="row100 body">
									<td class="list" style="border-style: none">${order.oSysSn}</td>
									<td class="list" style="border-style: none">${fn:substring(order.createTime, 0, 10)}</td>
									<td class="list" style="border-style: none"><fmt:formatNumber
											value="${order.price}" pattern="#,###,###" />元</td>
									<c:choose>
										<c:when test="${order.pay==1}">
											<td class="cell100 column2" style="border-style: none">信用卡一次繳清</td>
										</c:when>
										<c:when test="${order.pay==2}">
											<td class="cell100 column2" style="border-style: none">網路ATM付款</td>
										</c:when>
										<c:when test="${order.pay==0}">
											<td class="cell100 column2" style="border-style: none">貨到付款</td>
										</c:when>
										<c:otherwise>
										</c:otherwise>
									</c:choose>
									<td class="cell100 column2" style="border-style: none"><a
										href="<spring:url value='/orderItemByoSysSn?oSysSn=${order.oSysSn}' />"
										target="_self"> <span class="link_g"
											style="text-decoration: underline; color: blue">清單</span></a></td>
									<td class="cell100 column2" style="border-style: none"></td>
								</tr>
								<tr class="row100 body">
									<td height="40" colspan="6" align="center" class="content_td">
										<table border="0" align="center" cellpadding="0"
											cellspacing="0">
											<tbody>
												<tr>
													<td valign="bottom" height="9" align="center">
														<table width="300" border="0" cellspacing="0"
															cellpadding="0" height="8">
															<tbody>
																<tr>
																	<td height="8" bgcolor="dadfe1">
																		<table border="0" cellspacing="0" cellpadding="0"
																			height="8">
																			<tbody>
																				<tr bgcolor="FFFFFF">
																					<td height="20" width="120" style="padding: unset">
																						<table width="650" border="0" cellspacing="0"
																							cellpadding="0">
																							<tbody>
																								<tr style="width: 650">

																									<c:choose>
																										<c:when test="${order.status==3}">
																											<td class="bar" bgcolor="#28FF28" width="30"
																												height="20"></td>
																											<td class="bar" bgcolor="#28FF28" width="30"
																												height="20"></td>
																											<td class="bar" bgcolor="#FFFFFF" width="30"
																												height="20"></td>
																											<td class="bar" bgcolor="#FFFFFF" width="30"
																												height="20"></td>
																										</c:when>
																										<c:when test="${order.status==1}">
																											<td class="bar" bgcolor="#28FF28" width="30"
																												height="20"></td>
																											<td class="bar" bgcolor="#FFFFFF" width="30"
																												height="20"></td>
																											<td class="bar" bgcolor="#FFFFFF" width="30"
																												height="20"></td>
																											<td class="bar" bgcolor="#FFFFFF" width="30"
																												height="20"></td>
																										</c:when>
																										<c:when test="${order.status==4}">
																											<td class="bar" bgcolor="#28FF28" width="30"
																												height="20"></td>
																											<td class="bar" bgcolor="#28FF28" width="30"
																												height="20"></td>
																											<td class="bar" bgcolor="#28FF28" width="30"
																												height="20"></td>
																											<td class="bar" bgcolor="#FFFFFF" width="30"
																												height="20"></td>
																										</c:when>
																										<c:otherwise>
																											<td class="bar" bgcolor="#28FF28" width="30"
																												height="20"></td>
																											<td class="bar" bgcolor="#28FF28" width="30"
																												height="20"></td>
																											<td class="bar" bgcolor="#28FF28" width="30"
																												height="20"></td>
																											<td class="bar" bgcolor="#28FF28" width="30"
																												height="20"></td>
																										</c:otherwise>
																									</c:choose>

																								</tr>
																							</tbody>
																						</table>
																					</td>
																				</tr>
																				<tr>
																					<td valign="top" width="200" align="center">
																						<table border="0" cellspacing="0" cellpadding="0"
																							width="630">
																							<tbody>
																								<tr valign="bottom" class="text11"
																									align="center">
																									<td width="100" height="16"><font
																										color="#003399">收到訂單</font></td>
																									<td width="100"><font color="#003399">已出貨</font>
																									</td>
																									<td width="100"><font color="#003399">物流中</font>
																									</td>
																									<td width="100"><font color="#003399">已送達</font>
																									</td>
																								</tr>
																							</tbody>
																						</table>
																					</td>
																				</tr>
																			</tbody>
																		</table>
																	</td>
																</tr>
															</tbody>
														</table>
											</tbody>
										</table>
									</td>
								</tr>
							</tbody>
						<th/>
						</c:forEach>
					</table>
				</div>
			</div>
		</div>
		<%@ include file="./fragment/indexBOTTOM.jsp"%>
	</form:form>
</body>
</html>