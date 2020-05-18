<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>聽說這個叫後台</title>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css" integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">
<script src="https://code.jquery.com/jquery-3.4.1.slim.min.js" integrity="sha384-J6qa4849blE2+poT4WnyKhv5vZF5SrPo0iEjwBvKU7imGFAV0wwj1yYfoRSJoZ+n" crossorigin="anonymous"></script>
<script	src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js" integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6" crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/malihu-custom-scrollbar-plugin/3.1.5/jquery.mCustomScrollbar.concat.min.js"></script>
<link rel="stylesheet"href="<%=request.getContextPath()%>/static/open-iconic/font/css/open-iconic-bootstrap.min.css">

<link rel="stylesheet"href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<link href="https://fonts.googleapis.com/css?family=Noto+Sans+TC&display=swap" rel="stylesheet">
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<style type="text/css">
.wrapper {
    display: flex;
    width: 100%;
}
#content {
    width: calc(100% - 180px);
    padding: 10px;
    min-height: 100vh;
    transition: all 0.3s;
    position: absolute;
    top: 0;
    right: 0;
}
#content.active {
	width: 100%;
}
#content2 {
    width: calc(100% - 180px);
    margin-top:100px;
    min-height: 100vh;
    transition: all 0.3s;
    position: absolute;
    top: 0;
    right: 0;
}
#content2.active {
	width: 100%;
}
#sidebar.active {
    margin-left: -180px;
}
#sidebar {
    width: 180px;
    position: fixed;
    top: 0;
    left: 0;
    height: 100vh;
    z-index: 999;
    background: #7386D5;
    color: #fff;
    transition: all 0.3s;
}
.mCustomScrollbar{
touch-action: pinch-zoom;
}
body {
    font-family: 'Poppins', sans-serif;
    background: #7d706f;
 
}
p {
    font-family: 'Poppins', sans-serif;
    font-size: 1.1em;
    font-weight: 300;
    line-height: 1.7em;
    color: #999;
}

a, a:hover, a:focus {
    color: inherit;
    text-decoration: none;
    transition: all 0.3s;
}
#sidebar-active{
display:none  ;
}
#sidebar-active a{
font-weight:bold;
}
#sidebar-active.active{
display:block;
}
#sidebar {
    background: #d0d0d0;
    color: #fff;
    transition: all 0.3s;
}

#sidebar .sidebar-header {
    padding: 15px;
    background: #d0d0d0;
}

#sidebar ul.components {
    padding: 20px 0;
    border-bottom: 1px solid #d0d0d0;
}

#sidebar ul p {
    color: #fff;
    padding: 10px;
}

#sidebar ul li a {
    padding: 10px;
    font-size: 1.1em;
    display: block;
    color: #696969;    
	font-weight:bold;
}
#sidebar ul li a:hover {
    color: #7386D5;
    background: #fff;
}

#sidebar ul li.active > a, a[aria-expanded="true"] {
    color: #fff;
    background: #6d7fcc;
}
ul ul a {
    font-size: 0.9em !important;
    padding-left: 30px !important;
    background: #6d7fcc;
}
.backlogout{
text-align: right;
margin-top: auto;
}
.backlogout a{
font-weight:bold;
}
tr{
  border:1px solid #7d706f;
}
table{
border-collapse: collapse;
border-spacing: 0;
margin: auto;
}
tr:first-child th:first-child{
  border-top-left-radius: 10px;
}
tr:first-child th:last-child{
  border-top-right-radius: 10px;
}
tr:first-child td:first-child{
  border-top-left-radius: 10px;
}
tr:last-child td:first-child{
  border-bottom-left-radius: 10px;
}
tr:first-child td:last-child{
  border-top-right-radius: 10px;
}
tr:last-child td:last-child{
  border-bottom-right-radius: 10px;
}
</style>
</head>
<body>
<div class="wrapper">
    <!-- Sidebar -->
    <nav id="sidebar">
      <div class="sidebar-header">
        <img alt="" src="<%=request.getContextPath()%>/static/css/img/p666.png" height="150px" >
      </div>
        <ul class="list-unstyled components">
            <p></p>
            <li>
              <a href="<%=request.getContextPath()%>/back"><span class="oi oi-home"></span>&emsp;後台首頁</a>                     
            </li>
            <li>
               <a href="<%=request.getContextPath()%>/back/order">&nbsp;<span class="oi oi-dollar"></span>&emsp;訂單管理</a>
            </li>
            <li>
               <a href="<%=request.getContextPath()%>/product">&nbsp;<span class="oi oi-phone"></span>&emsp;商品管理</a>                 
            </li>
            <li>
                <a href="<%=request.getContextPath()%>/back/users"><span class="oi oi-people"></span>&emsp;會員管理</a>
            </li>
            <li>
                <a href="<%=request.getContextPath()%>/back/cusserv"><span class="oi oi-bell"></span>&emsp;線上客服</a>
            </li>
        </ul>
    </nav>	
    <div id="content">
    <nav class="navbar navbar-dark " style="background-color: #d0d0d0;">
        <div class="container-fluid">
            <button type="button" id="sidebarCollapse" class="btn btn-secondary">                
                <span class="navbar-toggler-icon"></span>
            </button>
            <div id="sidebar-active">
            	<a href="<%=request.getContextPath()%>/back" class="btn btn-secondary "><span class="oi oi-home"></span>&emsp;後台首頁</a>&emsp;&emsp;&emsp;&emsp;	
            	<a href="<%=request.getContextPath()%>/back/order" class="btn btn-secondary "><span class="oi oi-dollar"></span>&nbsp;&emsp;訂單管理</a>&emsp;&emsp;&emsp;&emsp;
            	<a href="<%=request.getContextPath()%>/product"	class="btn btn-secondary "><span class="oi oi-phone"></span>&nbsp;&emsp;商品管理</a>&emsp;&emsp;&emsp;&emsp;	
            	<a href="<%=request.getContextPath()%>/back/users" class="btn btn-secondary "><span class="oi oi-people"></span>&emsp;會員管理</a>&emsp;&emsp;&emsp;&emsp;
            	<a href="<%=request.getContextPath()%>/back/cusserv" class="btn btn-secondary "><span class="oi oi-bell"></span>&emsp;線上客服</a>				
			</div>		
            <div class="backlogout">
            	<a href="<%=request.getContextPath()%>/logout.return" class="btn btn-secondary "><span class="oi oi-power-standby"></span>登出</a>				
			</div>				
        </div>
    </nav>
</div>
</div>



<script src="https://cdnjs.cloudflare.com/ajax/libs/malihu-custom-scrollbar-plugin/3.1.5/jquery.mCustomScrollbar.concat.min.js"></script>
<script type="text/javascript">
	$(document).ready(function () {

	    $("#sidebar").mCustomScrollbar({
	         theme: "minimal"
	    });

	    $('#sidebarCollapse').on('click', function () {
	        $('#sidebar').toggleClass('active');
	        $('#content').toggleClass('active');
	        $('#content2').toggleClass('active');
	        $('#sidebar-active').toggleClass('active');
	        $('.collapse.in').toggleClass('in');
	        $('a[aria-expanded=true]').attr('aria-expanded', 'false');
	    });
	});
</script>
</body>
</html>