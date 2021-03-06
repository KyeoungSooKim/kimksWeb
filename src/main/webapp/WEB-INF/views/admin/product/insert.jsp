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
  <title>뮤직스쿨 - 상품등록</title>
  <!-- Tell the browser to be responsive to screen width -->
  <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
  <%@include file="/WEB-INF/views/admin/includes/config.jsp" %>

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
        상품등록
        <small>상품정보</small>
      </h1>
      <ol class="breadcrumb">
        <li><a href="#"><i class="fa fa-dashboard"></i> 상품관리</a></li>
        <li class="active">상품등록</li>
      </ol>
    </section>

    <!-- Main content -->
    <section class="content container-fluid">
	
     <div class="box box-primary">
            <div class="box-header with-border">
              
            </div>
            <!-- /.box-header -->
            <!-- form start -->
            <form role="form" id="productForm" action="/admin/product/insert" method="post" enctype="multipart/form-data">
              <div class="box-body">
            <div class="row">
			<div class="col-md-6">
              <div class="form-group">
                <label>1차 카테고리</label>
                <select id="mainCategory" name="cate_prt" class="form-control select2 select2-hidden-accessible" style="width: 100%;">
                  <option value=0>1차 카테고리 선택</option>
                 <c:forEach items="${mainCategory }" var="vo">
                  <option value="${vo.cate_code }">${vo.cate_name }</option>
              	</c:forEach>
                 </select>
              </div>
              </div>
           <div class="col-md-6">   
              <div class="form-group">
                <label>2차 카테고리</label>
                <select id="subCategory" name="cate_code" class="form-control select2 select2-hidden-accessible" style="width: 100%;">
                 
                 </select>
              </div>
              </div>
             </div> 
              <div class="row">
               <div class="col-md-6">
                <div class="form-group">
                  <label for="pdt_name">상품명</label>
                  <input type="text" class="form-control" id="pdt_name" name="pdt_name" placeholder="">
                </div>
               </div>
               <div class="col-md-6">
                <div class="form-group">
                  <label for="pdt_company">제조사</label>
                  <input type="text" class="form-control" id="pdt_company" name="pdt_company" placeholder="">
                </div>
               </div>
                </div>
       
                <div class="form-group">
                  <label for="exampleInputEmail1">상품 상세설명</label>
                  <div class="box box-info">
            <div class="box-header">
              <!-- tools box -->
              <div class="pull-right box-tools">
                
              </div>
              <!-- /. tools -->
            </div>
            <!-- /.box-header -->
            <div class="box-body pad">             
              <textarea id="pdt_detail" name="pdt_detail" rows="10" cols="80" style="visibility: hidden; display: none;">
              </textarea>              
            </div>
          </div>
          
                </div>
              <div class="row">
				<div class="col-md-3">
                <div class="form-group">
                  <label for="pdt_price">판매가격</label>
                  <input type="text" class="form-control" id="pdt_price" name="pdt_price" placeholder="">
                </div>
                </div>
                <div class="col-md-3">
                <div class="form-group">
                  <label for="pdt_discount">할인</label>
                  <input type="text" class="form-control" id="pdt_discount" name="pdt_discount" placeholder="">
                </div>
                </div>
                <div class="col-md-3">
                <div class="form-group">
                  <label for="pdt_amount">수량</label>
                  <input type="text" class="form-control" id="pdt_amount" name="pdt_amount" placeholder="">
                </div>
                </div>
                <div class="col-md-3">
 				<div class="form-group">
                  <label for="pdt_buy">판매여부</label> 
                  <div class="checkbox">
                  <label>
                      <input type="checkbox" name="pdt_buy">
                    	  판매여부
                    </label>
                    </div>             
                </div>
                </div>
                </div>    
                <div class="form-group">
                  <label for="exampleInputFile">상품이미지</label>
                  <input type="file" id="file1" name="file1">
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

<script src="/bower_components/ckeditor/ckeditor.js"></script>



<!-- Bootstrap WYSIHTML5 -->
<script src="/plugins/bootstrap-wysihtml5/bootstrap3-wysihtml5.all.min.js"></script>
<!-- 순서주의 -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/3.0.3/handlebars.js"></script>
<script>
  $(function () {
	  
	  var ckeditor_config = {
				resize_enabled : false,
				enterMode : CKEDITOR.ENTER_BR,
				shiftEnterMode : CKEDITOR.ENTER_P,
				toolbarCanCollapse : true,
				removePlugins : "elementspath", 
				// 파일 업로드 기능 추가
				// CKEditor를 이용해 업로드 사용 시 해당 주소에 업로드 됨
				filebrowserUploadUrl: '/admin/product/imgUpload'
		};

    // Replace the <textarea id="editor1"> with a CKEditor
    // instance, using default configuration.
    CKEDITOR.replace('pdt_detail', ckeditor_config);
    //bootstrap WYSIHTML5 - text editor
    $('.textarea').wysihtml5()
    //alert(CKEDITOR.version); 4.12.1(Standard)

    
    $("#mainCategory").on("change", function(){

      let mainCategory = $(this).val();
      let url = "/admin/product/subCategory/" + mainCategory;

      $.getJSON(url, function(data){
        //console.log(data[0]);
        subCategoryView(data, $("#subCategory"), $("#subCategoryTemplate"));
      });
    });

    $("#productForm").on("submit", function(){
        if($("#mainCategory option:selected").val()==0){
          alert("1차카테고리를 선택해주세요.");
          $("#mainCategory").focus();
          return false;
        }else if($("#subCategory option:selected").val()==0){
          alert("2차카테고리를 선택해주세요.");
          $("#subCategory").focus();
          return false;
        }else
        if($("#pdt_name").val() == "") {
          alert("상품명을 입력해주세요.");
          $("#pdt_name").focus();
          return false;
        }else if($("#pdt_company").val() == "") {
          alert("제조사를 입력해주세요.");
          $("#pdt_company").focus();
          return false;
        }else if($("#pdt_detail").val() == "") {
          alert("상품설명을 입력해주세요.");
          $("#pdt_detail").focus();
          return false;
        }else if($("#pdt_price").val() == "") {
          alert("가격을 입력해주세요.");
          $("#pdt_price").focus();
          return false;
        }else if($("#pdt_discount").val() == "") {
          alert("할인율을 입력해주세요.");
          $("#pdt_discount").focus();
          return false;
        }else if($("#pdt_amount").val() == "") {
          alert("수량을 입력해주세요.");
          $("#pdt_amount").focus();
          return false;
        }
      });
  })
</script>
<script id="subCategoryTemplate" type="text/x-handlebars-template">
 <option value="0">2차 카테고리 선택</option>
 {{#each. }}
  <option value="{{cate_code}}">{{cate_name}}</option>
 {{/each}}
</script>
<script>
  let subCategoryView = function(subCategory, target, templateObject){
    let template = Handlebars.compile(templateObject.html());
    let options = template(subCategory);
    target.empty();
    target.append(options);
  }
</script>
</body>
</html>