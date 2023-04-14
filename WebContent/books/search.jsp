<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<div class="row justify-content-center my-5 mx-2">
	<div class="col-md-10">
		<h1 class="text-center my-5">도서검색</h1>
		<div id="div_books" class="row">
			<div class="col-md-3">
				<form name="frm" class="input-group input-group-sm mb-3">
	  				<input name="query" value="리액트" type="text" class="form-control" aria-label="Sizing example input" aria-describedby="inputGroup-sizing-sm">
	  				<button class="input-group-text" id="inputGroup-sizing-sm"><i class="bi bi-search"></i></button>
				</form>
			</div>
			<div class="col">
				검색수: <span id="total">0</span>건
			</div>
		</div>	
		<div id="books" class="row"></div>
		<div class="text-center my-3">
			<button id="prev" class="btn btn-success">이전</button>
			<span id="page">1</span>
			<button id="next" class="btn btn-success">다음</button>
		</div>
	</div>
</div>

<!-- 도서목록 템플릿 -->
<script id="temp" type="text/x-handlebars-template">
	{{#each documents}}
		<div class="col-md-3 col-6">
			<div class="card p-2 m-2">
				<div class="card-body">
					<div><img src="{{image thumbnail}}" with="100%"></div>
					<div class="ellipsis">{{title}}</div>
					<div>{{price}}</div>
					<div class="ellipsis">{{authors}}</div>
					<!-- Button trigger modal -->
					<button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#book{{@index}}">
  						보기
					</button>
					<!-- Modal -->
					<div class="modal fade" id="book{{@index}}" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
  						<div class="modal-dialog">
    						<div class="modal-content">
      							<div class="modal-body">
									<div class="row">
										<div class="col-md-4">
											<img class="image" src={{image thumbnail}}>
										</div>
										<div class="col">
											<h6 class="title">{{title}}</h6>
											<div class="price">{{price}}</div>
											<div class="author">{{authors}}</div>
											<div>출판사: {{publisher}}</div>
										</div>
        							</div>
									<hr>
									<div class="row p-2" style="font-size:0.8rem;">
										{{contents}}
        							</div>
      							</div>
      							<div class="modal-footer">
        							<button type="button" class="btn btn-primary btn-save" data-bs-dismiss="modal">Save</button>
									<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
      							</div>
    						</div>
  						</div>
					</div>
				</div>
			</div>
		</div>
	{{/each}}
</script>
<script>
	Handlebars.registerHelper("image", function(image){
		if(!image) return "http://via.placeholder.com/120x170";
		else return image;
	});
	
</script>
<script>
	let page=1;
	let query=$(frm.query).val();
	let size=8;
	let is_end = false;
	getList();
	
	//다음버튼을 클릭한 경우
	$("#next").on("click", function(){
		page++;
		getList();
	});
	
	//이전버튼을 클릭한 경우
	$("#prev").on("click", function(){
		page--;
		getList();
	});
	
	$(frm).on("submit", function(e){
		e.preventDefault();
		query=$(frm.query).val();
		page=1;
		getList();
	});
	
	//save버튼을 클릭한 경우
	$("#books").on("click",".btn-save",function(){
		var book = $(this).parent().parent();
		let title = book.find(".title").html();
		let price = book.find(".price").html();
		let author = book.find(".author").html();
		let image = book.find(".image").attr("src");
		
			//상품저장하기
			$.ajax({
				type:"get",
				url:"/admin/books/save",
				data:{url:image, title:title, price:price, author:author},
				success:function(){
					alert("성공!");
				}
			})		
	})
	
	function getList(){
		$.ajax({
			type:"get",
			url:"https://dapi.kakao.com/v3/search/book?target=title",
			headers:{"Authorization": "KakaoAK b80880fbde422de3fd9b4a4e67c9bb54"},
			data:{query:query, page:page, size:size},
			dataType:"json",
			success:function(data){
				let temp=Handlebars.compile($("#temp").html());
				$("#books").html(temp(data));
				$("#total").html(data.meta.pageable_count);
				$("#page").html(page);
				is_end = data.meta.is_end;
				
				if(page==1) $("#prev").attr("disabled", true);
				else $("#prev").attr("disabled", false);
				
				if(is_end) $("#next").attr("disabled", true);
				else $("#next").attr("disabled", false);
			}
		});
	}
</script>


