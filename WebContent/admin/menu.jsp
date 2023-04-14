<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>	
<nav class="navbar navbar-expand-lg bg-light py-2">
	<div class="container-fluid">
		<a class="navbar-brand" href="/admin">LOGO</a>
		<button class="navbar-toggler" type="button" data-bs-toggle="collapse"
			data-bs-target="#navbarSupportedContent"
			aria-controls="navbarSupportedContent" aria-expanded="false"
			aria-label="Toggle navigation">
			<span class="navbar-toggler-icon"></span>
		</button>
		<div class="collapse navbar-collapse" id="navbarSupportedContent">
			<ul class="navbar-nav me-auto mb-2 mb-lg-0">
				<li class="nav-item">
					<a class="nav-link" href="/">Home</a>
				</li>
		
				<c:if test="${uid!=null}">
					<li class="nav-item">
					<a class="nav-link" href="/admin/books">도서관리</a>
					</li>
					<li class="nav-item">
						<a class="nav-link" href="/admin/books/search">도서검색</a>
					</li>								
					<li class="nav-item">
					<a class="nav-link" href="/admin/orders/list">주문목록</a>
					</li>
				</c:if>

				<li class="nav-item">
					<a class="nav-link" href="/posts">게시글</a>
				</li>				
				
			</ul>
			<div class="d-flex">
				<c:if test="${uid == null }">
					<a class="nav-link" href="/admin/login">로그인</a>
				</c:if>
				<c:if test="${uid != null }">					
					<a class="nav-link pe-3" href="/admin/logout">로그아웃</a>
					<a class="nav-link pe-3" href="/admin/mypage">${uname}(${uid})</a>
				</c:if>
			</div>
		</div>
	</div>
</nav>