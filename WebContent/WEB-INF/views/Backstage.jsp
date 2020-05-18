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

<script src="https://code.highcharts.com/highcharts.js"></script>
<style type="text/css">
.note{
background-color: #fdfdfe;
border: 1px solid #d0d0d0; 
border-radius: 10px;
font-weight:bold;
color: #7386D5;
text-align: center;
padding: 20px;
}
.note2{
background-color: #fdfdfe;
border: 1px solid #d0d0d0; 
border-radius: 10px;
font-weight:bold;
color: #7386D5;
text-align: center;
padding: 40px;
margin-bottom: 40px;
}
.container{
margin-top: 40px;
}


.highcharts-figure, .highcharts-data-table table {
    min-width: 320px; 
    max-width: 800px;
    margin: 1em auto;
}

.highcharts-data-table table {
	font-family: Verdana, sans-serif;
	border-collapse: collapse;
	border: 1px solid #EBEBEB;
	margin: 10px auto;
	text-align: center;
	width: 100%;
	max-width: 500px;
}
.highcharts-data-table caption {
    padding: 1em 0;
    font-size: 1.2em;
}
.highcharts-data-table th {
	font-weight: 600;
    padding: 0.5em;
}
.highcharts-data-table td, .highcharts-data-table th, .highcharts-data-table caption {
    padding: 0.5em;
}
.highcharts-data-table thead tr, .highcharts-data-table tr:nth-child(even) {
    background: #f8f8f8;
}
.highcharts-data-table tr:hover {
    background: #f1f7ff;
}


input[type="number"] {
	min-width: 50px;
}

</style>
</head>
<body>
<%@include file="BackstageUI.jsp" %>
	<div id="content2" >
		<div class="container">
			<div class="row justify-content-around">
			    <div class="col-3 note">			    	
			    	<a>今日銷售額&nbsp;&emsp;<span class="oi oi-dollar"></span></a><br><br><a>$${todaySale}</a><br><br><a>昨日銷售額&emsp;$${yesterdaySale}</a>
			    </div>
			    <div class="col-3 note">
			    	<a>今日訂單數&nbsp;&emsp;<span class="oi oi-document"></span></a><br><br><a>${todayOrder}</a><br><br><a>昨日訂單數&emsp;${yesterdayOrder}</a>
			    </div>
			    <div class="col-3 note">
			    	<a>當前會員人數&nbsp;&emsp;<span class="oi oi-people"></span></a><br><br><a id="totalrigster"></a>
			    </div>
			 </div>
		</div>
		<div class="container">
			<div class="row justify-content-around ">
			    <div class="col-3">
			    	<div class="note2">
			    		<a>訂單尚未付款</a><br><br><a>${orderPay}筆</a><br><br>
			    	</div>
			    	<div class=" note2">
			    		<a>訂單尚未出貨</a><br><br><a>${orderProduct}筆</a><br><br>
			    	</div>	
			    </div>
			    <div class="col-7 note">
				    <figure class="highcharts-figure">
					    <div id="container"></div>
					    <p class="highcharts-description">					        
					    </p>
					</figure>
					</div>
			 </div>
		</div>
	</div>
	<script>
			$.getJSON("../FinalProject/allUsersJson.json",function(result){
				var txt = 0;
				var str = "N";
				if(result!=null){
					data = eval(result.allUsers);
					for(var i=0;i<data.length;i++){						
						if(str==(data[i].utype)){
							txt += 1;								 								
							}														
						}
					}				
				$("#totalrigster").html(txt+'位');
				console.log(txt);						
			});
			var datab = [];
			
			var pdata = [];
			$.getJSON("../FinalProject/allProductJson.json",function(result){				
				if(result!=null){
					data = eval(result.allProduct);
					for(var i=0;i<data.length;i++){
						var tempdJson = {								
							"pName":data[i].p_name
							};
							pdata.push(tempdJson);						
						}
					}				
			});
			console.log(pdata);
			
			var odata = [];
			$.getJSON("../FinalProject/allOrdersJson.json",function(result){
				data = eval(result.allOrder);
				for(var i=0;i<data.length;i++){						
					for (let j = 0; j < data[i].ordersDetail.length; j++) {
						var tempdJson = {								
							"pName":data[i].ordersDetail[j].pName,								
							"price":data[i].ordersDetail[j].price
							};
							odata.push(tempdJson);	
						};																				
				};
				
				for(let a = 0; a< pdata.length; a++){
					var name = pdata[a].pName;
					var y = 0;
					for(let b = 0; b<odata.length; b++){
						if(name==odata[b].pName){
							y += odata[b].price;
							}
						};
					var tJson = {
							"name":name,
							"y":y
							};
					datab.push(tJson);					
				}

				Highcharts.chart('container', {
				    chart: {
				        plotBackgroundColor: null,
				        plotBorderWidth: null,
				        plotShadow: false,
				        type: 'pie'
				    },
				    title: {
				        text: '產品銷售排行表'
				    },
				    tooltip: {
				        pointFormat: '{series.name}: <b>{point.y:.0f}元</b>'
				    },
				    accessibility: {
				        point: {
				            valueSuffix: '%'
				        }
				    },
				    plotOptions: {
				        pie: {
				            allowPointSelect: true,
				            cursor: 'pointer',
				            dataLabels: {
				                enabled: true,
				                format: '<b>{point.name}</b>: {point.percentage:.1f} %'
				            }
				        }
				    },
				    series: [{
				        name: '銷售額',
				        colorByPoint: true,
				        data: datab
				    }]
				});
				$('.highcharts-credits').html('');
			});
			console.log(odata);	
			console.log(datab);	
	</script>
</body>
</html>