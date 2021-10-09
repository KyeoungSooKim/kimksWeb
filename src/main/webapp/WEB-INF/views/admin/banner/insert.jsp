<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<!--
This is a starter template page. Use this page to start your new project from
scratch. This page gets rid of all links and provides the needed markup only.
-->
<html>
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <title>뮤직스쿨 - 배너등록</title>
  <!-- Tell the browser to be responsive to screen width -->
  <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
  <%@include file="/WEB-INF/views/admin/includes/config.jsp" %>
<script>
    let msg = "${msg}";
    if(msg == "zeroFile"){
    	alert("이미지를 선택해주세요.");
    }else if(msg == "notImage"){
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
        배너등록
      </h1>
      <ol class="breadcrumb">
        <li><a href="#"><i class="fa fa-dashboard"></i> 배너관리</a></li>
        <li class="active">배너등록</li>
      </ol>
    </section>

    <!-- Main content -->
    <section class="content container-fluid">
	
     <div class="box box-primary">
            <div class="box-header with-border">
              
            </div>
            <!-- /.box-header -->
            <!-- form start -->
            <form role="form" id="bannerForm" action="/admin/banner/insert" method="post" enctype="multipart/form-data">
              <div class="box-body">     
              <div class="row">
                <div class="col-md-6">
                <div class="form-group">
                  <label for="file1">배너이미지</label>
                  <input type="file" id="file1" name="file1">
                </div> 
               </div>
                </div>    
              </div>
              <!-- /.box-body -->

              <div class="box-footer">
                <button type="submit" class="btn btn-primary">등록</button>
              </div>
            </form>
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

<!-- Bootstrap WYSIHTML5 -->
<script src="/plugins/bootstrap-wysihtml5/bootstrap3-wysihtml5.all.min.js"></script>

<script>
  $(function () {

  })
</script>
</body>
</html>