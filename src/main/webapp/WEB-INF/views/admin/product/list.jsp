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
  <title>뮤직스쿨 - 등록상품</title>
  <!-- Tell the browser to be responsive to screen width -->
  <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
  <%@include file="/WEB-INF/views/admin/includes/config.jsp" %>
  <script>
  let msg = "${msg}";
  if(msg=="success"){
	  alert("상품등록이 되었습니다.");
  }else if(msg=="editSuccess"){
	  alert("상품이 수정되었습니다.");
  }else if(msg=="deleted"){
	  alert("상품이 삭제되었습니다.");
  }else if(msg=="deleteFail"){
	  alert("주문내역에 존재하는 상품은 삭제할수없습니다.");
  }
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
        상품관리
        <small></small>
      </h1>
      <ol class="breadcrumb">
        <li><a href="#"><i class="fa fa-dashboard"></i> Level</a></li>
        <li class="active">Here</li>
      </ol>
    </section>

    <!-- Main content -->
    <section class="content container-fluid">

<h3>상품목록</h3>
	<div id="example2_wrapper" class="dataTables_wrapper form-inline dt-bootstrap">
	 <div class="float-left">
			 <div class="row">
				<div class="col-lg-12">
					<form id="searchForm" action="/admin/product/list" method="GET">
						<select name="type">
							<option value="N" <c:out value="${pageMaker.cri.type eq 'N'? 'selected' : '' }"/>>상품명</option>
							<option value="D" <c:out value="${pageMaker.cri.type eq 'D'? 'selected' : '' }"/>>내용</option>
							<option value="C" <c:out value="${pageMaker.cri.type eq 'C'? 'selected' : '' }"/>>제조사</option>
							<option value="ND" <c:out value="${pageMaker.cri.type eq 'ND'? 'selected' : '' }"/>>상품명+내용</option>
							<option value="NC" <c:out value="${pageMaker.cri.type eq 'NC'? 'selected' : '' }"/>>상품명+제조사</option>
							<option value="NDC" <c:out value="${pageMaker.cri.type eq 'NDC'? 'selected' : '' }"/>>상품명+내용+제조사</option>
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
  <button type="button" name="btnCheckedChange" id="btnCheckedChange">선택변경</button>
	</div>
	<div class="col-sm-6">
	</div>
	</div>
	<div class="row">
	<div class="col-sm-12">
	<table id="example2" class="table table-bordered table-hover dataTable" role="grid" aria-describedby="example2_info">
     <thead>
	     <tr role="row">
	    <th class="sorting" tabindex="0" aria-controls="example2" rowspan="1" colspan="1" aria-label="CSS grade: activate to sort column ascending"><input type="checkbox" id="checkAll"></th>
	     <th class="sorting_asc" tabindex="0" aria-controls="example2" rowspan="1" colspan="1" aria-sort="ascending" aria-label="Rendering engine: activate to sort column descending">상품코드</th>
	     <th class="sorting" tabindex="0" aria-controls="example2" rowspan="1" colspan="1" aria-label="Browser: activate to sort column ascending">상품명</th>
	     <th class="sorting" tabindex="0" aria-controls="example2" rowspan="1" colspan="1" aria-label="Platform(s): activate to sort column ascending">등록일</th>
	     <th class="sorting" tabindex="0" aria-controls="example2" rowspan="1" colspan="1" aria-label="Engine version: activate to sort column ascending">가격</th>
	     <th class="sorting" tabindex="0" aria-controls="example2" rowspan="1" colspan="1" aria-label="CSS grade: activate to sort column ascending">할인</th>
	     <th class="sorting" tabindex="0" aria-controls="example2" rowspan="1" colspan="1" aria-label="CSS grade: activate to sort column ascending">진열</th>
   	     <th class="sorting" tabindex="0" aria-controls="example2" rowspan="1" colspan="1" aria-label="CSS grade: activate to sort column ascending">수정</th>
   	     <th class="sorting" tabindex="0" aria-controls="example2" rowspan="1" colspan="1" aria-label="CSS grade: activate to sort column ascending">삭제</th>
	     </tr>
     </thead>
     <tbody>
     <c:forEach items="${list }" var="vo">
     <tr role="row" class="odd">
       <td class="sorting_1">
       <input type="checkbox" class="check" value="${vo.pdt_code }">
       <input type="hidden" class="pdt_img" value="${vo.pdt_img }">
       </td>
       <td><c:out value="${vo.pdt_code }"/></td>
       <td><a href="${vo.pdt_code }" class="productDetailEdit"><img src="/admin/product/displayFile?fileName=<c:out value="${vo.pdt_img }"/>" alt=""><c:out value="${vo.pdt_name }"/></a></td>
       <td><fmt:formatDate value="${vo.pdt_date_sub }" pattern="yyyy-MM-dd hh:mm:ss"/></td>
       <td><input type="number" id="pdt_price_${vo.pdt_code}" value='<c:out value="${vo.pdt_price }"/>' style="width: 100px;"></td>
       <td><input type="number" id="pdt_discount_${vo.pdt_code}" value='<c:out value="${vo.pdt_discount }"/>' style="width: 50px;"></td>
       <td><input type="checkbox" id="pdt_buy_${vo.pdt_code}" <c:out value="${vo.pdt_buy == 'Y' ? 'checked' : '' }"/>></td>
       <td><input type="button" class="btnEdit" value="수정" data-pdt-code="${vo.pdt_code }"></td>
       <td><input type="button" class="btnDel" value="삭제" data-pdt-num="${vo.pdt_code }"></td>
     </tr>
     </c:forEach>
     <!-- 
     <tr role="row" class="even">
       <td class="sorting_1">Gecko</td>
       <td>Firefox 1.5</td>
       <td>Win 98+ / OSX.2+</td>
       <td>1.8</td>
       <td>A</td>
     </tr>
      -->
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
   <c:if test="${pageMaker.cri.pageNum * pageMaker.cri.amount > total }">
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
<script>
let actionForm = $("#actionForm");

  $(function(){
    $("a.productDetailEdit").on("click", function(e){
      e.preventDefault();
      let pdt_code = $(this).attr("href");
      
      actionForm.append("<input type='text' name='pdt_code' value='"+pdt_code+"'>");
      actionForm.attr("action", "/admin/product/edit");
	  actionForm.submit();
    });
    
    $(".btnDel").on("click", function(){
        let pdt_code = $(this).data("pdt-num");
        
        actionForm.append("<input type='text' name='pdt_code' value='"+pdt_code+"'>");
        actionForm.attr("method", "post");
        actionForm.attr("action", "/admin/product/delete");
        if(confirm("삭제하시겠습니까?")){
        	actionForm.submit();
        }else {
        	return;
        }
  	  
      });

      $(".btnEdit").on("click" ,function(){

        let pdt_code = $(this).data("pdt-code");
        let pdt_price = $(this).parent().prev().prev().prev().children("input").val();
        let pdt_discount = $(this).parent().prev().prev().children("input").val();
        let pdt_buy = $(this).parent().prev().children("input").is(":checked");
        console.log(pdt_code, pdt_price, pdt_discount, pdt_buy);
        if(confirm("변경하시겠습니까?")){
          
          $.ajax({
            url:"/admin/product/priceModify/"+pdt_code+"/"+pdt_price+"/"+pdt_discount+"/"+pdt_buy,
            type:"patch",
            dataType:"text", //넘어온데이터
            data:{
              pdt_code : pdt_code,
              pdt_price : pdt_price,
              pdt_discount : pdt_discount,
              pdt_buy : pdt_buy
            },
            beforeSend: function(xmlHttpRequest){
            	xmlHttpRequest.setRequestHeader("AJAX", "true");
            }
            ,
            success: function(data){
              alert("변경되었습니다.");
              }
            });         
          } else{
            return;
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

      $("#btnCheckedChange").on("click", function(){
        if($(".check:checked").length == 0){
          alert("상품을 선택해주세요");
          return;
        }
        let result = confirm("선택한 상품정보를 변경하시겠습니까?");
      if(result){
        //선택된 상품코드, 이미지 정보 배열로 저장
        let pdt_codeArr = [];
        let pdt_priceArr = [];
        let pdt_discountArr = [];
        let pdt_buyArr = [];
        //체크된 만큼 반복
        $(".check:checked").each(function(){
          let pdt_code = $(this).val();
          let pdt_price = $(this).parent().parent().find("#pdt_price_"+pdt_code).val();
          let pdt_discount = $(this).parent().parent().find("#pdt_discount_"+pdt_code).val();
          let pdt_buy = $(this).parent().parent().find("#pdt_buy_"+pdt_code).is(":checked");
          pdt_codeArr.push(pdt_code);
          pdt_priceArr.push(pdt_price);
          pdt_discountArr.push(pdt_discount);
          pdt_buyArr.push(pdt_buy);      
        });
        $.ajax({
          url:"/admin/product/priceModifyChecked",
          type:"post",
          dataType:"text", //넘어온데이터
          data:{
            pdt_codeArr : pdt_codeArr,
            pdt_priceArr : pdt_priceArr,
            pdt_discountArr : pdt_discountArr,
            pdt_buyArr : pdt_buyArr
          },
          success: function(data){
            alert("변경되었습니다.");         
          }         
        });
      }   
      });

      $(".paginate_button a").on("click", function(e){
        e.preventDefault();

        actionForm.find("input[name='pageNum']").val($(this).attr("href"));
        actionForm.attr("action", "/admin/product/list");
        actionForm.submit();
      })
      
      $("#searchForm").on("submit", function(){
          if($("input[name='keyword']").val() == "") {
            alert("검색어를 입력해주세요.");
            return false;
          }
        });
  })
</script>
</body>
</html>