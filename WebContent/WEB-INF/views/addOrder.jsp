<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<%
	long t = System.currentTimeMillis();
	request.setAttribute("t", t);
%>

<!doctype html>
<html lang="zh-tw">
<head>
<!-- Required meta tags -->
<meta charset="utf-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">

<!-- Bootstrap CSS -->
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
<link rel="stylesheet" type="text/css"
	href="<c:url value='/shoppingCart/font-awesome.min.css' />">
<!-- Custom styles for this template -->
<link rel="stylesheet" type="text/css"
	href="<c:url value='/order/form-validation.css' />">

<title>結帳頁面</title>
</head>
<style>
#items_outer_div::-webkit-scrollbar {
	width: 0.5em;
}

#items_outer_div::-webkit-scrollbar-track {
	-webkit-box-shadow: inset 0 0 6px rgb(0, 0, 0, 0, 3);
	border-radius: 10px;
}

#items_outer_div::-webkit-scrollbar-thumb {
	border-radius: 10px;
	background-color: darkgrey;
	outline: 1px solid slategrey;
}

.container {
	width: 1200px;
	height: 550px;
	margin: 0 auto;
	box-shadow: 5px 5px 20px 0px rgba(0, 0, 0, 0.3);
	-webkit-border-radius: 20px;
	-moz-border-radius: 20px;
	-ms-border-radius: 20px;
	border-radius: 20px;
	position: relative;
	background: white;
	background: -moz-linear-gradient(45deg, #dadfe1 0%, #e8edef 30%, #f9feff 100%);
	background: -webkit-linear-gradient(45deg, #dadfe1 0%, #e8edef 30%, #f9feff 100%);
	background: linear-gradient(45deg, #dadfe1 0%, #e8edef 30%, #f9feff 100%);
	filter: progid:DXImageTransform.Microsoft.gradient( startColorstr='#dadfe1',
		endColorstr='#f9feff', GradientType=1);
}

.count {
	text-align: center;
	-webkit-border-radius: 20px;
	-moz-border-radius: 20px;
	-ms-border-radius: 20px;
	border-radius: 20px;
	border-bottom: 3px solid grey;
}
</style>
<body style="background-color: #7d706f;">
	<div class="wrapper">
		<div class="header">
			<jsp:include page="./fragment/indexTOP.jsp" />
		</div>
		<div class="content" style="margin: 30px">
			<div class="container">
				<div class="count">
					<img class="d-block mx-auto mb-4"
						src="https://getbootstrap.com/assets/brand/bootstrap-solid.svg"
						alt="" width="20px" height="20px">
					<h1 class="font-weight-bold">結帳</h1>
				</div>

				<!-- 購物車檢視 -->
				<div class="row">
					<div class="col-md-4 order-md-2 mb-4" style="margin: 20px auto">
						<h4 class="d-flex justify-content-between align-items-center mb-3"
							style="color: black;">
							<span style="font: bloder; color: grey">訂單詳情:</span> <span><strong
								class="text-danger">${insertError.emptyCart}</strong></span>
						</h4>

						<div id="items_outer_div"
							style="max-height: 300px; overflow-y: auto">
							<div>
								<ul class="list-group mb-3">
									<c:forEach varStatus="vs" var="anEntry"
										items="${ShoppingCart.content}">
										<li
											class="list-group-item d-flex justify-content-between lh-condensed">
											<div>
												<h6 style="font-size: 12px">${anEntry.key}-${anEntry.value.color}-${anEntry.value.storage}x
													${anEntry.value.quantity}</h6>
												<small class="text-muted"><fmt:formatNumber
														value="${anEntry.value.price}" pattern="#,###" />元</small>
											</div>
										</li>
									</c:forEach>
								</ul>
							</div>
						</div>
						<div class="input-group"
							style="background-color: white; padding: 15px; margin-top: 5px; border-radius: 10px;">
							<span class="h5"><strong>總付款金額</strong></span> <span class="h5"><strong><fmt:formatNumber
										value="${ShoppingCart.subtotal}" pattern="#,###,###" />元</strong></span>
						</div>
					</div>

					<div class="col-md-8 order-md-1" style="margin: 20px auto">
						<h3 style="font: bloder; color: grey; font-size: 24px">請確認以下資訊:</h3>
						<p class="h6">
							<strong>會員姓名: ${identity.uinfo.name}</strong>
						</p>

						<span id="toggleEz" class="btn btn-secondary"
							style="display: inline-block; height: 40px">超商取貨</span> <span
							id="home" class="btn btn-secondary"
							style="display: inline-block; margin-left: 5px; height: 40px">宅配</span>
						<span id="OnlinePay" class="btn btn-secondary"
							style="display: inline-block; margin-left: 5px; height: 40px">信用卡一次付清</span>
						<span id="WebATM" class="btn btn-secondary"
							style="display: inline-block; margin-left: 5px; height: 40px">網路ATM付款</span>
						<div id="ezForm" style="display: none;">
							<form method="post" name="simulation_from"
								action="https://map.ezship.com.tw/ezship_map_web.jsp"
								style="display: inline">
								<input name="Submit2" type="submit" value="選擇門市"
									class="btn btn-info" style="margin-top: 10px;">
									<input type="hidden" name="suID" value="buyer@myweb.com.tw">
									<input type="hidden" name="processID" value="${t}">
									<input type="hidden" name="rtURL"
									value="http://localhost:8080/FinalProject/ezship">
							</form>
						</div>



						<!--    結帳資訊        -->
						<div>
							<form:form id="orderForm" modelAttribute='order' method='POST'
								class='needs-validation' novalidate="novalidate"
								enctype="multipart/form-data">
								<div style="display:none">
									<form:input type="text" class="form-control" 
										style="background-color:white;" id="pay" path="pay" value='0'
										required="required" />
								</div>
								<div class="mb-3" >
									<label id="addrLabel" for="addr" class="h6"><strong>寄送地址:</strong></label>

									<form:input type="text" class="form-control"
										style="background-color:white;" id="addr" path="addr" value='${name}'
										required="required" />
									<div>
										<strong class="text-danger">${insertError.emptyAddr}</strong>
									</div>
									<div class="invalid-feedback">
										<strong>此欄位不可為空白</strong>
									</div>

								</div>

								<div class="mb-3">
									<label for="consignee" class="h6"><strong>收貨人:</strong></label>
									<form:input type="text" class="form-control"
										style="background-color:white;" id="consignee" value=''
										path="consignee" required="required" />
									<div>
										<strong class="text-danger">${insertError.emptyConsignee}</strong>
									</div>
									<div class="invalid-feedback">
										<strong>此欄位不可為空白</strong>
									</div>
								</div>
								<hr class="mb-4">
								<button id="submit" class="btn btn-secondary btn-lg btn-block"
									type="submit">下訂單</button>
							</form:form>
						</div>

					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- Bootstrap core JavaScript
    ================================================== -->
	<!-- Placed at the end of the document so the pages load faster -->
	<script src="https://code.jquery.com/jquery-3.2.1.slim.min.js"></script>
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js"></script>
	<script
		src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/holder/2.9.4/holder.min.js"></script>
	<script>
		// Example starter JavaScript for disabling form submissions if there are invalid fields
		(function() {
			'use strict';
			$("#coupon-select").hide();
			window.addEventListener('load',
					function() {
						// Fetch all the forms we want to apply custom Bootstrap validation styles to
						var forms = document
								.getElementsByClassName('needs-validation');

						// Loop over them and prevent submission
						var validation = Array.prototype.filter.call(forms,
								function(form) {
									form.addEventListener('submit', function(
											event) {
										if (form.checkValidity() === false) {
											event.preventDefault();
											event.stopPropagation();
										}
										form.classList.add('was-validated');
									}, false);
								});
					}, false);
		})();
	</script>

	<script>
		
		document
				.getElementById("submit")
				.addEventListener(
						"click",
						function(event) {
									
							if (confirm("你確定要下訂單嗎?")) {
								document.getElementById("orderForm").action = "<c:url value='/insertOrder' />";
								document.getElementById("orderForm").submit();
							} else {
								event.preventDefault();
								return false;
							}
						})
	</script>

	<script>
		$("#toggleEz").on("click", function() {
			$("#ezForm").toggle(1000);
			$("#toggleEz").css("border", "2px red solid");
			$("#home").css("border", "1px solid");
		});

		$("#home").on("click", function() {
			$("#addr").focus();
			$("#ezForm").css("display", "none");
			$("#home").css("border", "2px red solid");
			$("#toggleEz").css("border", "1px solid");

		});
		
		$("#OnlinePay").on("click", function() {
			if ($("#pay").val()!=1){
				$("#pay").val("1");
				$("#OnlinePay").css("border", "2px red solid");
				$("#WebATM").css("border", "1px solid");
			}else if ($("#pay").val()==1){
				$("#pay").val("0");
				$("#OnlinePay").css("border", "1px solid");
			}
		});
		$("#WebATM").on("click", function() {
			if ($("#pay").val()!=2){
				$("#pay").val("2");
				$("#WebATM").css("border", "2px red solid");
				$("#OnlinePay").css("border", "1px solid");
			}else if ($("#pay").val()==2){
				$("#pay").val("0");
				$("#WebATM").css("border", "1px solid");
			}
		});
	
	</script>

	<c:if test="${ezShip != null}">
		<script>
			$("#home").css("display", "none");
		</script>
	</c:if>


</body>
</html>