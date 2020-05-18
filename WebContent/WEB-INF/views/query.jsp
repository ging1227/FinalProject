<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Sampple store</title>
<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<style>
.queryContent {
	margin: 0px 20% 0px 20%;
	overflow: auto;
	height: 800px;
}

.queryMenu {
	margin: 0px 20% 0px 20%;
	overflow: auto;
}

.queryinfo {
	padding: 15px;
	height: 200px;
	width: 1200px;
}

.querybtn {
	text-align: center;
}

.menuImg {
	float: left;
	padding-right: 15px;
}

.menuText {
	float: left;
}

.qimg1 {
	width: 100px;
	height: 150px;
}
</style>
</head>
<body>
	<%@ include file="./fragment/indexTOP.jsp"%>
	<div id="queryContain">
		<div class="queryContent">
			<p style="text-align: center;">
				<input type="text" id=queryTxt name="query"
					value="${queryData.queryTxt}" onkeypress="reQueryEnter(1)" />
			</p>
			<hr />
			<div id="demo"></div>
		</div>
		<div id="d1" class="querybtn"></div>
		<div id="d2" class="querybtn"></div>
	</div>
	<script type="text/javascript">
		function reQueryEnter(page) {
			//page=1 搜尋出來是第一頁

			var keynum = (event.keyCode ? event.keyCode : event.which);
			if (keynum == '13') {
				//總共幾個分頁(總共多少按鈕)
				var totalbutton = 0;
				//設定一頁顯示幾筆資料
				var pageShow = 3;

				var queryTxt = $("#queryTxt").val();
				console.log(queryTxt);
				$
						.ajax({
							url : "http://localhost:8080/FinalProject/product/query.action",
							type : "POST",
							data : "&query=" + queryTxt,
							dataType : "json",
							success : function(data) {
								if (data != null) {
									document.getElementById("d2").innerHTML = "第"
											+ page + "頁";
								}
								console.log(data.length);

								var txt = "";
								if (data[((page - 1) * pageShow)
										+ (pageShow - 1)] == null) {
									for (let i = (page - 1) * pageShow; i < data.length; i++) {
										txt += "<div class='queryinfo'>"
										if (i < 1) {
											txt += "<div class='menuImg'>"
													+ "<img class='qimg1' src='http://localhost:8080/FinalProject/static/img/" + data[i].p_img + "'/></div>"
										}
										txt += "<div class='menuText'><p><h3>"
												+ data[i].p_name + "</h3></p>"
												+ "<p>" + data[i].des + "</p>"
										if (i < 1) {
											txt += "<p><a href='" + data[i].uri + "'>進一步了解</a>"
										} else {
											txt += "<p><a href='" + data[i].uri + "'>"
													+ data[i].uri + "</a></p>"
										}
										txt += "</div></div>"
									}
									$("#demo").html(txt);
								}
								//此頁可印出pageShow筆資料
								else {
									for (let i = (page - 1) * pageShow; i < ((page - 1) * pageShow)
											+ pageShow; i++) {
										txt += "<div class='queryinfo'>"
										if (i < 1) {
											txt += "<div class='menuImg'>"
													+ "<img class='qimg1' src='http://localhost:8080/FinalProject/static/img/" + data[i].p_img + "'/></div>"
										}
										txt += "<div class='menuText'><p><h3>"
												+ data[i].p_name + "</h3></p>"
												+ "<p>" + data[i].des + "</p>"
										if (i < 1) {
											txt += "<p><a href='" + data[i].uri + "'>進一步了解</a>"
										} else {
											txt += "<p><a href='" + data[i].uri + "'>"
													+ data[i].uri + "</a></p>"
										}
										txt += "</div></div>"
									}
									$("#demo").html(txt);
								}
								//能夠整除代表剛剛好
								if (data.length % pageShow == 0) {
									totalbutton = data.length / pageShow;
								}
								//不能整除就取整數+1
								else {
									totalbutton = Math.ceil(data.length
											/ pageShow);
								}
								//產生分頁頁數按鈕
								for (let i = 1; i <= totalbutton; i++) {

									var MyDiv = document.getElementById("d1");
									var bt = document.createElement("button");
									bt.onmouseover = function() {
										a1();
									}
									bt.innerHTML = i;

									d1.appendChild(bt);
								}
								//判斷選中第幾個button
								function a1() {

									var but = document
											.getElementsByTagName('button');
									for (var i = 0; i < but.length; i++) {
										but[i].setAttribute('i', i + 1);
										but[i].onclick = function() {
											b = this.getAttribute('i');
											go(b);
										}
									}
								}// a1() End
							}// success
						})
			}
		}

		//總共幾個分頁(總共多少按鈕)
		var totalbutton = 0;
		//設定一頁顯示幾筆資料
		var pageShow = 3;
		//先執行，產生第一頁的內容
		go(1);
		//呼叫totalPage()，判斷須分成幾頁
		totalPage();

		//讀取JSON資料並印出於表格上
		//page參數代表第幾頁

		function go(page) {

			var queryTxt = $("#queryTxt").val();
			console.log(queryTxt);

			$
					.ajax({
						url : "http://localhost:8080/FinalProject/product/query.action",
						type : "POST",
						data : "&query=" + queryTxt,
						dataType : "json",
						success : function(data) {
							if (data != null) {
								document.getElementById("d2").innerHTML = "第"
										+ page + "頁";
							}
							console.log(data.length);

							var txt = "";
							if (data[((page - 1) * pageShow) + (pageShow - 1)] == null) {
								for (let i = (page - 1) * pageShow; i < data.length; i++) {
									txt += "<div class='queryinfo'>"
									if (i < 1) {
										txt += "<div class='menuImg'>"
												+ "<img class='qimg1' src='http://localhost:8080/FinalProject/static/img/" + data[i].p_img + "'/></div>"
									}
									txt += "<div class='menuText'><p><h3>"
											+ data[i].p_name + "</h3></p>"
											+ "<p>" + data[i].des + "</p>"
									if (i < 1) {
										txt += "<p><a href='" + data[i].uri + "'>進一步了解</a>"
									} else {
										txt += "<p><a href='" + data[i].uri + "'>"
												+ data[i].uri + "</a></p>"
									}
									txt += "</div></div>"
								}
								$("#demo").html(txt);
							}
							//此頁可印出pageShow筆資料
							else {
								for (let i = (page - 1) * pageShow; i < ((page - 1) * pageShow)
										+ pageShow; i++) {
									txt += "<div class='queryinfo'>"
									if (i < 1) {
										txt += "<div class='menuImg'>"
												+ "<img class='qimg1' src='http://localhost:8080/FinalProject/static/img/" + data[i].p_img + "'/></div>"
									}
									txt += "<div class='menuText'><p><h3>"
											+ data[i].p_name + "</h3></p>"
											+ "<p>" + data[i].des + "</p>"
									if (i < 1) {
										txt += "<p><a href='" + data[i].uri + "'>進一步了解</a>"
									} else {
										txt += "<p><a href='" + data[i].uri + "'>"
												+ data[i].uri + "</a></p>"
									}
									txt += "</div></div>"
								}
								$("#demo").html(txt);
							}
						}// success
					})
		}
		function totalPage() {
			$
					.ajax({
						url : "http://localhost:8080/FinalProject/product/query.action",
						type : "POST",
						data : "&query=" + queryTxt,
						dataType : "json",
						success : function(data) {
							//能夠整除代表剛剛好
							if (data.length % pageShow == 0) {
								totalbutton = data.length / pageShow;
							}
							//不能整除就取整數+1
							else {
								totalbutton = Math.ceil(data.length / pageShow);
							}
							//產生分頁頁數按鈕
							for (let i = 1; i <= totalbutton; i++) {

								var MyDiv = document.getElementById("d1");
								var bt = document.createElement("button");
								bt.onmouseover = function() {
									a1();
								}
								bt.innerHTML = i;

								d1.appendChild(bt);
							}
						}
					})
		}
		//判斷選中第幾個button
		function a1() {

			var but = document.getElementsByTagName('button');
			for (var i = 0; i < but.length; i++) {
				but[i].setAttribute('i', i + 1);
				but[i].onclick = function() {
					b = this.getAttribute('i');
					go(b);
				}
			}
		}// a1() End
	</script>
</body>
</html>