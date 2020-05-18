<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html>

<head>
	<title>Product Management Application</title>
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/css//bootstrap.min.css">
</head>

<body>
	<%@include file="BackstageUI.jsp"%>

	<div id="content2" align="center">
		<h2>
			<a href="<%=request.getContextPath()%>/product/add" class="btn btn-dark">新增產品</a> &nbsp;&nbsp;&nbsp;
			<a href="<%=request.getContextPath()%>" class="btn btn-dark ">首頁</a>
		</h2>
		<h2>
			<form action="<%=request.getContextPath()%>/product/blurDetail" method="post" class="form-inline">
				<div style="margin:auto;">
					<input type="text" name="p_type" class="form-control" placeholder="產品類別">&nbsp;
					<input type="text" name="p_name" class="form-control" placeholder="產品名稱">&nbsp;
					<input type="submit" value="搜尋" class="btn btn-dark">
				</div>
			</form>
		</h2>

		<table cellpadding="5">

			<tr class="table-dark">
				<th>產品編號</th>
				<th>產品類別</th>
				<th>圖片</th>
				<th>產品名稱</th>
				<th>顯示器</th>
				<th style="width:10px">CPU</th>
				<th>記憶體</th>
				<th>容量</th>
				<th>顏色</th>
				<th style="width:450px">產品描述</th>
				<th>價格</th>
				<th>折扣</th>
				<th>下架</th>
				<th colspan="2">維護</th>
			</tr>

			<c:forEach var="product" items="${listProduct}">
				<tr class="table-light">
					<td>
						<c:out value="${product.p_id}" />
					</td>	
					<td>
						<c:out value="${product.p_type}" />
					</td>
					<!-- <td><img alt="" style="width:100px" src="<c:out value="${product.p_img}"/>"></td> -->
					<td><img alt="" style="width: 100px" src="<c:url value="/product/getImage?img=${product.p_img}" />
						"></td>
					<td>
						<c:out value="${product.p_name}" />
					</td>
					<td>
						<c:out value="${product.monitor}" />
					</td>
					<td style="width:10px">
						<c:out value="${product.cpu}" />
					</td>
					<td>
						<c:out value="${product.ram}" />
					</td>
					<td>
						<c:out value="${product.storage}" />
					</td>
					
						<td>
						<c:out value="${product.color}" />
					</td>
					<td style="width:450px">
						<c:out value="${product.des}" />
					</td>
				
					<td>
						<c:out value="${product.price}" />
					</td>
					<td>
						<c:out value="${product.discount}" />
					</td>
					<td>
						<c:out value="${product.delete_flag}" />
					</td>
					<td><a class="btn btn-outline-secondary"
							href="edit?p_id=<c:out value='${product.p_id}' />">Edit</a></td><td>
						<a class="btn btn-outline-danger" id="delete_product"
							href="delete?p_id=<c:out value='${product.p_id}' />">Delete</a></td>
				</tr>
			</c:forEach>
		</table>
	</div>
	<script>
		$("#delete_product").on("click", function () {
			if (confirm('是否刪除?'))
				return true;
			return false;
		});
	</script>

</body>

</html>