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
    <title>뮤직스쿨 - 장바구니</title>

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
 
})
</script>
  </head>
  <body>
    
<%@include file="/WEB-INF/views/includes/header.jsp" %>

<article class="container">
  <div class="row">
  <table class="table">
  <thead>
    <tr>
      <th scope="col"><input type="checkbox" id="checkAll"></th>
      <th scope="col">상품명</th>
      <th scope="col">수량</th>
      <th scope="col">가격</th>
      <th scope="col">재고</th>
      <th scope="col">비고</th>
    </tr>
  </thead>
  <tbody>
  <c:if test="${empty list }">
  <tr>
      <td colspan="4">장바구니에 담긴 상품이 없습니다</td>
    </tr>
  </c:if>
  <c:if test="${not empty list }">
  <c:forEach items="${list }" var="vo">
    <tr class="cartrow">
    <td><input type="checkbox" class="check" value="${vo.cart_code }" data-pdt-amount="${vo.pdt_amount}"><input type="hidden" name="cart_code" value="${vo.cart_code }"></td>
    
      <th scope="row"><a href="/product/get/?pdt_code=${vo.pdt_code }"><img src="/cart/displayFile?fileName=<c:out value="${vo.pdt_img }"/>" alt="" >${vo.pdt_name }</a></th>
      <td><input type="number" name="cart_amount_${vo.cart_code }" value="${vo.cart_amount }" style="width: 50px;" min="1"></td>
      <td>
        <fmt:formatNumber maxFractionDigits="3" value="${vo.pdt_price-(vo.pdt_price*vo.pdt_discount/100) }"/>원
        <input type="hidden" name="pdt_price_${vo.cart_code }" value="${vo.pdt_price-(vo.pdt_price*vo.pdt_discount/100) }">
      </td>
      <td class="pdtAmount">${vo.pdt_amount}</td>
      <td>
        <input type="button" name="btnEdit" value="수정" data-cart-code="${vo.cart_code }">
        <input type="button" name="btnDel" value="삭제" data-cart-code="${vo.cart_code }"></td>
    </tr>
 </c:forEach>
  </c:if>
  
  </tbody>
</table>
<c:if test="${not empty list }"><p id="totaldiv">총 가격: <span id="total"></span>원</p></c:if>
    
  
</div> 
<c:if test="${not empty list }">
  <div class="row">
    <div class="col-sm-9">
    <button type="button" class="btn btn-primary" id="btnOrder">주문하기</button>
    <button type="button" class="btn btn-primary" id="btnCartDel">비우기</button>
    </div>
    <div class="col-sm-3">
      <button type="button" class="btn btn-primary" id="btnCheckedEdit">선택수정</button>
      <button type="button" class="btn btn-primary" id="btnCheckedDel">선택삭제</button>
    </div>
  </div>
</c:if>
</article>
<%@include file="/WEB-INF/views/includes/footer.jsp" %>
<script>
  $(function(){
    cartTotalPrice();

    $("input[name=btnEdit]").on("click",function(){
      let cart_code = $(this).data("cart-code");
      let cart_amount = $(this).parent().prev().prev().prev().find("input[type=number]").val();
      console.log(cart_code);
      console.log(cart_amount);
      
      $.ajax({
        url:"/cart/edit",
          type:"post",
          dataType:"text", //넘어온데이터
          data:{
            cart_code: cart_code, cart_amount: cart_amount
          },
          success: function(data){
            alert("수량이 변경되었습니다.");
            totalPrice =0;
            cartTotalPrice();
          }         
      });
    });

    let crt;
    $("input[name=btnDel]").on("click",function(){
      crt = $(this).parent().parent();
      let cart_code = $(this).data("cart-code");
    
      console.log(cart_code);
      
      $.ajax({
        url:"/cart/delete",
          type:"post",
          dataType:"text", //넘어온데이터
          data:{
            cart_code: cart_code
          },
          success: function(data){
            alert("삭제되었습니다.");
            crt.remove();
            
            totalPrice = 0;
            cartTotalPrice();

            if($("table tr.cartrow").length == 0 ){
              $("#totaldiv").remove();
              $("#btnCartDel").remove();
              $("#btnOrder").remove();
              $("tbody").append("<td colspan='4'>장바구니에 담긴 상품이 없습니다</td>");
            }
          }         
      });
    });

    $("#checkAll").on("click", function(){
      $(".check").prop("checked", this.checked);
    });
    //개별선택
    $(".check").on("click", function(){
      $("#checkAll").prop("checked", false);
    });

    $("#btnCheckedEdit").on("click", function(){
      if($(".check:checked").length == 0){
        alert("상품을 선택해주세요");
        return;
      }

      let result = confirm("선택한 상품의 수량을 변경하시겠습니까?");
    if(result){
      //선택된 상품코드, 이미지 정보 배열로 저장
      let cart_codeArr = [];
      let cart_amountArr = [];

      //체크된 만큼 반복
      $(".check:checked").each(function(){
        let cart_code = $(this).val();
        let cart_amount = $("input[name=cart_amount_"+ cart_code + "]").val();
        cart_codeArr.push(cart_code);
        cart_amountArr.push(cart_amount);
        
      });
      console.log("cart_code: " + cart_codeArr);
      console.log("cart_amount: " +cart_amountArr);
      
      $.ajax({
        url:"/cart/checkedModify",
        type:"post",
        dataType:"text", //넘어온데이터
        data:{
          cart_codeArr : cart_codeArr,
          cart_amountArr : cart_amountArr
        },
        success: function(data){
          alert("변경되었습니다.");
          totalPrice =0;
          cartTotalPrice();
        }         
      });
    }   
    });

    let checkedTr;
    $("#btnCheckedDel").on("click", function(){
      if($(".check:checked").length == 0){
        alert("상품을 선택해주세요");
        return;
      }

      let result = confirm("선택한 상품을 삭제하시겠습니까?");
    if(result){
      //선택된 상품코드, 이미지 정보 배열로 저장
      let cart_codeArr = [];
      

      //체크된 만큼 반복
      $(".check:checked").each(function(){
        let cart_code = $(this).val();
      
        cart_codeArr.push(cart_code);
        
      });
      console.log("선택상품: " + cart_codeArr);

      $.ajax({
        url:"/cart/deleteChecked",
        type:"post",
        dataType:"text", //넘어온데이터
        data:{
          cart_codeArr : cart_codeArr
        },
        success: function(data){

          alert("선택하신 상품이 삭제되었습니다.");
          $(".check:checked").each(function(){
            checkedTr = $(this).parent().parent();
            checkedTr.remove();
      });
        totalPrice = 0;
        cartTotalPrice();

        if($("table tr.cartrow").length == 0 ){
          $("#totaldiv").remove();
          $("#btnCartDel").remove();
          $("#btnOrder").remove();
          $("#btnCheckedDel").remove();
          $("#btnCheckedEdit").remove();
          $("tbody").append("<td colspan='4'>장바구니에 담긴 상품이 없습니다</td>");
          $("#checkAll").prop("checked", false);
        }
        }         
      });
    }   
    });
    //장바구니 비우기
    $("#btnCartDel").on("click",function(){

      if(confirm("모두 비우겠습니까?")){
        location.href = "/cart/deleteAll";
      }

    });
    //주문하기
    $("#btnOrder").on("click",function(){

      let isAmountZero = false;

      if($(".check:checked").length==0){ //체크된 항목이 없을 경우

        $(".pdtAmount").each(function(){
          
          if($(this).html() == 0){
            alert("재고가 0개인 상품은 주문할 수 없습니다.");
            isAmountZero = true;
          }
        });
        if(isAmountZero == false){
          location.href = "/order/orderCartInfo"; //장바구니 전체 주문 주소
        }
      }else{ //체크된 항목이 있는 경우

        let cart_codeArr = []; //선택된 장바구니 코드들을 담을 배열 생성

        $(".check:checked").each(function(){ //체크된 만큼 반복
          
          if($(this).data("pdt-amount")==0){
            alert("재고가 0개인 상품은 주문할 수 없습니다.");
            isAmountZero = true;
          }
          let cart_code = $(this).val();
          cart_codeArr.push(cart_code); //선택된 장바구니 코드를 배열에 담아 선택주문 주소로 전달
        });
        if(isAmountZero == false){
          location.href = "/order/orderSelectCartInfo?cart_codeArr="+cart_codeArr;
        }
      }
    });

  });
  let totalPrice=0;
  let cartTotalPrice = function() {
    $("input[name=cart_code]").each(function(){
      
      let cart_code = $(this).val();
      let cart_price = $("input[name=pdt_price_"+ cart_code + "]").val();
      let cart_amount = $("input[name=cart_amount_"+ cart_code + "]").val();
      
      let unitPrice = parseInt(cart_price) * parseInt(cart_amount);
      totalPrice += unitPrice;
    });
    console.log(totalPrice);
    $("#total").text(totalPrice.toLocaleString());
  }

</script>
  </body>
</html>