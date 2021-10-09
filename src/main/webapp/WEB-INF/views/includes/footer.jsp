<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!--
<script>
    //ajax 전송되기 전에 호출됨
    $(document).ajaxSend(function(event, request, settings){
        request.setRequestHeader("AJAX", "true");
    });
    //ajax 에러처리
    $(document).ajaxError(function(event, request, settings, thrownError){
        if(request.status == -1 ||| request.status == 0){
            location.href = "/member/login";
        }else {
            alert("다음위치에서 에러가 발생. 관리자에게 문의바람\n"+settings.url);
        }
    });
</script>
-->

<div class="jumbotron jumbotron-fluid pt-4 my-md-5 pt-md-5">
<footer class="container-fluid navbar ">
    <p>
                    사업자: 123-23-12345 |
                    상호: 뮤직스쿨 |
                    대표자: 김경수 |
                    소재지: 서울 동작구 사당로 1111 101-A11
           <br>                        
                    문자: 02-1111-1111 |
                    이메일: kimks3971@naver.com |
                   고객지원(광고문의): 플러스친구 kimks
    </p>  
    </footer> 
    </div>        

