<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>	
<style>
	.menu {
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
	<div class="col">
		<h1 class="text-center my-5">게시글정보</h1>
		<c:if test="${post.writer==uid}">
			<div class="text-end">
				<a href="/posts/update?id=${post.id}" class="px-1" id="btn-update">수정</a>
				<a href="/posts/delete" class="px-1" id="btn-delete">삭제</a>
			</div>
		</c:if>

		<div class="card">
			<div class="card-body">
				<h5>[${post.id}] ${post.title}</h5>
				<p>조회수: ${post.viewcnt}</p>
				<hr>
				<p>${post.body}</p>
			</div>
			<div class="card-footer text-muted">
				Posted on ${post.fmtDate} by ${post.uname}(${post.writer})
			</div>
		</div>
		<!-- 로그인 되지 않은경우 -->
		<c:if test="${uid == null}">
			<div class="my-5">
				<a href="/login?target=posts/read?id=${post.id}">
					<button class="btn btn-primary w-100">댓글작성</button>
				</a>
			</div>
		</c:if>
		<!-- 로그인된 경우 -->
		<c:if test="${uid != null}">
			<div class="my-5">
				<form name="frm" class="text-center">
					<textarea name="body" 
						rows="3" class="form-control" placeholder="내용을 입력하세요."></textarea>
					<button class="btn btn-primary px-5 my-3">등록</button>
				</form>
			</div>
		</c:if>
		
		<div id="div_comments">
			<div>댓글수: <span id="total"></span></div>
			<div id="comments"></div>
			<ul class="pagination justify-content-center" id="pagination"></ul>
		</div>
	</div>
</div>
<!-- 댓글목록 템플릿 -->	
<script id="temp" type="text/x-handlebars-template">
	{{#each .}}
		<div class="card my-3">
			<div class="card-title text-end px-3 my-2" style="{{style writer}}">
				<i class="bi bi-three-dots-vertical menu" data-bs-toggle="dropdown" aria-expanded="false"></i>
				<div class="dropdown">
					<ul class="dropdown-menu">
    					<li><a class="dropdown-item btn-update" href="{{id}}">수정</a></li>
    					<li><a class="dropdown-item btn-delete" href="{{id}}">삭제</a></li>
  					</ul>
				</div>
			</div>
			<div class="card-body view" style="cursor:pointer;">
				<p class="body ellipsis">[{{id}}] {{body}}</p>
			</div>
			<div class="card-body edit" style="display:none;">
				<textarea class="form-control body" rows="10">{{body}}</textarea>
				<hr>
				<button class="btn btn-primary btn-sm btn-save" cid="{{id}}">저장</button>
				<button class="btn btn-secondary btn-sm btn-cancel" body="{{body}}">취소</button>
			</div>
			<div class="card-footer text-muted">
				Posted on {{date}} by {{writer}}
				<span class="favoritecnt">{{favoritecnt}}</span>
				<span class="favorite{{favorite}}" cid="{{id}}">{{heart favorite}}</span>
			</div>
		</div>
	{{/each}}
</script>
<script>
	Handlebars.registerHelper("style", function(writer){
		if(writer != "${uid}") return "display:none;"; 
	});
	
	Handlebars.registerHelper("heart", function(favorite){
		if(favorite == 0) return "♡";
		else return "♥";
	});
</script>

<script>
	let page=1;
	let size=3;
	let postid = "${post.id}";
	getList(page);
	getPagination();
	getTotal("/comments.total", {postid:postid});
	
	//댓글 좋아요 추가
	$("#comments").on("click", ".favorite0", function(){
		if("${uid}" == "") {
			location.href="/login?target=/posts/read?id=" + postid;
		}else{
			$.ajax({
				type:"get",
				url:"/comments/favorite/insert",
				data:{uid:"${uid}", id:$(this).attr("cid")},
				success:function(){
					getList(page);
					$("#alert").modal("show");
					$("#alert .modal-body").html("좋아요 추가되었습니다.");
				}
			});
		}	
	});
	
	//댓글 좋아요삭제
	$("#comments").on("click", ".favorite1", function(){
		$.ajax({
			type:"get",
			url:"/comments/favorite/delete",
			data:{uid:"${uid}", id:$(this).attr("cid")},
			success:function(){
				$("#alert").modal("show");
				$("#alert .modal-body").html("좋아요 삭제되었습니다.");
				getList(page);
			}
		});
	});
	
	$("#comments").on("click", "#heading"+${post.id}, function(){
		$(this).hide();	
	});
	
	$("#comments").on("click", ".body", function(){
		$(this).toggleClass('ellipsis');
	});
	
	$("#comments").on("click", ".full", function(){
		$(this).hide();
		$(this).parent().find(".ellipsis").show();
	});
	
	//댓글 삭제버튼을 클릭한 경우
	$("#btn-delete").on("click", function(e){
		e.preventDefault();
		let total=$("#total").html();
		if(total>0){
			$("#alert").modal("show");
			$("#alert .modal-body").html("댓글이 존재하여 삭제할수없습니다.");
		}else {
			$("#confirm").modal("show");
			$("#confirm .modal-body").html(postid + "번 게시글을 삭제하실래요?");
			$("#confirm").on("click", "#btn-yes", function(){
				//게시글삭제
				$.ajax({
					type:"get",
					url:"/posts/delete",
					data:{id:postid},
					success:function(){
						location.href="/posts";
					}
				});
			});
		}
	});
	
	//저장 버튼을 클릭한 경우
	$("#comments").on("click", ".btn-save", function(){
		let id=$(this).attr("cid");
		let body=$(this).parent().find(".body").val();
		$("#confirm").modal("show");
		$("#confirm .modal-body").html(id + "번 댓글을 수정하실래요?");
		$("#confirm").on("click", "#btn-yes", function(){
			$.ajax({
				type:"post",
				url:"/comments/update",
				data:{id:id, body:body},
				success:function(){
					getList(page);
				}
			});
		});
	});
	
	//취소 버튼을 클릭한 경우
	$("#comments").on("click", ".btn-cancel", function(){
		let card = $(this).parent().parent();
		card.find(".edit").hide();
		card.find(".view").show();
		card.find(".card-title").show();
		let body=$(this).attr("body");
		$(this).parent().find(".body").val(body);
	});
	
	//수정 버튼을 클릭한 경우
	$("#comments").on("click", ".btn-update", function(e){
		e.preventDefault();
		let card=$(this).parent().parent().parent().parent().parent();
		card.find(".edit").show();
		card.find(".view").hide();
		card.find(".card-title").hide();
	});
	
	//댓글 삭제 버튼을 클릭한 경우
	$("#comments").on("click", ".btn-delete", function(e){
		e.preventDefault();
		let id=$(this).attr("href");
		$("#confirm").modal("show");
		$("#confirm .modal-body").html(id + "번 댓글을 삭제하실래요?");
		$("#confirm").on("click", "#btn-yes", function(){
			$.ajax({
				type:"post",
				url:"/comments/delete",
				data:{id: id},
				success:function(){
					getList(1);
				}
			});
		});
	});
	
	//댓글등록
	$(frm).on("submit", function(e){
		e.preventDefault();
		let body=$(frm.body).val();
		if(body==""){
			$("#alert").modal("show");
			$("#alert .modal-body").html("댓글 내용을 입력하세요!");
		}else{
			//댓글등록
			$.ajax({
				type:"post",
				url:"/comments/insert",
				data:{postid:postid, body:body, writer:"${uid}"},
				success:function(){
					getList(1);
					getTotal("/comments.total", {postid:postid});
					$(frm.body).val("");
				}
			});
		}
		
	});
	
	function getList(page){
		$.ajax({
			type:"get",
			url:"/comments.json",
			data:{page:page, size:size, postid:postid, uid:"${uid}"},
			dataType:"json",
			success:function(data){
				let temp=Handlebars.compile($("#temp").html());
				$("#comments").html(temp(data));
				
				if(data.length==0) $("#div_comments").hide();
				else $("#div_comments").show();
			}
		});
	}
</script>










