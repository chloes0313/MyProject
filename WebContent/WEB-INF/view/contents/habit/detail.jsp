<%@ page contentType="text/html;charset=UTF-8"%>
<%@page import="org.apache.jasper.tagplugins.jstl.core.Param"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>


<!-- 오늘 날짜 -->
<fmt:formatDate var="today" value="<%=new java.util.Date()%>" pattern="yyyy-MM-dd" />
<!-- 인증회원 정보 -->
<sec:authentication property="principal" var="doer"/>

<!DOCTYPE html>
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
	<script src="${initParam.rootPath}/template/js/bootstrap.min.js?ver=1"></script>
	<!-- Waypoints -->
	<script src="${initParam.rootPath}/template/js/jquery.waypoints.min.js"></script>
	<!-- countTo -->
	<script src="${initParam.rootPath}/template/js/jquery.countTo.js"></script>
	<!-- Magnific Popup -->
	<script src="${initParam.rootPath}/template/js/jquery.magnific-popup.min.js"></script>
	<script src="${initParam.rootPath}/template/js/magnific-popup-options.js"></script>

	<script src="${initParam.rootPath}/template/js/moment.min.js"></script>
	<script src="${initParam.rootPath}/template/js/bootstrap-datetimepicker.min.js"></script>

	<!-- Stellar -->
	<script src="${initParam.rootPath}/template/js/jquery.stellar.min.js"></script>
	<!-- Main -->
	<script src="${initParam.rootPath}/template/js/main.js?ver=1"></script>
	

	<link href="https://fonts.googleapis.com/css?family=Open+Sans:300,400,700" rel="stylesheet">
	
	<!-- Animate.css -->
	<link rel="stylesheet" href="${initParam.rootPath}/template/css/animate.css">
	<!-- Bootstrap  -->
	<link rel="stylesheet" href="${initParam.rootPath}/template/css/bootstrap.css?ver=1">

	<!-- Bootstrap DateTimePicker -->
	<link rel="stylesheet" href="${initParam.rootPath}/template/css/bootstrap-datetimepicker.min.css">
	
	<!-- Magnific Popup -->
	<link rel="stylesheet" href="${initParam.rootPath}/template/css/magnific-popup.css">

	<!-- Theme style  -->
	<link rel="stylesheet" href="${initParam.rootPath}/template/css/style.css?ver=1">

	<!-- Icomoon Icon Fonts-->
	<link rel="stylesheet" href="${initParam.rootPath}/template/css/icomoon.css?ver=1">
	
	<!-- Modernizr JS -->
	<script src="${initParam.rootPath}/template/js/modernizr-2.6.2.min.js?ver=1"></script>
	<!-- FOR IE9 below -->
	<!--[if lt IE 9]>
	<script src="${initParam.rootPath}/template/js/respond.min.js"></script>
	<![endif]-->

	<script type="text/javascript">
	
	$(document).ready(function() {
		
		$(document).on("click", "#writeJournal-btn", function(){
			window.location.href="${ initParam.rootPath }/journal/add_form.do";
		});
		
		$(document).on("click", "#cancel-btn", function(e){
			window.history.back();
		});
		
	});
	
	
	function toggleHabitCheck(habitNo, day, habitDate){
		console.log(habitNo+", "+day+", "+habitDate);
		console.log('${today}');
		
		$.ajax({
 			"url":"${ initParam.rootPath }/habit/habit_chk/toggle.do",
 			"type":"post",
 			"data":{'habitNo' : habitNo, 'day' : day, '${_csrf.parameterName}':'${_csrf.token}'},
 			"dataType":"json",
 			"beforeSend":function(){
 				if(habitDate != '${today}'){
 					alert("당일이 아닌 날짜는 변경 불가 합니다!");
 					return false;
 				}
 				if(confirm("습관 실행 유무를 변경 하겠습니까?") != true){
 					return false;
 				}
 				
 			},
 			"success": function(habitCheck){
 				console.log($("#habit-table #today").find(".habitState").text());
 				$("#habit-table #today").find(".habitState").text(habitCheck.habitState);
 				$("#habit-today #today").find(".habitState").text(habitCheck.habitState);
 		     
 			},
 	        "error":function(xhr, msg, code){
 				alert("오류발생-" + code +":"+ msg);
 			} 	
 		     
 		     
 		});	//end of ajax 
		
	};
	
	function removeHabit(habitNo){
		
		$.ajax({
			"url" : "${ initParam.rootPath }/habit/remove.do",
			"type" : "post",
			"data" : {
				'habitNo' : habitNo,
				'${_csrf.parameterName}' : '${_csrf.token}'
			},
			"dataType" : "json",
			"beforeSend" : function() {
				if(confirm("정말 삭제 하겠습니까?") == false){
					console.log("삭제 취소");
					$("#removeHabit-btn").blur();
				 	return false;
				}
			},
			"success" : function(result) {
				if(result == '0'){
					alert("삭제 완료");
					opener.parent.location.reload();
					window.close();
				}else{
					alert("삭제 실패:"+result);
				}
				
			},
			"error" : function(xhr, msg, code) {
				alert("오류발생-" +xhr+":"+msg+":"+code);
			}
		
	}); // end of ajax
}	// end of removeJournal

	
	</script>
	</head>
		
	<style>
	
	.fh5co-heading h1,
	.fh5co-heading h2,
	.fh5co-heading h3{
		color:#fff;
	}
	
	.fh5co-heading .yet h2 {
	color : #cccccc;
	font-weight: bold;
	text-align: center;
	text-transform: uppercase;
	}
	
	.fh5co-heading .do h2 {
	color : #e0567a;
	font-weight: bold;
	text-align: center;
	text-transform: uppercase;
	}
	
	.fh5co-heading #today h2 {
	color : #24353d;
	font-weight: bold;
	text-align: center;
	text-transform: uppercase;
	}
	
	#fh5co-blog .fh5co-post {
	  background: #fff;
	  float: left;
	  width: 100%;
	  margin-bottom: 30px;
	  padding: 30px;
	  -webkit-box-shadow: -2px 11px 24px -10px rgba(0, 0, 0, 0.09);
	  -moz-box-shadow: -2px 11px 24px -10px rgba(0, 0, 0, 0.09);
	  box-shadow: -2px 11px 24px -10px rgba(0, 0, 0, 0.09);
	  position: relative;
	  bottom: 0;
	  -webkit-transition: 0.3s;
	  -o-transition: 0.3s;
	  transition: 0.3s;
	}
	
	
	#habit-today .habit-today-post{
		background: rgba(255,255,255, 0.5);
	  	float: left;
	  	width: 300%;
	  	margin-bottom: 30px;
		padding: 30px;
		-webkit-box-shadow: -2px 11px 24px -10px rgba(0, 0, 0, 0.09);
		-moz-box-shadow: -2px 11px 24px -10px rgba(0, 0, 0, 0.09);
		box-shadow: -2px 11px 24px -10px rgba(0, 0, 0, 0.09);
		position: relative;
		bottom: 0;
	  	-webkit-transition: 0.3s;
	  	-o-transition: 0.3s;
	  	transition: 0.3s;
	}
	
	@media screen and (max-width: 990px) {
		#habit-today .habit-today-post {
		  	width: 130%;
	  	}
	}
	
	@media screen and (max-width: 400px) {
		#habit-today .habit-today-post {
		  	width: 100%;
	  	}
	}
	
	#habit-today .habit-today-post h2{
		color : #24353d;
		font-size : 55px;
		font-weight: bold;
		text-align: center;
		text-transform: uppercase;
	}
	
	
	.habit-icons a {
		text-decoration: none !important;
		display: -moz-inline-stack;
		display: inline-block;
		zoom: 1;
		*display: inline;
		color: #e0567a;
		pading : 10px 5px;
	}
		
	.habit-icons {
		width: 100px;	
	}
	
	.habit-icons span {
		font-size: 30px;
	}
	
	.habit-icons-block{
	position:relative;
	bottom:120px;
	}
	
	@media screen and (max-width: 990px){
		.habit-icons-block{
		bottom:60px;
		} 
	}
	
	@media screen and (max-width: 789px){
		.habit-icons-block{
		position:static;
		bottom:0;
		} 
	}
	
	</style>
	
	
<body>
	
<!-- header -->
	<header id="fh5co-header" class="fh5co-cover fh5co-cover-sm" role="banner" style="background-image:url(${initParam.rootPath}/images/write.jpg);" data-stellar-background-ratio="0.5">
		<div class="overlay"></div>
		<div class="container">
			<div class="row">
				<div class="col-md-12 col-md-offset-0 text-left">
					<div class="col-md-6 col-sm-6 col-xs-6 text-left">
						<div class="display-t">
							<div class="display-tc fh5co-heading animate-box " data-animate-effect="fadeInUp">
								<span>Title</span>
								<h1 class="mb30">${ requestScope.habit.habitTitle }</h1>
								<span>Start From</span>
								<h3 class="mb30"><fmt:formatDate value="${ requestScope.habit.habitStart }" pattern="yyyy-MM-dd"/></h3>
								<span>End To</span>
								<h3 class="mb30"><fmt:formatDate value="${ requestScope.habit.habitEnd }" pattern="yyyy-MM-dd"/></h3>
								
							</div>
						</div>
						
					</div>

					<c:if test="${ requestScope.todayHabitCheck  != null }">
					<div class="col-md-6 col-sm-6 col-xs-6 text-left">
						<div id="habit-today">
							<div class="display-tc fh5co-heading animate-box" data-animate-effect="fadeInUp">
								<span>Today Check</span>
								<div class="habit-today-post ${ requestScope.todayHabitCheck.habitState } " onclick="javascript:toggleHabitCheck( '${ requestScope.todayHabitCheck.habitNo }', '${ requestScope.todayHabitCheck.day }', '${today}' )" id="today">
									<span class="day">DAY ${ requestScope.todayHabitCheck.day }</span>
									<h5 class="habitDate"> <fmt:formatDate value="${ requestScope.todayHabitCheck.habitDate }" pattern="yyyy-MM-dd"/></h5>
									<h2 class="habitState"> ${ requestScope.todayHabitCheck.habitState }</h2>
								</div>
							</div>
							
						</div>
					</div>
					</c:if>
					
					
					<div class="row">
					<div class="col-md-12 col-sm-6 text-left habit-icons-block">
								<button class="btn btn-primary habit-icons" id="removeHabit-btn" onclick="removeHabit('${ requestScope.habit.habitNo}');"><span class="icon-bin"></span></button>
								<button class="btn btn-primary habit-icons" id="writeJournal-btn"><span class="icon-pencil"></span></button>
					</div> 
					</div>							
			     </div> 
			      
				
			</div>
		</div>
	</header>


	<!-- contents#1 : Habit Doing List -->
	<div id="fh5co-blog" class="fh5co-bg-section">
		<div class="container">
			<div class="row row-pb-md">
				<div class="col-md-12  text-left fh5co-heading animate-box">
					<span>Habit Table</span>
					
					<c:forEach items="${requestScope.habit.habitCheck}" var="habitCheck">
						<div id="habit-table" class="col-md-2 col-sm-4 col-xs-6  animate-box" data-animate-effect="fadeIn" >
							<fmt:formatDate value="${ habitCheck.habitDate }" pattern="yyyy-MM-dd" var="habitDate"/>
							<div class="fh5co-post ${ habitCheck.habitState }" onclick="javascript:toggleHabitCheck( '${ habitCheck.habitNo }', '${ habitCheck.day }', '${ habitDate }' )" <c:if test="${ habitDate == today }"> id="today"</c:if>>
								<span class="day">DAY ${ habitCheck.day }</span>
								<h5 class="habitDate"> ${ habitDate }</h5>
								<h2 class="habitState"> ${ habitCheck.habitState }</h2>
							</div>
							
						</div>
					</c:forEach>
				</div>
			</div>
		</div>
	</div>


	<footer id="fh5co-footer" role="contentinfo">
		<div class="container">
			<div class="row copyright">
				<div class="col-md-12 text-center">
					<p>
						<small class="block">&copy; 2016 Free HTML5. All Rights Reserved.</small> 
						<small class="block">Designed by <a href="http://gettemplates.co/" target="_blank">GetTemplates.co</a> Demo Images: <a href="http://pixeden.com/" target="_blank">Pixeden</a> &amp; <a href="http://unsplash.com/" target="_blank">Unsplash</a></small>
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

	<div class="gototop js-top">
		<a href="#" class="js-gotop"><i class="icon-arrow-up"></i></a>
	</div>
	

	</body>

</body>
</html>