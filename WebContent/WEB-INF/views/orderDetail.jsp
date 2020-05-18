<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>訂單明細</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<!--===============================================================================================-->
<%--  <link rel="icon" type="image/png" href="<c:url value='/order/images/icons/favicon.ico' />"/> --%>
<!--===============================================================================================-->
<link rel="stylesheet" type="text/css"
 href="<c:url value='/order/vendor/bootstrap/css/bootstrap.min.css' />">
<!--===============================================================================================-->
<link rel="stylesheet" type="text/css"
 href="<c:url value='/order/fonts/font-awesome-4.7.0/css/font-awesome.min.css' />">
<!--===============================================================================================-->
<link rel="stylesheet" type="text/css"
 href="<c:url value='/order/vendor/animate/animate.css' />">
<!--===============================================================================================-->
<link rel="stylesheet" type="text/css"
 href="<c:url value='/order/vendor/select2/select2.min.css' />">
<!--===============================================================================================-->
<link rel="stylesheet" type="text/css"
 href="<c:url value='/order/vendor/perfect-scrollbar/perfect-scrollbar.css' />">
<!--===============================================================================================-->
<link rel="stylesheet" type="text/css"
 href="<c:url value='/order/css/util.css' />">
<link rel="stylesheet" type="text/css"
 href="<c:url value='/order/css/main.css' />">
<!--===============================================================================================-->
</head>

<style>
.transition {
 -webkit-transform: scale(1.6);
 -moz-transform: scale(1.6);
 -o-transform: scale(1.6);
 transform: scale(2.0);
}

body {
 opacity: 0;
 transition: opacity 2s;
 background-color: #7d706f;
 font-family: 'Noto Sans TC', sans-serif;
 line-height: 1;
}

#GLOBALWRAPPER {
 margin: auto;
}

#WRAPPER {
 width: 100%;
}

.block_C {
 float: none;
 margin: auto;
 padding: 30px 0;
 width: 19.8cm;
 background-color: #7d706f;
}

.invoice_form {
 position: relative;
 border-color: transparent;
 -webkit-border-radius: 20px;
 -moz-border-radius: 20px;
 -ms-border-radius: 20px;
 border-radius: 20px;
 box-shadow: 5px 5px 20px 0px rgba(0, 0, 0, 0.3);
 background: #dadfe1;
 
 
}

.invoice_form .header {
 padding:10px 10px;
 margin: 20px 20px;
 font-size:1.5em;
 color: black;
 text-align: center;
 letter-spacing: 3px;
}

.invoice_form .header a{
font-size:20px
}

.invoice_form .content {
 padding: 1cm;
 padding-top: 0;
}

.invoice_form .main {
 height: 50px;
}

.invoice_form caption {
 margin-bottom: 20px;  
 text-align: left;
 color:black;
 font-size:20px;

}

.invoice_form .main td li {
 margin: 10px 0;
}

.invoice_form .main th {
 height: 28px;
 color: gray;
 font-size:15px;
}

.invoice_form .main th, .invoice_form .main td {
 padding: 6px 8px;
 border: 1px solid gray;
}



th td {
 vertical-align: middle;
}

table {
 border-collapse: collapse;
 border-spacing: 0;
 margin:20px;
 font-family: 'Noto Sans TC', sans-serif; 
 background-color: #f9f9f9;
}

tbody {
 display: table-row-group;
 font-weight:500;
 clear: both;
 padding: 20px 0px 5px;
 font-size: 1em;
 letter-spacing: 0.5px;
 
}


.prod_w {
 width: 20cm;
 overflow: hidden;
}

li {
 display: list-item;
 text-align: -webkit-match-parent;
}

ol, ul {
 list-style: none;
 text-align: center;
}
.button{

}
</style>

<body onload="document.body.style.opacity='1'">
 <c:set var="total" value="0"></c:set>
 <div id="GLOBALWRAPPER" class="prod_w">
  <div id="WRAPPER">
   <div id="CONTENT">
    <div class="block_C">
     <dl class="invoice_form">
      <dd class="header">
       <h2>購物清單</h2>
       
      </dd>
      <dd class="content">
      <hr>
       <table class="table_box main">
        <caption>訂單編號：</caption>
        <tbody>
         <tr>
          <th width="160">品 名</th>
          <th width="40">數 量</th>
          <th width="100">單 價</th>
          <th width="100">金 額</th>
         </tr>
         <tr>
          <c:forEach var="ordersDetail" items="${ordersDetail}">
          <tr>
          <td>
            <ul>
             <li style="height: 14px;">${ordersDetail.pName}</li>
            </ul>
           </td>
           <td class="tr">
            <ul>
             <li style="height: 14px;">${ordersDetail.quantity}</li>
            </ul>
           </td>
           <td class="tr">
            <ul>
             <li style="height: 14px;">${ordersDetail.price}</li>
            </ul>
           </td>
           <td class="tr">
            <ul>
             <li style="height: 14px;">${ordersDetail.price*ordersDetail.quantity}</li>
             <c:set var="total"
              value="${total + (ordersDetail.price*ordersDetail.quantity)}"></c:set>
            </ul>
           </td>
          </tr>           
          </c:forEach>


         </tr>
         <tr>
          <th colspan="3">總 計</th>
          <td class="tr"><c:out value="${total}" /></td>
         </tr>
        </tbody>
       </table>

      </dd>
     </dl>
    </div>
   </div>
  </div>
 </div>

 <script>
  $('.js-pscroll').each(function() {
   var ps = new PerfectScrollbar(this);

   $(window).on('resize', function() {
    ps.update();
   })
  });
 </script>
</body>
</html>