<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>

<head>
<meta charset="UTF-8" name="viewport"
	content="width=device-width, initial-scale=1">
<title>LoginPage</title>
<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<style type="text/css">
body {
	background-color: #E8E8E8;
	margin: 0px;
	padding: 0px;
}

#content {
	background-repeat: no-repeat;
	background-size: cover;
	height: 700px;
	padding-top:30px;
	margin: auto ;
	font-family: 'Noto Sans TC', sans-serif;
	width: 800px;
}

form {
	border: 3px solid white;
	background-color: white;
	border-radius: 10px;
}

.emailStyle, input[type=password] {
	width: 100%;
	padding: 12px 20px;
	margin: 8px 0;
	display: inline-block;
	border: 1px solid #ccc;
	box-sizing: border-box;
}

button {
	background-color: #0080FF;
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
	padding-left: 20px;
	padding-right: 20px;
	padding-top: 10px;
	padding-bottom: 10px;
	font-family: 'Noto Sans TC', sans-serif
}

span.psw {
	float: right;
	padding-top: 16px;
}

.line {
	color: #E8E8E8
}

h5 {
	margin: 0px;
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
		<h2 class="up">會員登入</h2>
		<h3>${msg}${msgs} ${updatemsg}</h3>
		<form action="<c:url value='/login' />" method="post" id="form1">


			<div class="container">
				<label for="uname"><b>帳號</b></label> <input type="text" class="emailStyle"
					 placeholder="請輸入信箱" name="email" id="email"
					onblur="verifymail()" required>
				<div id="checkmailtxt" style="color: red; height: 10px"></div>
				<br> <label for="psw"><b>密碼</b></label> <input type="password"
					placeholder="請輸入密碼" name="password" id="password"
					onblur="verifypwd()" required>
				<div id="checkpwdtxt" style="color: red; height: 1px"></div>
				<br>

				<button type="submit" class="btn btn-primary"
					style="width: 50%; margin-left: 180px">登入</button>

				<img alt="google"
					src="<%=request.getContextPath()%>/static/img/google.jpg"
					id="btnSignIn"
					style="cursor: pointer; width: 30%; margin-left: 240px">

				<p style="color: red; height: 1px" id="errmsg">${errors.msg}</p>
				<h5 class="container line">
					<a href="<c:url value='/forget.return' />">忘記密碼?</a>
				</h5>

				<h5 class="container line">
					<a href="<c:url value='/sign.return' />">還沒有註冊? 建立新帳號</a>
				</h5>

				<!--CLIENT_ID請自己改-->
				<script type="text/javascript">
					let CLIENT_ID = "639020830248-o9oclhac3crknk5jsqadqeaeg36c7m6e.apps.googleusercontent.com";
					//let API_KEY = '';//Javascript SDK無須 API 金鑰
					// Array of API discovery doc URLs for APIs
					let DISCOVERY_DOCS = [ "https://www.googleapis.com/discovery/v1/apis/people/v1/rest" ];
				</script>
				<!--執行Google API必須的.js，callback function名稱請自訂 -->
				<!--↓https://apis.google.com/js/platform.js 或 https://apis.google.com/js/api.js 兩者網址都行得通 這裡採用跟官網寫法一樣-->
				<script async defer src="https://apis.google.com/js/api.js"
					onload="this.onload=function(){};GoogleClientInit()"
					onreadystatechange="if (this.readyState === 'complete') this.onload()">
					
				</script>

				<!--以下請另外放置到 *.js檔案-->
				<script type="text/javascript">
					//jQuery處理button click event 當畫面DOM都載入時....
					$(function() {
						$("#btnSignIn").on("click", function() {
							$("#content").html("");//清空顯示結果
							GoogleLogin();//Google 登入
						});
						$("#btnDisconnect").on("click", function() {
							Google_disconnect();//和Google App斷連
						});
					});

					function GoogleClientInit() {
						//官網範例寫client:auth2，但本人實測由於待會要呼叫gapi.client.init而不是gapi.auth2.init，所以給client即可
						gapi.load('client', function() {
							gapi.client.init({
								//client_id 和 scope 兩者參數必填
								clientId : CLIENT_ID,
								//scope列表參考：https://developers.google.com/people/api/rest/v1/people/get
								//"profile"是簡寫，要用完整scope名稱也可以
								scope : "profile",//"https://www.googleapis.com/auth/userinfo.profile",
								discoveryDocs : DISCOVERY_DOCS
							});
						});//end gapi.load
					}//end GoogleClientInit function

					function GoogleLogin() {
						let auth2 = gapi.auth2.getAuthInstance();//取得GoogleAuth物件
						auth2
								.signIn()
								.then(
										function(GoogleUser) {
											console.log("Google登入成功");
											let user_id = GoogleUser.getId();//取得user id，不過要發送至Server端的話，為了資安請使用id_token，本人另一篇文章有範例：https://dotblogs.com.tw/shadow/2019/01/31/113026
											console.log(`user_id:${user_id}`);
											let AuthResponse = GoogleUser
													.getAuthResponse(true);//true會回傳包含access token ，false則不會
											let id_token = AuthResponse.id_token;//取得id_token
											//people.get方法  拿到使用者的各種資料
											gapi.client.people.people
													.get(
															{
																'resourceName' : 'people/me',
																//通常你會想要知道的用戶個資↓
																'personFields' : 'names,phoneNumbers,emailAddresses,addresses,residences,genders,birthdays,occupations',
															})
													.then(
															function(res) {
																//success
																let genders = JSON
																		.stringify(res.result.genders[0].formattedValue);//將物件列化成string，方便顯示結果在畫面上
																let residences = JSON
																		.stringify(res.result.residences[0].value);

																let year = JSON
																		.stringify(res.result.birthdays[0].date.year);
																let month = JSON
																		.stringify(res.result.birthdays[0].date.month);
																let day = JSON
																		.stringify(res.result.birthdays[0].date.day);

																let birth = year
																		+ "-"
																		+ month
																		+ "-"
																		+ day;
																//console.log(year+"-"+month+"-"+day);
																//顯示授權你網站存取的用戶個資
																//document.getElementById('con').innerHTML = str;
																//↑通常metadata標記primary:true的個資就是你該抓的資料

																//請再自行Parse JSON，可以將JSON字串丟到線上parse工具查看：http://json.parser.online.fr/

																//最終，取得用戶個資後看要填在畫面表單上或是透過Ajax儲存到資料庫(記得是傳id_token給你的Web Server而不是明碼的user_id喔)，本範例就不贅述，請自行努力XD

																//{ id_token: id_token }
																//ajax
																$
																		.ajax({
																			url : "http://localhost:8080/FinalProject/googlelogin",
																			method : "post",
																			data : "&id_token="
																					+ id_token
																					+ "&genders="
																					+ genders
																					+ "&residences="
																					+ residences
																					+ "&birth="
																					+ birth,
																			success : function(
																					data) {
																				alert("訪客:"
																						+ data
																						+ "歡迎您！");
																				document.location.href = "http://localhost:8080/FinalProject/index.return";

																			}
																		});//end $.ajax 
															});
										}, function(error) {
											console.log("Google登入失敗");
											console.log(error);
										});

					}//end function GoogleLogin

					function Google_disconnect() {
						let auth2 = gapi.auth2.getAuthInstance(); //取得GoogleAuth物件

						auth2.disconnect().then(function() {
							console.log('User disconnect.');
						});
					}
				</script>


			</div>
		</form>

		<div>
			<span><input type="button" value="前台測試" onclick="inputUser()"></span>
			<span style="margin-left: 20px;"><input type="button" value="後台測試" onclick="inputBack()"></span>
		</div>

	</div>

	<div id="Footer"><%@ include file="./fragment/indexBOTTOM.jsp"%></div>

	<script type="text/javascript">
		function inputBack() {
			$("#email").val("sniper2824@gmail.com");
			$("#password").val("A12345@10904");
			verifymail();
			verifypwd();
			document.getElementById("errmsg").innerHTML = "";
			//form1.submit();
		}

		function inputUser() {
			$("#email").val("w92532@hotmail.com");
			$("#password").val("Ww414200");
			verifymail();
			verifypwd();
			document.getElementById("errmsg").innerHTML = "";
			//form1.submit();
		}

		function verifymail() {

			let txt = document.getElementById("checkmailtxt");
			let name1 = document.getElementById("email").value;

			let emailRule = /^\w+((-\w+)|(\.\w+))*\@[A-Za-z0-9]+((\.|-)[A-Za-z0-9]+)*\.[A-Za-z]+$/;

			if (name1 == "") {
				txt.innerHTML = "不可空白";

			} else if (name1.search(emailRule) == -1) {

				txt.innerHTML = "錯誤的email格式";

			} else {
				txt.innerHTML = "";
			}
		}

		function verifypwd() {
			var rexEng = /[A-Za-z]/
			var rexNum = /[0-9]/

			var txtValue = document.getElementById("checkpwdtxt")
			var pwdValue = document.getElementById("password").value
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
		}
	</script>
</body>

</html>