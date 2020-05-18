<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>


<!DOCTYPE html>
<html>

<head>
<meta charset='UTF-8'>
<title>Sampple</title>
<script src="https://code.jquery.com/jquery-3.5.0.min.js"
	integrity="sha256-xNzN2a4ltkB44Mc/Jz3pT4iU1cmeR0FkXs4pru/JxaQ="
	crossorigin="anonymous"></script>
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css"
	integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh"
	crossorigin="anonymous">
<script
	src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js"
	integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6"
	crossorigin="anonymous"></script>
<script
	src="https://cdn.jsdelivr.net/npm/jquery@3.4.1/dist/jquery.min.js"></script>

<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/gh/fancyapps/fancybox@3.5.7/dist/jquery.fancybox.min.css" />
<script
	src="https://cdn.jsdelivr.net/gh/fancyapps/fancybox@3.5.7/dist/jquery.fancybox.min.js"></script>


<link
	href="https://fonts.googleapis.com/css2?family=Noto+Sans+TC:wght@500;700&display=swap"
	rel="stylesheet">


<style class="cp-pen-styles">
* {
	margin: 0;
	padding: 0;
	box-sizing: border-box;
	-webkit-transition: 0.2s ease-in-out;
	-moz-transition: 0.2s ease-in-out;
	-o-transition: 0.2s ease-in-out;
	transition: 0.2s ease-in-out;
	font-family: "proxima-nova", sans-serif;
	font-weight: 300;
	color: #444B54;
}

*:focus {
	outline: none;
}

body {
	background-color: #7d706f;
}

#wrapper {
	position: absolute;
	top: 50%;
	margin-top: -300px;
	left: 0;
	width: 100%;
}

#container {
	width: 1100px;
	height: 650px;
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
	filter: progid:DXImageTransform.Microsoft.gradient(startColorstr='#dadfe1',
		endColorstr='#f9feff', GradientType=1);
}

#img-wrap {
	width: 550px;
	height: 80%;
	float: left;
	position: relative;
}

#img-wrap .images {
	width: 70%;
	overflow: hidden;
	margin: 500px auto 0 auto;
}

#img-wrap .images li {
	list-style: none;
	width: 33.33%;
	float: left;
	padding: 10px;
	text-align: center;
	cursor: pointer;
	opacity: 0.5;
}

#img-wrap .images li img {
	width: 80%;
}

#img-wrap .images li:nth-child(4) {
	padding-top: 25px;
}

#img-wrap .images li:hover {
	opacity: 1;
}

#img-wrap .images .big-img {
	width: 60%;
	float: none;
	padding: 0;
	margin: 12.5% 20%;
	text-align: center;
	opacity: 1;
	position: absolute;
	top: 0px;
	left: 0;
}

#img-wrap .images .big-img img {
	-webkit-filter: drop-shadow(0px 7px 3px #6C7A89);
	filter: drop-shadow(0px 7px 3px #6C7A89);
}

.colors {
	width: 125px;
	margin: 15px auto;
}

.colors li {
	width: 25px;
	height: 25px;
	margin-right: 25px;
	list-style: none;
	float: left;
	background: sliver;
	cursor: pointer;
	position: opacity: 0.7;
	-webkit-border-radius: 100%;
	-moz-border-radius: 100%;
	-ms-border-radius: 100%;
	border-radius: 100%;
	-webkit-box-shadow: 0px 1px 2px 0px rgba(0, 0, 0, 0.3);
	-moz-box-shadow: 0px 1px 2px 0px rgba(0, 0, 0, 0.3);
	box-shadow: 0px 1px 2px 0px rgba(0, 0, 0, 0.3);
}

.colors li:nth-child(2) {
	background: gray;
}

.colors li:nth-child(3) {
	margin-right: 0;
	background: pink;
}

.colors li:hover, .colors li.target {
	opacity: 1;
	-webkit-box-shadow: 0px 1px 4px 0px rgba(0, 0, 0, 0.5);
	-moz-box-shadow: 0px 1px 4px 0px rgba(0, 0, 0, 0.5);
	box-shadow: 0px 1px 4px 0px rgba(0, 0, 0, 0.5);
}

.info {
	width: 550px;
	height: 100%;
	float: right;
	padding: 30px 50px 20px 0;
	background: url() no-repeat;
	background-position: 80% 0%;
	background-size: 65%;
}

.info h1 {
	font-size: 2.5em;
	font-weight: 400;
	float: left;
	text-transform: uppercase;
	margin: 10px 0px 10px;
	font-style: italic;
	font-weight: bold;
}

.info h2 {
	clear: both;
	font-size: 2em;
	letter-spacing: 1px;
	text-transform: uppercase;
	margin: 5px 0 0;
	float: left;
	color: #8199A3;
}

.info p {
	font-family: cursive;
	font-weight: 900;
	clear: both;
	padding: 20px 0px 5px;
	line-height: 1.5em;
	font-size: 1.5em;
	letter-spacing: 0.5px;
}

.info #pricing .info #storage1 .info #quantity1 {
	text-transform: uppercase;
	letter-spacing: 1px;
	font-weight: bold;
}

.info #price {
	margin-top: 10px;
	float: none;
	font-size: 2em;
	font-family: "proxima-nova", bold = "900";
}

.info h3 {
	letter-spacing: 1px;
	text-transform: uppercase;
	margin: 5px 0 0;
	float: left;
	color: #8199A3;
}

.important {
	display: inline-block;
	float: left;
	margin-top: 5px;
}

.center {
	margin-top: 5px;
	display: inline-block;
	width: 20%;
	margin: 5px 0px 15px 50px;
}

.center .c1 {
	background: #7d706f;
	color: #F2F2F2;
	width: 70%;
	height: 40px;
	font-size: 1.5em;
	font-weight: bold;
	-webkit-border-radius: 5px;
	-moz-border-radius: 5px;
	-ms-border-radius: 5px;
	border-radius: 5px;
}

input[type=number]::-webkit-inner-spin-button {
	width: 40px;
	height: 40px;
}

.form {
	display: inline-block;
	float: right;
	margin-top: 5px;
}

.form .color {
	-webkit-appearance: none;
	-moz-appearance: none;
	appearance: none;
	padding: 0 20px;
	width: 100%;
	height: 40px;
	border: none;
	background: #7d706f;
	font-size: 1.5em;
	letter-spacing: 1px;
	-webkit-border-radius: 5px;
	-moz-border-radius: 5px;
	-ms-border-radius: 5px;
	border-radius: 5px;
	color: #F2F2F2;
	font-weight: bold;
	cursor: pointer;
	font-weight: 400;
	-moz-border-radius: 5px;
	-ms-border-radius: 5px;
	border-radius: 5px;
}

.form .color:hover {
	background: #5c5554;
}

.button {
	width: 100%;
	margin-top: 30px;
	border: none;
	background: #7d706f;
	padding: 20px 0;
	font-size: 1.5em;
	line-height: 1.5em;
	letter-spacing: 1px;
	-webkit-border-radius: 5px;
	-moz-border-radius: 5px;
	-ms-border-radius: 5px;
	border-radius: 5px;
	color: #F2F2F2;
	cursor: pointer;
}

.button:hover {
	background: #5c5554;
}

@media screen and (max-width: 1440px) {
	#wrapper {
		transform: scale(0.7);
	}
}

.forbottom {
	font-family: 'Noto Sans TC', sans-serif;
	color: white;
}

#one {
	z-index: 1;
}

#two {
	z-index: 999;
	position: relative
}
</style>
</head>

<body>
	<div id="two">
		<%@ include file="./fragment/indexTOP.jsp"%>
	</div>

	<div id="one">
		<div id="wrapper">
			<div id="container">

				<div id="img-wrap">
					<ul class="images">
						<li class="big-img"><a data-fancybox="gallery"
							href="<c:url value="/productC/getImage?img=${img}" />"><img
								id="image"
								style="-webkit-border-radius: 30px; -moz-border-radius: 30px; border-radius: 30px;"
								src="<c:url value="/productC/getImage?img=${img}" /> "></a></li>
					</ul>

					<ul class="colors">
						<c:forEach var="color" items="${colorlist}">
							<li role="radio" id="color" value="${color}"
								onclick="changeimg(this)" />
							</li>
						</c:forEach>
					</ul>
					<input type="text" id="newColor" value="${color}" disabled
						hidden="hidden">
				</div>

				<div class="info">

					<h1 id="p_name">${p_name}</h1>

					<h2>CPU:${cpu}</h2>
					<h2>RAM:${ram}</h2>

					<p>${des}</p>

					<div class="important">
						<p id="pricing">Price</p>
						<h3 id="price">NT$${price}</h3>
						<input type="text" id="newPrice" value="${price}" disabled
							hidden="hidden">
					</div>



					<div class="form">
						<p id="storage1">Choose Storage</p>
						<select class="color" id="storage" name="storage"
							onchange="changeprice()">
							<c:forEach var="storage" items="${storagelist}">
								<option>${storage}</option>
							</c:forEach>
						</select>
					</div>

					<%-- 調整購買數量 --%>
					<div class="center">
						<p id="quantity1">Quantity</p>
						<input type="number" class="c1" name="quantity" id="quantity"
							min="1" max="99" value="1" />
					</div>

					<%-- 加入購物車 --%>
					<input id="cartBtn" type="button" class="button"
						value="Add to cart">
				</div>


			</div>
	
			
		</div>

	</div>



	<script type="text/javascript">
		function changeprice() {

			$.ajax({
				url : "/FinalProject/productC/changeprice",
				type : "GET",
				dataType : "json",
				data : {
					"p_name" : $("#p_name").text(),
					"storage" : $("#storage option:selected").text(),
				},
				success : function(res) {
					$("#price").text("NT$" + res.price);
					$("#newPrice").attr('value', res.price);
				},
				error : function(error) {
					alert("error: " + error);
				}
			})
		}

		function changeimg(obj) {
			$.ajax({
				url : "/FinalProject/productC/changeimg",
				type : "POST",
				dataType : "json",
				data : {
					"p_name" : $("#p_name").text(),
					"color" : $(obj).attr('value'),

				},
				success : function(res) {
					$("#image").attr(
							'src',
							'<c:url value="/productC/getImage?img=' + res.p_img
									+ '" />');
					$("#newColor").attr('value', $(obj).attr('value'));
				},
				error : function(error) {
					alert("error: " + error);
				}
			})
		}

		$(document)
				.ready(
						function() {
							var qty = $("#quantity").val();
							$("#quantity").on("change", function() {
								qty = $(this).val();
								console.log("newQty=" + qty);
							});

							var storage = $("#storage").val();
							$("#storage").on("change", function() {
								storage = $(this).val();
								console.log("newstorage=" + storage);
							});

							$("#cartBtn")
									.click(
											function(e) {
												console.log("add Cart");
												var pname = '${p_name}';
												var cpu = '${cpu}';
												var ram = '${ram}';
												var price = $("#newPrice")
														.val();
												if (price == null) {
													price = '${price}';
												}

												var color = $("#newColor")
														.val();
												if (color == null) {
													color = '${color}';
												}

												var product = new Product(
														pname, color, cpu, ram,
														storage, price);
												var productAsJSON = JSON
														.stringify(product);
												console.log(productAsJSON);
												$
														.ajax({
															type : "POST",
															data : productAsJSON,
															contentType : "application/json",
															url : "/FinalProject/addCart?qty="
																	+ qty,
															success : function(
																	data) {

																if (data
																		.hasOwnProperty("error")) {
																	var error = data["error"];
																	alert(error);
																	$(
																			"#quantity")
																			.val(
																					"1");
																	qty = 1;
																} else if (data
																		.hasOwnProperty("success")) {
																	var success = data["success"];
																	alert(success);
																	$(
																			"#quantity")
																			.val(
																					1);
																	qty = 1;
																	window.location.href = "/FinalProject/cartConfirm";
																}
															}
														});
												return false;
											});

						});

		function Product(pname, color, cpu, ram, storage, price) {
			this.pname = pname;
			this.color = color;
			this.cpu = cpu;
			this.ram = ram;
			this.storage = storage;
			this.price = price;
		}
	</script>



</body>

</html>