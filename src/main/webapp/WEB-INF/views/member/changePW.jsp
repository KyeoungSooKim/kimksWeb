<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>뮤직스쿨 - 비밀번호변경</title>
<%@ include file="/WEB-INF/views/includes/common.jsp" %>
<script>
  $(document).ready(function(){
	
    $("#pwForm").on("submit", function(){
      if($("#u_pw").val() == $("#u_npw").val()) {
        alert("이전과 동일한 비밀번호로 변경할 수 없습니다.");
        return false;
      }else if($("#u_npw").val() != $("#u_nnpw").val()) {
    	  alert("새 비밀번호가 일치하지 않습니다.");
          return false; 
      }
    });

  });
  
  let msg = "${msg}";
  if(msg == "비밀번호변경실패"){
	  alert("현재 비밀번호를 확인해주세요.");
  }
</script>
</head>
<body>
<%@include file="/WEB-INF/views/includes/header.jsp" %>
<article class="container">
<div class="box box-info">
            <div class="box-header with-border">
              <h3 class="box-title">비밀번호 변경</h3>
            </div>
            <!-- /.box-header -->
            <!-- form start -->
            <form class="form-horizontal" id="pwForm" action="/member/changePW" method="post">
              <div class="box-body">
                <div class="form-group">
                  <label for="u_pw" class="col-sm-2 control-label">현재 비밀번호</label>

                  <div class="col-sm-10">
                    <input type="password" class="form-control" id="u_pw" name="u_pw" required >
                  </div>
                </div>
                <div class="form-group">
                  <label for="u_npw" class="col-sm-2 control-label">새 비밀번호</label>

                  <div class="col-sm-10">
                    <input type="password" class="form-control" id="u_npw" name="u_npw" required>
                  </div>
                </div>
                
                 <div class="form-group">
                  <label for="u_nnpw" class="col-sm-2 control-label">새 비밀번호 확인</label>

                  <div class="col-sm-10">
                    <input type="password" class="form-control" id="u_nnpw" required>
                  </div>
       
                </div>
              </div>
              <!-- /.box-body -->
              <div class="box-footer">
                <button type="button" onclick="location.href='/member/mypage';" class="btn btn-default">취소</button>
                <button type="submit" id="btnModify" class="btn btn-info pull-right">변경</button>
              </div>
              <!-- /.box-footer -->
            </form>
          </div>
</article>
<%@include file="/WEB-INF/views/includes/footer.jsp" %>
</body>
</html>