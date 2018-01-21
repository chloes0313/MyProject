<%@ page contentType="text/html;charset=UTF-8"%>
<%@page import="org.apache.jasper.tagplugins.jstl.core.Param"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!-- 인증회원 정보 -->
<sec:authentication property="principal" var="doer" />

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
<title>HabitMaker &mdash; Let's make something into your own
	habit!</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="description"
	content="Free HTML5 Website Template by gettemplates.co" />
<meta name="keywords"
	content="free website templates, free html5, free template, free bootstrap, free website template, html5, css3, mobile first, responsive" />
<meta name="author" content="gettemplates.co" />

<!-- Facebook and Twitter integration -->
<meta property="og:title" content="" />
<meta property="og:image" content="" />
<meta property="og:url" content="" />
<meta property="og:site_name" content="" />
<meta property="og:description" content="" />
<meta name="twitter:title" content="" />
<meta name="twitter:image" content="" />
<meta name="twitter:url" content="" />
<meta name="twitter:card" content="" />

<!-- jQuery -->
<script src="${initParam.rootPath}/template/js/jquery.min.js?ver=1"></script>
<!-- jQuery Easing -->
<script src="${initParam.rootPath}/template/js/jquery.easing.1.3.js"></script>
<!-- Bootstrap -->
<script src="${initParam.rootPath}/template/js/bootstrap.min.js?ver=1"></script>
<!-- Waypoints -->
<script src="${initParam.rootPath}/template/js/jquery.waypoints.min.js"></script>
<!-- countTo -->
<script src="${initParam.rootPath}/template/js/jquery.countTo.js"></script>
<!-- Magnific Popup -->
<script
	src="${initParam.rootPath}/template/js/jquery.magnific-popup.min.js"></script>
<script
	src="${initParam.rootPath}/template/js/magnific-popup-options.js"></script>

<script src="${initParam.rootPath}/template/js/moment.min.js"></script>
<script
	src="${initParam.rootPath}/template/js/bootstrap-datetimepicker.min.js"></script>

<!-- Stellar -->
<script src="${initParam.rootPath}/template/js/jquery.stellar.min.js"></script>
<!-- Main -->
<script src="${initParam.rootPath}/template/js/main.js?ver=1"></script>


<!-- fullcalendar -->
<script
	src="${initParam.rootPath}/template/js/fullcalendar.min.js?ver=1"></script>


<link
	href="https://fonts.googleapis.com/css?family=Open+Sans:300,400,700"
	rel="stylesheet">

<!-- Animate.css -->
<link rel="stylesheet"
	href="${initParam.rootPath}/template/css/animate.css">
<!-- Icomoon Icon Fonts-->
<link rel="stylesheet"
	href="${initParam.rootPath}/template/css/icomoon.css">
<!-- Bootstrap  -->
<link rel="stylesheet"
	href="${initParam.rootPath}/template/css/bootstrap.css?ver=1">

<!-- Bootstrap DateTimePicker -->
<link rel="stylesheet"
	href="${initParam.rootPath}/template/css/bootstrap-datetimepicker.min.css">

<!-- Magnific Popup -->
<link rel="stylesheet"
	href="${initParam.rootPath}/template/css/magnific-popup.css">

<!-- Theme style  -->
<link rel="stylesheet"
	href="${initParam.rootPath}/template/css/style.css?ver=1">

<!-- fullcalendar -->
<link rel="stylesheet"
	href="${initParam.rootPath}/template/css/fullcalendar.css?ver=1">
<link rel="stylesheet"
	href="${initParam.rootPath}/template/css/fullcalendar.min.css?ver=1">

<!-- Modernizr JS -->
<script
	src="${initParam.rootPath}/template/js/modernizr-2.6.2.min.js?ver=1"></script>
<!-- FOR IE9 below -->
<!--[if lt IE 9]>
	<script src="${initParam.rootPath}/template/js/respond.min.js"></script>
	<![endif]-->

<script type="text/javascript">
	$(document).ready(function() {

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
					$("div #totalHabitFailureCount").attr("data-to", map.totalHabitFailureCount);	
				}
			}) //ajax
		}
		
	
		$.ajax({
			"url" : "${ initParam.rootPath}/habit/calendar.do",
			"type" : "post",
			"data" : {
				'${_csrf.parameterName}' : '${_csrf.token}'
			},
			"dataType" : "json",
			"beforeSend" : function() {
				console.log()
			},
			"success" : function(events) {
				getHabitCalendar(events);

			},
			"error" : function(xhr, msg, code) {
				alert("오류발생-" + code);
			}

		}); //end of ajax  

	

		$('#habitStart').datetimepicker({
			format : 'YYYY-MM-DD',
			defaultDate : new Date()
		//minDate : new Date() 
		});

		//
		$('#add-habit-btn').on("click", function() {
			var scrollPosition = $("#add-habit").offset().top;

			$("html, body").animate({
				scrollTop : scrollPosition - 100
			}, 500);

			$(".form-wrap #title").focus();
		});

	});

	function moveScroll(target) {
		var scrollPosition = $(target).offset().top;

		$("html, body").animate({
			scrollTop : scrollPosition - 100
		}, 500);

		$('.fh5co-nav-toggle').removeClass('active').parent().parent()
				.removeClass('overflow offcanvas');

	};

	function openHabitDetail(habitNo) {
		window.open("${initParam.rootPath}/habit/detail.do?habitNo=" + habitNo,
				"HabitDetail", "width=600, height=800");
	}

	function getHabitCalendar(events) { // 파마미터 events 받아오기
		$('#calendar').fullCalendar({

			header : {
				left : 'prev,next today',
				center : 'title',
				right : 'month,basicWeek,basicDay'
			},
			defaultView : 'month',

			editable : false,
			height : 'auto',
			contentHeight : 'auto', //no scroll
			eventColor : '#e0567a',
			events : events

		});

		console.log(events);
	}
	
	function signOut(){
		document.getElementById("signout-form").submit();
	}
</script>


</head>

<style>
.errorWell {
	display: none;
}

.error {
	font-size: 10px;
	font-style: italic;
	color: #e0567a;
}


#add-habit{
	margin-top: 8em !important;
}
@media screen and (max-width: 780px) {
	#add-habit {
		margin-top: -2em !important;
	}
}


#add-habit-btn {
	display: none;
}

@media screen and (max-width: 780px) {
	#add-habit-btn {
		display: inline;
	}
}
/* 헤더에.... 왜 margin-top이 접속할 떄마다 왔다갔다 할까 ㅠㅠㅠ
#fh5co-header .row .form-wrap, #fh5co-header .row .display-t {
	margin-top: 10em !important;
}

@media screen and (max-width: 990px) {
	#fh5co-header .row .form-wrap, #fh5co-header .row .display-t {
		margin-top: -2em !important;
	}
} */

#habit-detail {
	position: relative;
}


#calendar {
	padding: 15px 15px;
	/* margin: 15px 15px !important;  */
	background: #fff;
	-webkit-box-shadow: 0px 14px 30px -15px rgba(0, 0, 0, 0.75) !important;
 	-moz-box-shadow: 0px 14px 30px -15px rgba(0, 0, 0, 0.75) !important;
  	box-shadow: 0px 14px 30px -15px rgba(0, 0, 0, 0.75) !important;
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
						<div id="fh5co-logo">
							<a href="${initParam.rootPath}/index.do">Habit Maker<span>*</span></a>
						</div>
					</div>

					<div class="col-xs-5 text-right menu-1">
						<ul>
							<li><a href="${initParam.rootPath}/index.do">Home</a></li>
							<%--인증된(로그인한) 사용자 메뉴 : 인증 안된상태에서 안보여야 하는 메뉴 --%>
							<sec:authorize access="isAuthenticated()">

								<li class="has-dropdown active"><a>Habit</a>
									<ul class="dropdown">
										<li><a href="${initParam.rootPath}/habit/main.do">Add
												Habit</a></li>
										<li><a href="${initParam.rootPath}/habit/main.do">Calendar</a></li>
										<li><a href="javascript:moveScroll('#habitDoingList')">List</a></li>
									</ul></li>
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




		<!-- header -->
		<header id="fh5co-header" class="fh5co-cover fh5co-cover-sm"
			role="banner"
			style="background-image:url(${initParam.rootPath}/images/write.jpg);"
			data-stellar-background-ratio="0.5">
			<div class="overlay"></div>
			<div class="container">
				<div class="row">

					<div class="col-md-6 text-left">
						<div class="display-t">
							<div class="display-tc animate-box "
								data-animate-effect="fadeInUp">
								<h1 class="mb30">Habit</h1>
								<p>
									목표를 정하고 66일 동안 반복해서 실천하세요.<br> 당신의 습관이 될 것입니다.
								</p>
							</div>
						</div>
					</div>


					<div class="col-md-5 col-md-push-1 animate-box"
						data-animate-effect="fadeInRight">
						<div class="form-wrap" id="add-habit">
							<div class="tab">

								<div class="tab-content">
									<div class="tab-content-inner active" data-content="signup">
										<h3 class="cursive-font">습관 설정</h3>
										<form action="${ initParam.rootPath }/habit/add.do"
											id="habit-add-form" method="post">
											<input type="hidden" name="${_csrf.parameterName}"
												value="${_csrf.token}">

											<div class="row form-group">
												<div class="col-md-12">
													<label for="habitTitle">목표</label> <span class="error">
														<form:errors path="habit.habitTitle" delimiter="&nbsp;" />
														<c:if
															test="${ requestScope.errorMsg_duplicateTitle != null }">
												  				${ requestScope.errorMsg_duplicateTitle }
											  				</c:if>
													</span> <input type="text" id="habitTitle" name="habitTitle"
														class="form-control">
												</div>
											</div>
											<div class="row form-group">
												<div class="col-md-12">
													<label for="habitStart">시작일</label> <span class="error">
														<form:errors path="habit.habitStart" delimiter="&nbsp;" />
													</span> <input type="text" id="habitStart" name="habitStart"
														data-format="yyyy-MM-dd" class="form-control">
												</div>
											</div>
											<div class="row form-group">
												<div class="col-md-12">
													<input type="submit" class="btn btn-primary btn-block"
														value="Add Habit">
												</div>
											</div>
										</form>
									</div>
								</div>
							</div>
						</div>
					</div>


				</div>
			</div>
		</header>
		
		<!-- 로그아웃폼  -->	
<form id="signout-form" action="${initParam.rootPath }/logout.do" method="post" style="display:none">
    <sec:csrfInput/>
</form>


		<!-- contents#2 : Habit Doing List-->
		<div id="fh5co-project">
			<div class="container">
				<div class="row row-pb-md">
					<div id="habitDoingList"
						class="col-md-8 col-md-offset-2 text-left fh5co-heading  animate-box">
						<span>For 66 Days</span>
						<h2>Check What To Do</h2>
						<p>${doer.name}님,오늘도습관을 만들기 위해 열심히 노력하셨나요? 당신은 현재${ requestScope.doingMap.pagingBean.totalItems }개의
							습관을 목표로 정해 실천중입니다. 다음 ${doer.name}님의 습관 목록을 확인하고 놓친 것은 없는지
							체크해보세요.</p>

					</div>
				</div>


				<!------------------ HabitList 페이징 처리할 곳 ------------------>
				<div class="row">
					<c:forEach items="${ requestScope.doingMap.list }" var="habit">
						<div class="col-md-4 col-sm-6 fh5co-project animate-box"
							data-animate-effect="fadeIn">
							<a onclick="javascripts:openHabitDetail('${ habit.habitNo }')"><img
								src="${ initParam.rootPath }/images/shutterstock_292007390.jpg"
								alt="Free HTML5 Website Template by gettemplates.co"
								class="img-responsive">
								<div class="fh5co-copy">
									<h3>
										<!-- 목표 -->${ habit.habitTitle }</h3>
									<p>
										<!-- 시작일 -->
										Since
										<fmt:formatDate value="${ habit.habitStart }"
											pattern="yyyy-MM-dd" />
										~
										<fmt:formatDate value="${ habit.habitEnd }"
											pattern="yyyy-MM-dd" />
									</p>
								</div> </a>
						</div>


					</c:forEach>

				</div>

				<!-- Pagination -->
				<div class="col-md-12 text-center">
					<nav aria-label="Page navigation">
						<ul class="pagination">





							<c:choose>
								<c:when
									test="${ requestScope.doingMap.pagingBean.totalPage  != 0 }">

									<li><c:choose>
											<c:when
												test="${ requestScope.doingMap.pagingBean.previousPageGroup }">
												<a
													href="${ initParam.rootPath }/habit/main.do?page=${requestScope.doingMap.pagingBean.beginPage -1}"
													aria-label="Previous"> <span aria-hidden="true">&laquo;</span>
												</a>
											</c:when>
											<c:otherwise>
												<a
													href="${ initParam.rootPath }/habit/main.do?page=${requestScope.doingMap.pagingBean.beginPage}"
													aria-label="Previous"> <span aria-hidden="true">&laquo;</span>
												</a>
											</c:otherwise>
										</c:choose></li>

									<c:forEach
										begin="${requestScope.doingMap.pagingBean.beginPage}"
										end="${requestScope.doingMap.pagingBean.endPage}" var="idx">
										<li
											<c:if test='${requestScope.doingMap.pagingBean.page == idx}'> class="active" </c:if>>
											<a href="${ initParam.rootPath }/habit/main.do?page=${idx}">${idx}</a>
										</li>
									</c:forEach>


									<li><c:choose>
											<c:when
												test="${ requestScope.doingMap.pagingBean.nextPageGroup }">
												<a
													href="${ initParam.rootPath }/habit/main.do?page=${requestScope.doingMap.pagingBean.endPage +1}"
													aria-label="Next"> <span aria-hidden="true">&raquo;</span>
												</a>
											</c:when>
											<c:otherwise>
												<a
													href="${ initParam.rootPath }/habit/main.do?page=${requestScope.doingMap.pagingBean.endPage}"
													aria-label="Next"> <span aria-hidden="true">&raquo;</span>
												</a>
											</c:otherwise>
										</c:choose></li>


								</c:when>
								<c:otherwise>
									<h2>등록한 습관이 없습니다...TT</h2>
									<a href="${ initParam.rootPath }/habit/main.do">등록하러 가기</a>
								</c:otherwise>
							</c:choose>

						</ul>
					</nav>
				</div>
				<!------------------------------------->

				<!------------------------------------------------------------>

			</div>

		</div>

		<!-- contents#3 : Habit Done -->
		<div id="habit-summary">
			<div id="fh5co-counter">
				<div class="container">

					<div class="row animate-box" data-animate-effect="fadeInUp">
						<div class="col-md-8 col-md-offset-2 text-left fh5co-heading">
							<span>until now</span>
							<h2>Your Habit Summary</h2>
							<p>Habit Maker와 함께하는 당신의 습관 만들기 프로젝트는 어떻게 진행되고 있을까요. 지금까지 시도한
								습관들, 현재 수행중인 습관들, 습관화에 성공한 횟수는 어떤지 변수치들로 알아보는 당신의 습관 만들기의 달성 정도
								CHECK CHECK!</p>
						</div>
					</div>

					<div class="row">
						<div class="col-md-3 col-sm-6 animate-box"
							data-animate-effect="fadeInLeft">
							<div class="feature-center">
								<span class="icon"> <i class="ti-download"></i>
								</span> <span class="counter"><span id="totalAllHabitCount"
									class="js-counter" data-from="0" data-to="0" data-speed="1500"
									data-refresh-interval="50">0</span></span> <span class="counter-label">Total
									Trial</span>

							</div>
						</div>
						<div class="col-md-3 col-sm-6 animate-box"
							data-animate-effect="fadeInLeft">
							<div class="feature-center">
								<span class="icon"> <i class="ti-face-smile"></i>
								</span> <span class="counter"><span id="totalHabitDoingCount"
									class="js-counter" data-from="0" data-to="0"
									data-speed="1500" data-refresh-interval="50">0</span></span> <span
									class="counter-label">Doing now</span>
							</div>
						</div>
						<div class="col-md-3 col-sm-6 animate-box"
							data-animate-effect="fadeInLeft">
							<div class="feature-center">
								<span class="icon"> <i class="ti-briefcase"></i>
								</span> <span class="counter"><span id="totalHabitSuccessCount"
									class="js-counter" data-from="0" data-to="0" data-speed="1500"
									data-refresh-interval="50">0</span></span> <span class="counter-label">Success</span>
							</div>
						</div>
						
						<div class="col-md-3 col-sm-6 animate-box"
							data-animate-effect="fadeInLeft">
							<div class="feature-center">
								<span class="icon"> <i class="ti-briefcase"></i>
								</span> <span class="counter"><span id="totalHabitFailureCount" class="js-counter"
									data-from="0" data-to="0" data-speed="1500"
									data-refresh-interval="50"> <!-- id="totalHabitFailureCount" -->0
								</span></span> <span class="counter-label">Failure</span>
							</div>
						</div>

					</div>
				</div>
			</div>
		</div>


		<!-- contents#4 :cal-->
		<div id="fh5co-blog" class="fh5co-bg-section">
			<div class="container">
				<div class="row animate-box row-pb-md"
					data-animate-effect="fadeInUp">
					<div class="col-md-8 col-md-offset-2 text-left fh5co-heading">
						<span>View In </span>
						<h2>Habit Calendar</h2>
						<p>습관 진행의 개괄적인 상황을 달력으로 한눈에 파악해봅시다.</p>
					</div>
				</div>

				<div id="fh5co-calendar">
					<div class="row  animate-box row-pb-md"
						data-animate-effect="fadeInUp">
						<div class="col-md-12 col-sm-12 text-left fh5co-heading">
							<div id="calendar"></div>
						</div>
					</div>
				</div>

			</div>
		</div>

		<!-- footer -->
		<footer id="fh5co-footer" role="contentinfo">
			<div class="container">
				<div class="row row-pb-md">
					<div class="col-md-4 fh5co-widget ">
						<h3>Habit Maker.</h3>
						<p>Facilis ipsum reprehenderit nemo molestias. Aut cum
							mollitia reprehenderit. Eos cumque dicta adipisci architecto
							culpa amet.</p>
						<p>
							<a href="#">Learn More</a>
						</p>
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
							<small class="block">&copy; 2016 Free HTML5. All Rights
								Reserved.</small> <small class="block">Designed by <a
								href="http://gettemplates.co/" target="_blank">GetTemplates.co</a>
								Demo Images: <a href="http://pixeden.com/" target="_blank">Pixeden</a>
								&amp; <a href="http://unsplash.com/" target="_blank">Unsplash</a></small>
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



