<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>forgetPwdPage</title>
<script src="http://code.jquery.com/jquery-1.12.4.min.js"></script>
<style type="text/css">
body {
	background-color: #E8E8E8;
	margin: 0px;
	padding: 0px;
	
}

#content {
	background-repeat: no-repeat;
	background-size: cover;
	height: 1000px;
	margin: 30px 0px 0px 550px;

	width: 800px
}
form {
	background-color: white;
	border: 1px solid white;
	border-radius: 10px;
}

input[type=text], input[type=password] {
	width: 100%;
	padding: 12px 20px;
	margin: 8px 0;
	display: inline-block;
	border: 1px solid #ccc;
	box-sizing: border-box;
}

button {
	background-color: #4CAF50;
	color: white;
	padding: 14px 20px;
	margin: 8px 0;
	border: none;
	cursor: pointer;
	width: 100%;
}

button:hover {
	opacity: 0.8;
}

.signbtn {
	width: auto;
	padding: 5px 5px;
	border-radius: 10px;
	border: 2px solid pink;
	margin: 10px;
	background-color: white;
	text-decoration: none;
}
.signbtn:hover{
	
	text-decoration:underline;
	background-color: #CCFFFF;
}

.imgcontainer {
	text-align: center;
	margin: 24px 0 12px 0;
}

img.avatar {
	width: 40%;
	border-radius: 50%;
}

.container {
	padding: 16px;
}

span.psw {
	float: right;
	padding-top: 16px;
}

.user_font {
	font-family: 'Noto Sans TC', sans-serif;
}

/* Change styles for span and cancel button on extra small screens */
@media screen and (max-width: 300px) {
	span.psw {
		display: block;
		float: none;
	}
	.cancelbtn {
		width: 100%;
	}
}
</style>
</head>
<body>
<%@ include file="./fragment/indexTOP.jsp"%>


<div id="content">

	<h2 class="user_font">忘記密碼?</h2>

		<form action="<c:url value="/memorycover" />" method="post">

			<h4 class="user_font">我們將寄送密碼重置信件協助您修改密碼</h4>
			<div class="container">
				<label for="uname"><b>帳號(信箱)</b></label> <input type="text"
					placeholder="請輸入帳號" name="email" required onblur="msg()"> <br>
				<b style="color:red" id="msg">${errors.no}</b>
				<button type="submit" class="btn btn-primary"
					style="width: 50%; margin-left: 180px; margin-top: 20px">繼續</button>
				

			</div>

			
		</form>


</div>

<script type="text/javascript">
	function msg(){
		$("#msg").html("");
	}
</script>

<%@ include file="./fragment/indexBOTTOM.jsp"%>
</body>
</html>