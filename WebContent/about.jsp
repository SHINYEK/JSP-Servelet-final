<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<style>
	.card-footer {
		font-size:0.8rem;
	}
	.bi-heart-fill {
		position: absolute;
		right:10px;
		color:pink;
		font-size: 1.5rem;
	}
	
</style>
<div class="row justify-content-center my-5 mx-2">
	<div class="col-md-10">
		<div id="div_books">
			<div class="row mb-2">
				<div class="col mt-2">
					검색수:<span id="total"></span>건
				</div>
				<div class="col">
					<form name="frmSearch" class="input-group col text-end">				
						<input name="word" class="form-control" placeholder="검색어">
						<button class="btn btn-secondary"><i class="bi bi-search"></i></button>
					</form>
				</div>
			</div>
			<hr>
			<div id="books"></div>
			<ul class="pagination justify-content-center my-3" id="pagination"></ul>
		</div>
	</div>
</div>
<!-- 도서목록출력 템플릿 -->
<script id="temp" type="text/x-handlebars-template">
	<div class="row">
		{{#each .}}
			<div class="col-md-3 col-6 my-3">
				<div class="card">
					<div class="card-body">
						<a href="/books/read?code={{code}}">
							<img src="{{src image}}" width="80%">
						</a>
						<i class="bi bi-heart-fill">{{favoritecnt}}</i>
						<hr>
						<div class="ellipsis">{{title}}</div>
						<div>{{fmtPrice}}</div>
					</div>
					<div class="card-footer text-muted">
						조회수:{{viewcnt}}
						리뷰수:{{reviewcnt}}
						
					</div>
				</div>
			</div>
		{{/each}}
	</div>
</script>
<script>
	Handlebars.registerHelper("src", function(image){
		if(!image) return "https://via.placeholder.com/170x200";
		else return "/images/books/" + image;
	});
</script>
<script>
	let page=1;
	let size=4;
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



