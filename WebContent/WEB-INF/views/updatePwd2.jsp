<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>updatePwdPage</title>
<style type="text/css">
body {
	margin: 0px;
	padding: 0px;
}

#content {
	background-color: #DADFE1;
	background-repeat: no-repeat;
	background-size: cover;
	height: 820px;
	margin: 20px 20% 20px 20%;
	border-radius: 15px;
	width: 1141px;
}

#formStyle {
	float: left;
	width: 600px;
	margin-top: 30px;
}

#header_Style {
	font-size: 32px;
	font-family: 'Noto Sans TC', sans-serif;
	padding-left: 235px;
}

.user_font {
	font-family: 'Noto Sans TC', sans-serif;
}

input[type=password] {
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

.signbtn:hover {
	text-decoration: underline;
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
		<%@ include file="./fragment/userMenu.jsp"%>
		<div id="formStyle">
		<span id="header_Style">修改密碼</span>
		<form action="<c:url value="/updatePwd.action" />" method="post" onsubmit="return checksubmit();">
			<div class="container">
				<label for="pwd" class="user_font"><b>請輸入密碼</b></label> <input type="password"
					placeholder="請輸入密碼" name="password" id="pwd" onkeyup="checkReg2()"
					required><br>
				<div style="color: red;height: 1px" id="txt2"></div>
				<span id="strong" style="display:none"></span><br><br>
							
					
					<label for="repwd" class="user_font"><b>請再次輸入密碼</b></label> <input
					type="password" placeholder="請再次輸入密碼" name="pwd-repeat" id="repwd"
					onkeyup="checkReg3()" required><br>
				<div style="color: red;height: 1px" id="txt3"></div><br><br>	

				<div class="form-group">
						<button type="submit" class="user_font btn btn-primary btn-block" style="width: 50%;margin: auto;">
							完成修改</button>
				</div>


			</div>


		</form>
		</div>

	</div>

	<%@ include file="./fragment/indexBOTTOM.jsp"%>



	<script type="text/javascript">
		function checksubmit(){

			var pwd=document.getElementById("txt2").innerHTML;
			var pwdre=document.getElementById("txt3").innerHTML;
			
			if( pwd !="" || pwdre !=""){
				window.alert("欄位輸入錯誤！請重新輸入");
				return false;
			}
			else{
				return true;
			}
		}


	
		// callback function
		function checkReg2() {
			var rexEng = /[A-Za-z]/
			var rexNum = /[0-9]/
			var strValue = document.getElementById("strong")
			var txtValue = document.getElementById("txt2")
			var pwdValue = document.getElementById("pwd").value

			//判斷密碼強度，總分9
			var score = 0;
			//判斷大寫
			var rexBig = /[A-Z]/
			//判斷小寫
			var rexLittle = /[a-z]/
			//判斷特殊符號
			var pattern = new RegExp("[`~!@#$^&*()=|{}':;',\\[\\].<>《》/?~！@#￥……&*（）——|{}【】‘；：”“'。，、？]");	

			
			// 不能為空值
			if (pwdValue == "") {
				
				txtValue.innerHTML = '密碼不能空白';
			}
			// 至少六個字
			else if (pwdValue.length < 6) {
				
				txtValue.innerHTML = '至少六個字';
			}
			// 判斷英文
			else if (!rexEng.test(pwdValue)) {
				
				txtValue.innerHTML = '沒有英文';
			}
			// 判斷數字
			else if (!rexNum.test(pwdValue)) {
				
				txtValue.innerHTML = '沒有數字';
			} else {
				
				txtValue.innerHTML = "";
			}


			//密碼強度
			if(txtValue.innerHTML==""){
				$("#strong").css("display",'');
				
				if (pwdValue.length >= 6) {
					score+=1;
					if(pwdValue.length >= 10){
						score+=2;
					}
					if(rexNum.test(pwdValue)){
						score+=1;
					}
					if(rexBig.test(pwdValue)){
						score+=2;
					}
					if(rexLittle.test(pwdValue)){
					score+=1;
					}
					if(pattern.test(pwdValue)){
						score+=2;
					}

					if(score<=3){
						strValue.innerHTML="密碼程度:弱";
					}
					else if(score>3 && score<7){
						strValue.innerHTML="密碼程度:中";
					}
					else{
						strValue.innerHTML="密碼程度:強";
					}	
				}
			}
			else{
				$("#strong").css("display",'none');
			}	
		}
		// callback function
		function checkReg3() {
			var rexEng = /[A-Za-z]/
			var rexNum = /[0-9]/
			
			var txtValue = document.getElementById("txt3")
			var pwdValue = document.getElementById("pwd").value
			var repwdValue = document.getElementById("repwd").value
			// 不能為空值
			if (repwdValue == "") {
				
				txtValue.innerHTML = '二次密碼不能空白';
			}
			// 至少六個字
			else if (repwdValue.length < 6) {
				
				txtValue.innerHTML = '至少六個字';
			}
			// 判斷英文
			else if (!rexEng.test(repwdValue)) {
				
				txtValue.innerHTML = '沒有英文';
			}
			// 判斷數字
			else if (!rexNum.test(repwdValue)) {
				
				txtValue.innerHTML = '沒有數字';
			}
			// 密碼相等
			else if (repwdValue != pwdValue) {
				
				txtValue.innerHTML = '二次密碼和密碼不同';
			} else {
				
				txtValue.innerHTML = "";
			}
		}
	</script>
</body>
</html>