<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <style>
 	.btn-delete{
		cursor:pointer
	}
 </style>
<div class="row justify-content-center my-5 mx-2">
	<div class="col">
		<h1 class="text-center my-5">장바구니🛒</h1>
		<div id="div_carts"></div>
			<div class="row px-2 mb-1">
				<div class="col">
					<input type="checkbox" id="all"/> 전체선택
				</div>
				<div class="col text-end mb-1">
					<button class="btn btn-dark btn-sm" id="btn-delete">선택상품삭제</button>
				</div>
			</div>
			<div id="carts"></div>
			<div class="text-center">
				<button class="btn btn-warning px-5" id="btn-order">주문하기</button>
				<a href="/"><button class="btn btn-primary px-5">계속쇼핑</button></a>
			</div>
	</div>
</div>
<script id="temp" type="text/x-handlebars-template">
	<table class="table table-striped">
			<tr class="text-center">				
				<td colspan="4">도서명</td>
				<td>판매가</td>
				<td>수량</td>
				<td>합계</td>
				<td>삭제</td>
			</tr>
		{{#each .}}
			<tr class="text-center align-items-center">
				<td style="padding-top:35px"><input type="checkbox" class="chk" index="{{@index}}"/></td>
				<td style="padding-top:35px" class="code">{{code}}</td>
				<td><img src="/images/books/{{image}}" width="50" height="70"/></td>
				<td style="padding-top:35px" class="text-start"><div>{{title}}</div></td>
				<td style="padding-top:35px">{{fmtPrice price}}원</td>
				<td style="padding-top:20px;" width="80"><input value="{{qnt}}" class="form-control text-center qnt"/>
				<button class="btn btn-secondary btn-sm btn-update px-2">수정</button></td>
				<td style="padding-top:35px">{{fmtSum price qnt}}원</td>
				<td style="padding-top:35px"><i class="bi bi-trash3 btn-delete"></i></td>
			</tr>
		{{/each }}
	</table>
		<table class="table table-striped">		
			<tr>
				<td>총 합계 :</td>
				<td id="sum" class="text-end px-5"></td>
			</tr>
		</table>
</script>

<script>
	Handlebars.registerHelper("fmtPrice",function(price){
		return price.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',')
	})
	Handlebars.registerHelper("fmtSum",function(price, qnt){
		let sum = price * qnt
		return sum.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',')
	})
</script>

<script>
getCart();
$("#cartcnt").hide();
//주문하기 버튼
$("#btn-order").on("click",function(){	
	if("${uid}"== ""){ //로그인
		location.href = "/login?target=/carts";
	}else{	
		let chk = $("#carts .chk:checked").length;	
		if(chk==0){
			$("#alert").modal("show");
			$("#alert .modal-body").html("상품을 하나 이상 선택해주세요!")
		}else{
			//주문페이지 이동
			let orders = new Array();
			$("#carts .chk:checked").each(function(){
				let index = $(this).attr("index");
				orders.push(index);
			});
			location.href = "/orders?orders="+orders;
		}
	}
})

//전체 선택 버튼을 클릭한 경우
$("#all").on("click",function(){
	if($(this).is(":checked")){
		$("#carts .chk").each(function(){
			$(this).prop("checked",true)
		})
	}else{
		$("#carts .chk").each(function(){
			$(this).prop("checked",false)
		})	
	}
})

//각 행의 체크박스를 클릭한 경우
$("#carts").on("click",".chk",function(){
	let all = $("#carts .chk").length;
	let chk = $("#carts .chk:checked").length;
	if(all === chk){
		$("#all").prop("checked",true);
	}else{
		$("#all").prop("checked",false);
	}
})


//선택상품삭제 버튼 클릭한 경우
$("#btn-delete").on("click", function(){
	let chk = $("#carts .chk:checked").length;
	if(chk == 0){
		$("#alert").modal("show");
		$("#alert .modal-body").html("삭제할 상품이 존재하지 않습니다.");
	}else{
		$("#carts .chk:checked").each(function(){
			let code = $(this).parent().parent().find(".code").html();
				$.ajax({ 
					type:"get",
					url:"/carts/delete",
					data:{code:code},
					success:function(){
						getCart();
					}
				})			
		
			})
		}	
})

function getCart(){
	$.ajax({
		type:"get",
		url:"/carts.json",
		dataType:"json",
		success:function(data){
			let temp = Handlebars.compile($("#temp").html());
			$("#carts").html(temp(data));
			if(data.length==0){
				$("#div_carts").hide();
			}else{
				$("#div_carts").show();
			}
			//합계구하기
			let sum = 0;
			$(data).each(function(){
				let price = this.price;
				let qnt = this.qnt;
				sum += price * qnt;
			})
			$("#sum").html(sum.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',')+"원");
		}
	})
	
	$("#carts").on("click",".btn-delete",function(){
		let code = $(this).parent().parent().find(".code").html();
		$("#confirm").modal("show");
		$("#confirm .modal-body").html(code+"번 상품을 삭제하시겠습니까?");
		$("#confirm").on("click","#btn-yes",function(){
			$.ajax({
				type:"get",
				url:"/carts/delete",
				data:{code:code},
				success:function(){
					getCart();
				}
			})
		})
	})
	
	$("#carts").on("click",".btn-update",function(){
		let code = $(this).parent().parent().find(".code").html();
		let qnt =  $(this).parent().parent().find(".qnt").val()
		$.ajax({
			type:"get",
			url:"/carts/update",
			data:{code:code,qnt:qnt},
			success:function(){
				getCart();
			}
		})
	})
}
</script>
