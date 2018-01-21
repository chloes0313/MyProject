<%@ page contentType="text/html;charset=UTF-8"%>
<%@page import="org.apache.jasper.tagplugins.jstl.core.Param"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!-- 인증회원 정보 -->
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
	<script src="${initParam.rootPath}/template/js/bootstrap.min.js?ver=1"></script>
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
	<link rel="stylesheet" href="${initParam.rootPath}/template/css/animate.css?ver=1">
	<!-- Icomoon Icon Fonts-->
	<link rel="stylesheet" href="${initParam.rootPath}/template/css/icomoon.css">
	<!-- Bootstrap  -->
	<link rel="stylesheet" href="${initParam.rootPath}/template/css/bootstrap.css?ver=1">

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
		var upImageIdx = 0;		//업로드 이미지 인덱스
	
		
	
		
		//업로드할 이미지를 화면에 보여주기 위한 처리
		$(document).on("click", "#up-image-btn", function(e){
			//확인
			
			var file = document.getElementById("upImage" + upImageIdx);
			
			
			if(file == null  || file.value.length != 0){
				console.log(file);
				if(file != null){
					console.log(file.value+":"+file.value.length);
				}
				
		
			
			$(".up-image>#up-image-list").append('<div class="col-md-4 col-sm-4 col-xs-6 animate-box" id="up-image-holder">'
					+'<input type="file" class="file" id="upImage'+ (++upImageIdx) +'" name="upImage" onchange="imageViewer(this)">');
			
			}else{
				console.log(file.value.length);	/* 0이 나와야 맞음 */
			}
		
			console.log("id:"+"#upImage"+upImageIdx);
			e.preventDefault();
			$("#upImage"+upImageIdx).click();

			
			$(this).blur();
			
		});
		
	
	});
	

	/* 파일 업로드 확인하기 위한 함ㅅ -> 필요 없게 되었다!!! 다른바법으로 처리
	function initialize(obj){
		document.body.onfocus = checkIt(obj);
	    console.log('initializing');
		
	};
	
	function checkIt(obj){
		console.log(obj);
		alert("obj.value.length :"+obj.value.length);
	    if(obj.value.length > 0) 
	    	alert('Files Loaded');
	    else 
	    	alert('Cancel clicked');
	    document.body.onfocus = null;
	    console.log('checked');
	}; 
	
	*/
	
	// 업로드할 이미지 화면에 뿌려주는 함수
	function imageViewer(obj){
		alert("obj.value:"+obj.value);
		  var file = obj.files[0],
		      reader = new FileReader();
		  reader.onload = function (event) {
		    var img = new Image();
		    img.src = event.target.result;
		    // note: no onload required since we've got the dataurl...I think! :)
		    $("#up-image-list>div:last-child").addClass("fadeInUp animated-fast").append($("<div>").addClass("img-box").append($(img).addClass("image")))
		    			.append('<button type="button" id="drop-image-btn" class=" btn btn-default drop-image-btn"><div class="icon-minus"></div></button>')
		    			.trigger("create");
		  };
		  
		  reader.readAsDataURL(file);
	};
	
	
	
	
	
	//화면이동 함수
	function moveScroll(target) {
		console.log("target:"+target);
		
		var scrollPosition = $(target).offset().top;

		$("html, body").animate({
			scrollTop : scrollPosition - 100
		}, 500);

		$('.fh5co-nav-toggle').removeClass('active').parent().parent()
				.removeClass('overflow offcanvas');

	};
	
	function openJournalDetail(journalNo){
		window.open("${initParam.rootPath}/journal/detail.do?journalNo="+journalNo,
				"JournalDetail", "width=600, height=750");
	}
	
	function openJournalAddForm() {
		window.open("${initParam.rootPath}/journal/add_form.do",
				"JournalAddForm", "width=600, height=800");
	}
	
	function signOut(){
		document.getElementById("signout-form").submit();
	}
	</script>
	</head>
	
	
	
	<style>
	/* 	#fh5co-header .row .form-wrap,
	#fh5co-header .row .display-t {
		margin-top: 10em !important;
	}
	
	
	@media screen and (max-width: 990px) {
		#fh5co-header .row .form-wrap,
		#fh5co-header .row .display-t {
			margin-top: 0 !important;
		}
	} */
	
	

	#journal-form {
		padding: 10px 10px;
		margin: 15px 0 !important; 
		background: rgba(218, 218, 218, 0.5) !important;
		height: auto;
		overflow: hidden;
	 	-webkit-box-shadow: 0px 14px 30px -15px rgba(0, 0, 0, 0.75) !important;
	 	-moz-box-shadow: 0px 14px 30px -15px rgba(0, 0, 0, 0.75) !important;
	  	box-shadow: 0px 14px 30px -15px rgba(0, 0, 0, 0.75) !important;
	}
	
	#journal-btn-wrap {
	 
		height: auto;
		overflow: hidden;
		
	}


	#journal-form .up-image{
		position: relative;
		height: auto;
	}
	
	#journal-form .form-group {
		margin: 20px 0;
	 }
	 
	 
	.drop-image-btn{
		position: absolute;
		right: 7px;
		top: 10px;
	}
	
	
	input#journalTitle,
	textarea#journalContents{
		background: #ffffff;
	}
	
	
	input:focus::-webkit-input-placeholder, 
	textarea:focus::-webkit-input-placeholder {	/* WebKit browsers */ 
	 	color:transparent; 
	}
	
	
	
	#up-image-holder{
		padding: 5px 5px !important;
		position: relative;
	}
	
	
	img.image {
		border: 2px solid rgb(218, 218, 218);
		border-radius: 7px;
		width: 100%; 
		height: 100%;
		object-fit: cover;	/* 비율 그대로 놓고 영역 그대로 여백없이 맞춤(확대/축소) */
		-moz-border-radius: 7px;
		-khtml-border-radius: 7px;
		-webkit-border-radius: 7px;
	}
	
	
	
	input.file{
		display: none;
	}
	
	
	
	#up-image-list{
		border: 2px solid rgb(218, 218, 218);
		border-radius: 7px;
		position: relative;
		overflow:hidden;	/* 컨텐츠에 따라 높이 정해지게 */
		min-height:200px;
		/* height: 700px; */
		background : #fff;
		-moz-border-radius: 7px;
		-khtml-border-radius: 7px;
		-webkit-border-radius: 7px;
		-webkit-position: relative;
		-webkit-transition: 0.5s;
		-o-transition: 0.5s;
  		transition: 0.5s;
		/* bottom: 15px; */
		
	}
	
	
	img#journalIconicImage{
		width:100%;
		height:100%;
		vertical-align: middle;
		object-fit: cover;	/* 비율 그대로 놓고 영역 그대로 여백없이 맞춤(확대/축소) */
		
	}
	
	
	

    

	</style>
	
	
	<style>
		/* 이미지 항상 일정 비율로 !! */
	.img-box{
	position: relative;
    width: 100%;
    }
    
    .img-box:BEFORE{
	    content: "";
    	display: block;
    	padding-top: 100%; /* 1:1 비율 */
    }
    
    .img-box img{
	    position: absolute;
	    top: 0;
	    right: 0;
	    bottom: 0;
	    left: 0;
    }
	
	</style>
	
	<style>
	.error,
	.error>span {
		color: #e0567a !important;
		font-style: italic;
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
						<li><a href="${initParam.rootPath}/index.do">Home</a></li>
						<%--인증된(로그인한) 사용자 메뉴 : 인증 안된상태에서 안보여야 하는 메뉴 --%>
						<sec:authorize access="isAuthenticated()">
						
						<li class="has-dropdown ">
							<a>Habit</a>
							<ul class="dropdown">
								<li><a href="${initParam.rootPath}/habit/main.do">Add Habit</a></li>
								<li><a href="${initParam.rootPath}/habit/main.do">Calendar</a></li>
								<li><a href="${initParam.rootPath}/habit/main.do">List</a></li>
							</ul>
						</li>
						<li class="active"><a href="${initParam.rootPath}/journal/main.do">Journal</a></li>
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
	<header id="fh5co-header" class="fh5co-cover fh5co-cover-sm" role="banner" style="background-image:url(../images/write.jpg);" data-stellar-background-ratio="0.5">
		<div class="overlay"></div>
		<div class="container">
			<div class="row">	
				<div class="col-md-10 text-left">
					<div class="display-t">
						<div class="display-tc animate-box" data-animate-effect="fadeInUp">
							<h1 class="mb30">Journal</h1>
							<p>
								${ doer.name }님이 습관을 만들기 위해 노력한 것들, 순간의 생각과 감정을 기록해보세요. <br>
							</p>
							
							<p>	
								<a id="write-now-btn" class="btn btn-primary" onclick="openJournalAddForm();">Write Now</a>
							</p>
						</div>
					</div>
				</div>
			</div>
		</div>
	</header>
	
	
<form id="signout-form" action="${initParam.rootPath }/logout.do" method="post" style="display:none">
    <sec:csrfInput/>
</form>
	
	
	<!-- 글쓰기를 누르면 나타나는 글쓰기 form -->
	<div id="journal-form-wrap" class="collapse">
	<div id="fh5co-blog">
		<div class="container">
			<div class="row animate-box row-pb-md" data-animate-effect="fadeInUp">
				<div id="add-journal" class="col-md-8 col-md-offset-2 text-left fh5co-heading">
					<span>Write Anything You Want</span>
					<h2>Just Keep Writing</h2>
				</div>
				
				
				<!-- 파일 있을떄 enctype 잊지말기 -->			
				<form action="${ initParam.rootPath }/journal/add.do" id="journal-add-form" enctype="multipart/form-data" method="post">
				<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
					<div class="col-md-8 col-md-offset-2">
						<div class="col-md-12" id="journal-form" >
							<div class="jouranl-title form-group animate-box" data-animate-effect="fadeInUp">
								<h3>Title 
									<span class="error">
										<form:errors path="journal.journalTitle" delimiter="&nbsp;" />
										<c:if test="${ requestScope.errorMsg_journalTitle != null }">
								  				${ requestScope.errorMsg_journalTitle }
							  			</c:if>
							  		</span>
							  	</h3>
								<input type="text" id="journalTitle" name="journalTitle" class="form-control" placeholder="제목을 입력하세요">
							</div>
							
							<div class="journal-contents form-group animate-box" data-animate-effect="fadeInUp">
								<h3>Thoughts &amp; Ideas
									<span class="error">
										<form:errors path="journal.journalContents" delimiter="&nbsp;" />
										<c:if test="${ requestScope.errorMsg_journalContents != null }">
								  				${ requestScope.errorMsg_journalContents }
							  			</c:if>
							  		</span>
								</h3>
								<textarea rows="6" name="journalContents" id="journalContents" class="form-control" placeholder="이곳에 당신의 생각과 감정을 자유롭게 적어보세요" style="resize:none;"></textarea>
							</div>
							
							<div class="up-image form-group animate-box" data-animate-effect="fadeInUp">
								<h3>Image <button type="button" id="up-image-btn" class="btn btn-primary"><div class="icon-plus"></div></button></h3>
									
								<div id="up-image-list">
								<!-- 파일을 추가했을 때 추가된 파일 기록 보여줄 부분 (삭제기능) -->
								</div>
										
							</div>
		
						</div>
						
					
						<div class="col-md-12" id="journal-btn-wrap">
							<div class="col-md-6 col-sm-6 animate-box" data-animate-effect="fadeInUp">
								<button type="submit" id="add-it-btn" class="btn btn-lg btn-primary" style="width:100%">Add It</button>
							</div>
							
							<div class="col-md-6 col-sm-6 animate-box" data-animate-effect="fadeInUp">
								<button type="reset" id="cancel-btn" class="btn btn-lg btn-default" style="width:100%">Cancel</button>
							</div>
						</div>
					
					</div>
			</form>
			
			</div>	
			
			
		</div>
	</div>
	</div>
	
	
	
	
	
	<!-- Journal list -->
	<div id="fh5co-blog" class="fh5co-bg-section" >
		<div class="container">
			<div class="row animate-box row-pb-md" data-animate-effect="fadeInUp">
				<div class="col-md-8 col-md-offset-2 text-left fh5co-heading">
					<span>Thoughts &amp; Ideas</span>
					<h2>Keep Writing</h2>
				</div>
			</div>
			
			
			
			
			<div class="row">
					<c:forEach items="${ requestScope.resultMap.list }" var="journal">
						<div class="col-md-4 col-sm-6 animate-box" data-animate-effect="fadeInUp">
							<div class="fh5co-post">
								<span class="fh5co-date"> <fmt:formatDate value="${ journal.journalWriteDate }" pattern="yyyy-MM-dd"/> </span>
								<h3><a onclick="javascript:openJournalDetail('${ journal.journalNo }')"> ${ journal.journalTitle } </a></h3>
								<div class="img-box" >
								
									<c:choose>
										<c:when test="${ journal.journalIconicImage != null }">
											<img src="${ initParam.rootPath }/images/upload/${ journal.journalIconicImage }" class="img-circle" alt="Here is the JournalIconicImage." id="journalIconicImage"><!-- 대표사진 -->
										</c:when>
										<c:otherwise>
											<img src="${ initParam.rootPath }/images/upload/no_image.png" class="img-circle" alt="Here is the JournalIconicImage." id="journalIconicImage"><!-- 대표사진 -->
										</c:otherwise>
									</c:choose>
								
								
								</div>
								<p class="text-right"><cite>&mdash; By ${ journal.journalWriteId }</cite></p>
							</div>
						</div>
					</c:forEach>
					
			</div>

			
			<!-- Pagination -->
				<div class="col-md-12 text-center">
					<nav aria-label="Page navigation">
					  <ul class="pagination">
					        
					    
					    <c:choose>
					    	<c:when test="${ requestScope.resultMap.pagingBean.totalPage  != 0 }">
					    	
					    		<li>
								    <c:choose>
									    <c:when test="${ requestScope.resultMap.pagingBean.previousPageGroup }">
									    	<a href="${ initParam.rootPath }/journal/main.do?page=${requestScope.resultMap.pagingBean.beginPage -1}" aria-label="Previous">
										        <span aria-hidden="true">&laquo;</span>
										    </a>
									    </c:when>
									    <c:otherwise>
									    	<a href="${ initParam.rootPath }/journal/main.do?page=${requestScope.resultMap.pagingBean.beginPage}" aria-label="Previous">
										        <span aria-hidden="true">&laquo;</span>
										    </a>
									    </c:otherwise>
								    </c:choose>
							    </li>
					    	
					    		<c:forEach begin="${requestScope.resultMap.pagingBean.beginPage}" end="${requestScope.resultMap.pagingBean.endPage}" var="idx">
						   			<li <c:if test='${requestScope.resultMap.pagingBean.page == idx}'> class="active" </c:if>>
								    	<a href="${ initParam.rootPath }/journal/main.do?page=${idx}">${idx}</a>
								    </li>
						    	</c:forEach>
						    
						    
						    	<li>
								    <c:choose>
									    <c:when test="${ requestScope.resultMap.pagingBean.nextPageGroup }">
									    	<a href="${ initParam.rootPath }/journal/main.do?page=${requestScope.resultMap.pagingBean.endPage +1}" aria-label="Next">
										        <span aria-hidden="true">&raquo;</span>
										    </a>
									    </c:when>
									    <c:otherwise>
									    	<a href="${ initParam.rootPath }/journal/main.do?page=${requestScope.resultMap.pagingBean.endPage}" aria-label="Next">
										        <span aria-hidden="true">&raquo;</span>
										    </a>
									    </c:otherwise>
								    </c:choose>
							    </li>
						    
						    
						    
					    	</c:when>
					    	<c:otherwise>
					    		<h2>등록된 기록이 없습니다...TT</h2>
					    		<a href="${ initParam.rootPath }/journal/write_form.do">등록하러 가기</a>
					    	</c:otherwise>
					    </c:choose>
					  
					  </ul>
					</nav>
				</div>
				
		</div>
	</div>

	

	<!-- footer -->
	<footer id="fh5co-footer" role="contentinfo">
		<div class="container">
			<div class="row row-pb-md">
				<div class="col-md-4 fh5co-widget ">
					<h3>Habit Maker.</h3>
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
	
	</div>


	<div class="gototop js-top">
		<a href="#" class="js-gotop"><i class="icon-arrow-up"></i></a>
	</div>
	

	</body>
</html>

