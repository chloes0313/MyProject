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
	
		
		$(document).on("click", ".image", function(){
			modalImage(this);
			
		});
		
		$(document).on("click", "#cancel-btn", function(){
			if(confirm("수정을 취소하겠습니까?") == true){
			window.location.href="${ initParam.rootPath }/journal/detail.do?journalNo="+${requestScope.journal.journalNo};
			}else{
				$(this).blur();
				return false;
			}
			
		});
		
		
		
	
		
	});
	
	
	
	
	function modalImage(target){
		
		$("#myModal").modal({
			backdrop: "static"	/* Note: You cannot click outside of this modal to close it. */
		
		});
		
		
		$("#myModal-image").attr({"src": target.src, "alt":target.alt, "title":target.alt});
		console.log(target.src);
	}
	
	
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
		    			.append('<button type="button" id="drop-image-btn" class=" btn btn-default drop-image-btn" onclick="cancelImage(this);"><div class="icon-minus"></div></button>')
		    			.trigger("create");
		  };
		  
		  
		  reader.readAsDataURL(file);
	};	//end of imageViewer
	
	function cancelImage(target){
		console.log($(target).parent());
		/* $("#drop-image-list").append($(target).parent()); */
		$(target).parent().remove();
	}
	
	

	
	
	function dropImageList(target){
		console.log($(target).parent());
		var dropImage = $(target).parent().children().children("img").attr("alt");
		$("form#journal-modify-form").append('<input type="hidden" name="dropImage" value="'+dropImage+'">');
		/* $("#drop-image-list").append($(target).parent()); */
		$(target).parent().remove();
	}
	
	
	
	</script>
	</head>
	

	<style>
	.error,
	.error>span {
		color: #e0567a !important;
		font-style: italic;
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
	
	<style>

	
	#journal-btn-wrap {
	 
		height: auto;
		overflow: hidden;
		
	}


	.up-image{
		position: relative;
		height: auto;
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


	<form id="journal-modify-form" action="${ initParam.rootPath }/journal/modify.do" enctype="multipart/form-data" method="post">
	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
	<input type="hidden" name="journalNo" value="${requestScope.journal.journalNo}">
	<input type="hidden" name="journalIconicImage" value="${requestScope.journal.journalIconicImage}">
	
	
	<div id="fh5co-started">
		<div class="container">
			<div class="row animate-box">
				<div class="col-md-12 col-md-offset-0 text-left">
					<div class="col-md-12 col-sm-12 text-left">
						<div class="display-t">
							<div class="display-tc fh5co-heading animate-box " data-animate-effect="fadeInUp">
								<span>Title</span>
								<span class="error">
									<form:errors path="journal.journalTitle" delimiter="&nbsp;"  />
									<c:if test="${ requestScope.errorMsg_journalTitle != null }">
							  				${ requestScope.errorMsg_journalTitle }
						  			</c:if>
						  		</span>
						  		
								
								<h1 class="mb30">
								<input type="text" id="journalTitle" name="journalTitle" class="form-control" value="${ requestScope.journal.journalTitle }" >
								</h1>
							</div>
							
						</div>
						
					</div>	
								
			     </div>
			</div>
		</div>
	</div>
	
	
	
	<div id="journal-form-wrap">
	<div id="fh5co-blog" class="fh5co-bg-section">
		<div class="container">
			<div class="row animate-box row-pb-md" data-animate-effect="fadeInUp">
				<div id="add-journal" class="col-md-8 col-md-offset-2 text-left fh5co-heading">
							<div class="journal-contents form-group animate-box" data-animate-effect="fadeInUp">
								<span>Thoughts &amp; Ideas</span>
								<span class="error">
									<form:errors path="journal.journalContents" delimiter="&nbsp;" />
									<c:if test="${ requestScope.errorMsg_journalContents != null }">
							  				${ requestScope.errorMsg_journalContents }
						  			</c:if>
						  		</span>
								<textarea rows="6" name="journalContents" id="journalContents" class="form-control" style="resize:none;" >${ requestScope.journal.journalContents }</textarea>
							</div>
							
							
							<div class="up-image form-group animate-box" data-animate-effect="fadeInUp">
								<span>Image <button type="button" id="up-image-btn" class="btn btn-primary"><div class="icon-plus"></div></button></span>
									
								<div id="up-image-list">
									
									<c:forEach items="${ requestScope.journal.imageList }" var="image">
									<c:if test="${image.imageSaveName != null && image.imageSaveName != ''}">
										<div class="col-md-4 col-sm-4 col-xs-6 animate-box" id="up-image-holder">
											<div class="img-box">
												<img src="${ initParam.rootPath }/images/upload/${ image.imageSaveName }" alt="${ image.imageSaveName }" class="image">
											</div>
											<button type="button" id="drop-image-btn" class=" btn btn-default drop-image-btn" onclick="dropImageList(this);"><div class="icon-minus"></div></button>
											
										</div>
									</c:if>
									</c:forEach>
									
								</div>
							</div>
			
						<div class="col-md-12" id="journal-btn-wrap">
							<div class="col-md-6 col-sm-6 animate-box" data-animate-effect="fadeInUp">
								<button type="submit" id="modify-btn" class="btn btn-lg btn-primary" style="width:100%">Modify</button>
							</div>
							<div class="col-md-6 col-sm-6 animate-box" data-animate-effect="fadeInUp">
								<button type="reset" id="cancel-btn" class="btn btn-lg btn-default" style="width:100%">Cancel</button>
							</div>
						</div>
					
					
			
				</div>
			</div>	
			
			</div>
		</div>
	</div>
	</form>


	<div id="drop-image-list">
									
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
</html>