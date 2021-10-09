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
    <title>뮤직스쿨 - 주문내역</title>
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
      /* 상품후기 별평점 스타일이 적용됨 */
    #star_grade_modal a {
    	font-size: 22px;
    	text-decoration: none;
    	color: lightgray;
    }    
    /* 클릭 이벤트설정에 의하여 적용 */
    #star_grade_modal a.on {
    	color: rgb(212, 183, 17);
    } 
    </style>
  </head>
  <body> 
<%@include file="/WEB-INF/views/includes/header.jsp" %>

<form action="/order/orderProcess" method="post">
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
  <c:forEach items="${list }" var="vo">
    <tr id="tr_${vo.odr_code }">
      <td scope="row">${vo.odr_code }</td>
      <td><span class="userOrderDetail" data-odr_code="${vo.odr_code }" style="cursor: pointer;">[상세보기] [${vo.odr_count } 건] </span></td>
      <td><fmt:formatDate value="${vo.odr_date }" pattern="yyyy-MM-dd"/></td>
      <td><fmt:formatNumber maxFractionDigits="3" value="${vo.odr_total_price }"/>원</td>
      <td>${vo.odr_delivery }</td>
    </tr>
   </c:forEach>
  </tbody>
</table>
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
</div>
</form> 
<%@include file="/WEB-INF/views/includes/footer.jsp" %>

<script src="https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/3.0.1/handlebars.js"></script>

<script id="userOrderDetailTemplate" type="text/x-handlebars-template">
	{{#each .}}
  <tr class="table-active addOrderDetail">
    <td><a href="/product/get/?pdt_code={{pdt_code}}"><img src="/product/displayFile?fileName={{pdt_img}}"></a></td>
	<td><a href="/product/get/?pdt_code={{pdt_code}}">{{pdt_name}}</a></td>
    <td>수량: {{odr_amount}}</td>
    <td>{{prettifyNumber odr_price}}원</td>
    <td><a class="writeReview" data-odr-code="{{odr_code}}" data-pdt-code="{{pdt_code}}" data-pdt-name="{{pdt_name}}" style="cursor: pointer;">{{prettifyReview rv_check}}</a></td>
  </tr>
	{{/each}}
</script>

<script>
 $(function(){

  $("table td span.userOrderDetail").on("click", function(){
    let odr_code = $(this).data("odr_code");

    $.ajax({
      url:'/order/userOrderDetailInfo/' + odr_code,
      type:'get',
      success:function(data){
        printData(data, $("#tr_"+odr_code), $("#userOrderDetailTemplate"));
        $(".writeReview").each(function(){
          console.log($(".writeReview").html());
          if($(this).html() == "후기작성완료"){
            $(this).contents().unwrap(); //a태그 제거
          }
        });
      }
    });
  });

  var scoreState = function(){
    let point = 0;

    $("#star_grade_modal a").each(function(){

      if($(this).attr('class') == 'on'){
        point += 1;
       
      }
    });

    $("#rv_score").val(point); // 모달대화상자의 평점점수 hidden태그에 값을 할당
  }

  $("#star_grade_modal a").on("click" ,function(e){
  
    e.preventDefault();
    // 별 5개를 on 선택자 모두제거(클릭시 on선택자를 무도제거하는 초기화)
    $(this).parent().children("a").removeClass("on");
    $(this).addClass("on").prevAll("a").addClass("on");
  
    scoreState();
  })
  
  $("tbody").on("click","tr.addOrderDetail a.writeReview", function(e){
    e.preventDefault();
    $("#reviewModal").modal('show');
    let odr_code = $(this).data("odr-code");
    let pdt_name = $(this).data("pdt-name");
    let pdt_code = $(this).data("pdt-code");
    $("#rv_odr_code").val(odr_code);
    $(".col-form-label").html(pdt_name);
    $("#rv_pdt_code").val(pdt_code);
  });

  $("#btnReviewSave").on("click", function(){
    
    let odr_code = $("#rv_odr_code").val();
    let rv_score = $("#rv_score").val();
    let rv_content = $("#rv_content").val();
    let pdt_code = $("#rv_pdt_code").val();
  
    if(rv_score == 0){
      alert("별점을 선택해주세요.");
      return;
    }else if(rv_content == ""){
      alert("상품후기를 입력해주세요.");
      return;
    }
  
    

    $.ajax({
      url :'/review/write',
      type:'post',
      dataType:'text',
      data : {rv_score : rv_score, rv_content : rv_content, pdt_code : pdt_code, odr_code : odr_code},
      success: function(data){
    
          $("#reviewModal").modal("hide");
          $("#star_grade_modal a").removeClass("on");
          $("#rv_score").val("0");
          $("#rv_content").val("");
          alert("상품후기가 등록되었습니다.");
          printData(data, $("#tr_"+odr_code), $("#userOrderDetailTemplate"));
          $(".writeReview").each(function(){
            console.log("g");
            if($(this).html() == "후기작성완료"){
              $(this).contents().unwrap(); //a태그 제거
            }
          });
      }
    });
  
  });
  
  Handlebars.registerHelper("prettifyNumber",function(number){
    let num = number.toLocaleString();
  
    return num;
  });

  Handlebars.registerHelper("prettifyReview",function(rv_check){
    let reviewLink = "";
    if(rv_check == 'N'){
      reviewLink = "후기작성";
    }else{
      reviewLink = "후기작성완료";
    }
  
    return reviewLink;
  });
  
   let printData = function(replyArr, target, templateObj) {
     
    let template = Handlebars.compile(templateObj.html());
    let html = template(replyArr);
    target.siblings(".addOrderDetail").remove(); // 기존 상품후기목록 지우기
    target.after(html);
    
  }

  $(".page-item a").on("click", function(e){
		e.preventDefault();
		let pageNum = $(this).attr("href");
		location.href = "/order/userOrderInfo/" + pageNum;
	});

  
  
  
 });

</script>

<div class="modal fade" id="reviewModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="modalMethod">상품후기작성</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
        <form>
          <div class="form-group">
            <label for="replytext" class="col-form-label"></label>
            <p id="star_grade_modal">
              <a href="#">★</a>
              <a href="#">★</a>
              <a href="#">★</a>
              <a href="#">★</a>
              <a href="#">★</a>
            </p>
            <input type="hidden" id="rv_odr_code">
            <input type="hidden" id="rv_score">
            <input type="hidden" id="rv_pdt_code">
            <textarea id="rv_content" rows="3" style="width: 100%;"></textarea>	
          </div>
        </form>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-dismiss="modal">취소</button>
        <button data-modal="btnCommon" type="button" class="btn btn-primary" id="btnReviewSave">등록</button>
      </div>
    </div>
  </div>
</div> 
  </body>
</html>