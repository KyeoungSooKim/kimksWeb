<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>뮤직스쿨 - 관리자로그인</title>
<style>
.login-block{
float:left;
width:100%;
padding : 50px 0;
}

.container{background:#D3D3D3; border-radius: 10px; width: 40%; height: 40%;}
.login-sec{padding: 50px 30px; position:relative;}
.login-sec h2{margin-bottom:30px; font-weight:800; font-size:30px; color: #0069c0;}
.login-sec h2:after{content:" "; width:100px; height:5px; background:#6ec6ff; display:block; margin-top:20px; border-radius:3px; margin-left:auto;margin-right:auto}
.btn-login{background: #0069c0; color:#fff; font-weight:600;}
</style>

<%@ include file="/WEB-INF/views/includes/common.jsp" %>
<script>
let msg = "${msg}";
if(msg == "loginFail"){
	alert("비밀번호가 올바르지 않습니다.");
}
</script>
</head>
<body>

<section class="login-block">
    <div class="container">
	<div class="row ">
		<div class="col login-sec">
		    <h2 class="text-center">관리자 로그인</h2>
 <form class="login-form" action="/admin/login" method="post">
  <div class="form-group">
    <label for="exampleInputEmail1" class="text-uppercase">아이디</label>
    <input type="text" class="form-control" name="admin_id">
    
  </div>
  <div class="form-group">
    <label for="exampleInputPassword1" class="text-uppercase">비밀번호</label>
    <input type="password" class="form-control" name="admin_pw">
  </div>
  
  
   <div class="form-check">
    <button type="submit" class="btn btn-login float-right">로그인</button>
  </div>
  
</form>
  </div>
    </div>
    </div>
</section>
</body>
</html>