<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div class="row justify-content-center mx-2">
	<div class="col">
		<h1 class="text-center my-5">도서관리</h1>
		<div id="div_books">
			<div class="row mb-2">
				<div class="col mt-2">
					<a href="/admin/books/insert" class="pe-3">도서등록</a>
					검색수:<span id="total"></span>건
				</div>
				<div class="col">
					<form name="frmSearch" class="input-group col text-end">				
						<input name="word" class="form-control" placeholder="검색어">
						<button class="btn btn-secondary"><i class="bi bi-search"></i></button>
					</form>
				</div>
			</div>
			<div id="books"></div>
			<ul class="pagination justify-content-center" id="pagination"></ul>
		</div>
	</div>
</div>
<!-- 도서목록출력 템플릿 -->
<script id="temp" type="text/x-handlebars-template">
	<table class="table table-striped">
		{{#each .}}
			<tr class="align-items-center">
				<td style="padding-top:35px;">{{code}}</td>
				<td><img src="{{src image}}" width="50" height="70"></td>				
				<td style="padding-top:35px;"><a href="/admin/books/update?code={{code}}">{{title}}</a></td>
				<td style="padding-top:35px;">{{price}}</td>
				<td style="padding-top:35px;">{{author}}</td>
			</tr>
		{{/each}}
	</table>
</script>		
<script>
	Handlebars.registerHelper("src", function(image){
		if(!image) return "https://via.placeholder.com/170x200";
		else return "/images/books/" + image;
	});
</script>

<script>
	let page=1;
	let size=3;
	let word="";
	getList(page);
	getPagination();
	getTotal("/books.total", {word: word});
	
	$(frmSearch).on("submit", function(e){
		e.preventDefault();
		word=$(frmSearch.word).val();
		page=1;
		getList(page);
		getTotal("/books.total", {word: word});
	});
	
	function getList(page){
		$.ajax({
			type:"get",
			url:"/books.json",
			data:{page:page, size:size, word:word},
			dataType:"json",
			success:function(data){
				let temp=Handlebars.compile($("#temp").html());
				$("#books").html(temp(data));
			}
		});
	}
</script>






