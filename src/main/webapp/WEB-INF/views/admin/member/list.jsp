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
  <title>뮤직스쿨 - 회원관리</title>
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
      <h1>회원관리</h1>
      <ol class="breadcrumb">
        <li><a href="#"><i class="fa fa-dashboard"></i> Level</a></li>
        <li class="active">Here</li>
      </ol>
    </section>

    <!-- Main content -->
    <section class="content container-fluid">

<h3>회원목록</h3>
	<div id="example2_wrapper" class="dataTables_wrapper form-inline dt-bootstrap">
	 <div class="float-left">
			 <div class="row">
				<div class="col-lg-12">
					<form id="searchForm" action="/admin/member/list" method="GET">
						<select name="type">
							<option value="I" <c:out value="${pageMaker.cri.type eq 'I'? 'selected' : '' }"/>>회원ID</option>
							<option value="N" <c:out value="${pageMaker.cri.type eq 'N'? 'selected' : '' }"/>>이름</option>
							<option value="A" <c:out value="${pageMaker.cri.type eq 'A'? 'selected' : '' }"/>>주소</option>
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
  <button type="button" id="btnExcel">엑셀다운</button>
	</div>
	<div class="col-sm-6">
	</div>
	</div>
	<div class="row">
	<div class="col-sm-12">
	<table id="example2" class="table table-bordered table-hover dataTable" role="grid" aria-describedby="example2_info">
	<colgroup>
		<col width="5%">
		<col width="10%">
		<col width="10%">
		<col width="15%">
    <col width="10%">
    <col width="20%">
		<col width="10%">
		<col width="10%">
	</colgroup>
     <thead>
	     <tr role="row">
	    <th class="sorting" tabindex="0" aria-controls="example2" rowspan="1" colspan="1" aria-label="CSS grade: activate to sort column ascending"><input type="checkbox" id="checkAll"></th>
	     <th class="sorting" tabindex="0" aria-controls="example2" rowspan="1" colspan="1" aria-label="Browser: activate to sort column ascending">아이디</th>
	     <th class="sorting" tabindex="0" aria-controls="example2" rowspan="1" colspan="1" aria-label="Platform(s): activate to sort column ascending">이름</th>
	     <th class="sorting" tabindex="0" aria-controls="example2" rowspan="1" colspan="1" aria-label="CSS grade: activate to sort column ascending">이메일</th>
	     <th class="sorting" tabindex="0" aria-controls="example2" rowspan="1" colspan="1" aria-label="CSS grade: activate to sort column ascending">전화번호</th>
       <th class="sorting" tabindex="0" aria-controls="example2" rowspan="1" colspan="1" aria-label="CSS grade: activate to sort column ascending">주소</th>
   	     <th class="sorting" tabindex="0" aria-controls="example2" rowspan="1" colspan="1" aria-label="CSS grade: activate to sort column ascending">가입일</th>
   	     <th class="sorting" tabindex="0" aria-controls="example2" rowspan="1" colspan="1" aria-label="CSS grade: activate to sort column ascending">비고</th>
	     </tr>
     </thead>
     <tbody>
     <c:forEach items="${list }" var="vo">
     <tr role="row" class="odd">
       <td class="sorting_1">
       <input type="checkbox" class="check" name="id_check" value="${vo.u_id }">
       </td>
        <td>
          <a href="javascript:openWindowPop('/admin/member/userDetailInfo?u_id=${vo.u_id }', 'userInfo');">${vo.u_id }</a>
        </td>
       <td>${vo.u_name }</td>
       <td>${vo.u_email }</td>
       <td>${vo.u_phone }</td>
       <td>${vo.u_addr }</td>
       <td>
        <fmt:formatDate value="${vo.u_regdate }" pattern="yyyy-MM-dd"/>
       </td>
       <td><button class="btnMemberDelete" data-u_id="${vo.u_id }">삭제</button></td>
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

    <form id="excelForm" action="/excel/downloadExcelFile" method="post"></form>

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
function openWindowPop(url, name){
    var options = 'top=100, left=400, width=500, height=600, status=no, menubar=no, toolbar=no, resizable=no';
    window.open(url, name, options);
}
let actionForm = $("#actionForm");

  $(function(){
	  
	  let cur_tr = "";
	  $("table td span.userDetail").on("click", function(){
	    let u_id = $(this).data("u_id");

	    cur_tr = $(this).parent().parent();
	    $.ajax({
	      url:'/admin/member/userDetailInfo/' + u_id,
	      type:'get',
	      success:function(data){
	        printData(data, cur_tr, $("#userDetailTemplate"));
	      }

	    });
	  });
	  
	  let printData = function(replyArr, target, templateObj) {
		   
		  let template = Handlebars.compile(templateObj.html());
		  let html = template(replyArr);
		  target.siblings(".addOrderDetail").remove(); // 기존 상품후기목록 지우기
		  target.after(html);
		  
		}
    
    $(".btnMemberDelete").on("click", function(){
        let u_id = $(this).data("u_id");
        
        if(confirm(u_id+" 회원을 삭제하시겠습니까?")){
        	//location.href = "/admin/order/orderDelete?odr_code=" + odr_code;
          actionForm.append("<input type='text' name='u_id' value='"+u_id+"'>");
          actionForm.attr("action", "/admin/member/memberDelete");
          actionForm.attr("method", "post");
	        actionForm.submit();
        }else {
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

      $("#btnChkDel").on("click", function(){
        if($("input[name='id_check']:checked").length == 0){
          alert("회원을 선택해주세요");
          return;
        }

        let result = confirm("선택한 회원을 삭제하시겠습니까?");
      if(result){
        //선택된 상품코드, 이미지 정보 배열로 저장
        let u_idArr = [];
        

        //체크된 만큼 반복
        $("input[name='id_check']:checked").each(function(){
          let u_id = $(this).val();
        
          u_idArr.push(u_id);
          
        });

        $.ajax({
          url:"/admin/member/deleteChecked",
          type:"post",
          dataType:"text", //넘어온데이터
          data:{
            u_idArr : u_idArr
          },
          success: function(data){
            alert("선택된 회원이 삭제되었습니다.");
             //폼전송
            actionForm.attr("action", "/admin/member/list");
	          actionForm.submit();
          }         
        });
      }   
      });

      $("#btnExcel").on("click", function(){
        $("#excelForm").submit();
      });

      $(".paginate_button a").on("click", function(e){
        e.preventDefault();

        actionForm.find("input[name='pageNum']").val($(this).attr("href"));
        actionForm.attr("action", "/admin/member/list");
        actionForm.submit();
      });
      
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