<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<c:set var="funcName" value="product_insert" scope="session" />
<html>
<head>
<meta charset="UTF-8">
<title>Product System</title>

<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css">
<link
	href="https://fonts.googleapis.com/css?family=Noto+Sans+TC&display=swap"
	rel="stylesheet">
<link rel="stylesheet"
	href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<link rel="stylesheet" href="/resources/demos/style.css">

<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>

<style type="text/css">
radio {
	transform: scale(.8)
}

body {
	font-family: 'Noto Sans TC', sans-serif;
}

h2 {
	margin: auto;
	text-align: center;
	padding: 15px;
}

form {
	margin: auto;
	width: 500px;
}

.d1 {
	width: 500px;
	border-bottom: 1px solid rgb(163, 160, 160);
	padding: 20px;
}

.err {
	font-size: smaller;
	color: #CC0000
}

.button {
	text-align: center
}

.msg1 {
	color: blue
}
</style>

<script>
	function openFile(event) {
		var input = event.target; //取得上傳檔案
		var reader = new FileReader(); //建立FileReader物件

		reader.readAsDataURL(input.files[0]); //以.readAsDataURL將上傳檔案轉換為base64字串

		reader.onload = function() { //FileReader取得上傳檔案後執行以下內容
			var dataURL = reader.result; //設定變數dataURL為上傳圖檔的base64字串
			$('#output').attr('src', dataURL).show(); //將img的src設定為dataURL並顯示
		};
	}
</script>
</head>
<body>
<%@include file="BackstageUI.jsp" %>
	
	<div id="content2">
	<c:if test="${product != null}">
		<form action="<%=request.getContextPath()%>/product/update"
			method="post" enctype="multipart/form-data" class="form-horizontal" />
	</c:if>
	<c:if test="${product == null}">
		<form action="<%=request.getContextPath()%>/product/insert"
			method="post" enctype="multipart/form-data" class="form-horizontal" />
	</c:if>

 
		 <input class="form-control" type="hidden"
			id="p_id" name="p_id" value="<c:out value='${product.p_id}' />" /> <span
			class="err"></span>


	<div class="d1">
		<label>產品類別</label><br /> <select name="p_type">
			<c:forEach var="p_type" items="${p_typelist}">
				<option value="${p_type}"
					<c:if test="${p_type eq product.p_type}">selected="selected"
				    </c:if>>${p_type}
				</option>
			</c:forEach>
		</select>
	</div>

	<div class="d1">
		<label>產品名稱 </label>&nbsp; <input class="form-control" type="text"
			id="pname" name="p_name" value="<c:out value='${product.p_name}' />" />
		<span class="err"></span>
	</div>

	<div class="d1">
		<label>顯示器</label><br />
		<c:forEach var="monitor" items="${monitorlist}">
				&nbsp;<input type="radio" name="monitor" value="${monitor}"
				<c:if test="${monitor eq product.monitor}">checked="checked"
				</c:if>>
			<label>${monitor}</label>
		</c:forEach>
	</div>


	<div class="d1">
		<label>中央處理器</label> <select name="cpu">
			<c:forEach var="cpu" items="${cpulist}">
				<option value="${cpu}"
					<c:if test="${cpu eq product.cpu}">selected="selected"
				    </c:if>>${cpu}
				</option>
			</c:forEach>
		</select>
	</div>


	<div class="d1">
		<label>主記憶體</label> <select name="ram">
			<c:forEach var="ram" items="${ramlist}">
				<option value="${ram}"
					<c:if test="${ram eq product.ram}">selected="selected"
				    </c:if>>${ram}
				</option>
			</c:forEach>
		</select>
	</div>


	<div class="d1">
		<label>容量</label><br />
		<c:forEach var="storage" items="${storagelist}">
		&nbsp;<input type="radio" name="storage" value="${storage}"
				<c:if test="${storage eq product.storage}">checked="checked"
				</c:if>>
			<label>${storage}</label>
		</c:forEach>
	</div>


	<div class="d1">
		<label>顏色</label><br />
		<c:forEach var="color" items="${colorlist}">
		&nbsp;<input type="radio" name="color" value="${color}"
				<c:if test="${color eq product.color}">checked="checked"
				</c:if>>
			<label>${color}</label>
		</c:forEach>
	</div>


	<div class="d1">
		<label>產品描述</label> <input class="form-control" type="text" id="des"
			name="des" value="<c:out value='${product.des}' />" /> <span
			class="err"></span>
	</div>


	<div class="d1">
		<label>價格</label><input type="text" id="price" name="price"
			class="form-control" value="<c:out value='${product.price}' />">
		<span class="err"></span>
	</div>


	<div class="d1">
		<label>促銷價</label><input type="text" id="discount" name="discount"
			class="form-control" value="<c:out value='${product.discount}' />">
	</div>

	<div class="d1">
		<label>照片</label><br /> <img id="output" height="200"
			style="display: none"> <input type="file" id="p_img"
			name="files" class="form-control" onchange="openFile(event)">
	</div>

	<div class="d1">
		<label>delete_flag</label><br />
		<!--  <input class="form-control" type="text"
			 name="delete_flag" />-->
		&nbsp;<input type="radio" name="delete_flag" value="Y"><label>Y</label>
		&nbsp;<input type="radio" name="delete_flag" value="N"><label>N</label>
	</div>


	<div class="button">
		<input type="submit" value="儲存" class="btn btn-secondary"> &nbsp; <input
			type="reset" value="清除" class="btn btn-secondary">
	</div>
</div>
</body>
</html>
