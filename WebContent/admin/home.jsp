<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<script src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/3.0.1/handlebars.js"></script>
	<!-- CSS only -->
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">
	<!-- JavaScript Bundle with Popper -->
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4" crossorigin="anonymous"></script>
	<link rel="stylesheet" href="/css/home.css"/>
	<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/twbs-pagination/1.4.2/jquery.twbsPagination.min.js"></script>
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.3/font/bootstrap-icons.css">
	<meta charset="UTF-8">
	<script src="/js/pagination.js"></script>
	<title>쇼핑몰</title>
</head>
<body>
	<div class="div_page">
		<div class="div_header">
			<img src="https://contents.kyobobook.co.kr/pmtn/2023/banner/230321/i_1624_450_01.jpg" width="100%"/>
			<jsp:include page="/admin/menu.jsp"/>
		</div>
		<div class="div_content container">
			<jsp:include page="${pageName}"/>
		</div>
		<div class="div_footer">
			<h5>Copyright 2023 인천일보아카데미 All right reserved.</h5>
		</div>
		
		<div id="load" style="display:none">
    		<img src="/image/loading.gif">
		</div>
	</div>
	<jsp:include page="/modal.jsp"/> 
</body>
</html>