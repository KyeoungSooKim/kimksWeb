<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!doctype html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="Mark Otto, Jacob Thornton, and Bootstrap contributors">
    <meta name="generator" content="Hugo 0.80.0">
    <title>뮤직스쿨 - 검색결과</title>

    <link rel="canonical" href="https://getbootstrap.com/docs/4.6/examples/pricing/">

    

    <!-- Bootstrap core CSS , Jquery-->
<%@ include file="/WEB-INF/views/includes/common.jsp" %>

    <style>
      .bd-placeholder-img {
        font-size: 1.125rem;
        text-anchor: middle;
        -webkit-user-select: none;
        -moz-user-select: none;
        -ms-user-select: none;
        user-select: none;
      }

      @media (min-width: 768px) {
        .bd-placeholder-img-lg {
          font-size: 3.5rem;
        }
      }
    </style>
<script>
$(function () {
 
    let actionForm = $("#actionForm");
    
    $("a.detail").on("click", function(e){
        e.preventDefault();
        
        let pdt_code = $(this).attr("href");
        
        actionForm.append("<input type='hidden' name='pdt_code' value='"+pdt_code+"'>");
		actionForm.attr("action", "/product/get");
		actionForm.submit();
		//location.href = "/product/get/" + pdt_num;
      });
    
    
    
    $(".page-item a").on("click", function(e){
		e.preventDefault();
			
		actionForm.find("input[name='pageNum']").val($(this).attr("href"));
		actionForm.attr("action", "/product/find");
		actionForm.submit();
		
	});
})
</script>
  </head>
  <body>
    
<%@include file="/WEB-INF/views/includes/header.jsp" %>

<div class="container-fluid">
<div class="row">
 <p><b>총 ${total }건</b></p>
</div>
  <div class="row">
  <c:if test="${total == 0}">
  <h2>찾으시는 상품이 없습니다.</h2>
  </c:if>
  <c:if test="${total != 0}">
  <c:forEach items="${list }" var="vo">
    <div class="col-md-3">
          <div class="card mb-3 shadow-sm">
            <title></title>
            <a href="${vo.pdt_code }" class="detail"><img src="/product/displayFile?fileName=<c:out value="${vo.pdt_img }"/>" alt="" ></a>
            <div class="card-body">
              <a href="${vo.pdt_code }" class="detail"><p class="card-text">${vo.pdt_name }</p></a><c:if test="${vo.pdt_amount == 0}"><b style="color: red;">품절</b></c:if>
              <div class="d-flex justify-content-between align-items-center">
                <div class="btn-group">
                  <button type="button" class="btn btn-sm btn-outline-secondary btnOrder" data-pdt-code="${vo.pdt_code } " data-pdt-amount="${vo.pdt_amount }">바로구매</button>
                  <button type="button" class="btn btn-sm btn-outline-secondary btnCartAdd" data-pdt-code="${vo.pdt_code }" data-pdt-amount="${vo.pdt_amount }">장바구니</button>
                </div>
                                <span><fmt:formatNumber maxFractionDigits="3" value="${vo.pdt_discount }"/>%</span>
                <small class="text-muted" style="text-decoration: line-through;"><fmt:formatNumber maxFractionDigits="3" value="${vo.pdt_price }"/>원</small>
              </div>
            </div>
            <span style="text-align: right;"><b><fmt:formatNumber maxFractionDigits="3" value="${vo.pdt_price-(vo.pdt_price*vo.pdt_discount/100) }"/>원</b></span>
          </div>
        </div>
   </c:forEach>
   </c:if>
   </div>
   <div class="row">
    <ul class="pagination">
 					<c:if test="${pageMaker.prev }">
 						<li class="page-item"><a data-pagenum="${pageMaker.startPage -1 }" class="btnPagePrev page-link" href="${pageMaker.startPage -1 }">Previous</a></li>
 					</c:if>
 					<c:forEach var="num" begin="${pageMaker.startPage }" end="${pageMaker.endPage }">
 						<li class="page-item ${pageMaker.cri.pageNum == num? "active" : "" }"><a data-pagenum="${num }" class="btnPageNum page-link" href="${num }">${num }</a></li>
 					</c:forEach>
 					<c:if test="${pageMaker.next }">
 						<li class="page-item"><a class="btnPageNext page-link" href="${pageMaker.endPage + 1 }">Next</a></li>
 					</c:if>
 				</ul>
 			</div>	
  
		<form id="actionForm" action="" method="get">
 			<input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum }">
 			<input type="hidden" name="amount" value="${pageMaker.cri.amount }">
 			<input type="hidden" name="type" value="${pageMaker.cri.type }">
 			<input type="hidden" name="keyword" value="${pageMaker.cri.keyword }">
 		</form>
  <%@include file="/WEB-INF/views/includes/footer.jsp" %>
</div> 
<script>
  $(function(){
    $(".btnCartAdd").on("click", function(){
        
      let pdt_code = $(this).data("pdt-code");
      let cart_amount = 1;

      let pdt_amount = $(this).data("pdt-amount");
      if(pdt_amount == 0){
        alert("현재 재고가 없는 상품입니다.");
        return;
      }
      $.ajax({
        url:"/cart/cartAdd",
          type:"post",
          dataType:"text", //넘어온데이터
          data:{
            pdt_code: pdt_code,
            cart_amount: cart_amount
          },
          success: function(data){
            if(confirm("장바구니에 추가되었습니다\n확인하시겠습니까?")){
              location.href = "/cart/list";
            }
            
          }         
      });
    });
    
    $(".btnOrder").on("click",function(){
      
      let pdt_code = $(this).data("pdt-code");
      let odr_amount = 1;
      let pdt_amount = $(this).data("pdt-amount");
      if(pdt_amount == 0){
        alert("현재 재고가 없는 상품입니다.");
        return;
      }
      location.href = "/order/orderInfo?pdt_code=" + pdt_code + "&odr_amount=" + odr_amount;
     });
  })
</script>
  </body>
</html>