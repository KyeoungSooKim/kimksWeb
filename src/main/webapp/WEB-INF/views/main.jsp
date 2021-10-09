<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ include file="/WEB-INF/views/includes/common.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>뮤직스쿨 - 악기쇼핑몰</title>
<link rel="shortcut icon" href="#">
<script>
let msg = "${msg}";
if(msg == "가입성공"){
	alert("회원가입 되었습니다.");
}else if(msg == "탈퇴성공"){
	alert("탈퇴 되었습니다.");
}
</script>
</head>
<body>
<%@include file="/WEB-INF/views/includes/header.jsp" %>

<div class="container-fluid">
  <div id="carouselExampleIndicators" class="carousel slide" data-ride="carousel">
  <ol class="carousel-indicators">
    <li data-target="#carouselExampleIndicators" data-slide-to="0" class="active"></li>
    <c:forEach items="${banner }" varStatus="i">
    <li data-target="#carouselExampleIndicators" data-slide-to="${i.count }"></li>
    </c:forEach>
  </ol>
  <div class="carousel-inner">
   <div class="carousel-item active">
	      		<img src="/admin/banner/displayOriginalFile?fileName=<c:out value="${firstBanner.bn_img }"/>" class="d-block w-100">
	    	</div>
	<c:forEach items="${banner }" var="vo">
			 <div class="carousel-item">
	      		<img src="/admin/banner/displayOriginalFile?fileName=<c:out value="${vo.bn_img }"/>" class="d-block w-100">
	    	</div>
	</c:forEach>
  </div>
  <a class="carousel-control-prev" href="#carouselExampleIndicators" role="button" data-slide="prev">
    <span class="carousel-control-prev-icon" aria-hidden="true"></span>
    <span class="sr-only">Previous</span>
  </a>
  <a class="carousel-control-next" href="#carouselExampleIndicators" role="button" data-slide="next">
    <span class="carousel-control-next-icon" aria-hidden="true"></span>
    <span class="sr-only">Next</span>
  </a>
</div>

<div class="row">
  <c:forEach items="${cate1 }" var="vo">
    <c:if test="${vo.pdt_buy eq 'Y' }">
    <div class="col-md-3">
          <div class="card mb-3 shadow-sm">
            <title></title>
            <a href="${vo.pdt_code }" class="detail"><img src="/product/displayFile?fileName=<c:out value="${vo.pdt_img }"/>" alt="" ></a>
            <div class="card-body">
              <a href="${vo.pdt_code }" class="detail"><p class="card-text">${vo.pdt_name }</p></a><c:if test="${vo.pdt_amount == 0}"><b style="color: red;">품절</b></c:if>
              <div class="d-flex justify-content-between align-items-center">
                <div class="btn-group">
                  <button type="button" class="btn btn-sm btn-outline-secondary btnOrder" data-pdt-code="${vo.pdt_code }" data-pdt-amount="${vo.pdt_amount }">바로구매</button>
                  <button type="button" class="btn btn-sm btn-outline-secondary btnCartAdd" data-pdt-code="${vo.pdt_code }" data-pdt-amount="${vo.pdt_amount }">장바구니</button>
                </div>
                <span><fmt:formatNumber maxFractionDigits="3" value="${vo.pdt_discount }"/>%</span>
                <small class="text-muted" style="text-decoration: line-through;"><fmt:formatNumber maxFractionDigits="3" value="${vo.pdt_price }"/>원</small>
              </div>
            </div>
            <span style="text-align: right;"><b><fmt:formatNumber maxFractionDigits="3" value="${vo.pdt_price-(vo.pdt_price*vo.pdt_discount/100) }"/>원</b></span>
          </div>
        </div>
      </c:if>
   </c:forEach>
</div>
<div class="row">
  <c:forEach items="${cate2 }" var="vo">
  <c:if test="${vo.pdt_buy eq 'Y' }">
    <div class="col-md-3">
          <div class="card mb-3 shadow-sm">
            <title></title>
            <a href="${vo.pdt_code }" class="detail"><img src="/product/displayFile?fileName=<c:out value="${vo.pdt_img }"/>" alt="" ></a>
            <div class="card-body">
              <a href="${vo.pdt_code }" class="detail"><p class="card-text">${vo.pdt_name }</p></a><c:if test="${vo.pdt_amount == 0}"><b style="color: red;">품절</b></c:if>
              <div class="d-flex justify-content-between align-items-center">
                <div class="btn-group">
                  <button type="button" class="btn btn-sm btn-outline-secondary btnOrder" data-pdt-code="${vo.pdt_code }" data-pdt-amount="${vo.pdt_amount }">바로구매</button>
                  <button type="button" class="btn btn-sm btn-outline-secondary btnCartAdd" data-pdt-code="${vo.pdt_code }" data-pdt-amount="${vo.pdt_amount }">장바구니</button>
                </div>
                <span><fmt:formatNumber maxFractionDigits="3" value="${vo.pdt_discount }"/>%</span>
                <small class="text-muted" style="text-decoration: line-through;"><fmt:formatNumber maxFractionDigits="3" value="${vo.pdt_price }"/>원</small>
              </div>
            </div>
            <span style="text-align: right;"><b><fmt:formatNumber maxFractionDigits="3" value="${vo.pdt_price-(vo.pdt_price*vo.pdt_discount/100) }"/>원</b></span>
          </div>
        </div>
        </c:if>
   </c:forEach>
</div>
<div class="row">
  <c:forEach items="${cate3 }" var="vo">
  <c:if test="${vo.pdt_buy eq 'Y' }">
    <div class="col-md-3">
          <div class="card mb-3 shadow-sm">
            <title></title>
            <a href="${vo.pdt_code }" class="detail"><img src="/product/displayFile?fileName=<c:out value="${vo.pdt_img }"/>" alt="" ></a>
            <div class="card-body">
              <a href="${vo.pdt_code }" class="detail"><p class="card-text">${vo.pdt_name }</p></a><c:if test="${vo.pdt_amount == 0}"><b style="color: red;">품절</b></c:if>
              <div class="d-flex justify-content-between align-items-center">
                <div class="btn-group">
                  <button type="button" class="btn btn-sm btn-outline-secondary btnOrder" data-pdt-code="${vo.pdt_code }" data-pdt-amount="${vo.pdt_amount }">바로구매</button>
                  <button type="button" class="btn btn-sm btn-outline-secondary btnCartAdd" data-pdt-code="${vo.pdt_code }" data-pdt-amount="${vo.pdt_amount }">장바구니</button>
                </div>
                <span><fmt:formatNumber maxFractionDigits="3" value="${vo.pdt_discount }"/>%</span>
                <small class="text-muted" style="text-decoration: line-through;"><fmt:formatNumber maxFractionDigits="3" value="${vo.pdt_price }"/>원</small>
              </div>
            </div>
            <span style="text-align: right;"><b><fmt:formatNumber maxFractionDigits="3" value="${vo.pdt_price-(vo.pdt_price*vo.pdt_discount/100) }"/>원</b></span>
          </div>
        </div>
        </c:if>
   </c:forEach>
</div>
<div class="row">
  <c:forEach items="${cate4 }" var="vo">
  <c:if test="${vo.pdt_buy eq 'Y' }">
    <div class="col-md-3">
          <div class="card mb-3 shadow-sm">
            <title></title>
            <a href="${vo.pdt_code }" class="detail"><img src="/product/displayFile?fileName=<c:out value="${vo.pdt_img }"/>" alt="" ></a>
            <div class="card-body">
              <a href="${vo.pdt_code }" class="detail"><p class="card-text">${vo.pdt_name }</p></a><c:if test="${vo.pdt_amount == 0}"><b style="color: red;">품절</b></c:if>
              <div class="d-flex justify-content-between align-items-center">
                <div class="btn-group">
                  <button type="button" class="btn btn-sm btn-outline-secondary btnOrder" data-pdt-code="${vo.pdt_code }" data-pdt-amount="${vo.pdt_amount }">바로구매</button>
                  <button type="button" class="btn btn-sm btn-outline-secondary btnCartAdd" data-pdt-code="${vo.pdt_code }" data-pdt-amount="${vo.pdt_amount }">장바구니</button>
                </div>
                <span><fmt:formatNumber maxFractionDigits="3" value="${vo.pdt_discount }"/>%</span>
                <small class="text-muted" style="text-decoration: line-through;"><fmt:formatNumber maxFractionDigits="3" value="${vo.pdt_price }"/>원</small>
              </div>
            </div>
            <span style="text-align: right;"><b><fmt:formatNumber maxFractionDigits="3" value="${vo.pdt_price-(vo.pdt_price*vo.pdt_discount/100) }"/>원</b></span>
          </div>
        </div>
        </c:if>
   </c:forEach>
</div>
<div class="row">
  <c:forEach items="${cate5 }" var="vo">
  <c:if test="${vo.pdt_buy eq 'Y' }">
    <div class="col-md-3">
          <div class="card mb-3 shadow-sm">
            <title></title>
            <a href="${vo.pdt_code }" class="detail"><img src="/product/displayFile?fileName=<c:out value="${vo.pdt_img }"/>" alt="" ></a>
            <div class="card-body">
              <a href="${vo.pdt_code }" class="detail"><p class="card-text">${vo.pdt_name }</p></a><c:if test="${vo.pdt_amount == 0}"><b style="color: red;">품절</b></c:if>
              <div class="d-flex justify-content-between align-items-center">
                <div class="btn-group">
                  <button type="button" class="btn btn-sm btn-outline-secondary btnOrder" data-pdt-code="${vo.pdt_code }" data-pdt-amount="${vo.pdt_amount }">바로구매</button>
                  <button type="button" class="btn btn-sm btn-outline-secondary btnCartAdd" data-pdt-code="${vo.pdt_code }" data-pdt-amount="${vo.pdt_amount }">장바구니</button>
                </div>
                <span><fmt:formatNumber maxFractionDigits="3" value="${vo.pdt_discount }"/>%</span>
                <small class="text-muted" style="text-decoration: line-through;"><fmt:formatNumber maxFractionDigits="3" value="${vo.pdt_price }"/>원</small>           
              </div>          
            </div>
               
            <span style="text-align: right;"><b><fmt:formatNumber maxFractionDigits="3" value="${vo.pdt_price-(vo.pdt_price*vo.pdt_discount/100) }"/>원</b></span>
          </div>
        </div>
        </c:if>
   </c:forEach>
</div>

</div>

<%@include file="/WEB-INF/views/includes/footer.jsp" %>
<script>
$(function () {
    
    $("a.detail").on("click", function(e){
        e.preventDefault();
        
        let pdt_code = $(this).attr("href");

		location.href = "/product/get/?pdt_code=" + pdt_code;
      });

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