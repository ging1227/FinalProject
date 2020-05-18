<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
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
td{
	width: 250px;
	height:60px;	
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
.table-dark td{
font-weight:bold;
}
.note{
font-weight:bold;
text-align: center;
padding: 20px;
}
.tital{
width: 105px;
height:60px;
}
</style>
</head>
<body>
<%@include file="BackstageUI.jsp" %>
	<div id="content2">		
			<div >		
			<table>
				<tr class="table-dark">
				<td class="tital"><label>客服編號查詢</label>
				<td class="tital"><input type="text" value="" id="checkorder"  onkeyup="orderkeyup()">
				<td class="tital"><label>會員姓名查詢</label>
				<td class="tital"><input type="text" value="" id="checkuser"  onkeyup="userkeyup()">
				<td class="tital"><label>客服狀態查詢</label>
				<td class="tital"><input type="text" value="" id="checkstatus"  onkeyup="statuskeyup()">										
			</table>
			</div>
			<br>
			<div class="row justify-content-around">
			    <div class="col-2 note">
			    <a href="#" class="btn btn-secondary btn-lg" onclick="customer()">開啟聊天室</a>
			    </div>
			     <div class="col-10 note">
					<table  id="demo" >						
					</table>
					<div id="changet"></div>
					<div >
						<ul class="dot" id="page"></ul>
					</div>
			    </div>
			</div>	
	</div>
	<script>
			function customer() {
				console.log("click!");
				$.ajax({
					type : "GET",
					url : "../chat",
					success : function(data) {						
						window.open(
							'http://localhost:8080/FinalProject/customer',
							'客服支援', config = 'height=400,width=400')						
					}
				});
			};
			var datau=[];
			var custatus=[{"status":"未完成"},{"status":"完成"}];
			$.getJSON("../allUsersJson.json",function(result){
				datau = eval(result.allUsers);
			});
			
			$.getJSON("../allCusServJson.json",function(result){
					data = eval(result.allCusServ);					
					init();	

					orderkeyup = function (){
						$("#checkuser").val('');
						$("#checkstatus").val('');
					var checkorder = $("#checkorder").val().toString();
					if(checkorder==""||checkorder==null){
						console.log(checkorder);
						data = eval(result.allCusServ);
					}else{
						data = eval(result.allCusServ);
						var odata = [];
						for(var i=0;i<data.length;i++){
							var len = checkorder.length;
							var str = (data[i].cSysSn).toString();
							if(checkorder==(str.substring(0,len))){	
								 var tempJson = {
									"cSysSn":data[i].cSysSn,										 
									"uSysSn":data[i].uSysSn,
									"content":data[i].content,
									"status":data[i].status,									
								 	};
								 odata.push(tempJson);								
								}														
							}
						data = odata;
						console.log(data);
					}
					init();	
					}
					userkeyup = function (){
						$("#checkorder").val('');
						$("#checkstatus").val('');
						var checkuser = $("#checkuser").val().toString().toUpperCase();
						if(checkuser==""||checkuser==null){
							console.log(checkuser);
							data = eval(result.allCusServ);
						}else{
							data = eval(result.allCusServ);
							var odata = [];
							for(var i=0;i<data.length;i++){
								var len = checkuser.length;
								var str = (datau[data[i].uSysSn-1].name).toString().toUpperCase();
								console.log(str);
								if(checkuser==(str.substring(0,len))){	
									 var tempJson = {
										"cSysSn":data[i].cSysSn,										 
										"uSysSn":data[i].uSysSn,
										"content":data[i].content,
										"status":data[i].status,									
									 	};
									 odata.push(tempJson);								
									}														
								}
							data = odata;
							console.log(data);
						}
						init();	
						}
					statuskeyup = function (){
						$("#checkuser").val('');
						$("#checkorder").val('');
						var checkstatus = $("#checkstatus").val();
						if(checkstatus==""||checkstatus==null){
							console.log(checkstatus);
							data = eval(result.allCusServ);
						}else{
							data = eval(result.allCusServ);
							var odata = [];
							for(var i=0;i<data.length;i++){
								var len = checkstatus.length;
								var str = (custatus[data[i].status].status);
								if(checkstatus==(str.substring(0,len))){	
									 var tempJson = {
										"cSysSn":data[i].cSysSn,										 
										"uSysSn":data[i].uSysSn,
										"content":data[i].content,
										"status":data[i].status,									
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
				console.log(datau);
				console.log(data);
				if(data!=null){
					var p = 0;
					var pg = "";
					$("#changet").html(pg);
					for (let j = 1; j< data.length/5+1; j++){						
						pg += "<button type='button' class='btn btn-secondary' id='pagechange"+j+"'>"+j+"</button>";
					}
					$("#page").html(pg);
					
					var txt = "<tr class='table-dark'><td>客服編號<td>會員姓名<td>客服狀態<td>客服明細";
					var l = 5;
					if(data.length<5){
						l = data.length
						}
					for (let i = 0; i < l; i++) {
						txt += "<tr class='table-light'><td>"+ data[i].cSysSn;
						txt += "<td>"+ datau[data[i].uSysSn-1].name;
						txt += "<td>"+ custatus[data[i].status].status +"</td>";
						txt += "<td>"+ "<input type='hidden' id='delete"+i+"' value='"+i+"'>"+"<input type='submit' id='deleteo"+i+"' value='明細' class='btn btn-outline-secondary'></td>";
						}
					$("#demo").html(txt);
					
					for (let j = 1; j< data.length/5+1; j++){
					$("#page").on("click","#pagechange"+j+"",function() {
						p=$("#pagechange"+j+"").index();
						console.log($("#pagechange"+j+"").index());
						var txt = "";
							txt += "<tr class='table-dark'><td>客服編號<td>會員姓名<td>客服狀態<td>客服明細";
						if(5+p*5<data.length){
							for (let i = 0+p*5; i < 5+p*5; i++) {
								txt += "<tr class='table-light'><td>"+ data[i].cSysSn;
								txt += "<td>"+ datau[data[i].uSysSn-1].name;
								txt += "<td>"+ custatus[data[i].status].status +"</td>";
								txt += "<td>"+ "<input type='hidden' id='delete"+i+"' value='"+i+"'>"+"<input type='submit' id='deleteo"+i+"' value='明細' class='btn btn-outline-secondary'></td>";								
								}
						}else{
							for (let i = 0+p*5; i < data.length; i++) {
								txt += "<tr class='table-light'><td>"+ data[i].cSysSn;
								txt += "<td>"+ datau[data[i].uSysSn-1].name;
								txt += "<td>"+ custatus[data[i].status].status +"</td>";
								txt += "<td>"+ "<input type='hidden' id='delete"+i+"' value='"+i+"'>"+"<input type='submit' id='deleteo"+i+"' value='明細' class='btn btn-outline-secondary'></td>";								
								}
						}
						$("#demo").html(txt);
						});											
						};				
					}else{
						var txt = "<tr class='table-dark'><td>客服編號<td>會員姓名<td>客服狀態<td>客服明細";
						$("#demo").html(txt);
						var pg = "";
						$("#page").html(pg);
					}
				
				for (let j = 0; j< data.length; j++){
					$("#demo").on("click","#deleteo"+j+"",function() {
						
						var xml = "<xml>";
						xml += data[j].content+"</xml>";
					
						console.log(xml);
						var users = [];
						var contents = [];
						$(xml).find("user").each(function() {
							var user = $(this);
							usern = user.text();//讀取子節點的值
							users.push(usern);
							});
						$(xml).find("content").each(function() {
							var content = $(this);
							contentn = content.text();//讀取子節點的值	
							contents.push(contentn);						
							});
						
						console.log(users);
						console.log(contents);
						
						var d = 0;	
							d = $("#delete"+j+"").val();
						var txt = "";
							txt += "<tr class='table-dark'><td>對話順序<td>姓名<td>對話紀錄<td><a href='cusserv'class='btn btn-outline-secondary'>回上一頁</a></tr>";
						var pg = "";
						$("#page").html(pg);				
						for (let i = 0; i <users.length; i++) {
							txt += "<tr class='table-light'><td>"+(i+1);
							txt += "<td>"+ users[i];
							txt += "<td>"+ contents[i];
							txt += "<td></td>";
						}
						$("#demo").html(txt);					
					});
				};
								
			}
	</script>
</body>
</html>