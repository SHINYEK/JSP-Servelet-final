<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<div class="row justify-content-center my-5 mx-2">
	<div class="col-md-10">
		<h1 class="text-center my-5">글쓰기</h1>
		<form name="frm" method="post">
			<input name="writer" value="${uid}" type="hidden">
			<input name="title" placeholder="제목을 입력하세요."
				class="form-control my-2">
			<textarea name="body" placeholder="내용을 입력하세요."
				rows="10" class="form-control my-2"></textarea>
			<div class="text-center">
				<button type="submit" class="btn btn-primary">등록</button>
				<button type="reset" class="btn btn-secondary">등록취소</button> 
			</div>
		</form>
	</div>
</div>	
<script>
	$(frm).on("submit", function(e){
		e.preventDefault();
		let title=$(frm.title).val();
		if(title==""){
			$("#alert").modal("show");
			$("#alert .modal-body").html("제목을 입력하세요!");
			$("#alert").on("click", ".btn-close", function(){
				$(frm.title).focus();
			});
		}else{
			$("#confirm").modal("show");
			$("#confirm .modal-body").html("게시글을 등록하실래요?");
			$("#confirm").on("click", "#btn-yes", function(){
				frm.submit();
			});
		}
	});
</script>	






