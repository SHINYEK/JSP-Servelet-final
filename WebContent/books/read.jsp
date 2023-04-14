<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>	
<style>
	.dropdown-menu {
		font-size:0.8rem;
	}
	.bi-heart, .bi-heart-fill {
		color:red;
		cursor:pointer;
	}
	
	.favorite0, .favorite1 {
		color: red;
		cursor:pointer;
		float: right;
		font-size:1.5rem;
	}
	
	.favoritecnt{
		float:right;
		font-size: 0.8rem;
	}
</style>
<div class="row justify-content-center my-5 mx-2">
	<div class="col-md-10">
		<h1 class="text-center my-5">도서정보</h1>
		<div class="row">
			<div class="col">
				<c:if test="${book.image==null}">
					<img src="http://via.placeholder.com/170x200" width="80%">
				</c:if>	
				<c:if test="${book.image!=null}">
					<img src="/images/books/${book.image}" width="80%">
				</c:if>			
			</div>
			<div class="col">
				<h5>
					[${book.code}] ${book.title}
					<i class="bi bi-heart" id="check0"></i>
					<i class="bi bi-heart-fill" style="display:none;" id="check1"></i>
					<span id="count" style="font-size:0.8rem">${book.favoritecnt}</span>
				</h5>
				<hr>
				<div class="my-2">저자: ${book.author}</div>
				<div class="my-2">가격: ${book.fmtPrice}</div>
				<div class="my-2">조회수: ${book.viewcnt}</div>
				<div class="my-2">출간일: 2023-01-02</div>
				<div class="my-2">페이지: 300쪽</div>
				<div class="my-2">ISBN: </div>
				<div class="my-2">물류코드:</div>
				<hr>
				<div>
					<button class="btn btn-primary" id="btn-cart" code="${book.code}">장바구니</button>
					<button class="btn btn-warning">바로구매</button>
				</div>
			</div>
		</div>
		<hr>
		<!-- 댓글등록 -->
		<div class="row my-5">
			<div class="col">
				<c:if test="${uid==null}">
					<a href="/login?target=/books/read?code=${book.code}">
						<button class="btn btn-primary w-100">리뷰작성</button>
					</a>
				</c:if>
				<c:if test="${uid!=null}">
					<form name="frm" class="text-center">
						<textarea name="body" rows="5" class="form-control my-2" placeholder="내용입력"></textarea>
						<button class="btn btn-primary px-5">등록</button>
					</form>
				</c:if>
			</div>
		</div>
		<div id="div_reviews">
			<div>리뷰수:<span id="total"></span></div>
			<div id="reviews"></div>
			<ul class="pagination justify-content-center" id="pagination"></ul>
		</div>
	</div>
</div>
<!-- 리뷰목록 템플릿 -->
<script id="temp" type="text/x-handlebars-template">
	{{#each .}}
		<div class="card my-2">
			<div class="card-title" style="{{none writer}}">
				<div class="dropdown text-end my-2 mx-3" style="cursor:pointer;">
    				<i class="bi bi-three-dots-vertical" data-bs-toggle="dropdown"></i>
  					<ul class="dropdown-menu">
    					<li><a class="dropdown-item btn-update" href="#">수정</a></li>
    					<li><a class="dropdown-item btn-delete" href="{{id}}">삭제</a></li>
  					</ul>
				</div>
			</div>	
			<div class="card-body view" style="cursor:pointer">
				<p class="ellipsis body">[{{id}}] {{body}}</p>
			</div>
			<div class="card-body edit" style="display:none;">
				<textarea rows="5" class="form-control body">{{body}}</textarea>
				<button class="btn btn-primary btn-sm mt-2 btn-save" rid="{{id}}">저장</button>
				<button class="btn btn-secondary btn-sm mt-2 btn-cancel">취소</button>
			</div>
			<div class="card-footer text-muted">
				Posted on {{date}} by {{writer}}
				<span class="favoritecnt">{{favoritecnt}}</span>
				<span class="favorite{{favorite}}" rid="{{id}}">{{heart favorite}}</span>
			</div>
		</div>
	{{/each}}
</script>		
<script>
	Handlebars.registerHelper("none", function(writer){
		if (writer != "${uid}") return "display:none";	
	});
	
	Handlebars.registerHelper("heart", function(favorite){
		if(favorite == 0) return "♡";
		else return "♥";
	});
</script>
<script>
	let page=1;
	let size=3;
	let code="${book.code}";
	getFavorite();
	
	getList(page);
	getPagination();
	getTotal("/reviews.total", {code: code});
	
	$("#reviews").on("click", ".body", function(){
		$(this).toggleClass("ellipsis");	
	});
	
	//리뷰 좋아요 추가
	$("#reviews").on("click", ".favorite0", function(){
		if("${uid}" == "") {
			location.href="/login?target=/books/read?code=" + code;
		}else{
			$.ajax({
				type:"get",
				url:"/reviews/favorite/insert",
				data:{uid:"${uid}", id:$(this).attr("rid")},
				success:function(){
					getList(page);
					$("#alert").modal("show");
					$("#alert .modal-body").html("좋아요 추가되었습니다.");
				}
			});
		}	
	});
	
	//장바구니 추가
	$("#btn-cart").on("click",function(){
		let code = $(this).attr("code");
		$.ajax({
			type:"get",
			url:"/carts/insert",
			data:{code:code},
			success:function(){
				$("#confirm").modal("show");
				$("#confirm .modal-body").html("장바구니로 이동하시겠습니까?");
				$("#confirm #btn-yes").html("계속쇼핑");
				$("#confirm #btn-no").html("장바구니")
				
				$("#confirm").on("click","#btn-yes",function(){
					location.href="/";
				})
				
				$("#confirm").on("click","#btn-no",function(){
					location.href="/carts";
				})
			}
		})
	})
	
	//리뷰 좋아요삭제
	$("#reviews").on("click", ".favorite1", function(){
		$.ajax({
			type:"get",
			url:"/review/favorite/delete",
			data:{uid:"${uid}", id:$(this).attr("rid")},
			success:function(){
				$("#alert").modal("show");
				$("#alert .modal-body").html("좋아요 삭제되었습니다.");
				getList(page);
			}
		});
	});
	
	$("#check0").on("click", function(){ //좋아요 등록
		if("${uid}" == ""){
			location.href="/login?target=/books/read?code=" + code;
		}else{
			$.ajax({
				type:"get",
				url:"/books/favorite/insert",
				data:{uid:"${uid}", code:code},
				success:function(){
					getFavorite();
					getFavoriteCount();
					$("#alert").modal("show");
					$("#alert .modal-body").html("좋아요! 추가되었습니다.");
				}
			})
		}	
	});
	
	$("#check1").on("click", function(){ //좋아요삭제
		$.ajax({
			type:"get",
			url:"/books/favorite/delete",
			data:{uid:"${uid}", code:code},
			success:function(){
				getFavorite();
				getFavoriteCount();
				$("#alert").modal("show");
				$("#alert .modal-body").html("좋아요! 삭제되었습니다.")
			}
		})
	});
	
	function getFavoriteCount(){
		$.ajax({
			type:"get",
			url:"/books/favorite/count",
			data:{code:code},
			success:function(data){
				$("#count").html(data);
			}
		});
	}
	
	function getFavorite(){ //좋아요 체크
		$.ajax({
			type:"get",
			url:"/books/favorite",
			data:{uid:"${uid}", code:code},
			success:function(data){
				if(data==0){
					$("#check0").show();
					$("#check1").hide();
				}else if(data==1){
					$("#check0").hide();
					$("#check1").show();
				}
			}
		});
	}
	
	//취소 버튼을 클릭한 경우
	$("#reviews").on("click", ".btn-cancel", function(e){
		let card=$(this).parent().parent();
		card.find(".view").show();
		card.find(".edit").hide();
	});
	
	//저장 버튼을 클릭한 경우
	$("#reviews").on("click", ".btn-save", function(e){
		let id=$(this).attr("rid");
		let body=$(this).parent().find(".body").val();
		$("#confirm").modal("show");
		$("#confirm .modal-body").html(id + "번 리뷰를 수정하실래요?");
		$("#confirm").on("click", "#btn-yes", function(){
			$.ajax({
				type:"post",
				url:"/reviews/update",
				data: {id:id, body:body},
				success:function(){
					getList(page);
				}
			});
		});
	});
	
	//수정 버튼을 클릭한 경우
	$("#reviews").on("click", ".btn-update", function(e){
		e.preventDefault();
		let card=$(this).parent().parent().parent().parent().parent();
		card.find(".view").hide();
		card.find(".edit").show();
	});
	
	//삭제 버튼을 클릭한 경우
	$("#reviews").on("click", ".btn-delete", function(e){
		e.preventDefault();
		let id=$(this).attr("href");
		$("#confirm").modal("show");
		$("#confirm .modal-body").html(id + "번 리뷰를 삭제하실래요?");
		$("#confirm").on("click", "#btn-yes", function(){
			$.ajax({
				type:"post",
				url:"/reviews/delete",
				data: {id:id},
				success:function(){
					getList(1);
					getTotal("/reviews.total", {code: code});
				}
			});
		});
	});
	
	//리뷰등록
	$(frm).on("submit", function(e){
		e.preventDefault();
		let body=$(frm.body).val();
		if(body==""){
			$("#alert").modal("show");
			$("#alert .modal-body").html("리뷰 내용을 입력하세요!")
		}else{
			$.ajax({
				type:"post",
				url:"/reviews/insert",
				data:{code:code, body:body, writer:"${uid}"},
				success:function(){
					getList(1);
					getTotal("/reviews.total", {code: code});
					$(frm.body).val("");
				}
			});
		}
	});
	
	function getList(page){
		$.ajax({
			type:"get",
			url:"/reviews.json",
			data:{page:page, size:size, code:code, uid:"${uid}"},
			dataType:"json",
			success:function(data){
				let temp=Handlebars.compile($("#temp").html());
				$("#reviews").html(temp(data));
				
				if(data.length==0) $("#div_reviews").hide();
				else $("#div_reviews").show();
			}
		});
	}
</script>



