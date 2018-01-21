<%@ page contentType="text/html;charset=UTF-8"%>
<%@page import="org.apache.jasper.tagplugins.jstl.core.Param"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<!-- 인증된 사용자 -->
<sec:authentication property="principal" var="doer"/>


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
		if('${requestScope.fail}' == ""){
			
		}else if('${requestScope.fail}' != ""){
			moveScroll('${requestScope.fail}');
		}

		if('${doer}' != null && '${doer}' != 'anonymousUser'){
			
			$.ajax({
				"url": "${ initParam.rootPath }/findHabitCount.do",
				"type":"post",
	 			"data":{'${_csrf.parameterName}':'${_csrf.token}'},
	 			"dataType":"json",
				"success": function(map){
					$("div #totalAllHabitCount").attr("data-to", map.totalAllHabitCount);
					$("div #totalHabitDoingCount").attr("data-to", map.totalHabitDoingCount);
					$("div #totalHabitSuccessCount").attr("data-to", map.totalHabitSuccessCount);
				}
			}) //ajax
		}
		
	 	
	});
	
	
	function moveScroll(target){
	   	 var scrollPosition= $(target).offset().top;
	   	 
	   	 $("html, body").animate({
	   		 scrollTop : scrollPosition-100
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
	.error{
		font-size: 10px;
		font-style: italic;
		color: #e0567a;
	}
	
	#habit-summary{
	  padding: 0;
	  clear: both;
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
								<li><a href="${initParam.rootPath}/habit/main.do">Add Habit</a></li>
								<li><a href="${initParam.rootPath}/habit/main.do">Calendar</a></li>
								<li><a href="${initParam.rootPath}/habit/main.do">List</a></li>
							</ul>
						</li>
						<li><a href="${initParam.rootPath}/journal/main.do">Journal</a></li>
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

<!-- 로그아웃폼  -->
<form id="signout-form" action="${initParam.rootPath }/logout.do" method="post" style="display:none">
    <sec:csrfInput/>
</form>

	<!-- header -->
	<sec:authorize access="!isAuthenticated()">
	<header id="fh5co-header" class="fh5co-cover" role="banner" style="background-image:url(${initParam.rootPath}/images/room.jpg);" data-stellar-background-ratio="0.5">
		<div class="overlay"></div>
		<div class="container">
			<div class="row">
				<div class="col-md-7 text-left">
					<div class="display-t">
						<div class="display-tc animate-box" data-animate-effect="fadeInUp">
							<h1 class="mb30">Make something into your own habit.</h1>
						
							<p>
								<a href="javascript:moveScroll('#sign-in')" class="btn btn-primary">Get Started</a>
							
							</p>
						</div>
					</div>
				</div>
			</div>
		</div>
	</header>
	</sec:authorize>
	
	<sec:authorize access="isAuthenticated()">
	<header id="fh5co-header" class="fh5co-cover" role="banner" style="background-image:url(${initParam.rootPath}/images/room.jpg);" data-stellar-background-ratio="0.5">
		<div class="overlay"></div>
		<div class="container">
			<div class="row">
				<div class="col-md-7 text-left">
					<div class="display-t">
						<div class="display-tc animate-box" data-animate-effect="fadeInUp">
							<h1 class="mb30">Make something into your own habit.</h1>
							<p>
								Hi, There! <br>
								${ doer.name }님, 어서오세요. 오늘도 당신의 습관을 위해 열심히 노력하세요! <br>
								
							</p>
							
							<p>	
								<a href="${ initParam.rootPath }/habit/main.do" class="btn btn-primary">Make It</a>
								<a href="${ initParam.rootPath }/journal/main.do" class="btn btn-primary">Write Now</a>
							</p>
						</div>
					</div>
				</div>
			</div>
		</div>
	</header>
	</sec:authorize>
	
		
	
	<%--인증 안된(로그인 안한) 사용자 메뉴 : 인증되면 안보여야 하는 메뉴 
			cont#1, cont#2--%>
	<sec:authorize access="!isAuthenticated()">
	
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
						          			<input class="form-control" id="id" name="id" type="text" placeholder="아이디를 입력하세요" value="${initParam.id}">
						          			<span class="error"> 
											  	<c:if test="${ requestScope.errorMsg_id != null }">
												  ${ requestScope.errorMsg_id }
											  	</c:if>
											</span>
						          		</div>
					        		</div>
					        
							        <div class="row form-group">    
								        <label class="col-sm-3 control-label" for="password">Password &nbsp;</label>
								        <div class="col-md-9 col-sm-9">
								        	<input class="form-control" type="password" id="password" name="password" placeholder="비밀번호를 입력하세요" value="${initParam.password}">
								       		<span class="error"> 
											  	<c:if test="${ requestScope.errorMsg_pw != null }">
												  ${ requestScope.errorMsg_pw }
											  	</c:if>
											</span>
								       </div>
								    </div>
								</div>
						
								<div class="col-md-2 col-sm-2">
									<div class="row form-group">
								    	<div class="col-md-12 col-sm-12">
											<input type="submit" id="signin-btn" name="signin-btn" class="btn btn-primary btn-block" value="Sign In">
										</div>
									</div>
									<div class="row form-group">
								    	<div class="col-md-12 col-sm-12">
											<input type="button" id="join-form-btn" name="join-form-btn" class="btn btn-default btn-block" value="Join Us"
												onclick="javascript:moveScroll('#join-us')">
												
										</div>
									</div>
								</div>
						</div>
					</form>
					
				</div>
			</div>
		</div>
	</div>


	<!-- contents#2 : Join Us -->
	<div id="fh5co-testimonial" class="fh5co-bg-section">
		<div class="container">
			<div class="row animate-box row-pb-md">
				<div class="col-md-8 col-md-offset-2 text-left fh5co-heading" id="join-us">
					<span>Welcome to Habit Maker</span>
					<h2>Join Us</h2>
					<p>66일 간의 습관 만들기 프로젝트에 참여하세요. 분명 당신은 해 낼 수 있어요.</p>
				</div>
			</div>
			<div class="row">
				<form action="${initParam.rootPath}/join.do" id="join-form" name="join-form" method="post">
					<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
						<!-- 에러메시지 -->
					      <div class="well errorWell">
					      	<span class="error"><!-- 메시지 찍히는 곳 --></span>
					      </div>  
					      
						<div class="col-md-12 animate-box">
						
								<div class="form-wrap form-horizontal">
									<div class="row form-group ">
					          			<label class="col-sm-2 control-label" for="id">ID &nbsp;</label>
						        		<div class="col-md-9 col-sm-9">
						          			<input class="form-control" id="id" name="id" type="text" value="${ param.id }" placeholder="아이디를 입력하세요">
						          			<span class="error">
						          				<form:errors path="doer.id" delimiter="&nbsp;" /> 
											  	<c:if test="${ requestScope.errorMsg != null }">
												  ${ requestScope.errorMsg }
											  	</c:if>
											</span>
						       		 	</div>
					        		</div>
					        
							        <div class="row form-group">    
								        <label class="col-sm-2 control-label" for="password">Password &nbsp;</label>
								        <div class="col-md-9 col-sm-9">
								        	<input class="form-control" type="password" id="password" name="password" placeholder="비밀번호를 입력하세요">
								        	<span class="error">
						          				<form:errors path="doer.password" delimiter="&nbsp;" /> 
											</span>
								        </div>
								    </div>
								    <div class="row form-group">    
								        <label class="col-sm-2 control-label" for="name">Name &nbsp;</label>
								        <div class="col-md-9 col-sm-9">
								          	<input class="form-control" type="text" id="name" name="name" value="${ param.name }" placeholder="이름를 입력하세요">
								        	<span class="error">
						          				<form:errors path="doer.name" delimiter="&nbsp;" /> 
											  	
											</span>
								        </div>
								    </div>
								    <div class="row form-group">    
								        <label class="col-sm-2 control-label" for="email">Email &nbsp;</label>
								        <div class="col-md-9 col-sm-9">
								        	<input class="form-control" type="email" id="email" name="email" value="${ param.email }" placeholder="이메일을 입력하세요">
								        	<span class="error">
						          				<form:errors path="doer.email" delimiter="&nbsp;" /> 
											  	
											</span>
								        </div>
								    </div>
								    <div class="row form-group">
								    	<label class="col-sm-2 control-label" for="join-btn"></label>
										<div class="col-md-9 col-sm-9">
											<input type="submit" id="join-btn" class="btn btn-primary btn-block" value="Join">
										</div>
									</div>
						 		</div>
							
							
					</div>
				</form>
				

			</div>
		</div>
	</div>
	
	</sec:authorize>
	
	<%--인증된 사용자(로그해야 보이는) 메뉴 :  
			cont#3, cont#4--%>
	<sec:authorize access="isAuthenticated()">
	<!-- contents#3 -->
	
	<div id="habit-summary">
	<div id="fh5co-counter">
		<div class="container">

			<div class="row animate-box" data-animate-effect="fadeInUp">
				<div class="col-md-8 col-md-offset-2 text-left fh5co-heading">
					<span>Keep up the</span>
					<h2>Good Work</h2>
					<p>Habit Maker와 함께하는 당신의 습관 만들기 프로젝트는 어떻게 진행되고 있을까요. 지금까지 시도한 습관들, 현재 수행중인 습관들, 습관화에 성공한 횟수는 어떤지 변수치들로 알아보는 당신의 습관 만들기의 달성 정도 CHECK CHECK!</p>
				</div>
			</div>
			
			<div class="row">
				<div class="col-md-3 col-sm-6 animate-box" data-animate-effect="fadeInLeft">
					<div class="feature-center">
						<span class="icon">
							<i class="ti-download"></i>
						</span>
						<span class="counter"><span id="totalAllHabitCount" class="js-counter" data-from="0" data-to="15" data-speed="1500" data-refresh-interval="50">0</span></span>
						<span class="counter-label">Total Trial</span>

					</div>
				</div>
				<div class="col-md-3 col-sm-6 animate-box" data-animate-effect="fadeInLeft">
					<div class="feature-center">
						<span class="icon">
							<i class="ti-face-smile"></i>
						</span>
						<span class="counter"><span id="totalHabitDoingCount" class="js-counter" data-from="0" data-to="120" data-speed="1500" data-refresh-interval="50">0</span></span>
						<span class="counter-label">Doing now</span>
					</div>
				</div>
				<div class="col-md-3 col-sm-6 animate-box" data-animate-effect="fadeInLeft">
					<div class="feature-center">
						<span class="icon">
							<i class="ti-briefcase"></i>
						</span>
						<span class="counter"><span id="totalHabitSuccessCount" class="js-counter" data-from="0" data-to="90" data-speed="1500" data-refresh-interval="50">0</span></span>
						<span class="counter-label">Habits Success</span>
					</div>
				</div>
				<div class="col-md-3 col-sm-6 animate-box" data-animate-effect="fadeInLeft">
					<div class="feature-center">
						<span class="icon">
							<i class="ti-briefcase"></i>
						</span>
						<span class="counter"><span class="js-counter" data-from="0" data-to="90" data-speed="1500" data-refresh-interval="50"><!-- id="totalJournalCount" -->0</span></span>
						<span class="counter-label">Writing</span>
					</div>
				</div>
					
			</div>
		</div>
	</div>
	</div>
	
	
	<!-- contents#4 -->
	<div id="fh5co-blog" class="fh5co-bg-section">
		<div class="container">
			<div class="row animate-box row-pb-md" data-animate-effect="fadeInUp">
				<div class="col-md-8 col-md-offset-2 text-left fh5co-heading">
					<span>Thoughts &amp; Ideas</span>
					<h2>Journal</h2>
					<p>습관 만들기를 진행하면서 떠오르는 순간의 감정이나 생각들을 끄적여보는 공간도 준비했습니다. 아무말 대잔치도 좋아요. 작은 것 하나라도 기록하는 것도 결국 글쓰는 좋은 습관이 될거라고 믿습니다:)</p>
				</div>
			</div>
			<div class="row">
				<div class="col-md-4 col-sm-4 animate-box" data-animate-effect="fadeInUp">
					<div class="fh5co-post">
						<span class="fh5co-date">Sep. 12th</span>
						<h3><a href="#">Web Design for the Future</a></h3>
						<p>Facilis ipsum reprehenderit nemo molestias. Aut cum mollitia reprehenderit. Eos cumque dicta adipisci architecto culpa amet.</p>
						<p class="author"><img src="${initParam.rootPath}/template/images/person1.jpg" alt="Free HTML5 Bootstrap Template by gettemplates.co"> <cite> Mike Adam</cite></p>
					</div>
				</div>
				<div class="col-md-4 col-sm-4 animate-box" data-animate-effect="fadeInUp">
					<div class="fh5co-post">
						<span class="fh5co-date">Sep. 23rd</span>
						<h3><a href="#">Web Design for the Future</a></h3>
						<p>Facilis ipsum reprehenderit nemo molestias. Aut cum mollitia reprehenderit. Eos cumque dicta adipisci architecto culpa amet.</p>
						<p class="author"><img src="${initParam.rootPath}/template/images/person1.jpg" alt="Free HTML5 Bootstrap Template by gettemplates.co"> <cite> Mike Adam</cite></p>
					</div>
				</div>
				<div class="col-md-4 col-sm-4 animate-box" data-animate-effect="fadeInUp">
					<div class="fh5co-post">
						<span class="fh5co-date">Sep. 24th</span>
						<h3><a href="#">Web Design for the Future</a></h3>
						<p>Facilis ipsum reprehenderit nemo molestias. Aut cum mollitia reprehenderit. Eos cumque dicta adipisci architecto culpa amet.</p>
						<p class="author"><img src="${initParam.rootPath}/template/images/person1.jpg" alt="Free HTML5 Bootstrap Template by gettemplates.co"> <cite> Mike Adam</cite></p>
					</div>
				</div>
			</div>
		</div>
	</div>
	
	</sec:authorize>

	<div id="fh5co-started">
		<div class="container">
			<div class="row animate-box">
				<div class="col-md-8 col-md-offset-2 text-center fh5co-heading">
					<span>Let's work together</span>
					<h2>Try this template for free</h2>
					<p>Dignissimos asperiores vitae velit veniam totam fuga molestias accusamus alias autem provident. Odit ab aliquam dolor eius.</p>
					<p><button type="submit" class="btn btn-primary">Get In Touch</button></p>
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

