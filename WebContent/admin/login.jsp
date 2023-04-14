<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<div class="row justify-content-center my-5 mx-2">
	<div class="col-md-5">
		<div class="card px-5 pt-2 pb-4">
			<div class="card-title">
				<h1>로그인(관리자)</h1>
			</div>
			<div class="card-body">
				<form name="frm">
					<input name="uid" value="admin" 
						class="form-control my-2">
					<input name="upass" value="pass" type="password" 
						class="form-control my-2">
					<button class="btn btn-primary w-100 mt-3">로그인</button>
				</form>
			</div>
		</div>
	</div>
</div>
<script>
	$(frm).on("submit", function(e){
		e.preventDefault();
		let uid=$(frm.uid).val();
		let upass=$(frm.upass).val();
		
		$.ajax({
			type:"post",
			url:"/login",
			data:{uid:uid, upass:upass},
			success:function(data){
				if(data==0){
					$("#alert").modal("show");
					$("#alert .modal-body").html("아이디가 존재하지 않습니다!");
				}else if(data==2){
					$("#alert").modal("show");
					$("#alert .modal-body").html("비밀번호가 일치하지 않습니다.");
				}else if(data==1){
					location.href="/admin"
				}
			}
		});
	});
</script>