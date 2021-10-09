<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>뮤직스쿨 - 마이페이지</title>
<%@ include file="/WEB-INF/views/includes/common.jsp" %>
<script>
let msg = "${msg}";
if(msg == "비밀번호변경성공"){
	  alert("비밀번호가 변경되었습니다.");
}else if(msg == "수정성공"){
	  alert("회원정보가 수정되었습니다.");
}
</script>
</head>
<body>
<%@include file="/WEB-INF/views/includes/header.jsp" %>
<article class="container">
<form class="form-horizontal">
<fieldset>

<legend>마이페이지</legend>

<div class="form-group">
  <label class="col-md-4 control-label" for="u_name">이름</label>  
  <div class="col-md-4">
  <input id="u_id" name="u_name" type="text" class="form-control input-md" value="${memberVO.u_name }" readonly>  
  </div>
</div>

<div class="form-group">
  <label class="col-md-4 control-label" for="u_id">아이디</label>  
  <div class="col-md-4">
  <input id="u_id" name="u_id" type="text" class="form-control input-md" value="${memberVO.u_id }" readonly>
  </div>
</div>

<div class="form-group">
  <label class="col-md-4 control-label" for="u_email">이메일</label>  
  <div class="col-md-4">
  <input id="u_email" name="u_email" type="text" class="form-control input-md" value="${memberVO.u_email }" readonly>
    
  </div>
</div>

<div class="form-group">
  <label class="col-md-4 control-label" for="sample2_postcode">우편번호</label>  
  <div class="col-md-4">
  <input id="sample2_postcode" name="u_zipcode" type="text" class="form-control input-md" value="${memberVO.u_zipcode }" readonly>  
  </div>
</div>

<div class="form-group">
  <label class="col-md-4 control-label" for="sample2_address">기본주소</label>  
  <div class="col-md-4">
  <input id="sample2_address" name="u_addr" type="text" class="form-control input-md" value="${memberVO.u_addr }" readonly>  
  </div>
</div>

<div class="form-group">
  <label class="col-md-4 control-label" for="sample2_detailAddress">상세주소</label>  
  <div class="col-md-4">
  <input id="sample2_detailAddress" name="u_addr_d" type="text" class="form-control input-md" value="${memberVO.u_addr_d }" readonly>
  <input type="hidden" id="sample2_extraAddress" placeholder="참고항목"> 
  </div>
</div>

<div class="form-group">
  <label class="col-md-4 control-label" for="u_phone">전화번호</label>  
  <div class="col-md-4">
  <input id="u_phone" name="u_phone" type="text" class="form-control input-md" value="${memberVO.u_phone }" readonly>   
  </div>
</div>
<!-- Button (Double) -->
<div class="form-group">
  <label class="col-md-4 control-label" for="save"></label>
  <div class="col-md-8">
    <button id="save" type="button" class="btn btn-success" onclick="location.href='/member/modify';">내 정보 수정</button>
    <button id="clear" type="button" class="btn btn-danger" onclick="location.href='/member/changePW';">비밀번호 변경</button>
    <button id="clear" type="button" class="btn btn-danger" onclick="location.href='/member/deleteConfirm';">회원탈퇴</button>
  </div>
</div>

</fieldset>
</form>
</article>
<%@include file="/WEB-INF/views/includes/footer.jsp" %>

</body>
</html>