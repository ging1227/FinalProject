<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<!DOCTYPE html>
<html>

<head>
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/static/css/bootstrap.min.css"
	type="text/css" />
<!-- animate css -->
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/static/css/animate.css"
	type="text/css" />
<!-- jquery-ui.min css -->
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/static/css/jquery-ui.min.css"
	type="text/css" />
<!-- meanmenu css -->
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/static/css/meanmenu.min.css"
	type="text/css" />
<!-- nivo slider css -->
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/static/css/nivo-slider.css"
	type="text/css" />
<link rel="stylesheet" 
	href="<%=request.getContextPath()%>/static/css/preview.css"
	type="text/css" />
<!-- owl.carousel css -->
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/css/owl.carousel.css"
	type="text/css" />
<!-- font-awesome css -->
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/static/css/font-awesome.min.css"
	type="text/css" />
<!-- style css -->
<link rel="stylesheet" 
	href="<%=request.getContextPath()%>/static/css/style.css"
	type="text/css" />
<!-- responsive css -->
<link rel="stylesheet"
	href="//netdna.bootstrapcdn.com/bootstrap/3.0.0/css/bootstrap.min.css">

<script type="text/javascript"
	src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<script type="text/javascript"
	src="https://cdnjs.cloudflare.com/ajax/libs/modernizr/2.8.3/modernizr.min.js"></script>

<title>客服支援</title>

<style>
.system_log {
	color: red;
	font-size: 25px;
	margin-top: 5px;
}

#log::-webkit-scrollbar {
	width: 8px;
}

#log::-webkit-scrollbar-track {
	-webkit-border-radius: 10px;
	border-radius: 10px;
	margin: 5px 5px 5px 5px;
}

#log::-webkit-scrollbar-thumb {
	-webkit-border-radius: 4px;
	border-radius: 4px;
	background: rgb(191, 191, 191);
}
</style>


<script>
	var ws;

	$(document).on('keypress', function(e) {
		if (e.which == 13 & $("#msg").is(":focus")) {
			send();
		}
	});

	$(function() {
		//WebSocket
		ws = new WebSocket("ws://localhost:8080/FinalProject/chat/${name}/${email}");
		ws.onmessage = function(event) {
			//clean message
			$("#clean")
					.click(
							function() {
								$("#log")
										.html(
												"<div class='system_log'><strong>系統通知 : 已清除聊天室</strong></div>");
							});
			//send message
			console.log("Event:" + event.data);
			var msgJson = JSON.parse(event.data);
			if (msgJson.sysMsg != null) {
				$("#log").append(
						"<div class='system_log'><strong>系統通知 : "
								+ msgJson.sysMsg + "</strong></div>");
			} else {
				//picture + username + message with html css
				let userContent = msgJson.content;
				var log_start = "<div class='message' style='width:auto;height:70px;font-size: 16px;border: 1px solid gray;border-left:0px;border-right:0px;margin-top: 10px;'>";
				var name = "<div style='display:inline;'>" + msgJson.name
						+ ":</div>";
				var message = "<div style='margin-left:70px;margin-right:5px;border-top:1px solid silver'>"
						+ userContent + "</div>";
				var log_end = "</div>";
				$("#log").append(log_start + name + message + log_end);
			}

			//13 message and get scrollbar rolling error
			$("#log").scrollTop($("#log").height());
		};

	});

	function send() {
		if ($("#msg").val() != "") {
			var json = JSON.stringify({
				"content" : $("#msg").val()
			});
			console.log(json);
			//reset and refocus on input
			$("#msg").val("");
			$("#msg").focus();
			ws.send(json);
		}
	}
</script>

</head>

<body>
	<table
		style="margin-left: auto; margin-right: auto; margin-top: 5px; margin-bottom: 5px; border: 2px solid black;">
		<tr>
			<td>
				<div
					style="width: 450px; height: 500px; background-color: white; overflow: auto;"
					id="log"></div>
			</td>
		</tr>
		<tr>
			<td><input type="text" size="51" id="msg"
				placeholder="請輸入訊息....." autofocus="autofocus" />
				<button type="button" onclick="send();">Send</button>
				<button id="clean" type="button">clean</button></td>

		</tr>
	</table>
</body>



</html>