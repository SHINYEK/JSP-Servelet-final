<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>	  
<style>
	
</style>  
<div class="row justify-content-center my-5 mx-2">
	<div class="col">
		<h1 class="text-center my-5">게시글</h1>
		<div class="row">
			<div class="col-md-8">
				<c:if test="${uid != null }">
					<a href="/posts/insert" class="pe-5">글쓰기</a>
				</c:if>
				게시글수: <span id="total"></span>건
			</div>
			<form name="frmSearch" class="input-group col text-end">
				<input name="word" class="form-control" placeholder="검색어">
				<button class="btn btn-secondary"><i class="bi bi-search"></i></button>
			</form>
		</div>
		<hr>
		<div id="div_posts">
			<div id="posts"></div>
			<ul class="pagination justify-content-center" id="pagination"></ul>
		</div>
	</div>
</div>

<!-- 게시글 출력 템플릿 -->
<script id="temp" type="text/x-handlebars-template">
	<table class="table table-striped">
			<tr class="text-center">
				<td>ID.</td>
				<td>제목</td>
				<td>작성자</td>
				<td>작성일</td>
				<td>조회</td>
				<td>댓글</td>
			</tr>
		{{#each .}}
			<tr>
				<td>{{id}}</td>
				<td>
					<a href="/posts/read?id={{id}}"><div class="ellipsis">{{title}}</div></a>
				</td>
				<td>{{uname}}({{writer}})</td>
				<td><div class="ellipsis">{{fmtDate}}</div></td>
				<td>{{viewcnt}}</td>
				<td>{{commentcnt}}</td>
			</tr>
		{{/each}}
	</table>
</script>

<script>
	let page=1;
	let size=5;
	let word="";
	
	getList(page);
	getPagination();
	getTotal('/posts.total', {word: word});
	
	$(frmSearch).on("submit", function(e){
		e.preventDefault();
		word = $(frmSearch.word).val();
		getList(1);
		getTotal('/posts.total', {word: word});
	});
	
	function getList(page){
		$("#load").show();
		$.ajax({
			type:"get",
			url:"/posts.json",
			data:{page:page, size:size, word:word},
			dataType:"json",
			success:function(data){
				let temp=Handlebars.compile($("#temp").html());
				$("#posts").html(temp(data));
				if(data.length==0) $("#div_posts").hide();
				else $("#div_posts").show();
				$("#load").hide();
			}
		});
	}
</script>










