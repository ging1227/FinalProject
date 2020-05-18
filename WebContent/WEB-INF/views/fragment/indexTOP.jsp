<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>

<head>
<meta charset="UTF-8">
<title>indexTop</title>
<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>

<link
	href="https://fonts.googleapis.com/css2?family=Noto+Sans+TC:wght@500;700&display=swap"
	rel="stylesheet">

<!-- 彈跳視窗 -->
<script src="https://code.jquery.com/jquery-3.4.1.js"
	integrity="sha256-WpOohJOqMqqyKL9FccASB9O0KwACQJpFTUBLTYOVvVU="
	crossorigin="anonymous"></script>
<script
	src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"
	integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM"
	crossorigin="anonymous"></script>

<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css"
	integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T"
	crossorigin="anonymous">

<!-- 彈跳視窗 End -->

<style>
body {
	margin: 0px;
	padding: 0px;
	background-color: #E8E8E8;
}

.top1 {
	margin: 0px 20% 0px 20%;
	overflow: auto;
}

.fixed_top1 {
	/* fixed 固定住位置, top:0 代表固定在最上面 */
	position: fixed;
	top: 0;
	width: 100%;
	z-index: 1000;
}

#containTop {
	background-color: #272727;
}

#m1 {
	float: left;
}

#m2 {
	float: right;
}

table tr td {
	padding-right: 20px;
}

table tr td a {
	color: #F0F0F0;
	line-height: 45px;
	text-decoration: none;
	font-family: 'Noto Sans TC', sans-serif;
}

table tr td a:hover {
	color: white;
	text-decoration: none;
}

.ptxt {
	background-color: #272727;
	border: 0px;
	color: white;
}

#imgQ1 {
	float: right;
	cursor: pointer;
}

img {
	vertical-align: middle
}

.queryHide {
	display: none;
}
</style>
</head>

<body>
	<div id="containTop">
		<div id="header" class="top1">
			<table id="m1">
				<tr>
					<td><a href="<%=request.getContextPath()%>/"><img
							src="<%=request.getContextPath()%>/static/img/verygoodapple.png" /></a></td>
					<td><a href="<%=request.getContextPath()%>/productC/mac">XMac</a></td>
					<td><a href="<%=request.getContextPath()%>/productC/pad">XPad</a></td>
					<td><a href="<%=request.getContextPath()%>/productC/phone">XPhone</a></td>
				</tr>
			</table>
			<table id="m2">
				<tr>
					<!-- 搜尋 -->
					<td><!-- 彈跳視窗搜尋 --> <label id="la" data-toggle="modal"
						data-target=".bd-example-modal-sm"><img
							src="<%=request.getContextPath()%>/static/img/query.jpg"
							style="cursor: pointer;" /></label> <!-- Modal 彈跳視窗內容-->
						<div class="modal fade bd-example-modal-sm" tabindex="-1"
							role="dialog" aria-labelledby="mySmallModalLabel"
							aria-hidden="true">
							<div class="modal-dialog modal-sm">
								<div class="modal-content">
									<span class="ptxt"> <input type="text" id="queryValue"
										class="ptxt" name="query" placeholder="搜尋 sampple.com…"
										size="34" autofocus onkeypress="queryEnter()" /> <img
										id="imgQ1"
										src="<%=request.getContextPath()%>/static/img/query.jpg"
										onclick="query()" /></span>
								</div>
							</div>
						</div>
					</td>
					<td><a href="#" onclick="customer()">支援</a></td>
					<c:if test="${empty identity}">
						<td><a href="<c:url value='/login.return' />">登入</a></td>
					</c:if>
					<c:if test="${!empty identity }">
						<td><a id="logout" href="<c:url value='/logout.return' />">登出</a></td>
					</c:if>
					<c:if test="${!empty identity }">
						<td><a id="update" href="<c:url value='/update.action' />">個人資料</a></td>
					</c:if>
					<td><a href="<c:url value='/cartConfirm' />">購物車</a></td>
				</tr>
			</table>
		</div>
	</div>

	<script type="text/javascript">
		function queryEnter() {
			var keynum = (event.keyCode ? event.keyCode : event.which);
			if (keynum == '13') {
				//jQuery.noConflict();
				$('.bd-example-modal-sm').modal('hide');
				var queryValue = $("#queryValue").val();
				$
						.ajax({
							url : "http://localhost:8080/FinalProject/product/query.value",
							type : "GET",
							async : false,
							data : "&query=" + queryValue,
							dataType : "text",
							success : function(path) {
								window.location.href = path;
							}
						})
			}
		}
		function query() {
			$('.bd-example-modal-sm').modal('hide');
			var queryTxt = $("#queryTxt").val();
			jQuery.noConflict();
			$.ajax({
				url : "http://localhost:8080/FinalProject/product/query.value",
				type : "GET",
				async : false,
				data : "&query=" + queryTxt,
				dataType : "text",
				success : function(path) {
					window.location.href = path;
				}
			})
		}

		$(function() {
			//offset() ：讀取指定元素在頁面(文件)上的相對坐標，
			//回傳含有top及left屬性的物件            

			let navbarPosition = $('#containTop').offset().top;
			$(window).scroll(function() {
				let scrollTop = $(this).scrollTop();

				if (scrollTop > navbarPosition) {
					$('#containTop').addClass("fixed_top1")
				} else {
					$("#containTop").removeClass("fixed_top1")
				}
			});
		});

		function customer() {
			console.log("click!");
			$.ajax({
				type : "GET",
				url : "chat",
				success : function(data) {
					if (data.hasOwnProperty('fail')) {
						alert(data["fail"]);
					} else if (data.hasOwnProperty('login')) {
						alert(data["login"]);
						window.location.href = "/FinalProject/login.return";
					} else {
						window.open(
								'http://localhost:8080/FinalProject/customer',
								'客服支援', config = 'height=600,width=600')
					}
				}
			});
		};
	</script>
</body>

</html>