<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<div class="row justify-content-center mx-2">
	<div class="col">
		<h1 class="text-center my-5">주문목록</h1>
		<div id="div_purchase">
			<div id="purchase"></div>
		</div>
		<hr>
		
		<!-- 주문상품출력 -->
		<div id="div_orders" style="display:none">
			<h3>주문상품목록 [<span id="oid"></span>]</h3>
			<div id="orders"></div>
		</div>
	</div>
</div>
<!-- 주문목록템플릿 -->
<script id="temp" type="text/x-handlebars-template">
	<table class="table text-center">
			<thead class="text-center table-light" style="font-weight:bold;">
				<td>No</td>
				<td>주문번호</td>			
				<td>주문자명</td>
				<td>주소</td>
				<td>전화번호</td>
				<td>주문일</td>
				<td></td>
			</thead>
		{{#each .}}
			<tbody class="text-center">
				<td>{{index @index}}</td>
				<td style="color:blue">{{oid}}</td>			
				<td>{{uname}}</a></td>
				<td><div class="ellipsis">{{address}}</div></td>
				<td>{{phone}}</td>
				<td><div class="ellipsis">{{date}}</div></td>
				<td><button class="btn btn-primary btn-sm" oid="{{oid}}">주문상품</button></td>
			</tbody>
		{{/each}}
	</table>
</script>

<!-- 주문상품템플릿 -->
<script id="otemp" type="text/x-handlebars-template">
	<table class="table my-5">			
		{{#each .}}
			<tbody>
				<td>{{index @index}}</td>
				<td>{{code}}</td>			
				<td><img src="/images/books/{{image}}" width="50"/></td>
				<td><div class="ellipsis">{{title}}</div></td>
				<td>{{fmtPrice price 1}}</td>
				<td>{{qnt}}</td>
				<td class="text-end">{{fmtPrice price qnt}}</td>
			</tbody>
		{{/each}}
	</table>
	<table class="table table-striped">
		<tr>
			<td class="text-end">합계: </td>
			<td id="sum" class="text-end"></td>
		</tr>
	</table>
</script>

<script>
	Handlebars.registerHelper("index", function(index) {
	  return index + 1;
	});
	
	Handlebars.registerHelper("fmtPrice", function(price, qnt) {
		let newprice = price * qnt;
		  return newprice.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',')+"원";
	});

</script>


<script>
getList();

 function getList(){
	 $.ajax({
		 type:"get",
		 url:"/purchase.json",
		 data:{uid:"${uid}"},
		 dataType:"json",
		 success:function(data){
			let temp = Handlebars.compile($("#temp").html());
			$("#purchase").html(temp(data));
		 }
	 })
 }
 
 //주문상품 버튼을 클릭한 경우
 $("#purchase").on("click",".btn",function(){
	 $("#div_orders").show();
	 let oid = $(this).attr("oid");
	 $("#oid").html(oid);
	 $.ajax({
		 type:"get",
		 url:"/orders.json",
		 data:{oid:oid},
		 dataType:"json",
		 success:function(data){
			let otemp = Handlebars.compile($("#otemp").html());
			$("#orders").html(otemp(data));
			
			let sum = 0;
			$(data).each(function(){
				let price = this.price;
				let qnt = this.qnt;
				sum += price * qnt;
			})
			$("#sum").html(sum.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',')+"원");
		 }
	 })
 })
 
</script>