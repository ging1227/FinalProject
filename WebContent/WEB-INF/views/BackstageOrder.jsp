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
td{
	width: 105px;
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
</style>
</head>
<body>
<%@include file="BackstageUI.jsp" %>
	<div id="content2" >		
			<div >		
			<table>
				<tr class="table-dark">
				<td><label>訂單編號查詢</label>
				<td><input type="text" value="" id="checkorder"  onkeyup="orderkeyup()">
				<td><label>會員編號查詢</label>
				<td><input type="text" value="" id="checkuser"  onkeyup="userkeyup()">
				<td><label>訂單狀態查詢</label>
				<td><input type="text" value="" id="checkstatus"  onkeyup="statuskeyup()">
				<td><label>付款狀態查詢</label>
				<td><input type="text" value="" id="checkpay"  onkeyup="paykeyup()">
				<td><label>建立時間查詢</label>
				<td><input type="text" value="" id="checkdate"  onkeyup="datekeyup()">							
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
	var statusJson = [{"status":"接收訂單成功"},{"status":"後端處理商品成功"},{"status":"已出貨"},{"status":"物流中"},{"status":"已送達未領取"},{"status":"已送達已領取"},{"status":"已送達未領取後退回"},{"status":"退訂"},{"status":"發生錯誤"}];	
	var payJson = [{"pay":"貨到付款"},{"pay":"信用卡一次繳清"},{"pay":"網路ATM付款"}];
	console.log(payJson);
	console.log(statusJson);
	
			$.getJSON("../allOrdersJson.json",function(result){
					data = eval(result.allOrder);					
					init();	

					orderkeyup = function (){
						$("#checkuser").val('');
						$("#checkstatus").val('');
						$("#checkpay").val('');
						$("#checkdate").val('');
					var checkorder = $("#checkorder").val().toString();
					if(checkorder==""||checkorder==null){
						console.log(checkorder);
						data = eval(result.allOrder);
					}else{
						data = eval(result.allOrder);
						var odata = [];
						for(var i=0;i<data.length;i++){
							console.log(((data[i].oSysSn).toString()));
							var len = checkorder.length;
							var str = (data[i].oSysSn).toString();
							if(checkorder==(str.substring(0,len))){								
								var oddata = [];
								for (let j = 0; j < data[i].ordersDetail.length; j++) {									
									var tempdJson = {
									"oSysSn":data[i].oSysSn,
									"pName":data[i].ordersDetail[j].pName,
									"seq":data[i].ordersDetail[j].seq,
									"cpu":data[i].ordersDetail[j].cpu,
									"ram":data[i].ordersDetail[j].ram,
									"storage":data[i].ordersDetail[j].storage,
									"color":data[i].ordersDetail[j].color,
									"quantity":data[i].ordersDetail[j].quantity,
									"price":data[i].ordersDetail[j].price
									};
									oddata.push(tempdJson);	
								}
								 var tempJson = {
									"oSysSn":data[i].oSysSn,										 
									"uSysSn":data[i].uSysSn,
									"status":data[i].status,
									"price":data[i].price,
									"consignee":data[i].consignee,
									"addr":data[i].addr,
									"pay":data[i].pay,
									"payStatus":data[i].payStatus,
									"createTime":data[i].createTime,
									"updateTime":data[i].updateTime,
									"ordersDetail":oddata
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
						$("#checkpay").val('');
						$("#checkdate").val('');
						var checkuser = $("#checkuser").val().toString();
						if(checkuser==""||checkuser==null){
							console.log(checkuser);
							data = eval(result.allOrder);
						}else{
							data = eval(result.allOrder);
							var odata = [];
							for(var i=0;i<data.length;i++){
								console.log(((data[i].uSysSn).toString()));
								var len = checkuser.length;
								var str = (data[i].uSysSn).toString();
								if(checkuser==(str.substring(0,len))){								
									var oddata = [];
									for (let j = 0; j < data[i].ordersDetail.length; j++) {									
										var tempdJson = {
										"oSysSn":data[i].oSysSn,
										"pName":data[i].ordersDetail[j].pName,
										"seq":data[i].ordersDetail[j].seq,
										"cpu":data[i].ordersDetail[j].cpu,
										"ram":data[i].ordersDetail[j].ram,
										"storage":data[i].ordersDetail[j].storage,
										"color":data[i].ordersDetail[j].color,
										"quantity":data[i].ordersDetail[j].quantity,
										"price":data[i].ordersDetail[j].price
										};
										oddata.push(tempdJson);	
									}
									 var tempJson = {
										"oSysSn":data[i].oSysSn,										 
										"uSysSn":data[i].uSysSn,
										"status":data[i].status,
										"price":data[i].price,
										"consignee":data[i].consignee,
										"addr":data[i].addr,
										"pay":data[i].pay,
										"payStatus":data[i].payStatus,
										"createTime":data[i].createTime,
										"updateTime":data[i].updateTime,
										"ordersDetail":oddata
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
						$("#checkpay").val('');
						$("#checkdate").val('');
						var checkstatus = $("#checkstatus").val().toString();
						if(checkstatus==""||checkstatus==null){
							console.log(checkstatus);
							data = eval(result.allOrder);
						}else{
							data = eval(result.allOrder);
							var odata = [];
							for(var i=0;i<data.length;i++){
								console.log(((data[i].status).toString()));
								var len = checkstatus.length;
								var str = (statusJson[data[i].status-1].status).toString();
								if(checkstatus==(str.substring(0,len))){								
									var oddata = [];
									for (let j = 0; j < data[i].ordersDetail.length; j++) {									
										var tempdJson = {
										"oSysSn":data[i].oSysSn,
										"pName":data[i].ordersDetail[j].pName,
										"seq":data[i].ordersDetail[j].seq,
										"cpu":data[i].ordersDetail[j].cpu,
										"ram":data[i].ordersDetail[j].ram,
										"storage":data[i].ordersDetail[j].storage,
										"color":data[i].ordersDetail[j].color,
										"quantity":data[i].ordersDetail[j].quantity,
										"price":data[i].ordersDetail[j].price
										};
										oddata.push(tempdJson);	
									}
									 var tempJson = {
										"oSysSn":data[i].oSysSn,										 
										"uSysSn":data[i].uSysSn,
										"status":data[i].status,
										"price":data[i].price,
										"consignee":data[i].consignee,
										"addr":data[i].addr,
										"pay":data[i].pay,
										"payStatus":data[i].payStatus,
										"createTime":data[i].createTime,
										"updateTime":data[i].updateTime,
										"ordersDetail":oddata
									 	};
									 odata.push(tempJson);								
									}														
								}
							data = odata;
							console.log(data);
						}
						init();	
						}
					paykeyup = function (){
						$("#checkuser").val('');
						$("#checkstatus").val('');
						$("#checkorder").val('');
						$("#checkdate").val('');
						var checkpay = $("#checkpay").val().toString().toUpperCase();
						if(checkpay==""||checkpay==null){
							console.log(checkpay);
							data = eval(result.allOrder);
						}else{
							data = eval(result.allOrder);
							var odata = [];
							for(var i=0;i<data.length;i++){
								console.log(((data[i].payStatus).toString()));
								var len = checkpay.length;
								var str = (data[i].payStatus).toString();
								if(checkpay==(str.substring(0,len))){								
									var oddata = [];
									for (let j = 0; j < data[i].ordersDetail.length; j++) {									
										var tempdJson = {
										"oSysSn":data[i].oSysSn,
										"pName":data[i].ordersDetail[j].pName,
										"seq":data[i].ordersDetail[j].seq,
										"cpu":data[i].ordersDetail[j].cpu,
										"ram":data[i].ordersDetail[j].ram,
										"storage":data[i].ordersDetail[j].storage,
										"color":data[i].ordersDetail[j].color,
										"quantity":data[i].ordersDetail[j].quantity,
										"price":data[i].ordersDetail[j].price
										};
										oddata.push(tempdJson);	
									}
									 var tempJson = {
										"oSysSn":data[i].oSysSn,										 
										"uSysSn":data[i].uSysSn,
										"status":data[i].status,
										"price":data[i].price,
										"consignee":data[i].consignee,
										"addr":data[i].addr,
										"pay":data[i].pay,
										"payStatus":data[i].payStatus,
										"createTime":data[i].createTime,
										"updateTime":data[i].updateTime,
										"ordersDetail":oddata
									 	};
									 odata.push(tempJson);								
									}														
								}
							data = odata;
							console.log(data);
						}
						init();	
						}
					datekeyup = function (){
						$("#checkuser").val('');
						$("#checkstatus").val('');
						$("#checkorder").val('');
						$("#checkpay").val('');						
						var checkdate = $("#checkdate").val().toString().toUpperCase();
						if(checkdate==""||checkdate==null){
							console.log(checkdate);
							data = eval(result.allOrder);
						}else{
							data = eval(result.allOrder);
							var odata = [];
							for(var i=0;i<data.length;i++){
								console.log(((data[i].createTime).toString()));
								var len = checkdate.length;
								var str = (data[i].createTime).toString();
								if(checkdate==(str.substring(0,len))){								
									var oddata = [];
									for (let j = 0; j < data[i].ordersDetail.length; j++) {									
										var tempdJson = {
										"oSysSn":data[i].oSysSn,
										"pName":data[i].ordersDetail[j].pName,
										"seq":data[i].ordersDetail[j].seq,
										"cpu":data[i].ordersDetail[j].cpu,
										"ram":data[i].ordersDetail[j].ram,
										"storage":data[i].ordersDetail[j].storage,
										"color":data[i].ordersDetail[j].color,
										"quantity":data[i].ordersDetail[j].quantity,
										"price":data[i].ordersDetail[j].price
										};
										oddata.push(tempdJson);	
									}
									 var tempJson = {
										"oSysSn":data[i].oSysSn,										 
										"uSysSn":data[i].uSysSn,
										"status":data[i].status,
										"price":data[i].price,
										"consignee":data[i].consignee,
										"addr":data[i].addr,
										"pay":data[i].pay,
										"payStatus":data[i].payStatus,
										"createTime":data[i].createTime,
										"updateTime":data[i].updateTime,
										"ordersDetail":oddata
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
					
					var txt = "<tr class='table-dark'><td>訂單編號<td>會員編號<td>訂單狀態<td>價格<td>收件人<td>寄送地址<td>付款方式<td>付款狀態<td>建立時間<td>修改時間<td>訂單明細<td>修改訂單";
					var l = 5;
					if(data.length<5){
						l = data.length
						}
					for (let i = 0; i < l; i++) {
						var s = data[i].status-1;
						txt += "<tr class='table-light'><td>"+ data[i].oSysSn;
						txt += "<td>"+ data[i].uSysSn;
						txt += "<td>"+ statusJson[s].status;
						txt += "<td>"+ data[i].price;
						txt += "<td>"+ data[i].consignee;
						txt += "<td>"+ data[i].addr;
						txt += "<td>"+ payJson[data[i].pay].pay;
						txt += "<td>"+ data[i].payStatus;
						txt += "<td>"+ data[i].createTime;
						txt += "<td>"+ data[i].updateTime +"</td>";
						txt += "<td>"+ "<input type='hidden' id='delete"+i+"' value='"+i+"'>"+"<input type='submit' id='deleteo"+i+"' value='明細' class='btn btn-outline-secondary'></td>";
						txt += "<td>"+ "<input type='hidden' id='change"+i+"' value='"+i+"'>"+"<input type='submit' id='changeo"+i+"' value='修改' class='btn btn-outline-secondary'></td>";

						}
					$("#demo").html(txt);
					
					for (let j = 1; j< data.length/5+1; j++){
					$("#page").on("click","#pagechange"+j+"",function() {
						p=$("#pagechange"+j+"").index();
						console.log($("#pagechange"+j+"").index());
						var txt = "";
							txt += "<tr class='table-dark'><td>訂單編號<td>會員編號<td>訂單狀態<td>價格<td>收件人<td>寄送地址<td>付款方式<td>付款狀態<td>建立時間<td>修改時間<td>訂單明細<td>修改訂單";
						if(5+p*5<data.length){
							for (let i = 0+p*5; i < 5+p*5; i++) {
								var s = data[i].status-1;
								txt += "<tr class='table-light'><td>"+ data[i].oSysSn;
								txt += "<td>"+ data[i].uSysSn;
								txt += "<td>"+ statusJson[s].status;
								txt += "<td>"+ data[i].price;
								txt += "<td>"+ data[i].consignee;
								txt += "<td>"+ data[i].addr;
								txt += "<td>"+ payJson[data[i].pay].pay;
								txt += "<td>"+ data[i].payStatus;
								txt += "<td>"+ data[i].createTime;
								txt += "<td>"+ data[i].updateTime +"</td>";
								txt += "<td>"+ "<input type='hidden' id='delete"+i+"' value='"+i+"'>"+"<input type='submit' id='deleteo"+i+"' value='明細' class='btn btn-outline-secondary'></td>";
								txt += "<td>"+ "<input type='hidden' id='change"+i+"' value='"+i+"'>"+"<input type='submit' id='changeo"+i+"' value='修改' class='btn btn-outline-secondary'></td>";
								
								}
						}else{
							for (let i = 0+p*5; i < data.length; i++) {
								var s = data[i].status-1;
								txt += "<tr class='table-light'><td>"+ data[i].oSysSn;
								txt += "<td>"+ data[i].uSysSn;
								txt += "<td>"+ statusJson[s].status;
								txt += "<td>"+ data[i].price;
								txt += "<td>"+ data[i].consignee;
								txt += "<td>"+ data[i].addr;
								txt += "<td>"+ payJson[data[i].pay].pay;
								txt += "<td>"+ data[i].payStatus;
								txt += "<td>"+ data[i].createTime;
								txt += "<td>"+ data[i].updateTime +"</td>";
								txt += "<td>"+ "<input type='hidden' id='delete"+i+"' value='"+i+"'>"+"<input type='submit' id='deleteo"+i+"' value='明細' class='btn btn-outline-secondary'></td>";
								txt += "<td>"+ "<input type='hidden' id='change"+i+"' value='"+i+"'>"+"<input type='submit' id='changeo"+i+"' value='修改' class='btn btn-outline-secondary'></td>";
								
								}
						}
						$("#demo").html(txt);
						});											
					};
					for (let j = 0; j< data.length; j++){
						$("#demo").on("click","#changeo"+j+"",function() {			
							var txt = "";
								txt += "<form action='order.change' method='post'><table><tr class='table-dark'><td>訂單編號<td>會員編號<td>訂單狀態<td>價格<td>收件人<td>寄送地址<td>付款方式<td>付款狀態<td>建立時間<td>修改時間<td>修改訂單</tr>";
							var pg = "";
							$("#page").html(pg);
							var c = 0;	
								c = $("#change"+j+"").val();								
									txt += "<tr class='table-light'><td>"+"<input type='hidden' name='oSysSn' value='"+ data[c].oSysSn+"'>"+ data[c].oSysSn;
									txt += "<td>"+"<input type='hidden' name='uSysSn' value='"+ data[c].uSysSn+"'>"+data[c].uSysSn;
									txt += "<td>"+"<select type='text' name='status'><option value='"+data[c].status+"' hidden>"+data[c].status+"</option><option value='1'>01：接收訂單成功</option><option value='2'>02：後端處理商品成功</option><option value='3'>03：已出貨</option><option value='4'>04：物流中</option><option value='5'>05：已送達未領取</option><option value='6'>06：已送達已領取</option><option value='7'>07：已送達未領取後退回</option><option value='8'>08：退訂</option><option value='9'>09：發生錯誤</option>";
									txt += "<td>"+"<input type='hidden' name='price' value='"+ data[c].price+"'>"+data[c].price;
									txt += "<td>"+"<input type='hidden' name='consignee' value='"+ data[c].consignee+"'>"+ data[c].consignee;
									txt += "<td>"+"<input type='hidden' name='addr' value='"+ data[c].addr+"'>"+ data[c].addr;
									txt += "<td>"+"<input type='hidden' name='pay' value='"+ data[c].pay+"'>"+ payJson[data[c].pay].pay;
									txt += "<td>"+"<select type='text' name='payStatus'><option value='"+data[c].payStatus+"' hidden>"+data[c].payStatus+"</option><option value='N'>未付款</option><option value='Y'>已付款</option>";
									txt += "<td>"+"<input type='hidden' name='createTime' value='"+ data[c].createTime+"'>"+data[c].createTime;
									txt += "<td>"+"<input type='hidden' name='updateTime' value='"+ data[c].updateTime+"'>"+data[c].updateTime;									
									txt += "<td>"+"<input type='submit' id='changeo' value='修改' class='btn btn-outline-secondary'>"+"</table></form>";
								$("#changet").html(txt);
								$("#demo").html(pg);
							});
					};
										
					}else{
						var txt = "<tr class='table-dark'><td>訂單編號<td>會員編號<td>訂單狀態<td>價格<td>收件人<td>寄送地址<td>付款方式<td>付款狀態<td>建立時間<td>修改時間<td>訂單明細<td>修改訂單";
						$("#demo").html(txt);
						var pg = "";
						$("#page").html(pg);
					}
				
				for (let j = 0; j< data.length; j++){
					$("#demo").on("click","#deleteo"+j+"",function() {

							var d = 0;	
							d = $("#delete"+j+"").val();
						var txt = "";
							txt += "<tr class='table-dark'><td>訂單編號<td>型號<td>序列<td>CPU<td>RAM<td>Storage<td>顏色<td>數量<td>價格<td><a href='order'class='btn btn-outline-secondary'>回上一頁</a></tr>";
						var pg = "";
						$("#page").html(pg);				
						for (let i = 0; i < data[d].ordersDetail.length; i++) {
							txt += "<tr class='table-light'><td>"+ data[d].oSysSn;
							txt += "<td>"+ data[d].ordersDetail[i].pName;
							txt += "<td>"+ data[d].ordersDetail[i].seq;
							txt += "<td>"+ data[d].ordersDetail[i].cpu;
							txt += "<td>"+ data[d].ordersDetail[i].ram;
							txt += "<td>"+ data[d].ordersDetail[i].storage;
							txt += "<td>"+ data[d].ordersDetail[i].color;
							txt += "<td>"+ data[d].ordersDetail[i].quantity;
							txt += "<td>"+ data[d].ordersDetail[i].price;
							txt += "<td>"+ "</td>";
						}
						$("#demo").html(txt);					
					});
				};
								
			}
	</script>
</body>
</html>