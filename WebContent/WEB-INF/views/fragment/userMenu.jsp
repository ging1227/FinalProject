<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="BIG5">
<title>userMenu</title>
<!-- JQuery -->
<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>

<!-- /彈跳視窗 -->
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">

<script
  src="https://code.jquery.com/jquery-3.4.1.js"
  integrity="sha256-WpOohJOqMqqyKL9FccASB9O0KwACQJpFTUBLTYOVvVU="
  crossorigin="anonymous">
</script>

<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
<!-- 彈跳視窗/ -->

<!-- 圖案   -->
<link rel="stylesheet"
	href="https://use.fontawesome.com/releases/v5.0.8/css/all.css">
<style>
body {
	background: #7d706f
}

.menu_Style {
	height: 820px;
	width: 300px;
	float: left;
	margin-top: 30px;
	margin-left: 20px;
}

.menu_headStyle {
	margin: 60px 0px 30px 60px;
}

.menu_a1{
	padding-left: 10px;
}

.user_font {
	font-family: 'Noto Sans TC', sans-serif;
}

ul li {
	list-style: none;
	margin: 30px 0px 30px 15px;
}


</style>
</head>
<body>
	<div id="update-menu" class="menu_Style">
		<div id="menu-head" class="menu_headStyle">
			<div id="img">
				<!-- 點擊圖片跳出彈跳視窗 -->
				<label data-toggle="modal" data-target="#exampleModalCenter">
					<img src="<%=request.getContextPath()%>/static/${data.picture}"
					style="cursor: pointer; width: 150px; height: 150px" />
				</label>


				<!-- Modal 彈跳視窗內容-->
				<div class="modal fade" id="exampleModalCenter" tabindex="-1"
					role="dialog" aria-labelledby="exampleModalCenterTitle"
					aria-hidden="true">
					<div class="modal-dialog modal-lg" role="document">
						<div class="modal-content">
							<div class="modal-header">
								<h5 class="modal-title" id="exampleModalLongTitle">
									<input type="file" multiple id="picture">
								</h5>

								<button type="button" class="close" data-dismiss="modal"
									aria-label="Close">
									<span aria-hidden="true">&times;</span>
								</button>
							</div>
							<div class="modal-body">

								<img id="show" src="" alt="預覽圖片" />

							</div>
							<div class="modal-footer">
								<button type="button" class="user_font btn btn-secondary"
									onclick="upload()">上傳頭像</button>
							</div>
						</div>
					</div>
				</div>
				<script type="text/javascript">
					//點擊上傳
					function upload() {
						//js接收文件
						var formData = new FormData();
						formData.append("files", $("#picture")[0].files[0]);

						$
								.ajax({
									url : "http://localhost:8080/FinalProject/upload.action",
									type : "POST",
									data : formData,
									contentType : false,
									processData : false,//有必要，不然不行
									mimeType : "multipart/form-data",
									success : function() {
										window.location.reload("update.jsp")
									}
								})
					}

					//用來顯示預覽圖片
					//imgInp(file的ID)
					$("#picture").change(function() {
						//當檔案改變後，做一些事 
						readURL(this); // this代表<input id="imgInp">
					});

					function readURL(input) {
						if (input.files && input.files[0]) {
							var reader = new FileReader();
							reader.onload = function(e) {
								//顯示圖片的ID
								$("#show").attr('src', e.target.result);
							}
							reader.readAsDataURL(input.files[0]);
						}
					}
				</script>


			</div>
		</div>
		<div id="menu-content" class="menu_contentStyle"></div>
		<ul>
			<li><span><i class="fa fa-user"></i></span><a
				class="menu_a1 user_font" href="<c:url value='/update.action' />">編輯使用者資訊</a></li>
			<li><span><i class="fa fa-lock"></i></span><a
				class="menu_a1 user_font" href="<c:url value='/updatePwd' />">登入與帳號安全</a></li>
			<li><span><i class="fa fa-file"></i></span><a
				class="menu_a1 user_font" href="<c:url value='/ordersBymId' />">查詢訂單</a></li>
		</ul>
	</div>
</body>
</html>