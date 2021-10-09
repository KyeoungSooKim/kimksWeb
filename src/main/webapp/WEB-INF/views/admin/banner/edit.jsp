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
  <title>뮤직스쿨 - 배너목록</title>
  <!-- Tell the browser to be responsive to screen width -->
  <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
  <%@include file="/WEB-INF/views/admin/includes/config.jsp" %>
<script>
    let msg = "${msg}";
    if(msg == "notImage"){
    	alert("이미지 형식을 선택해주세요.");
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
        배너관리
        <small></small>
      </h1>
      <ol class="breadcrumb">
        <li><a href="#"><i class="fa fa-dashboard"></i> Level</a></li>
        <li class="active">Here</li>
      </ol>
    </section>

    <!-- Main content -->
    <section class="content container-fluid">

<h3>배너수정</h3>
	<div id="example2_wrapper" class="dataTables_wrapper form-inline dt-bootstrap">
	<div class="row">
	<div class="col-sm-6">
  <button type="button" id="btnSaveModify">적용</button>
	</div>
	<div class="col-sm-6">
	</div>
	</div>
	<div class="row">
	<div class="col-sm-12">
	<form action="/admin/banner/modify" id="modifyForm" method="POST" enctype="multipart/form-data">
	<table id="example2" class="table table-bordered table-hover dataTable" role="grid" aria-describedby="example2_info">
     <thead>
	     <tr role="row">
	    <th class="sorting" tabindex="0" aria-controls="example2" rowspan="1" colspan="1" aria-label="CSS grade: activate to sort column ascending">순서</th>
	     <th class="sorting" tabindex="0" aria-controls="example2" rowspan="1" colspan="1" aria-label="Browser: activate to sort column ascending">배너</th>
   	     <th class="sorting" tabindex="0" aria-controls="example2" rowspan="1" colspan="1" aria-label="CSS grade: activate to sort column ascending">수정</th>
   	     <th class="sorting" tabindex="0" aria-controls="example2" rowspan="1" colspan="1" aria-label="CSS grade: activate to sort column ascending">삭제</th>
	     </tr>
     </thead>
     <tbody>
     <c:forEach items="${list }" var="vo" varStatus="status">
     <tr role="row" class="odd">
       <td class="sorting_1">
        <input type="hidden" name="bn_code" value="${vo.bn_code }">
       <input type="number" name="bn_order" value="${vo.bn_order}" min="1">
       <input type="hidden" name="bn_img" value="${vo.bn_img }">
       </td>
       <td><img src="/admin/banner/displayFile?fileName=<c:out value="${vo.bn_img }"/>" alt=""></td>
       <td><input type="file" name="file1"></td>
       <td><input type="button" class="btnDel" value="삭제" data-bn-code="${vo.bn_code }" data-bn-img="${vo.bn_img }"></td>
     </tr>
     </c:forEach>
     
     </tbody>
   </table>
  </form>
   </div>
   </div>
   <div class="row">
   <div class="col-sm-5">
   </div>
   <div class="col-sm-7">
   <div class="dataTables_paginate paging_simple_numbers" id="example2_paginate">
   </div>
   </div>
   </div>
   </div>
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
  $(function(){
    
    $(".btnDel").on("click", function(){
        let bn_code = $(this).data("bn-code");
        let bn_img = $(this).data("bn-img");
        console.log("Del: "+bn_code);
        
        if(confirm("배너를 삭제하시겠습니까?")){
        	location.href = "/admin/banner/delete?bn_code="+bn_code+"&bn_img="+bn_img;
        }else {
        	return;
        }
  	  
      });

      let modifyForm = $("#modifyForm");
      $("#btnSaveModify").on("click", function(){
        
        if(confirm("배너를 변경하시겠습니까?")){
          
          let bn_orderArr = [];
          let bn_order_check = false;
          $("input[name='bn_order']").each(function(){
            bn_orderArr.push($(this).val());
          });

          let firstCheck = false;
          for(let i = 0; i < bn_orderArr.length; i++) {
            let cur_bn_order = bn_orderArr[i];
            if(cur_bn_order == 1) {
              firstCheck = true;
              break;
            }
          }

          let result = true;
          for(let i = 0; i < bn_orderArr.length; i++) {
            let cur_bn_order = bn_orderArr[i];
            
            for(let j = i+1; j < bn_orderArr.length; j++) {
              if(cur_bn_order === bn_orderArr[j]) {
                result = false;
                break;
              }
            }
          }
          if(firstCheck && result){
            modifyForm.submit();
          }else{
            alert("순서를 확인해주세요.");
            return;
          }
        }else {
        	return;
        }
      });
  })
</script>
</body>
</html>