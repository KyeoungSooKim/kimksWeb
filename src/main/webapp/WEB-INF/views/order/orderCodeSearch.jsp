<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>뮤직스쿨 - 비회원 주문조회</title>
<%@ include file="/WEB-INF/views/includes/common.jsp" %>
<script>
    $(document).ready(function(){


    });
    let msg = "${msg}";
    if(msg == "notFound"){
    	alert("주문정보를 다시 확인해주세요.");
    }
    function sendit(){
    	if(document.getElementById("odr_name").value == "") {
    		alert("이름을 입력해주세요.");
    		document.getElementById("odr_name").focus();
    		return;
    	}else if(document.getElementById("odr_code").value == "") {
    		alert("주문번호를 입력해주세요.");
    		document.getElementById("odr_name").focus();
    		return;
    	}
    		document.getElementById("orderForm").submit();
    }
</script>
</head>
<body>
<%@include file="/WEB-INF/views/includes/header.jsp" %>
<div class="container">

<form id="orderForm" action="/order/orderFind" method="post">
 <div class="row">
		<div class="col-md-4 col-md-offset-4">
    		<div class="panel panel-default">
			  	<div class="panel-heading">
			    	<h3 class="panel-title">주문조회</h3>
			 	</div>
			  	<div class="panel-body">
			    	<form accept-charset="UTF-8" role="form">
			    		<div class="form-group">
			    			<input class="form-control" placeholder="주문자(이름) 입력" id="odr_name" name="odr_name" type="text">
			    		</div>                   
			    		<div class="form-group">
			    			<input class="form-control" placeholder="주문번호 입력" id="odr_code" name="odr_code" type="text">
			    		</div>		 
			    		<input id="btnSubmit" class="btn btn-lg btn-success btn-block" type="button" onclick="sendit();" value="조회">			    	
			      	</form>
			    </div>
			</div>
		</div>
	</div>
</form>
</div>
<%@include file="/WEB-INF/views/includes/footer.jsp" %>
</body>
</html>