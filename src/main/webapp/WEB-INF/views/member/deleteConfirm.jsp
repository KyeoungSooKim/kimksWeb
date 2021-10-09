<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>뮤직스쿨 - 회원탈퇴</title>
<%@ include file="/WEB-INF/views/includes/common.jsp" %>
<script>
    $(document).ready(function(){

        $("#btnDelete").on("click", function(){
        	if($("#u_pw").val() == ""){
        		alert("비밀번호를 입력해주세요.");
        	}else
            if(confirm("최근 주문건이 있을 시 주문이 취소되며 모든 주문내역이 사라집니다.\n그래도 탈퇴하시겠습니까?")){
                $("#deleteForm").submit();
            }
        });

    });
    let msg = "${msg}";
    if(msg == "탈퇴실패"){
    	alert("비밀번호를 확인해주세요.");
    }
</script>
</head>
<body>
<%@include file="/WEB-INF/views/includes/header.jsp" %>
<div class="container">

<form id="deleteForm" action="/member/delete" method="post">
 <div class="row">
		<div class="col-md-4 col-md-offset-4">
    		<div class="panel panel-default">
			  	<div class="panel-heading">
			    	<h3 class="panel-title">탈퇴</h3>
			 	</div>
			  	<div class="panel-body">
			    	<form accept-charset="UTF-8" role="form">                   
			    		<div class="form-group">
			    			<input class="form-control" placeholder="비밀번호 입력" id="u_pw" name="u_pw" type="password">
			    		</div>		 
			    		<input id="btnDelete" class="btn btn-lg btn-success btn-block" type="button" value="확인">			    	
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