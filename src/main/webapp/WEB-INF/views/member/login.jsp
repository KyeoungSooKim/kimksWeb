<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>뮤직스쿨 - 로그인</title>
<%@ include file="/WEB-INF/views/includes/common.jsp" %>
<style>
.login-container{
    margin-top: 5%;
    margin-bottom: 5%;
}
.login-form-1{
    padding: 5%;
    box-shadow: 0 5px 8px 0 rgba(0, 0, 0, 0.2), 0 9px 26px 0 rgba(0, 0, 0, 0.19);
}
.login-form-1 h3{
    text-align: center;
    color: #333;
}
.login-form-2{
    padding: 5%;
    background: #0062cc;
    box-shadow: 0 5px 8px 0 rgba(0, 0, 0, 0.2), 0 9px 26px 0 rgba(0, 0, 0, 0.19);
}
.login-form-2 h3{
    text-align: center;
    color: #fff;
}
.login-container form{
    padding: 10%;
}
.btnSubmit
{
    width: 50%;
    border-radius: 1rem;
    padding: 1.5%;
    border: none;
    cursor: pointer;
}
.login-form-1 .btnSubmit{
    font-weight: 600;
    color: #fff;
    background-color: #0062cc;
}
.login-form-2 .btnSubmit{
    font-weight: 600;
    color: #0062cc;
    background-color: #fff;
}
.login-form-2 .ForgetPwd{
    color: #fff;
    font-weight: 600;
    text-decoration: none;
}
.login-form-1 .ForgetPwd{
    color: #0062cc;
    font-weight: 600;
    text-decoration: none;
}
</style>
<script>
    $(document).ready(function(){

    	  $("#loginForm").on("submit", function(){
    	      if($("#u_id").val() == "") {
    	        alert("아이디를 입력해주세요.");
    	        return false;
    	      }else if($("#u_pw").val() == "") {
    	    	  alert("비밀번호를 입력해주세요.");
    	          return false; 
    	      }
    	    });

    });
    let msg = "${msg}";
   if(msg == "로그인실패"){
    	alert("비밀번호를 확인해주세요.");
    }
</script>
</head>
<body>
<%@include file="/WEB-INF/views/includes/header.jsp" %>
<div class="container login-container">
            <div class="row">
                <div class="col-md-7 login-form-1">
                    <h3>로그인</h3>
                    <form id="loginForm" action="/member/login" method="post">
                        <div class="form-group">
                            <input type="text" class="form-control" id="u_id" name="u_id" placeholder="아이디" />
                        </div>
                        <div class="form-group">
                            <input type="password" class="form-control" id="u_pw" name="u_pw" placeholder="비밀번호" />
                        </div>
                        <div class="form-group">
                            <input type="submit" class="btnSubmit" value="로그인" />
                        </div>
                        <div class="form-group"> 
					    <div class="checkbox">
					      <label> <input type="checkbox" name="rememberLogin"> 자동로그인 </label>
					    </div> 
					    </div> 
                        <div class="form-group">
                            <a href="/member/findIDPW" class="ForgetPwd">ID/PW찾기</a>
                        </div>
                    </form>
                </div>
            </div>
        </div>
<%@include file="/WEB-INF/views/includes/footer.jsp" %>
</body>
</html>