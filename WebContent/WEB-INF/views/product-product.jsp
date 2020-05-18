<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">

<head>

	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
	<meta name="description" content="">
	<meta name="author" content="">

	<title>Sampple</title>
	<script src="../static/jquery/jquery.min.js"></script>
	<script src="../static/jquery/jquery.slim.min.js"></script>
	<!-- Bootstrap core CSS -->
	<link href="../static/css/bootstrap-grid.css" rel="stylesheet">
	<link href="../static/css/bootstrap-reboot.css" rel="stylesheet">
	<link href="../static/css/bootstrap.css" rel="stylesheet">
	<!-- Custom styles for this template -->
	<link href="../static/css/shop-homepage.css" rel="stylesheet">
	<style>
		#one{z-index:1;}

	</style>
</head>

<body>

	<div id="two">
		<%@ include file="./fragment/indexTOP.jsp"%>
	</div>
	
	<!-- Page Content -->
	<div class="container" id="one">

		<div class="row">
			<div class="col-lg-9" style="margin:0 auto ;z-index:1; position:relative">
				<div class="mainview">
					<div id="carouselExampleIndicators" class="carousel slide my-4" data-ride="carousel">
						<ol class="carousel-indicators">
							<li data-target="#carouselExampleIndicators" data-slide-to="0" class="active"></li>
							<li data-target="#carouselExampleIndicators" data-slide-to="1"></li>
							<li data-target="#carouselExampleIndicators" data-slide-to="2"></li>
						</ol>
						<div class="carousel-inner" role="listbox">
							<div class="carousel-item active">
								<img class="d-block img-fluid" src="../static/css/img/iphone.png" alt="First slide">
							</div>
							<div class="carousel-item">
								<img class="d-block img-fluid" src="../static/css/img/ipad.png" alt="Second slide">
							</div>
							<div class="carousel-item">
								<img class="d-block img-fluid" src="../static/css/img/mac.png" alt="Third slide">
							</div>
						</div>
						<a class="carousel-control-prev" href="#carouselExampleIndicators" role="button"
							data-slide="prev"> <span class="carousel-control-prev-icon" aria-hidden="true"></span> <span
								class="sr-only">Previous</span>
						</a> <a class="carousel-control-next" href="#carouselExampleIndicators" role="button"
							data-slide="next">
							<span class="carousel-control-next-icon" aria-hidden="true"></span>
							<span class="sr-only">Next</span>
						</a>
					</div>
				</div>
				<div class="row">
					<c:forEach var="item" items="${listProduct}">
						<div class="col-lg-4 col-md-6 mb-4">
							<div class="card h-100">
								<a style="margin:auto"
									href="<%=request.getContextPath()%>/productC/Detail?p_id=<c:out value='${item.p_id}'/>">
									<img src="<c:url value="/productC/getImage?img=${item.p_img}" /> "
									width="200" height="300">
								</a>

								<div class="card-body">
									<h4 class="card-title">${item.p_name}</h4>
									<h5>NT$${item.price} 起</h5>
									<p class="card-text">${item.des}</p>
								</div>
								<input type="button" class="btn btn-secondary" style="background-color: #7D706f"
									value="more"
									onclick="javascript:location.href='<%=request.getContextPath()%>/productC/Detail?p_id=<c:out value='${item.p_id}'/>'">
							</div>
						</div>
					</c:forEach>
				</div>
				<!-- /.row -->

			</div>
			<!-- /.col-lg-9 -->

		</div>
		<!-- /.row -->

	</div>
	<!-- /.container -->

	<!-- Footer -->
	<!-- <footer class="py-5 bg-dark">
		<div class="container">
			<p class="m-0 text-center text-white">Copyright &copy; Your
				Website 2019</p>
		</div> -->
		<!-- /.container -->
	<!--</footer> -->

	<!-- Bootstrap core JavaScript -->
	<script src="../static/js/bootstrap.min.js"></script>
	<script src="../static/js/bootstrap.bundle.min.js"></script>

<%@ include file="./fragment/indexBOTTOM.jsp"%>
</body>

</html>