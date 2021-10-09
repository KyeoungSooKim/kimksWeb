<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!doctype html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="Mark Otto, Jacob Thornton, and Bootstrap contributors">
    <meta name="generator" content="Hugo 0.80.0">
    <title>뮤직스쿨 - 비회원 주문내역</title>
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
  </head>
  <body> 
<%@include file="/WEB-INF/views/includes/header.jsp" %>

<div class="container">
	<div class="row">

<h3>주문내역</h3>

  <table class="table table">
  <thead>
    <tr>
      <th scope="col">주문번호</th>
      <th scope="col">주문정보</th>
      <th scope="col">주문일</th>
      <th scope="col">주문금액</th>
      <th scope="col">주문상태</th>
    </tr>
  </thead>
  
  <tbody>
    <tr>
      <td scope="row">${vo.odr_code }</td>
      <td><span class="userOrderDetail" data-odr_code="${vo.odr_code }" style="cursor: pointer;">[상세보기] [${vo.odr_count } 건] </span></td>
      <td><fmt:formatDate value="${vo.odr_date }" pattern="yyyy-MM-dd"/></td>
      <td><fmt:formatNumber maxFractionDigits="3" value="${vo.odr_total_price }"/>원</td>
      <td>${vo.odr_delivery }</td>
    </tr>
  </tbody>
</table>
  </div>        
</div>

<%@include file="/WEB-INF/views/includes/footer.jsp" %>

<script src="https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/3.0.1/handlebars.js"></script>

<script id="userOrderDetailTemplate" type="text/x-handlebars-template">
	{{#each .}}
  <tr class="table-active addOrderDetail">
    <td><a href="/product/get/?pdt_code={{pdt_code}}"><img src="/product/displayFile?fileName={{pdt_img}}"></a></td>
	<td><a href="/product/get/?pdt_code={{pdt_code}}">{{pdt_name}}</a></td>
    <td>수량: {{odr_amount}}</td>
    <td>{{prettifyNumber odr_price}}원</td>
    <td></td>
  </tr>
	{{/each}}
</script>

<script>
 $(function(){

  let cur_tr = "";
  $("table td span.userOrderDetail").on("click", function(){
    let odr_code = $(this).data("odr_code");

    cur_tr = $(this).parent().parent();
    $.ajax({
      url:'/order/userOrderDetailInfo/' + odr_code,
      type:'get',
      success:function(data){
        printData(data, cur_tr, $("#userOrderDetailTemplate"));
      }

    });
  });

  Handlebars.registerHelper("prettifyNumber",function(number){
    let num = number.toLocaleString();
  
    return num;
  });
  
  let printData = function(replyArr, target, templateObj) {
    
    let template = Handlebars.compile(templateObj.html());
    let html = template(replyArr);
    target.siblings(".addOrderDetail").remove(); // 기존 상품후기목록 지우기
    target.after(html);
    
  }

});

</script>
  </body>
</html>