	//pagination 출력
	function getPagination(){
		$('#pagination').twbsPagination({
		    startPage:1,
		    totalPages:1,
		    visiblePages: 5,
		    first: '<span sris-hidden="true">«</span>',
		    last: '<span sris-hidden="true">»</span>',
		    prev: "&lt;",
		    next: "&gt;",
		    onPageClick: function(event, curPage) {
		    	page = curPage;
		        getList(page);
		    }
	    });
	}
	
	
	function getTotal(url, data){
		$.ajax({
			type:"get",
			url: url,
			data: data,
			success:function(data){
				$("#total").html(data);
				totalPages=Math.ceil(data/size);
				$("#pagination").twbsPagination("changeTotalPages",totalPages,1);
			}
		});
	}