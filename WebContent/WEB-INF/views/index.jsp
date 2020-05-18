<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Welcome to Sampple</title>
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<script src="<%=request.getContextPath()%>/static/js/jquery-3.4.1.min.js"></script>
<style>

.wrapper {
	position: relative;
	/*center*/
	width: 800px;
	height: 300px;
	overflow: hidden;
	/*picture too large*/
	margin: 100px auto;
	padding-top:100px;
	padding-bottom:474px;

}

ul {
	margin: 0;
	padding: 0;
	position: absolute;
}

li {
	margin: 0;
	padding: 0;
	list-style: none;
}

ul.slides {
	width: 3200px;
	left: 0px;
	transition: all .5s;
	cursor: pointer;
}

ul.slides li {
	width: 800px;
	height: 300px;
	overflow: hidden;
	float: left;
}

ul.slides li img {
	width: 100%;
	height: 100%;
	object-fit: cover;
}

.dot {
	bottom: 120px;
	width: 100%;
	display: flex;
	justify-content: center;
}

.dot li {
	border: 1px solid #fff;
	/* border-radius: 50%; */
	margin: 0 5px;
	width: 24px;
	height: 10px;
}

.slide_btn {
	display: flex;
	justify-content: center;
	align-items: center;
	top: -50px;
	bottom: 0;
	width: 30px;
	color: #fff;
	position: absolute;
	font-size: 24px;
}

#prevSlide {
	left: 0;
}

#nextSlide {
	right: 0;
}

.slide_btn i {
	color: rgba(255, 255, 255, .6);
	transition: .5s;
}

.slide_btn:hover i {
	color: rgba(255, 255, 255, 1);
}

#wrapper {
	z-index: 1;
}

#two {
	z-index: 1500;
	position: relative
}

#footer{
height: 574px;
　position: relative;
　margin-top: -574px;
}

</style>
</head>
<body>

	<div id="two">
		<%@ include file="./fragment/indexTOP.jsp"%>
	</div>


	<div class="wrapper" id="wrapper">
		<ul class="slides"
			onclick="location.href=
'<%=request.getContextPath()%>/productC/phone'">
			<li><img
				src="<%=request.getContextPath()%>/static/css/img/p2.png" alt=""></li>
			<li><img
				src="<%=request.getContextPath()%>/static/css/img/p1.png" alt=""></li>
			<li><img
				src="<%=request.getContextPath()%>/static/css/img/p.png" alt=""></li>
			<li><img
				src="<%=request.getContextPath()%>/static/css/img/p3.png" alt=""></li>
		</ul>
		<ul class="dot">
			<li></li>
			<li></li>
			<li></li>
			<li></li>
		</ul>

		<div class="showNav">
			<span></span>
		</div>
		<div id="prevSlide" class="slide_btn">
			<i class="fa fa-caret-left"></i>
		</div>
		<div id="nextSlide" class="slide_btn">
			<i class="fa fa-caret-right"></i>
		</div>
	</div>





		
	<script>
		$(function() {
			let slideNum = 0;
			let slideCount = $(".slides li").length; //4
			let lastIndex = slideCount - 1; //3
			console.log(slideCount)

			console.log($(".dot li"));

			var timer = null;
			timer = setInterval(function() {
				slideNum++;
				if (slideNum > lastIndex)
					slideNum = 0;
				show();
			}, 1500);

			$(".wrapper").hover(function() {
				clearInterval(timer);
			}, function() {
				timer = setInterval(function() {
					slideNum++;
					if (slideNum > lastIndex)
						slideNum = 0;
					show();
				}, 1500)
			});

			$(".dot li").eq(0).css("background", "#fff");
			$(".dot li").mouseover(function() {
				slideNum = $(this).index();
				console.log(slideNum);
				show();
			});

			$("#prevSlide").click(function() {
				slideNum--;
				if (slideNum < 0)
					slideNum = lastIndex;
				show();
			});

			$("#nextSlide").click(function() {
				slideNum++;
				if (slideNum > lastIndex - 1)
					slideNum = 0;
				show();
			});

			function show() {
				$(".dot li").eq(slideNum).css("background", "white").siblings()
						.css("background", "none");

				let slideMove = 0 - 800 * slideNum;

				$("ul.slides").css("left", slideMove);
			}
		});
	</script>
	<div id="Footer"><%@ include file="./fragment/indexBOTTOM.jsp"%></div>

</body>
</html>