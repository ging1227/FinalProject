<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>註冊</title>
<!-- JQuery -->
<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>

<!-- TWzipcode -->


<!-- JQuery UI -->
<link rel="stylesheet"
	href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<script src="https://code.jquery.com/jquery-3.4.1.js"
	integrity="sha256-WpOohJOqMqqyKL9FccASB9O0KwACQJpFTUBLTYOVvVU="
	crossorigin="anonymous"></script>

<!-- style -->
<link
	href="http://maxcdn.bootstrapcdn.com/bootstrap/4.1.1/css/bootstrap.min.css"
	rel="stylesheet" id="bootstrap-css">
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css"
	integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T"
	crossorigin="anonymous">
<link rel="stylesheet"
	href="https://use.fontawesome.com/releases/v5.0.8/css/all.css">
<link rel="stylesheet" href="<%=request.getContextPath()%>/static/css/register.css">

<script
	src="http://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script
	src="http://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>
<script
	src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"
	integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM"
	crossorigin="anonymous"></script>
	
<style>

		#one{z-index:1;}
		#two{z-index:999;}
.container{
font-family: 'Noto Sans TC', sans-serif
}
</style>
</head>
<body>
		<div id="two">
		<%@ include file="./fragment/indexTOP.jsp"%>
	</div>

	<div class="container" id="one">
		<div class="cardtest1"><!-- bg-light -->

			<article class="card-body mx-auto" style="max-width: 1000px;padding:50px 100px 50px 100px;">
				<h4 class="rexColor1 card-title mt-3 text-center" style="color:black"><b>註冊會員</b></h4>
				<p class="rexColor1 text-center" style="color:black;">Get started with your free
					account</p>
				<form  action="<c:url value="/signup" />" method="Post" id="form1" onsubmit="return checksubmit();" style="background-color:white;padding: 20px;border-radius: 20px;text-align: center;">
					<div class="form-group input-group" style="margin-left: 50px ">
						<div style="margin-left: 120px" class="input-group-prepend">
							<span class="input-group-text"> <i class="fa fa-envelope"></i>
							</span>
						</div>
						<input id="userName" name="email" type="email"
							placeholder="信箱" autocomplete="off" required="required"
							title="example@gmail.com"  onblur="checkReg1()" style="width: 50%" />
							<span style="color:red">
							<span id="img1"></span><span id="txt1"></span>
							</span>
					</div>
					<!-- javaScript空標籤 -->
					
					<!-- CheckReg()1 -->
					<script type="text/javascript">					
					
						//表單送出時先驗證
						function checksubmit(){
							if(document.getElementById("txt1").innerHTML!=""){
								window.alert("帳號欄位不正確，請重新輸入");
								return false;
							}
							else if(document.getElementById("txt2").innerHTML!=""){
								window.alert("密碼欄位不正確，請重新輸入");
								return false;
							}
							else if(document.getElementById("txt3").innerHTML!=""){
								window.alert("二次密碼欄位不正確，請重新輸入");
								return false;
							}
							else if(document.getElementById("txt4").innerHTML!=""){
								window.alert("暱稱欄位不正確，請重新輸入");
								return false;
							}
							else if(document.getElementById("txt5").innerHTML!=""){
								window.alert("身分證欄位不正確，請重新輸入");
								return false;
							}
							else{
								return true;
							}
						}
					
					
						// callback function
						function checkReg1() {
							var rexEmail = /^\w+((-\w+)|(\.\w+))*\@[A-Za-z0-9]+((\.|-)[A-Za-z0-9]+)*\.[A-Za-z]+$/;
							var imgValue = document.getElementById("img1")
							var txtValue = document.getElementById("txt1")
							var emailValue = document.getElementById("userName").value
							// 不能為空值
							if (emailValue == "") {
								imgValue.innerHTML = '<i class="fa fa-times">';
								txtValue.innerHTML = '帳號不能空白';
							}
							// Email格式驗證
							else if (emailValue.search(rexEmail) == -1) {
								imgValue.innerHTML = '<i class="fa fa-times">';
								txtValue.innerHTML = '錯誤Email格式';
							} else {
								imgValue.innerHTML = "";
								txtValue.innerHTML = "";
								$.ajax({
									url : "http://localhost:8080/FinalProject/check",
									data : "&email=" + emailValue,
									type : "GET",
									success : function(data) {
										var status=eval(data);
										
										
										if(status){
											txtValue.innerHTML ="";
											txtValue.innerHTML = "此帳號已重複";
										}
										else{
											txtValue.innerHTML ="";
											//txtValue.innerHTML = "可申請";
										}
											
										
											
										
									}
								})	
							}
						
						}
					</script>
					<!-- form-group// -->

					<div class="form-group input-group" style="margin-left: 50px ">
						<div class="input-group-prepend">
							<div style="margin-left: 120px" class="input-group-text"> <i class="fa fa-lock"></i>
							</div>
						</div>
						<input id="pwd" name="password" type="password"
							placeholder="密碼" required="required"
							title="至少6個字且必須包含英文字母、數字" onblur="checkReg2()" style="width: 50%" />
					<!-- javaScript空標籤 -->
						<span>
							<span class="text-center rexColor1">
								<span class="rexColor1" style="color: red">
									<span id="img2"></span><span id="txt2"></span>
									<span id="strong" style="display:none"></span>
								</span>
							</span>
						</span>
					</div>
						<!-- 二次密碼  -->
					<div class="form-group input-group" style="margin-left: 50px ">
						<div class="input-group-prepend">
							<div style="margin-left: 120px" class="input-group-text"> <i class="fa fa-lock"></i>
							</div>
						</div>
						<input id="repwd" type="password"
							placeholder="驗證" onblur="checkReg3()" required="required" style="width: 50%"/>
							
						<!-- javaScript空標籤 -->
						<span>
						
							<span class="text-center rexColor1">
								<span class="rexColor1" style="color: red">
									<span id="img3"></span><span id="txt3"></span>
								</span>
							</span>
						</span>
					</div>
					
					<!-- CheckReg2()、CheckReg3() -->
					<script type="text/javascript">

						// callback function
						function checkReg2() {
							var rexEng = /[A-Za-z]/
							var rexNum = /[0-9]/
							var strValue = document.getElementById("strong")
							var imgValue = document.getElementById("img2")
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
								imgValue.innerHTML = '<i class="fa fa-times">'
								txtValue.innerHTML = '密碼不能空白';
							}
							// 至少六個字
							else if (pwdValue.length < 6) {
								imgValue.innerHTML = '<i class="fa fa-times">'
								txtValue.innerHTML = '至少六個字';
							}
							// 判斷英文
							else if (!rexEng.test(pwdValue)) {
								imgValue.innerHTML = '<i class="fa fa-times">'
								txtValue.innerHTML = '沒有英文';
							}
							// 判斷數字
							else if (!rexNum.test(pwdValue)) {
								imgValue.innerHTML = '<i class="fa fa-times">'
								txtValue.innerHTML = '沒有數字';
							} else {
								imgValue.innerHTML = "";
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
							var imgValue = document.getElementById("img3")
							var txtValue = document.getElementById("txt3")
							var pwdValue = document.getElementById("pwd").value
							var repwdValue = document.getElementById("repwd").value
							// 不能為空值
							if (repwdValue == "") {
								imgValue.innerHTML = '<i class="fa fa-times">'
								txtValue.innerHTML = '驗證不能空白';
							}
							// 至少六個字
							else if (repwdValue.length < 6) {
								imgValue.innerHTML = '<i class="fa fa-times">'
								txtValue.innerHTML = '至少六個字';
							}
							// 判斷英文
							else if (!rexEng.test(repwdValue)) {
								imgValue.innerHTML = '<i class="fa fa-times">'
								txtValue.innerHTML = '沒有英文';
							}
							// 判斷數字
							else if (!rexNum.test(repwdValue)) {
								imgValue.innerHTML = '<i class="fa fa-times">'
								txtValue.innerHTML = '沒有數字';
							} 
							// 密碼相等
							else if(repwdValue != pwdValue) {
								imgValue.innerHTML = '<i class="fa fa-times">'
								txtValue.innerHTML = '驗證和密碼不同';
							} else {
								imgValue.innerHTML = "";
								txtValue.innerHTML = "";
							}
						}
					</script>
					<!-- form-group// -->
					<!-- 暱稱  -->
					<div class="form-group input-group" style="margin-left: 50px ">
						<div class="input-group-prepend">
							<span style="margin-left: 120px" class="input-group-text"> <i class="fa fa-user"></i>
							</span>
						</div>
						<input id="nickName" name="name" style="width: 50%" type="text"
							 placeholder="姓名" maxlength="8" required="required"
							 onblur="checkReg4()" autocomplete="off" />
						<!-- javaScript空標籤 -->
						<span>
							<span class="text-center rexColor1" style="float: left;">
								<span class="rexColor1" style="color: red">
									<span id="img4"></span><span id="txt4"></span>
								</span>
							</span>	 
						</span>	
					</div>
						<!-- 身分證  -->
					<div class="form-group input-group" style="margin-left: 50px ">	
						<div class="input-group-prepend">
							<span style="margin-left: 120px" class="input-group-text"><i class="fa fa-key"></i></span>
						</div>
						<input id="userId" name="id" style="width: 50%" type="text"
							placeholder="身分證" maxlength="10" required="required"
							onblur="checkReg5()"/>
						<!-- javaScript空標籤 -->
						<span>
						
							<span class="text-center rexColor1" style="float: right;">
								<span class="rexColor1" style="color: red">
									<span id="img5"></span><span id="txt5"></span>
								</span>
							</span>
						</span>
					</div>
					
					<!-- CheckReg4()、CheckReg5() -->
					<script type="text/javascript">
						// callback function
						function checkReg4() {
							var rexMark = /[\u0021-\u002F\u003A-\u0040\u005B-\u0060\u007B-\u007E]/
							var imgValue = document.getElementById("img4")
							var txtValue = document.getElementById("txt4")
							var nickValue = document.getElementById("nickName").value
							// 不能為空值
							if (nickValue == "") {
								imgValue.innerHTML = '<i class="fa fa-times">'
								txtValue.innerHTML = '姓名不能空白';
							}
							// 不能有標點符號 
							else if (rexMark.test(nickValue)) {
								imgValue.innerHTML = '<i class="fa fa-times">'
								txtValue.innerHTML = '不能有標點符號';
							} else {
								imgValue.innerHTML = "";
								txtValue.innerHTML = "";
							}
						}
						// callback function
						function checkReg5() {
							var rexid = /^[a-z](1|2)\d{8}$/i;
							var imgValue = document.getElementById("img5")
							var txtValue = document.getElementById("txt5")
							var idValue = document.getElementById("userId").value
							// 不能為空值
							if (idValue == "") {
								imgValue.innerHTML = '<i class="fa fa-times">'
								txtValue.innerHTML = '身分證不能空白';
							}
							// 至少十個字
							else if (idValue.length < 9) {
								imgValue.innerHTML = '<i class="fa fa-times">'
								txtValue.innerHTML = '字數不對';
							}
							// 格式驗證 
							else if (!rexid.test(idValue)) {
								imgValue.innerHTML = '<i class="fa fa-times">'
								txtValue.innerHTML = '格式不符';
							} else {
								imgValue.innerHTML = "";
								txtValue.innerHTML = "";
							}
						}
					</script>
					
					<!-- form-group// -->

					<div class="form-group input-group" style="margin-left: 50px ">
						<div class="input-group-prepend">
							<span style="margin-left: 120px" class="input-group-text"><i
								class="fa fa-address-card"></i></span>
						</div>
						
							<input id="address" name="addr" type="text" 
								placeholder="地址" size="25" onblur="checkReg6()" required="required" style="width: 50%" />
								<span class="text-center rexColor1" style="color: red">
						<span id="img6"></span><span id="txt6"></span>
					</span>
						
						
						<!-- javaScript空標籤 -->
					
					</div>
					
					<!-- CheckReg6() -->
					<script src="https://cdn.jsdelivr.net/npm/jquery-twzipcode@1.7.14/jquery.twzipcode.min.js"></script>
					<script type="text/javascript">
						$("#twzipcode").twzipcode({
							zipcodeIntoDistrict: true,
							"css": ["city form-control", "town form-control"],
							countyName: 'county', // 設定取得縣市的name
						    districtName: 'district', // 設定取得鄉鎮市區的name
							//  選擇縣市後執行
							onCountySelect: function() {
								var county = $("select[name='county']").val();
								$("#address").val(county);
							},
							//  選擇鄉鎮市區後執行
				    	  	onDistrictSelect: function() {
				    	  		var district = $("select[name='district']").val();
								var cityValue = $("#address").val();
								addrValue = cityValue + district;
								$("#address").val(addrValue);
							}  
						})
						
						// callback function
						function checkReg6() {
							var rexChina = /^[\u4E00-\u9FA5]/
							var imgValue = document.getElementById("img6")
							var txtValue = document.getElementById("txt6")
							var addrValue = document.getElementById("address").value
							// 不能為空值
							if (addrValue == "") {
								imgValue.innerHTML = '<i class="fa fa-times">'
								txtValue.innerHTML = '地址不能空白';
							}
							// 必須有中文
							else if (!rexChina.test(addrValue)) {
								imgValue.innerHTML = '<i class="fa fa-times">'
								txtValue.innerHTML = '必須有中文';
							} else {
								imgValue.innerHTML = "";
								txtValue.innerHTML = "";
							}
						}
					</script>
					<!-- form-group// -->
					<!-- 性別// -->
					<div class="form-group input-group" style="margin-left: 50px ">
						<div class="input-group-prepend">
							<span style="margin-left: 120px" class="input-group-text"><i class="fa fa-tag"></i></span>
						</div>
						<select id="gender" name="gender" style="width: 50%">
							<option value="">請選擇性別</option>
							<option value="男">男</option>
							<option value="女">女</option>
						</select>
					</div>
						<!-- 出生年月日  -->
					<div class="form-group input-group" style="margin-left: 50px ">
						<div class="input-group-prepend">
							<span style="margin-left: 120px" class="input-group-text"> <i class="fa fa-building"></i>
							</span>
						</div>
						<input id="birth" name="birth" placeholder="出生年月日…" style="width: 50%"
							type="date">
					</div>
					<!-- form-group// -->
					<div class="form-group input-group" style="margin-left: 50px ">
						<div class="input-group-prepend">
							<span style="margin-left: 120px" class="input-group-text"> <i class="fa fa-phone"></i>
							</span>
						</div>
						<input id="ph" name="tel" type="text"
							 placeholder="電話" maxlength="10" style="width: 50%">
					</div>
					
					<label ><input type="checkbox" checked="checked" name="ademail" value="Y"
					style="margin-bottom: 15px;margin-left: 20px">同意寄送最新產品廣告
					</label>
					<!-- form-group// -->

					<div class="form-group">
						<button type="submit" class="btn btn-primary btn-block" style="width: 50%;margin: auto;">
							註冊</button>
					</div>
					
					
					
					<!-- form-group// -->

					<p class="text-center">
						<!-- Button trigger modal -->
						<label data-toggle="modal" data-target="#exampleModalCenter"><a
							href="#">隱私權條款</a></label>
					</p>
					<div>
						<input type="button" value="註冊測試" onclick="input()">
					</div>
					<p class="text-center rexColor1">
						<span id="img"></span><span id="txt"></span>
					</p>
				</form>
			</article>
		</div>
		<!-- card.// -->
	</div>
	<!--container end.//-->

	<!-- Modal -->
	<div class="modal fade" id="exampleModalCenter" tabindex="-1"
		role="dialog" aria-labelledby="exampleModalCenterTitle"
		aria-hidden="true">
		<div class="modal-dialog modal-lg" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="exampleModalLongTitle">隱私權條例</h5>
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body">
					一、隱私權保護政策的適用範圍
					隱私權保護政策內容，包括本網站如何處理在您使用網站服務時收集到的個人識別資料。隱私權保護政策不適用於本網站以外的相關連結網站，也不適用於非本網站所委託或參與管理的人員。
					<br> <br> 二、個人資料的蒐集、處理及利用方式
					當您造訪本網站或使用本網站所提供之功能服務時，我們將視該服務功能性質，請您提供必要的個人資料，並在該特定目的範圍內處理及利用您的個人資料；非經您書面同意，本網站不會將個人資料用於其他用途。
					本網站在您使用服務信箱、問卷調查等互動性功能時，會保留您所提供的姓名、電子郵件地址、聯絡方式及使用時間等。
					於一般瀏覽時，伺服器會自行記錄相關行徑，包括您使用連線設備的IP位址、使用時間、使用的瀏覽器、瀏覽及點選資料記錄等，做為我們增進網站服務的參考依據，此記錄為內部應用，決不對外公佈。
					為提供精確的服務，我們會將收集的問卷調查內容進行統計與分析，分析結果之統計數據或說明文字呈現，除供內部研究外，我們會視需要公佈統計數據及說明文字，但不涉及特定個人之資料。
					<br> <br> 三、資料之保護
					本網站主機均設有防火牆、防毒系統等相關的各項資訊安全設備及必要的安全防護措施，加以保護網站及您的個人資料採用嚴格的保護措施，只由經過授權的人員才能接觸您的個人資料，相關處理人員皆簽有保密合約，如有違反保密義務者，將會受到相關的法律處分。
					如因業務需要有必要委託其他單位提供服務時，本網站亦會嚴格要求其遵守保密義務，並且採取必要檢查程序以確定其將確實遵守。 <br>
					<br> 四、網站對外的相關連結
					本網站的網頁提供其他網站的網路連結，您也可經由本網站所提供的連結，點選進入其他網站。但該連結網站不適用本網站的隱私權保護政策，您必須參考該連結網站中的隱私權保護政策。
					<br> <br> 五、與第三人共用個人資料之政策
					本網站絕不會提供、交換、出租或出售任何您的個人資料給其他個人、團體、私人企業或公務機關，但有法律依據或合約義務者，不在此限。 <br>
					<br> 前項但書之情形包括不限於：<br> <br> 1.經由您書面同意。<br> <br>
					2.法律明文規定。<br> <br> 3.為免除您生命、身體、自由或財產上之危險。<br> <br>
					4.與公務機關或學術研究機構合作，基於公共利益為統計或學術研究而有必要，且資料經過提供者處理或蒐集著依其揭露方式無從識別特定之當事人。
					<br> <br>
					當您在網站的行為，違反服務條款或可能損害或妨礙網站與其他使用者權益或導致任何人遭受損害時，經網站管理單位研析揭露您的個人資料是為了辨識、聯絡或採取法律行動所必要者。
					有利於您的權益。 <br> <br>
					本網站委託廠商協助蒐集、處理或利用您的個人資料時，將對委外廠商或個人善盡監督管理之責。 <br> <br>
					六、Cookie之使用
					為了提供您最佳的服務，本網站會在您的電腦中放置並取用我們的Cookie，若您不願接受Cookie的寫入，您可在您使用的瀏覽器功能項中設定隱私權等級為高，即可拒絕Cookie的寫入，但可能會導至網站某些功能無法正常執行
					。 <br> <br> 七、隱私權保護政策之修正
					本網站隱私權保護政策將因應需求隨時進行修正，修正後的條款將刊登於網站上。
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary"
						data-dismiss="modal">關閉</button>
				</div>
			</div>
		</div>
	</div>
	<script type="text/javascript">

		function input(){
			
			$("#userName").val("w92532@hotmail.com");
			$("#pwd").val("Ww414200");
			$("#repwd").val("Ww414200");
			$("#nickName").val("Vincent");
			$("#userId").val("A123789456");
			$("#gender").get(0).selectedIndex = 1;
			$('#birth').val("2000-07-25");
			$("#address").val("台北市中正區中正路10號");
			$("#ph").val("0958744563");
			checkReg1();
			checkReg2();
			checkReg3();
			checkReg4();
			checkReg5();
			checkReg6();
			//form1.submit();
			
		}
	
		function showModal() {
			$('#rule1').modal('show');
		}

	</script>
</body>
</html>