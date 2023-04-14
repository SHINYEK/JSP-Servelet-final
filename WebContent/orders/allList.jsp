<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<div class="row justify-content-center my-5 mx-2">
   <div class="col">
      <h1 class="text-center my-5">주문목록(관리자)</h1>
      <div id="div_purchase" class="row">
         <div class="col-md-3">
            <form name="frm" class="input-group input-group-sm mb-3">
                 <input name="query" value="" type="text" class="form-control" aria-label="Sizing example input" aria-describedby="inputGroup-sizing-sm">
                 <button class="input-group-text" id="inputGroup-sizing-sm"><i class="bi bi-search"></i></button>
            </form>
         </div>
         <div id="purchase" class="row"></div>
      </div>
   </div>
   <!-- Modal -->
   <div class="modal fade" id="div_orders" data-bs-backdrop="static" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-lg">
             <div class="modal-content">
               <div class="modal-header">
                 <p class="modal-title fs-5" id="oid"></p>
                   <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
               </div>
               <div class="modal-body">
               <div id="orders"></div>
               </div>
               <div class="modal-footer">
                 <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">확인</button>
               </div>
          </div>
        </div>
   </div>
</div>
<!-- 주문목록 템플릿 -->   
<script id="temp" type="text/x-handlebars-template">
   <table class="table table-striped">
   {{#each .}}
      <tr>
         <td>{{index @index}}</td>
         <td>{{oid}}</td>
         <td width="80">{{uname}}</td>
         <td><div class="ellipsis">{{address}}</div></td>
         <td><div class="ellipsis">{{phone}}</div></td>
         <td><div class="ellipsis">{{date}}</div></td>
         <td><button class="btn btn-primary btn-sm" oid="{{oid}}">상품</td>
      </tr>
   {{/each}}
   </table>
</script>   

<!-- 주문상품목록 템플릿 -->
<script id="otemp" type="text/x-handlebars-template">
   <table class="table table-striped">
   {{#each .}}
      <tr>
         <td>{{index @index}}</td>
         <td>{{code}}</td>
         <td><img src="/images/books/{{image}}" width="50"></td>
         <td><div class="ellipsis">{{title}}</div></td>
         <td><div class="ellipsis">{{fmtPrice price 1}}</div></td>
         <td><div class="ellipsis">{{qnt}}</div></td>
         <td><div class="ellipsis text-end">{{fmtPrice price qnt}}</div></td>
      </tr>
   {{/each}}
   </table>
   <table class="table table-striped">
      <tr>
         <td class="text-center">합계</td>
         <td id="sum" class="text-end"></td>
      </tr>
   </table>
</script>

<script>
   Handlebars.registerHelper("index", function(index){
      return index + 1;
   });
   
   Handlebars.registerHelper("fmtPrice", function(price, qnt){
      let newprice=price * qnt;
      return newprice.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',') + "원";
   });
</script>   
<script>
   getOrders();
   $(frm).on("submit", function(e){
      e.preventDefault();
      getOrders();
   });
   
   //주문상품버튼을 클릭한 경우
   $("#purchase").on("click", ".btn", function(){
      let oid=$(this).attr("oid");
      $("#div_orders").modal("show");   
      $("#oid").html(oid);
      $.ajax({
         type:"get",
         url:"/orders.json",
         data:{oid: oid},
         dataType:"json",
         success:function(data){
            let temp=Handlebars.compile($("#otemp").html());
            $("#orders").html(temp(data));
            let sum=0;
            $(data).each(function(){
               let price=this.price;
               let qnt=this.qnt;
               sum += price * qnt;
            });
            $("#sum").html(sum.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',') + "원")
         }
      });
   });
   
   function getOrders(){
      let word=$(frm.query).val();
      $.ajax({
         type:"get",
         url:"/orders/all.json",
         data:{word: word},
         dataType:"json",
         success:function(data){
            let temp=Handlebars.compile($("#temp").html());
            $("#purchase").html(temp(data));
         }
      });
   }
</script>   