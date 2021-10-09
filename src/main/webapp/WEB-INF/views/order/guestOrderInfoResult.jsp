<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!doctype html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="Mark Otto, Jacob Thornton, and Bootstrap contributors">
    <meta name="generator" content="Hugo 0.80.0">
    <title>뮤직스쿨 - 비회원 주문조회</title>
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

<form action="/order/orderProcess" method="post">
<div class="container">
	<h3>주문완료</h3>
         <h4>주문번호 : <b>${orderCode }</b></h4>
         <p>*위 주문번호로 조회 가능합니다.</p> 
  <%@include file="/WEB-INF/views/includes/footer.jsp" %>
</div>
</form> 
  </body>
</html>