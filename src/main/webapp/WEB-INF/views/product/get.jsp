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
    <title>뮤직스쿨 - 상품페이지</title>
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
<script src="https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/3.0.1/handlebars.js"></script>

<script id="reviewListTemplate" type="text/x-handlebars-template">
	<h5>상품 후기</h5>
	{{#each .}}
  <div class="card mt-2">
    <div class="card-header p-2">
      <table>
        <tbody>
        <tr class="align-middle">
          <td class="ml">{{prettifyID u_id}}</td>
        </tr>
        <tr>
          <td>{{checkRating rv_score}}</td>
        </tr>
        <tr>
          <td>
            <font size="2">{{prettifyDate rv_regdate}}</font>         
          </td>
        </tr>
        </tbody>
      </table>
      </div>
      <div class="card-body">
      <p class="card-text">{{rv_content}}</p>
    </div>
  </div>
	{{/each}}
</script>
<script>
	
	
	// 상품후기목록 출력작업
	// replyArr : 댓글데이타를 받을 파라미터, target : 댓글목록이 삽입될 위치, templateObj : 템플릿을 참조할 파라미터
	let printData = function(replyArr, target, templateObj) {
		
		let template = Handlebars.compile(templateObj.html());
		let html = template(replyArr);
		target.empty(); // 기존 상품후기목록 지우기
		target.append(html);
		
	}

 // 페이징 출력작업  pagenation
  let printPaging = function(pageMaker, target){
	let str = "";

	if(pageMaker.prev){
		str += "<li class='page-item'><a class='page-link' href='" + (pageMaker.startPage - 1) + "'>[prev]</a></li>";
	}

	// 1 2 3 4 5
	for(let i=pageMaker.startPage, len = pageMaker.endPage; i <= len; i++){
		let strClass = (pageMaker.cri.pageNum == i) ? 'active' : '';
		//console.log(strClass);

		str += "<li class='page-item " + strClass + "'><a class='page-link' href='" + i + "'>" + i + "</a></li>";
	}

	if(pageMaker.next){
		str += "<li class='page-item'><a class='page-link' href='" + (pageMaker.endPage + 1) + "'>[next]</a></li>";
	}

	target.html(str);
  }
	
	
	// /review/상품코드/1페이지
    let pdt_code = ${productVO.pdt_code }; // 상품코드
	let page = 1;  // 클릭한 댓글 페이지번호
	let pageInfo = "/review/" + pdt_code + "/" + page;
	getPage(pageInfo);

	function getPage(pageInfo){
	  // 댓글정보와페이징정보를 json으로 받아오는 구문
		$.getJSON(pageInfo, function(data){
			//alert(data.list.length);
			printData(data.list, $("#reviewListView"), $("#reviewListTemplate"));
			printPaging(data.pageMaker, $("#pagination"));

			//$("#replyListView").html(txt);

		});	

	}

</script>

<div class="container">
	<div class="row">
  <div class="col-md-12">
      <div class="row g-0 border rounded overflow-hidden flex-md-row mb-4 shadow-sm h-md-250 position-relative">
        <div class="col p-4 d-flex flex-column position-static">
          <strong class="d-inline-block mb-2 text-primary">${productVO.pdt_name }</strong>
          <h3 class="mb-0"><c:if test="${productVO.pdt_amount == 0}"><b style="color: red;">품절</b></c:if></h3>
          <div class="mb-1 text-muted">주문수량: <input type="number" id="cartAmount" min="1" value="1"></div>
          <p class="card-text mb-auto">할인 : <b>${productVO.pdt_discount }%</b></p>
          <p class="card-text mb-auto" style="text-decoration: line-through;">원가 : <fmt:formatNumber maxFractionDigits="3" value="${productVO.pdt_price }"/>원</p>        
          <p class="card-text mb-auto">판매가 : <b><fmt:formatNumber maxFractionDigits="3" value="${productVO.pdt_price-(productVO.pdt_price*productVO.pdt_discount/100) }"/></b>원</p>
          <p class="card-text mb-auto">제조사: ${productVO.pdt_company }</p>
          <p class="card-text mb-auto">남은수량: ${productVO.pdt_amount }</p>
          <button class="btn btn-outline-primary" id="btnOrder">구매</button>
          <button class="btn btn-outline-primary" id="btnCartAdd">담기</button>
        </div>
        <div class="col-auto d-none d-lg-block">
          <img src="/product/displayOriginalFile?fileName=${productVO.pdt_img }" class="bd-placeholder-img" width="200" height="250" alt="" />

        </div>
      </div>
    </div>
  </div>
  <div class="row">
  <div class="col-md-12">
  ${productVO.pdt_detail }
  </div>
  </div>
  <div class="row">
  <div class="col-md-12" id="reviewListView">

  </div>
  </div>
  <div class="row">
    <ul id="pagination" class="pagination">
    </ul>
  </div>
		<form id="actionForm" action="" method="get">
 			<input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum }">
 			<input type="hidden" name="amount" value="${pageMaker.cri.amount }">
 			<input type="hidden" name="type" value="${pageMaker.cri.type }">
 			<input type="hidden" name="keyword" value="${pageMaker.cri.keyword }">
 		</form>
</div> 
<%@include file="/WEB-INF/views/includes/footer.jsp" %>
<script>
  $(function(){
    $("#btnCartAdd").on("click", function(){

      let pdt_code = ${productVO.pdt_code};
      let cart_amount = $("#cartAmount").val();

      if(${productVO.pdt_amount }==0){
        alert("현재 재고가 없는 상품입니다.");
        return;
      }
      $.ajax({
        url:'/cart/cartAdd',
        type:'post',
        dataType:'text',
        data:{pdt_code : pdt_code, cart_amount : cart_amount},
        success: function(data){
          let result = confirm("장바구니에 추가되었습니다.\n 확인하시겠습니까?");
          if(result) {
            location.href = "/cart/list";
          }
        }
      });
    });

    $("#btnOrder").on("click",function(){
      
      let pdt_code = ${productVO.pdt_code};
      let odr_amount = $("#cartAmount").val();
      if(${productVO.pdt_amount }==0){
        alert("현재 재고가 없는 상품입니다.");
        return;
      }
      location.href = "/order/orderInfo?pdt_code=" + pdt_code + "&odr_amount=" + odr_amount;
    });

    $("#pagination").on("click","li a.page-link",function(e){
      e.preventDefault();
      
      // 별 5개를 on 선택자 모두제거(클릭시 on선택자를 무도제거하는 초기화)
      let pdt_code = ${productVO.pdt_code }; // 상품코드
      page = $(this).attr("href");  // 클릭한 댓글 페이지번호
      let pageInfo = "/review/" + pdt_code + "/" + page;
      
      getPage(pageInfo);
    });
  });

  Handlebars.registerHelper("prettifyDate", function(timeValue){
		let dateObj = new Date(timeValue);
		let year = dateObj.getFullYear();
		let month = dateObj.getMonth() + 1;
		let date = dateObj.getDate();

		return year + "/" + month + "/" + date;
	});

  Handlebars.registerHelper("prettifyID", function(u_id){
    let userID = "";
		if(u_id == null){
      userID = "탈퇴한 회원";
    }else{
      userID = u_id;
    }

		return userID;
	});

  Handlebars.registerHelper("checkRating", function(rv_score){
		
    let star = "";
    switch(rv_score){
      case 1:
        star = "★☆☆☆☆"; // ★☆☆☆☆
        break;
      case 2:
        star = "★★☆☆☆";
        break;
      case 3:
        star = "★★★☆☆";
        break;
      case 4:
        star = "★★★★☆";
        break;
      case 5:
        star = "★★★★★";
        break;
    }

    return star;


	});
</script>


  </body>
</html>