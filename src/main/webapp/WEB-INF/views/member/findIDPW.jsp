<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>뮤직스쿨 - ID/PW찾기</title>
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

        $("#btnDelete").on("click", function(){
            if(confirm("탈퇴하시겠습니까?")){
                $("#deleteForm").submit();
            }
        });

    });
    let msg = "${msg}";
    if(msg == "notFound"){
    	alert("정보가 올바르지 않습니다.");
    }
    function sendId(){
    	if(document.getElementById("id_name").value == "") {
    		alert("이름을 입력해주세요.");
    		document.getElementById("id_name").focus();
    		return;
    	}else if(document.getElementById("id_email").value == "") {
    		alert("이메일을 입력해주세요.");
    		document.getElementById("id_email").focus();
    		return;
    	}
    		document.getElementById("idForm").submit();
    }
</script>
</head>
<body>
<%@include file="/WEB-INF/views/includes/header.jsp" %>
<div class="container login-container">
            <div class="row">
                <div class="col-md-6 login-form-1">
                    <h3>아이디 찾기</h3>
                    <form id="idForm" action="/member/findID" method="post">
                        <div class="form-group">
                            이름<input type="text" class="form-control" id="id_name" name="u_name" placeholder="이름" />
                        </div>
                        <div class="form-group">
                            이메일<input type="email" class="form-control" id="id_email" name="u_email" placeholder="이메일" />
                        </div>
                        <div class="form-group">
                            <input type="button" id="btnID" class="btnSubmit" onclick="" value="찾기" />
                        </div> 
                        <div class="form-group">
                        </div>
                    </form>
                </div>
                <div class="col-md-6 login-form-2">
                    <h3>비밀번호 찾기</h3>
                    <form id="pwForm" action="/email/send" method="post">
                        <div class="form-group">
				             <span style="color: white;">아이디</span>
				             <input type="text" class="form-control" id="u_id" name="u_id" placeholder="아이디" />
                        </div>
                        <div class="form-group">
                            <span style="color: white;">이메일</span>
                            <input type="email" class="form-control" id="u_email" name="u_email" placeholder="이메일" />
                        </div>
                        <div class="form-group">
                            <input type="button" id="btnEmail" class="btnSubmit" value="찾기" />
                        </div>
                        <div class="form-group">
                        </div>
                    </form>
                </div>
            </div>
        </div>
<script>
    $(document).ready(function(){

        $("#btnEmail").on("click",function(){
            let u_id = $("#u_id").val();
            let u_email = $("#u_email").val();
            if(u_id == ""){
                alert("아이디를 입력해주세요.");
                $("#u_id").focus();
            }else if(u_email == ""){
                alert("이메일을 입력해주세요.");
                $("#u_email").focus();
            }else{
                $.ajax({
                    url:"/email/send",
                    type:"post",
                    dataType:"text",
                    data:{
                        u_id: u_id, u_email: u_email
                    },
                    success: function(data){
                        if(data=="success"){
                            alert("임시비밀번호가 메일로 발송되었습니다.");
                        }else{
                            alert("정보가 올바르지 않습니다.");
                        }
                    }         
                });
            }
            
        });

        $("#btnID").on("click",function(){
            let id_name = $("#id_name").val();
            let id_email = $("#id_email").val();
            if(id_name == ""){
                alert("이름을 입력해주세요.");
                $("#id_name").focus();
            }else if(id_email == ""){
                alert("이메일을 입력해주세요.");
                $("#id_email").focus();
            }else{
                $.ajax({
                    url:"/member/findID",
                    type:"post",
                    dataType:"text",
                    data:{
                        u_name: id_name, u_email: id_email
                    },
                    success: function(data){
                        if(data!="fail"){
                            alert("회원 아이디는 "+ data + "입니다.");
                        }else{
                            alert("정보가 올바르지 않습니다.");
                        }
                    }         
                });
            }
            
        });

    });
</script>
<%@include file="/WEB-INF/views/includes/footer.jsp" %>
</body>
</html>