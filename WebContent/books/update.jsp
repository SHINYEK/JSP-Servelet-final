<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>	
<div class="row justify-content-center my-5 mx-2">
	<div class="col-md-10">
		<h1 class="text-center my-5">도서정보수정</h1>
		<div class="card">
			<form name="frm" method="post" class="card-body" enctype="multipart/form-data">
				<input type="hidden" name="old" value="${book.image}">
				<input name="code" value="${book.code}" readonly
					class="form-control my-2">
				<input name="title" value="${book.title}"
					class="form-control my-2" placeholder="도서이름">
				<input name="author" value="${book.author}"
					class="form-control my-2" placeholder="도서저자">
				<input name="price" value="${book.price }"
					class="form-control my-2" placeholder="도서가격">
				<c:if test="${book.image==null}">
					<img id="image" 
						src="http://via.placeholder.com/170x200" class="my-2" width="170">
				</c:if>
				<c:if test="${book.image!=null}">
					<img id="image" 
						src="/images/books/${book.image}" class="my-2" width="170">
				</c:if>			
				<input name="image" 
					type="file" class="form-control" accept="image/*">
				<div class="text-center my-3">	
					<button type="submit" class="btn btn-primary">정보수정</button>
					<button type="reset" class="btn btn-primary">수정취소</button>
				</div>	
			</form>
		</div>
	</div>
</div>		
<script>
	//이미지 미리보기
	$(frm.image).on("change", function(e){
		$("#image").attr("src", URL.createObjectURL(e.target.files[0]));	
	});
	
	$(frm).on("submit", function(e){
		e.preventDefault();
		let title=$(frm.title).val();
		let price=$(frm.price).val();
		let image=$(frm.image).val();
		if(title=="") {
			$("#alert").modal("show");
			$("#alert .modal-body").html("제목을 입력하세요!");
		}else if(price.replace(/[0-9]/g,'')){
			$("#alert").modal("show");
			$("#alert .modal-body").html("가격은 숫자로 입력하세요!");
		}else{
			$("#confirm").modal("show");
			$("#confirm .modal-body").html("도서정보를 수정하실래요?");
			$("#confirm").on("click", "#btn-yes", function(){
				frm.submit();
			});
		}
	});
</script>








