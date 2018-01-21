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
	<!-- Slick::jQuery Responsive Touch for Carousel -->
	<script type="text/javascript" src="${initParam.rootPath}/template/slick/slick.min.js"></script>
	
	
	

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
	
	<!-- Slick::jQuery Responsive Touch for Carousel -->
	<link rel="stylesheet" type="text/css" href="${initParam.rootPath}/template/slick/slick.css?ver=1"/>
	<link rel="stylesheet" type="text/css" href="${initParam.rootPath}/template/slick/slick-theme.css?ver=1"/>
	<!-- Modernizr JS -->
	<script src="${initParam.rootPath}/template/js/modernizr-2.6.2.min.js?ver=1"></script>
	<!-- FOR IE9 below -->
	<!--[if lt IE 9]>
	<script src="${initParam.rootPath}/template/js/respond.min.js"></script>
	<![endif]-->


	<script type="text/javascript">
	
	$(document).ready(function() {
		$(document).on("click", ".image", function(){
			modalImage(this);
			
		});
		
		
		$('.image-sum-slide').slick({
			  dots: true,
			  infinite: false,
			  speed: 300,
			  slidesToShow: 1,
			  /* centerMode: true, */
			  variableWidth: true
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
	
	
	
	function modalImage(target){
		
		$("#myModal").modal({
			backdrop: "static"	/* Note: You cannot click outside of this modal to close it. */
		
		});
		
		
		$("#myModal-image").attr({"src": target.src, "alt":target.alt, "title":target.alt});
		console.log(target.src);
	}
	
	
	function modifyJournal(journalNo){
		alert(journalNo);
		window.location.href="${ initParam.rootPath }/journal/mod_Chk.do?journalNo="+journalNo;
		
	}
	
	
	function removeJournal(journalNo){
		
			$.ajax({
				"url" : "${ initParam.rootPath }/journal/remove.do",
				"type" : "post",
				"data" : {
					'journalNo' : journalNo,
					'${_csrf.parameterName}' : '${_csrf.token}'
				},
				"dataType" : "json",
				"beforeSend" : function() {
					alert(journalNo);
					if(confirm("정말 삭제 하겠습니까?") == false){
						console.log("삭제 취소");
						$("#removeJournal-btn").blur();
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



	
	.fh5co-bg-section {
	  background: #F0F5F9;
	}
	
	.fh5co-heading h1,
	.fh5co-heading h2,
	.fh5co-heading h3{
		color:#fff;
	}
	
		#fh5co-testimonial .testimonial:after{
		
    position: absolute;
    left: 11%;
    bottom: -30px;
    display: block;
    width: 0;
    content: "";
    border-width: 30px 30px 0 0;
    border-style: solid;
    border-color: #fff transparent;
	}
	
	#fh5co-started .display-tc h1{
		margin-bottom: 0px;
		margin-top: 0;
		font-size: 60px;
		line-height: 1.3;
		font-family: "Open Sans", Arial, sans-serif;
		font-weight: 300;
	
	}
	
	@media screen and (max-width: 400px) {
	  #fh5co-started .display-tc h1 {
	    font-size: 40px;
	  }
	  
	  #fh5co-started .text-left,
	  blockquote .text-left {
    	text-align: center !important;
 	 }
	}
	
	
	.journal-icons a {
		text-decoration: none !important;
		display: -moz-inline-stack;
		display: inline-block;
		zoom: 1;
		display: inline;
		color: #e0567a;
		pading : 10px 5px;
	}
		
	.journal-icons {
		width: 100px;
		
	}
	
	@media screen and (max-width: 400px){
		.journal-icons {
			display: block;
	    	width: 100%;
		}
	}
	
	.journal-icons span {
		font-size: 30px;
	}
	
	#fh5co-testimonial .testimonial p.write-date cite {
	  font-style: normal;
	  font-size: 13px;
	  font-family: "Open Sans", Arial, sans-serif;
	}
	
	img.image {
		/* width: 100%;  */
		height: 100px;
		margin: 5px 10px !important;
		
	}
	.
	
	
	.testimonial{
		overflow: hidden;
		
	}

	
	#image-sum{
		bottom: -10px !important;
		margin: 10px 0 !important;
		padding: 0 5px !important;
		width:inherit;
		overflow:hidden;
		white-space:nowrap;
		
	}
	
	
	#image-sum blockquote{
		overflow-x:scroll;
	}
	
	#image-sum blockquote::-webkit-scrollbar { 
	    display: none; 
	}
	
	#journalIconicImage{
	
	}
	
	</style>


	<style>
	/* 모달 */
	/* Style the Image Used to Trigger the Modal */
		
		
		
		 .modal {
		    z-index: 2000; /* Sit on top */
		    padding: 70px 0; /* Location of the box */
		    left: 0;
		    top: 0;
		    width: 100%; /* Full width */
		    height: 100%; /* Full height */
		    
		}
		
		
		/* Modal Content (Image) */
		/* 789px까지는 높이에 맞춰서 */
		.modal-content {
		    margin: auto;
			display: inline;
			width:80%;
		    height: 90%;
		    
		}
		
		
		#myModal-image{
			margin: auto;
			display:block;
		    border-radius: 5px;
		    cursor: pointer;
		    transition: 0.3s;
		    max-width:100%;
		    max-height: 100%;
		}
		
		
		
		@media screen and (max-width: 789px){
			.modal-content {
			    margin: auto;
			    display: block;
			    height: auto;
			    width: 80%;
			    max-width: 1200px;
			}
			
			
			
			#myModal-image{
			    border-radius: 5px;
			    cursor: pointer;
			    transition: 0.3s;
			    width: 100%;
			    
			}
		}
		
		
		
		/* 95% Image Width on Smaller Screens */
		@media only screen and (max-width: 700px){
		    .modal-content {
		        width: 95%;
		    }
		}
		
		
		/* Add Animation - Zoom in the Modal */
		.modal-content { 
		    animation-name: zoom;
		    animation-duration: 0.6s;
		}
		
		@keyframes zoom {
		    from {transform:scale(0)} 
		    to {transform:scale(1)}
		}
		
		
		
		
		/* The Close Button */
		.close {
		    position: absolute;
		   	z-index: 2001;
		    top: 15px;
		    right: 20px;
		    color: #f1f1f1;
		    font-size: 30px;
		    font-weight: 200;
		    transition: 0.3s;
		}
		
		
		.close:hover,
		.close:focus {
		    color: #bbb;
		    text-decoration: none;
		    cursor: pointer;
		}
		
		
	
	</style>
	
	
<body>

	<!-- 사진 확대 모달 -->

		<!-- The Modal -->
		<div id="myModal" class="modal fade">
		<!-- The Close Button -->
	  		<button type="button" class="close" data-dismiss="modal"><span class="icon-cross"></span></button>
		  	<div class="modal-content">
			<!-- Modal Content (The Image) -->
				  <img id="myModal-image">
			  </div>
		</div>




	<div id="fh5co-started">
		<div class="container">
			<div class="row animate-box">
				<div class="col-md-12 col-md-offset-0 text-left">
					<div class="col-md-12 col-sm-12 text-left">
						<div class="display-t">
							<div class="display-tc fh5co-heading animate-box " data-animate-effect="fadeInUp">
								<span>Title</span>
								<h1 class="mb30">${ requestScope.journal.journalTitle }</h1>
							</div>
						
						</div>
						
					</div>	
					
					<div class="col-md-12 col-sm-6 text-left journal-icons-block">
							<button class="btn btn-primary journal-icons" id="modifyJournal-btn" onclick="modifyJournal('${ requestScope.journal.journalNo }')"><span class="icon-wrench"></span></button>
							<button class="btn btn-primary journal-icons" id="removeJournal-btn" onclick="removeJournal('${ requestScope.journal.journalNo }')"><span class="icon-bin"></span></button>
					</div>
						
								
			     </div>
			</div>
		</div>
	</div>



	<!-- contents#1 : Journal Contents -->
	<div id="fh5co-testimonial" class="fh5co-bg-section">
		<div class="container">
			<div class="row animate-box row-pb-md">
				<div class="col-md-8 col-md-offset-2 text-left fh5co-heading">
					<span>You Said</span>
					
					<div class="col-md-12 animate-box">
					<div class="testimonial">
					<!-- 내용 뿌려줄 곳 -->
						<blockquote>
							<p class="text-left">&ldquo;
								${ requestScope.journal.journalContents }
							&rdquo;</p>
							<p class="author write-date text-right"><cite> ${ requestScope.journal.journalWriteDate }</cite></p>
						</blockquote>
					</div>
					
			
					<div class="image-sum-slide">
						<!-- 사진 뿌려줄 곳 -->
							<c:forEach items="${ requestScope.journal.imageList }" var="image">
							<c:if test="${image.imageSaveName != null && image.imageSaveName != ''}">
							
								<div>
										<img src="${initParam.rootPath}/images/upload/${ image.imageSaveName }" title="${ image.imageOriginalName }" alt="${ image.imageOriginalName }" class="image">
								</div> 
							</c:if>
							</c:forEach>
							
					</div>
				</div>
				
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