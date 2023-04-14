<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
     <%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>		
<div class="row justify-content-center my-5 mx-2">
	<div class="col-md-10">
		<h1>주문페이지</h1>
		<div id="div_orders">
		<!-- 주문상품 -->
			<table class="table table-striped" id="tbl">
				<c:forEach items="${list}" var="book">
					<tr class="align-items-center book" code="${book.code}" price="${book.price}" qnt="${book.qnt}">
						<td style="padding-top:35px">${book.code}</td>
						<td><img src="/images/books/${book.image}" width="50" height="70"/></td>
						<td style="padding-top:35px">${book.title}</td>
						<td style="padding-top:35px">${book.qnt}</td>
						<td style="padding-top:35px"><fmt:formatNumber value="${book.price}" pattern="#,###원"></fmt:formatNumber></td>
						<td style="padding-top:35px"><fmt:formatNumber value="${book.price*book.qnt}" pattern="#,###원"></fmt:formatNumber></td>
					</tr>
				</c:forEach>
			</table>
			<table class="table table-striped">
				<tr>
					<td>합계</td>
					<td class="text-end"><fmt:formatNumber value="${sum}" pattern="#,###원"></fmt:formatNumber></td>
				</tr>				
			</table>
			<!-- 주문자정보 -->
			<div class="card my-5 text-center px-5">
				<div class="card-title mt-5"><h3>주문자정보</h3></div>
				<div class="card-body">
					<form name="frm" class="px-5">
						<input class="form-control my-2" placeholder="주문자번호" value="${no}" name="oid"/>
						<input class="form-control my-2" placeholder="주문자명" value="${user.uname}"  name="uname"/>
						<input class="form-control my-2" placeholder="배송지" value="${user.address}"  name="address">
						<input class="form-control my-2" placeholder="전화번호" value="${user.phone}"  name="phone"/>
						<button class="btn btn-primary">주문하기</button>
					</form>
				</div>
				
			</div>
		</div>		
	</div>
</div>

<script>


 $(frm).on("submit",function(e){
	 e.preventDefault();
	 $("#confirm").modal("show");
	 $("#confirm .modal-body").html("상품을 주문하시겠습니까?");
	 $("#confirm").on("click","#btn-yes",function(){
		 let uid = "${uid}";
		 let oid = $(frm.oid).val();
		 let uname = $(frm.uname).val();
		 let address = $(frm.address).val();
		 let phone = $(frm.phone).val();
		 //주문정보입력
		 $.ajax({
			 type:"post",
			 url:"/purchase/insert",
			 data:{uid:uid,oid:oid,uname:uname,address:address,phone:phone},
			 success:function(){
				//주문상품입력
				 $("#tbl .book").each(function(){
					let code = $(this).attr("code");
					let price = $(this).attr("price");
					let qnt =  $(this).attr("qnt");
					$.ajax({
						type:"post",
						url:"/orders/insert",
						data:{oid:oid,code:code,price:price,qnt:qnt},
						success:function(){
							//카트삭제
							$.ajax({
								type:"get",
								url:"/carts/delete",
								data:{code:code},
								success:function(){}
							})
						}
					})
				 })
				 location.href="/ordered";
			 }
		 })
	 })
 })
</script>