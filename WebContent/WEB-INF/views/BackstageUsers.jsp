<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>backstage</title>
<link rel="stylesheet"href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">

<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<style type="text/css">
table{
border-collapse: collapse;
margin: auto;
}
td{
	width: 105px;
	height:60px;	
}
.table-dark td{
font-weight:bold;
}
.table-light{
color: #696969;	
}
.dot{
	bottom:10px;
	width:100%;
	display: flex;
	justify-content: center;
}
.dot li{
	border:1px solid #fff;           
	margin: 0 5px;
	width:24px;
	height: 24px;
	list-style: none;
	font-size: 20px;
	background-color: #fff;
}
input{
width: 90px;
}
</style>
</head>
<body>
<%@include file="BackstageUI.jsp" %>
	<div id="content2" >		
			<div >		
			<table>
				<tr class="table-dark">
				<td><label>會員編號查詢</label>
				<td><input type="text" value="" id="checkuser"  onkeyup="userkeyup()">
				<td><label>身分證查詢</label>
				<td><input type="text" value="" id="checkid"  onkeyup="idkeyup()">				
				<td><label>信箱查詢</label>
				<td><input type="text" value="" id="checkemail"  onkeyup="emailkeyup()">
				<td><label>電話查詢</label>
				<td><input type="text" value="" id="checktel"  onkeyup="telkeyup()">
				<td><label>凍結帳號查詢</label>
				<td><input type="text" value="" id="checkfreeze"  onkeyup="freezekeyup()">							
			</table>
			</div>
			<br>			
			<table  id="demo" >						
			</table>
			<div id="changet"></div>
			<div >
				<ul class="dot" id="page"></ul>
			</div>
	</div>
	<script>
			$.getJSON("../allUsersJson.json",function(result){
					data = eval(result.allUsers);					
					init();	

					userkeyup = function (){
						$("#checkid").val('');
						$("#checkemail").val('');
						$("#checktel").val('');
						$("#checkfreeze").val('');
					var checkuser = $("#checkuser").val().toString();
					if(checkuser==""||checkuser==null){
						console.log(checkuser);
						data = eval(result.allUsers);
					}else{
						data = eval(result.allUsers);
						var odata = [];
						for(var i=0;i<data.length;i++){
							console.log(((data[i].sysSn).toString()));
							var len = checkuser.length;
							var str = (data[i].sysSn).toString();
							if(checkuser==(str.substring(0,len))){
								 var tempJson = {
									"sysSn":data[i].sysSn,
									"name":data[i].name,
									"id":data[i].id,								
									"addr":data[i].addr,									
									"gender":data[i].gender,
									"birth":data[i].birth,
									"tel":data[i].tel,
									"ademail":data[i].ademail,
									"utype":data[i].utype,
									"users":{"email":data[i].users.email,"password":data[i].users.password,"deleteFlag":data[i].users.deleteFlag}										
								 	};
								 odata.push(tempJson);								
								}														
							}
						data = odata;
						console.log(data);
					}
					init();	
					}
					idkeyup = function (){
						$("#checkuser").val('');
						$("#checkemail").val('');
						$("#checktel").val('');
						$("#checkfreeze").val('');
					var checkid = $("#checkid").val().toString().toUpperCase();
					if(checkid==""||checkid==null){
						console.log(checkid);
						data = eval(result.allUsers);
					}else{
						data = eval(result.allUsers);
						var odata = [];
						for(var i=0;i<data.length;i++){
							console.log(((data[i].id).toString()));
							var len = checkid.length;
							var str = (data[i].id).toString();
							if(checkid==(str.substring(0,len))){
								 var tempJson = {
									"sysSn":data[i].sysSn,
									"name":data[i].name,
									"id":data[i].id,								
									"addr":data[i].addr,									
									"gender":data[i].gender,
									"birth":data[i].birth,
									"tel":data[i].tel,
									"ademail":data[i].ademail,
									"utype":data[i].utype,
									"users":{"email":data[i].users.email,"password":data[i].users.password,"deleteFlag":data[i].users.deleteFlag}										
								 	};
								 odata.push(tempJson);								
								}														
							}
						data = odata;
						console.log(data);
					}
					init();	
					}
					emailkeyup = function (){
						$("#checkid").val('');
						$("#checkuser").val('');
						$("#checktel").val('');
						$("#checkfreeze").val('');
					var checkemail = $("#checkemail").val().toString();
					if(checkemail==""||checkemail==null){
						console.log(checkemail);
						data = eval(result.allUsers);
					}else{
						data = eval(result.allUsers);
						var odata = [];
						for(var i=0;i<data.length;i++){
							console.log(((data[i].users.email).toString()));
							var len = checkemail.length;
							var str = (data[i].users.email).toString();
							if(checkemail==(str.substring(0,len))){
								 var tempJson = {
									"sysSn":data[i].sysSn,
									"name":data[i].name,
									"id":data[i].id,								
									"addr":data[i].addr,									
									"gender":data[i].gender,
									"birth":data[i].birth,
									"tel":data[i].tel,
									"ademail":data[i].ademail,
									"utype":data[i].utype,
									"users":{"email":data[i].users.email,"password":data[i].users.password,"deleteFlag":data[i].users.deleteFlag}										
								 	};
								 odata.push(tempJson);								
								}														
							}
						data = odata;
						console.log(data);
					}
					init();	
					}
					telkeyup = function (){
						$("#checkid").val('');
						$("#checkemail").val('');
						$("#checkuser").val('');
						$("#checkfreeze").val('');
					var checktel = $("#checktel").val().toString();
					if(checktel==""||checktel==null){
						console.log(checktel);
						data = eval(result.allUsers);
					}else{
						data = eval(result.allUsers);
						var odata = [];
						for(var i=0;i<data.length;i++){
							console.log(((data[i].tel).toString()));
							var len = checktel.length;
							var str = (data[i].tel).toString();
							if(checktel==(str.substring(0,len))){
								 var tempJson = {
									"sysSn":data[i].sysSn,
									"name":data[i].name,
									"id":data[i].id,								
									"addr":data[i].addr,									
									"gender":data[i].gender,
									"birth":data[i].birth,
									"tel":data[i].tel,
									"ademail":data[i].ademail,
									"utype":data[i].utype,
									"users":{"email":data[i].users.email,"password":data[i].users.password,"deleteFlag":data[i].users.deleteFlag}										
								 	};
								 odata.push(tempJson);								
								}														
							}
						data = odata;
						console.log(data);
					}
					init();	
					}
					freezekeyup = function (){
						$("#checkid").val('');
						$("#checkemail").val('');
						$("#checktel").val('');
						$("#checkuser").val('');
					var checkfreeze = $("#checkfreeze").val().toString().toUpperCase();
					if(checkfreeze==""||checkfreeze==null){
						console.log(checkfreeze);
						data = eval(result.allUsers);
					}else{
						data = eval(result.allUsers);
						var odata = [];
						for(var i=0;i<data.length;i++){
							console.log(((data[i].users.deleteFlag).toString()));
							var len = checkfreeze.length;
							var str = (data[i].users.deleteFlag).toString();
							if(checkfreeze==(str.substring(0,len))){
								 var tempJson = {
									"sysSn":data[i].sysSn,
									"name":data[i].name,
									"id":data[i].id,								
									"addr":data[i].addr,									
									"gender":data[i].gender,
									"birth":data[i].birth,
									"tel":data[i].tel,
									"ademail":data[i].ademail,
									"utype":data[i].utype,
									"users":{"email":data[i].users.email,"password":data[i].users.password,"deleteFlag":data[i].users.deleteFlag}										
								 	};
								 odata.push(tempJson);								
								}														
							}
						data = odata;
						console.log(data);
					}
					init();	
					}						
				});
			
			function init(){
				
				console.log(data);
				if(data!=null){
					var p = 0;
					var pg = "";
					$("#changet").html(pg);
					for (let j = 1; j< data.length/5+1; j++){						
						pg += "<button type='button' class='btn btn-secondary' id='pagechange"+j+"'>"+j+"</button>";
					}
					$("#page").html(pg);
					
					var txt = "<tr class='table-dark'><td>會員編號<td>姓名<td>身分證字號<td>地址<td>信箱<td>性別<td>生日<td>連絡電話<td>電子通知<td>管理員<td>凍結帳號<td>";
					var l = 5;
					if(data.length<5){
						l = data.length
						}
					for (let i = 0; i < l; i++) {
						txt += "<tr class='table-light'><td>"+ data[i].sysSn;
						txt += "<td>"+ data[i].name;
						txt += "<td>"+ data[i].id;
						txt += "<td>"+ data[i].addr;
						txt += "<td>"+ data[i].users.email;
						txt += "<td>"+ data[i].gender;
						txt += "<td>"+ data[i].birth;
						txt += "<td>"+ data[i].tel;
						txt += "<td>"+ data[i].ademail;
						txt += "<td>"+ data[i].utype;												
						txt += "<td>"+ data[i].users.deleteFlag +"</td>";						
						txt += "<td>"+ "<input type='hidden' id='change"+i+"' value='"+i+"'>"+"<input type='submit' id='changeo"+i+"' value='修改' class='btn btn-outline-secondary'></td>";
						

						}
					$("#demo").html(txt);
					
					for (let j = 1; j< data.length/5+1; j++){
					$("#page").on("click","#pagechange"+j+"",function() {
						p=$("#pagechange"+j+"").index();
						console.log($("#pagechange"+j+"").index());
						var txt = "";
							txt += "<tr class='table-dark'><td>會員編號<td>姓名<td>身分證字號<td>地址<td>信箱<td>性別<td>生日<td>連絡電話<td>電子通知<td>管理員<td>凍結帳號<td>";
						if(5+p*5<data.length){
							for (let i = 0+p*5; i < 5+p*5; i++) {
								txt += "<tr class='table-light'><td>"+ data[i].sysSn;
								txt += "<td>"+ data[i].name;
								txt += "<td>"+ data[i].id;
								txt += "<td>"+ data[i].addr;
								txt += "<td>"+ data[i].users.email;
								txt += "<td>"+ data[i].gender;
								txt += "<td>"+ data[i].birth;
								txt += "<td>"+ data[i].tel;
								txt += "<td>"+ data[i].ademail;
								txt += "<td>"+ data[i].utype;												
								txt += "<td>"+ data[i].users.deleteFlag +"</td>";								
								txt += "<td>"+ "<input type='hidden' id='change"+i+"' value='"+i+"'>"+"<input type='submit' id='changeo"+i+"' value='修改' class='btn btn-outline-secondary'></td>";
								

								}
						}else{
							for (let i = 0+p*5; i < data.length; i++) {
								txt += "<tr class='table-light'><td>"+ data[i].sysSn;
								txt += "<td>"+ data[i].name;
								txt += "<td>"+ data[i].id;
								txt += "<td>"+ data[i].addr;
								txt += "<td>"+ data[i].users.email;
								txt += "<td>"+ data[i].gender;
								txt += "<td>"+ data[i].birth;
								txt += "<td>"+ data[i].tel;
								txt += "<td>"+ data[i].ademail;
								txt += "<td>"+ data[i].utype;												
								txt += "<td>"+ data[i].users.deleteFlag +"</td>";								
								txt += "<td>"+ "<input type='hidden' id='change"+i+"' value='"+i+"'>"+"<input type='submit' id='changeo"+i+"' value='修改' class='btn btn-outline-secondary'></td>";
								

								}
						}
						$("#demo").html(txt);
						});											
					};
					for (let j = 0; j< data.length; j++){
						$("#demo").on("click","#changeo"+j+"",function() {			
							var txt = "";
								txt += "<form action='users.change' method='post'><table><tr class='table-dark'><td>會員編號<td>姓名<td>身分證字號<td>地址<td>信箱<td>性別<td>生日<td>連絡電話<td>電子通知<td>管理員<td>凍結帳號<td></tr>";
							var pg = "";
							$("#page").html(pg);
							var c = 0;	
								c = $("#change"+j+"").val();								
									txt += "<tr class='table-light'><td>"+ data[c].sysSn;
									txt += "<td>"+ data[c].name;
									txt += "<td>"+ data[c].id;
									txt += "<td>"+ data[c].addr;
									txt += "<td>"+ "<input type='hidden' name='email' value='"+data[c].users.email+"'>"+data[c].users.email;
									txt += "<td>"+ data[c].gender;
									txt += "<td>"+ data[c].birth;
									txt += "<td>"+ data[c].tel;
									txt += "<td>"+ data[c].ademail;
									txt += "<td>"+ "<select type='text' name='utype'><option value='"+data[c].utype+"' hidden>"+data[c].utype+"</option><option value='N'>一般會員</option><option value='Y'>管理員</option>";
									txt += "<td>"+ "<select type='text' name='deleteFlag'><option value='"+data[c].users.deleteFlag+"' hidden>"+data[c].users.deleteFlag+"</option><option value='N'>解凍</option><option value='Y'>凍結帳號</option>";																											
									txt += "<td>"+"<input type='submit' id='changeo' value='修改' class='btn btn-outline-secondary'>"+"</table></form>";
								$("#changet").html(txt);
								$("#demo").html(pg);
							});
					};
										
					}else{
						var txt = "<tr class='table-dark'><td>會員編號<td>姓名<td>身分證字號<td>地址<td>信箱<td>性別<td>生日<td>連絡電話<td>電子通知<td>管理員<td>凍結帳號<td>";
						$("#demo").html(txt);
						var pg = "";
						$("#page").html(pg);
					}				
			}
	</script>
</body>
</html>