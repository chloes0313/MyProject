<%@ page contentType="text/html;charset=UTF-8"%>
<%@page import="org.apache.jasper.tagplugins.jstl.core.Param"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<!DOCTYPE HTML>
<!--
	Concept by gettemplates.co
	Twitter: http://twitter.com/gettemplateco
	URL: http://gettemplates.co
-->
<html>
	<head>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<title>HabitMaker &mdash; Let's make something into your own habit!</title>
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<meta name="description" content="Free HTML5 Website Template by gettemplates.co" />
	<meta name="keywords" content="free website templates, free html5, free template, free bootstrap, free website template, html5, css3, mobile first, responsive" />
	<meta name="author" content="gettemplates.co" />

  	<!-- Facebook and Twitter integration -->
	<meta property="og:title" content=""/>
	<meta property="og:image" content=""/>
	<meta property="og:url" content=""/>
	<meta property="og:site_name" content=""/>
	<meta property="og:description" content=""/>
	<meta name="twitter:title" content="" />
	<meta name="twitter:image" content="" />
	<meta name="twitter:url" content="" />
	<meta name="twitter:card" content="" />

	<!-- jQuery -->
	<script src="${initParam.rootPath}/template/js/jquery.min.js?ver=1"></script>
	<!-- jQuery Easing -->
	<script src="${initParam.rootPath}/template/js/jquery.easing.1.3.js"></script>
	<!-- Bootstrap -->
	<script src="${initParam.rootPath}/template/js/bootstrap.min.js"></script>
	<!-- Waypoints -->
	<script src="${initParam.rootPath}/template/js/jquery.waypoints.min.js"></script>
	<!-- countTo -->
	<script src="${initParam.rootPath}/template/js/jquery.countTo.js"></script>
	<!-- Magnific Popup -->
	<script src="${initParam.rootPath}/template/js/jquery.magnific-popup.min.js"></script>
	<script src="${initParam.rootPath}/template/js/magnific-popup-options.js"></script>
	<!-- Stellar -->
	<script src="${initParam.rootPath}/template/js/jquery.stellar.min.js"></script>
	<!-- Main -->
	<script src="${initParam.rootPath}/template/js/main.js?ver=1"></script>
	<link href="https://fonts.googleapis.com/css?family=Open+Sans:300,400,700" rel="stylesheet">
	
	<!-- Animate.css -->
	<link rel="stylesheet" href="${initParam.rootPath}/template/css/animate.css">
	<!-- Icomoon Icon Fonts-->
	<link rel="stylesheet" href="${initParam.rootPath}/template/css/icomoon.css">
	<!-- Bootstrap  -->
	<link rel="stylesheet" href="${initParam.rootPath}/template/css/bootstrap.css">

	<!-- Magnific Popup -->
	<link rel="stylesheet" href="${initParam.rootPath}/template/css/magnific-popup.css">

	<!-- Theme style  -->
	<link rel="stylesheet" href="${initParam.rootPath}/template/css/style.css?ver=1">

	<!-- Modernizr JS -->
	<script src="${initParam.rootPath}/template/js/modernizr-2.6.2.min.js?ver=1"></script>
	<!-- FOR IE9 below -->
	<!--[if lt IE 9]>
	<script src="${initParam.rootPath}/template/js/respond.min.js"></script>
	<![endif]-->


	<script type="text/javascript">
	$(document).ready(function() {
		
		
		//로그인 처리
		$(document).on("click", "#signin-btn", function(){
			var formData = $("#signin-form").serializeArray();
			
			$.ajax({
				"url": "${ initParam.rootPath }/signIn.do",
				"type": "post",
				"data": formData,
				"dataType":"text",
				"success": function(text){
					if(text == "0"){
						$("#signin-form .errorWell").find(".error").empty();
						$("#signin-form .errorWell").hide();
						
						window.location.href="${ initParam.rootPath }/index.do";
						
					}else{
						$("#signin-form .errorWell").find(".error").text("*로그인실패 : "+text);
						$("#signin-form .errorWell").show();
					}
				}
			})
	 	})
	 	
	});
	
	
	
	function moveScroll(target){
	   	 var scrollPosition= $(target).offset().top;
	   	 
	   	 $("html, body").animate({
	   		 scrollTop : scrollPosition-118
	   	 },500);
	   	 
	   	 $('.fh5co-nav-toggle').removeClass('active').parent().parent().removeClass('overflow offcanvas');

	};
	
	function signOut(){
		document.getElementById("signout-form").submit();
	}
	
	</script>

	</head>
	<style>
	.errorWell{
		display: none;
		
	}
	
	
	#signin-btn{
		height: 120px;
	}
	
	@media screen and (max-width: 768px) {
	  #signin-btn{
	    height: auto;
	  }
	}
	</style>


	<body>

	<div class="fh5co-loader"></div>
	
	<div id="page">
	
	<!-- navigator -->
	<nav class="fh5co-nav" role="navigation">
		<div class="container">
			<div class="row">			
				<div class="col-xs-7 text-left">
					<div id="fh5co-logo"><a href="${initParam.rootPath}/index.do">Habit Maker<span>*</span></a></div>
				</div>
				
				<div class="col-xs-5 text-right menu-1">
					<ul>
						<li class="active"><a href="${initParam.rootPath}/index.do">Home</a></li>
						<%--인증된(로그인한) 사용자 메뉴 : 인증 안된상태에서 안보여야 하는 메뉴 --%>
						<sec:authorize access="isAuthenticated()">
						<li class="has-dropdown">
							<a>Habit</a>
							<ul class="dropdown">
								<li><a href="${initParam.rootPath}/habit.do">Add Habit</a></li>
								<li><a href="#">Calendar</a></li>
								<li><a href="#">List</a></li>
							</ul>
						</li>
						<li><a href="${initParam.rootPath}/journal.do">Journal</a></li>
						<li><a href="javascript:signOut()">Sign-out</a></li>
						</sec:authorize>
						
						<%--인증 안된(로그인 안한) 사용자 메뉴 : 인증되면 안보여야 하는 메뉴 --%>
						<sec:authorize access="!isAuthenticated()">
						<li><a href="javascript:moveScroll('#sign-in')">Sign-in</a></li>
						<li><a href="javascript:moveScroll('#join-us')">Join</a></li>
						</sec:authorize>
					</ul>
				</div>
			</div>
			
		</div>
	</nav>
	
	
	<!-- header -->
	<header id="fh5co-header" class="fh5co-cover" role="banner" style="background-image:url(${initParam.rootPath}/images/milkyway.jpg);" data-stellar-background-ratio="0.5">
		<div class="overlay"></div>
		<div class="container">
			<div class="row">
				<div class="col-md-12 text-center fh5co-heading">
					<div class="display-t">
						<div class="display-tc animate-box" data-animate-effect="fadeInUp">
							<span>Welcome to Habit Maker.</span>
							<h1 class="mb30">You are ready to make it work!</h1>
						
							<p>
								<a href="javascript:moveScroll('#sign-in')" class="btn btn-primary">Sign in Now</a><em class="or">or</em> 
								<a href="${initParam.rootPath}/index.do" style="text-decoration: none;">Go Home</a>
							
							</p>
						</div>
					</div>
				</div>
			</div>
		</div>
	</header>
	
	<!-- contents#1 : signIn -->
	<div id="fh5co-blog" class="fh5co-bg-section">
		<div class="container">
			<div class="row animate-box row-pb-md" data-animate-effect="fadeInUp">
				<div class="col-md-8 col-md-offset-2 text-left fh5co-heading" id="sign-in">
					<span>Let's make it</span>
					<h2>Sign In</h2>
					<p>오늘도 열심히 습관을 만들기 위해 가열차게 달려봅시다.</p>
				</div>
			</div>
			
			<div class="row">
				<div class="col-md-12 col-sm-12 animate-box" data-animate-effect="fadeInUp">
					
					<form action="${initParam.rootPath}/signIn.do" id="signin-form" method="post">
						<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
							<!-- 에러메시지 -->
						      <div class="well errorWell">
						      	<span class="error"><!-- 메시지 찍히는 곳 --></span>
						      </div>  
							
							<div class="form-wrap form-horizontal">
								<div class="col-md-9 col-sm-9">
						
									<div class="row form-group ">
					          			<label class="col-sm-3 control-label" for="id">ID &nbsp;</label>
						        		<div class="col-md-9 col-sm-9">
						          			<input class="form-control" id="id" name="id" type="text" placeholder="아이디를 입력하세요">
						          		</div>
					        		</div>
					        
							        <div class="row form-group">    
								        <label class="col-sm-3 control-label" for="password">Password &nbsp;</label>
								        <div class="col-md-9 col-sm-9">
								        	<input class="form-control" type="password" id="password" name="password" placeholder="비밀번호를 입력하세요">
								       </div>
								    </div>
								</div>
						
								<div class="col-md-2 col-sm-2">
									<div class="row form-group">
								    	<div class="col-md-12 col-sm-12">
											<input type="submit" id="signin-btn" name="signin-btn" class="btn btn-primary btn-block" value="Sign In">
										</div>
									</div>
									
								</div>
						</div>
					</form>
					
				</div>
			</div>
		</div>
	</div>

	
		<footer id="fh5co-footer" role="contentinfo">
		<div class="container">
			<div class="row row-pb-md">
				<div class="col-md-4 fh5co-widget ">
					<h3>Habit Maker</h3>
					<p>Facilis ipsum reprehenderit nemo molestias. Aut cum mollitia reprehenderit. Eos cumque dicta adipisci architecto culpa amet.</p>
					<p><a href="#">Learn More</a></p>
				</div>
				<div class="col-md-2 col-sm-4 col-xs-6 col-md-push-1 ">
					<ul class="fh5co-footer-links">
						<li><a href="#">About</a></li>
						<li><a href="#">Help</a></li>
						<li><a href="#">Contact</a></li>
						<li><a href="#">Terms</a></li>
						<li><a href="#">Meetups</a></li>
					</ul>
				</div>

				<div class="col-md-2 col-sm-4 col-xs-6 col-md-push-1 ">
					<ul class="fh5co-footer-links">
						<li><a href="#">Shop</a></li>
						<li><a href="#">Privacy</a></li>
						<li><a href="#">Testimonials</a></li>
						<li><a href="#">Handbook</a></li>
						<li><a href="#">Held Desk</a></li>
					</ul>
				</div>

				<div class="col-md-2 col-sm-4 col-xs-6 col-md-push-1 ">
					<ul class="fh5co-footer-links">
						<li><a href="#">Find Designers</a></li>
						<li><a href="#">Find Developers</a></li>
						<li><a href="#">Teams</a></li>
						<li><a href="#">Advertise</a></li>
						<li><a href="#">API</a></li>
					</ul>
				</div>
			</div>

			<div class="row copyright">
				<div class="col-md-12 text-center">
					<p>
						<small class="block">Copyright &copy; 2017 Habit Maker. All rights reserved.</small> 
						<!-- <small class="block">Designed by <a href="http://gettemplates.co/" target="_blank">GetTemplates.co</a> Demo Images: <a href="http://pixeden.com/" target="_blank">Pixeden</a> &amp; <a href="http://unsplash.com/" target="_blank">Unsplash</a></small> -->
					</p>
					<p>
						<ul class="fh5co-social-icons">
							<li><a href="#"><i class="icon-twitter"></i></a></li>
							<li><a href="#"><i class="icon-facebook"></i></a></li>
							<li><a href="#"><i class="icon-linkedin"></i></a></li>
							<li><a href="#"><i class="icon-dribbble"></i></a></li>
						</ul>
					</p>
				</div>
			</div>

		</div>
	</footer>
	</div>

	<div class="gototop js-top">
		<a href="#" class="js-gotop"><i class="icon-arrow-up"></i></a>
	</div>
	
	

	</body>
</html>
