<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<div class="row justify-content-center my-5 mx-2">
	<div class="col-md-10">
		<h1 class="text-center my-5">게시글수정</h1>
		<form name="frm" method="post">
			<input type="hidden" name="id" value="${post.id}">
			<input name="title" 
				class="form-control my-2" value="${post.title}">
			<textarea name="body" 
				rows="10" class="form-control my-2">${post.body}</textarea>
			<div class="text-center">
				<button type="submit" class="btn btn-primary">정보수정</button>
				<button type="reset" class="btn btn-secondary">수정취소</button> 
			</div>
		</form>
	</div>
</div>	
<script>
	let id="${post.id}";
	$(frm).on("submit", function(e){
		e.preventDefault();
		$("#confirm").modal("show");
		$("#confirm .modal-body").html(id + "번 게시글을 수정하실래요?");
		$("#confirm").on("click", "#btn-yes", function(){
			frm.submit();
		});
	});
</script>	






