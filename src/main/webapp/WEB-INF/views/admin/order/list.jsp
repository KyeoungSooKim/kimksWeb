<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<!--
This is a starter template page. Use this page to start your new project from
scratch. This page gets rid of all links and provides the needed markup only.
-->
<html>
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <title>뮤직스쿨 - 주문관리</title>
  <!-- Tell the browser to be responsive to screen width -->
  <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
  <%@include file="/WEB-INF/views/admin/includes/config.jsp" %>
  <script>

  </script>
</head>
<body class="hold-transition skin-blue sidebar-mini">
<div class="wrapper">

  <!-- Main Header -->
  <%@include file="/WEB-INF/views/admin/includes/top.jsp" %>
  
  <!-- Left side column. contains the logo and sidebar -->
 <%@include file="/WEB-INF/views/admin/includes/nav.jsp" %>

  <!-- Content Wrapper. Contains page content -->
  <div class="content-wrapper">
    <!-- Content Header (Page header) -->
    <section class="content-header">
      <h1>
        주문리스트
        <small>Optional description</small>
      </h1>
      <ol class="breadcrumb">
        <li><a href="#"><i class="fa fa-dashboard"></i> Level</a></li>
        <li class="active">Here</li>
      </ol>
    </section>

    <!-- Main content -->
    <section class="content container-fluid">

<h3>주문목록</h3>
	<div id="example2_wrapper" class="dataTables_wrapper form-inline dt-bootstrap">
	 <div class="float-left">
			 <div class="row">
				<div class="col-lg-12">
					<form id="searchForm" action="/admin/order/list" method="GET">
						<select name="type">
							<option value="C" <c:out value="${pageMaker.cri.type eq 'C'? 'selected' : '' }"/>>주문번호</option>
							<option value="I" <c:out value="${pageMaker.cri.type eq 'I'? 'selected' : '' }"/>>주문ID</option>
							<option value="N" <c:out value="${pageMaker.cri.type eq 'N'? 'selected' : '' }"/>>수령인</option>
						</select>

						<input type="text" name="keyword" value="<c:out value="${pageMaker.cri.keyword}"/>">
						<input type="hidden" name="pageNum" value="1">
						<input type="hidden" name="amount" value="${pageMaker.cri.amount }">
						<button type="submit" class="btn btn-default">검색</button>
					</form>
				</div>
			</div>
		</div>
	<div class="row">
	<div class="col-sm-6">
	<button type="button" id="btnChkDel">선택삭제</button>
  <button type="button" name="btnDeliveryAllChange" id="btnDeliveryAllChange">선택주문상태변경</button>
	</div>
	<div class="col-sm-6">
	</div>
	</div>
	<div class="row">
	<div class="col-sm-12">
	<table id="example2" class="table table-bordered table-hover dataTable" role="grid" aria-describedby="example2_info">
	<colgroup>
		<col width="10%">
		<col width="20%">
		<col width="10%">
		<col width="20%">
    <col width="10%">
    <col width="20%">
		<col width="10%">	
	</colgroup>
     <thead>
	     <tr role="row">
	    <th class="sorting" tabindex="0" aria-controls="example2" rowspan="1" colspan="1" aria-label="CSS grade: activate to sort column ascending"><input type="checkbox" id="checkAll"></th>
	     <th class="sorting" tabindex="0" aria-controls="example2" rowspan="1" colspan="1" aria-label="Browser: activate to sort column ascending">주문일자</th>
	     <th class="sorting" tabindex="0" aria-controls="example2" rowspan="1" colspan="1" aria-label="Platform(s): activate to sort column ascending">주문번호</th>
	     <th class="sorting" tabindex="0" aria-controls="example2" rowspan="1" colspan="1" aria-label="CSS grade: activate to sort column ascending">주문ID</th>
	     <th class="sorting" tabindex="0" aria-controls="example2" rowspan="1" colspan="1" aria-label="CSS grade: activate to sort column ascending">수령인</th>
   	     <th class="sorting" tabindex="0" aria-controls="example2" rowspan="1" colspan="1" aria-label="CSS grade: activate to sort column ascending">주문단계</th>
   	     <th class="sorting" tabindex="0" aria-controls="example2" rowspan="1" colspan="1" aria-label="CSS grade: activate to sort column ascending">비고</th>
	     </tr>
     </thead>
     <tbody>
     <c:forEach items="${list }" var="vo">
     <tr role="row" class="odd">
       <td class="sorting_1">
       <input type="checkbox" class="check" name="odr_check" value="${vo.odr_code }">
       </td>
       <td><fmt:formatDate value="${vo.odr_date }" pattern="yyyy-MM-dd hh:mm:ss"/></td>
       <td><span class="userOrderDetail" data-odr_code="${vo.odr_code }" style="cursor: pointer;">[${vo.odr_code }] / [${vo.odr_count }]건</span></td>
       <td>
       <c:if test="${vo.u_id != null}">
       <c:out value="${vo.u_id }"/>
       </c:if>
       <c:if test="${vo.u_id == null}">
       <c:out value="비회원"/>
       </c:if>
       </td>
       <td><c:out value="${vo.odr_name }"/></td>
       <td>
         <select name="odr_delivery" id="odr_delivery_${vo.odr_code}">
           <option value="입금확인중" <c:out value="${vo.odr_delivery eq '입금확인중'? 'selected' : '' }"/>>입금확인중</option>
           <option value="결제완료" <c:out value="${vo.odr_delivery eq '결제완료'? 'selected' : '' }"/>>결제완료</option>
           <option value="상품준비중" <c:out value="${vo.odr_delivery eq '상품준비중'? 'selected' : '' }"/>>상품준비중</option>
           <option value="배송준비중" <c:out value="${vo.odr_delivery eq'배송준비중'? 'selected' : '' }"/>>배송준비중</option>
           <option value="배송중" <c:out value="${vo.odr_delivery eq '배송중'? 'selected' : '' }"/>>배송중</option>
           <option value="배송완료" <c:out value="${vo.odr_delivery eq '배송완료'? 'selected' : '' }"/>>배송완료</option>
           <option value="구매확정" <c:out value="${vo.odr_delivery eq '구매확정'? 'selected' : '' }"/>>구매확정</option>
         </select>
         <button class="btnDeliveryState" data-odr_code="${vo.odr_code }">변경</button>
       </td>
       <td><button class="btnOrderDelete" data-odr_code="${vo.odr_code }">주문삭제</button></td>
    </tr>
    </c:forEach>
    </tbody>
  </table>
  </div>
  </div>
  <div class="row">
  <div class="col-sm-5">
  <div class="dataTables_info" id="example2_info" role="status" aria-live="polite">
   Showing ${pageMaker.cri.pageNum * pageMaker.cri.amount - pageMaker.cri.amount+1} to
   <c:if test="${pageMaker.cri.pageNum * pageMaker.cri.amount < total }">
   ${pageMaker.cri.pageNum * pageMaker.cri.amount }
  </c:if>
   <c:if test="${pageMaker.cri.pageNum * pageMaker.cri.amount >= total }">
  ${total }
  </c:if> of 
  ${total }
    entries
  </div>
  </div>
  <div class="col-sm-7">
  <div class="dataTables_paginate paging_simple_numbers" id="example2_paginate">
  <ul class="pagination">
  <c:if test="${pageMaker.prev }">
  <li class="paginate_button previous" id="example2_previous">
  <a href="${pageMaker.startPage -1 }" aria-controls="example2" data-dt-idx="0" tabindex="0">Prev</a>
  </li>
  </c:if>
  <c:forEach var="num" begin="${pageMaker.startPage }" end="${pageMaker.endPage }">
  <li class="paginate_button ${pageMaker.cri.pageNum == num? "active" : "" } ">
  <a href="${num }" data-pagenum="${num }" aria-controls="example2" data-dt-idx="1" tabindex="0">${num }</a>
  </li>
  </c:forEach>
<c:if test="${pageMaker.next }">
  <li class="paginate_button next" id="example2_next">
  <a href="${pageMaker.endPage + 1 }" aria-controls="example2" data-dt-idx="7" tabindex="0">Next</a>
  </li>
  </c:if>
   </ul>
   </div>
   </div>
   </div>
   </div>
<form id="actionForm" action="" method="get">
 			<input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum }">
 			<input type="hidden" name="amount" value="${pageMaker.cri.amount }">
 			<input type="hidden" name="type" value="${pageMaker.cri.type }">
 			<input type="hidden" name="keyword" value="${pageMaker.cri.keyword }">
 		</form>

    </section>
    <!-- /.content -->
  </div>
  <!-- /.content-wrapper -->

  <!-- Main Footer -->
  <%@include file="/WEB-INF/views/admin/includes/bottom.jsp" %>

  <!-- Add the sidebar's background. This div must be placed
  immediately after the control sidebar -->
  <div class="control-sidebar-bg"></div>
</div>
<!-- ./wrapper -->

<!-- REQUIRED JS SCRIPTS -->
<%@include file="/WEB-INF/views/admin/includes/common.jsp" %>

<script src="https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/3.0.1/handlebars.js"></script>

<script id="userOrderDetailTemplate" type="text/x-handlebars-template">
	{{#each .}}
  <tr class="addOrderDetail">
	<td></td>
    <td scope="row"><img src="/product/displayFile?fileName={{pdt_img}}"></td>
    <td>{{pdt_name}}</td>
    <td>{{prettifyNumber odr_price}}원</td>
    <td>수량 : {{odr_amount}}</td>
    <td></td>
    <td><button type="button" class="btnOrderProductDelete" data-odr_code="{{odr_code }}" data-pdt_code="{{pdt_code }}">상품삭제</button></td>
  </tr>
	{{/each}}
</script>
<script>
let actionForm = $("#actionForm");

  $(function(){
	  
	  let cur_tr = "";
	  $("table td span.userOrderDetail").on("click", function(){
	    let odr_code = $(this).data("odr_code");

	    cur_tr = $(this).parent().parent();
	    $.ajax({
	      url:'/admin/order/userOrderDetailInfo/' + odr_code,
	      type:'get',
	      success:function(data){
	        printData(data, cur_tr, $("#userOrderDetailTemplate"));
	      }

	    });
	  });
	  
	  let printData = function(replyArr, target, templateObj) {
		   
		  let template = Handlebars.compile(templateObj.html());
		  let html = template(replyArr);
		  target.siblings(".addOrderDetail").remove(); // 기존 상품후기목록 지우기
		  target.after(html);
		  
		}
    
    $(".btnOrderDelete").on("click", function(){
        let odr_code = $(this).data("odr_code");
        
        if(confirm("삭제하시겠습니까?")){
        	//location.href = "/admin/order/orderDelete?odr_code=" + odr_code;
          actionForm.append("<input type='text' name='odr_code' value='"+odr_code+"'>");
          actionForm.attr("method", "post");
          actionForm.attr("action", "/admin/order/orderDelete");
	        actionForm.submit();
        }else {
        	return;
        }
  	  
      });

      $("tbody").on("click", "tr.addOrderDetail button.btnOrderProductDelete",function(){

        cur_tr = $(this).parent().parent();
  
          let odr_code = $(this).data("odr_code");
          let pdt_num = $(this).data("pdt_code");
          if(confirm("삭제하시겠습니까?")){
            
            $.ajax({
              url:"/admin/order/orderDeleteProduct/" + odr_code + "/" + pdt_num,
              type:"get",
              dataType:"text", //넘어온데이터
              data:{
                odr_code : odr_code,
                pdt_num : pdt_num
              },
              success: function(data){
                alert("선택된 상품이 삭제되었습니다.");
                 //폼전송
                cur_tr.remove();
                if($("tbody tr.addOrderDetail").length == 0){
                  actionForm.append("<input type='text' name='odr_code' value='"+odr_code+"'>");
                  actionForm.attr("action", "/admin/order/orderDelete");
                  actionForm.attr("method", "post");
                  actionForm.submit();
                }
              }         
            });
  
          }else {
            return;
          }
          
        });

        $(".btnDeliveryState").on("click" ,function(){

          let odr_code = $(this).data("odr_code");
          let odr_delivery = $(this).prev().val();
          if(confirm("주문코드" + odr_code +"의 배송상태를 " + odr_delivery +"(으)로 변경하시겠습니까?")){
            
            $.ajax({
              url:"/admin/order/deliveryStateModify/" + odr_code + "/" + odr_delivery,
              type:"patch",
              dataType:"text", //넘어온데이터
              data:{
                odr_code : odr_code,
                odr_delivery : odr_delivery
              },
              success: function(data){
                alert("변경되었습니다.");
                }
              });         
            }
          });

      //전체선택
      $("#checkAll").on("click", function(){
        $(".check").prop("checked", this.checked);
      });
      //개별선택
      $(".check").on("click", function(){
        $("#checkAll").prop("checked", false);
      });

      $("#btnDeliveryAllChange").on("click", function(){
        if($("input[name='odr_check']:checked").length == 0){
          alert("상품을 선택해주세요");
          return;
        }

        let result = confirm("선택한 상품의 배송상태를 변경하시겠습니까?");
      if(result){
        //선택된 상품코드, 이미지 정보 배열로 저장
        let odr_codeArr = [];
        let odr_deliveryArr = [];

        //체크된 만큼 반복
        $("input[name='odr_check']:checked").each(function(){
          let odr_code = $(this).val();
          let odr_delivery = $("#odr_delivery_"+odr_code).val();
          odr_codeArr.push(odr_code);
          odr_deliveryArr.push(odr_delivery);
          
        });
        console.log("선택주문: " + odr_codeArr);
        console.log("선택배송상태: " +odr_deliveryArr);
        
        $.ajax({
          url:"/admin/order/deliveryModifyChecked",
          type:"post",
          dataType:"text", //넘어온데이터
          data:{
            odr_codeArr : odr_codeArr,
            odr_deliveryArr : odr_deliveryArr
          },
          success: function(data){
            alert("변경되었습니다.");
            
          }         
        });
      }   
      });

      $("#btnChkDel").on("click", function(){
        if($("input[name='odr_check']:checked").length == 0){
          alert("상품을 선택해주세요");
          return;
        }

        let result = confirm("선택한 상품을 삭제하시겠습니까?");
      if(result){
        //선택된 상품코드, 이미지 정보 배열로 저장
        let odr_codeArr = [];
        

        //체크된 만큼 반복
        $("input[name='odr_check']:checked").each(function(){
          let odr_code = $(this).val();
        
          odr_codeArr.push(odr_code);
          
        });
        console.log("선택상품: " + odr_codeArr);

        $.ajax({
          url:"/admin/order/deleteChecked",
          type:"post",
          dataType:"text", //넘어온데이터
          data:{
            odr_codeArr : odr_codeArr
          },
          success: function(data){
            alert("선택된 주문이 삭제되었습니다.");
             //폼전송
            actionForm.attr("action", "/admin/order/list");
	          actionForm.submit();
          }         
        });
      }   
      });

      $(".paginate_button a").on("click", function(e){
        e.preventDefault();

        actionForm.find("input[name='pageNum']").val($(this).attr("href"));
        actionForm.attr("action", "/admin/order/list");
        actionForm.submit();
      });
  })
  Handlebars.registerHelper("prettifyNumber",function(number){
    let num = number.toLocaleString();
  
    return num;
  });
</script>
</body>
</html>