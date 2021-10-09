<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script>
$(function(){
    //ajax 전송되기 전에 호출됨
    /*
    $(document).ajaxSend(function(event, request, settings){
        request.setRequestHeader("AJAX", "true");
    });
    */
    //ajax 에러처리
    $(document).ajaxError(function(event, request, settings, thrownError){
        if(request.status == 500 || request.status == 0){
        	alert("Ajax Error"+request.status);
            location.href = "/admin/main";
        }else {
            alert("다음위치에서 에러가 발생. 관리자에게 문의바람\n"+settings.url);
        }
    });
});
</script>   
  <footer class="main-footer">
    <!-- To the right -->
    <div class="pull-right hidden-xs">
      Anything you want
    </div>
    <!-- Default to the left -->
    <strong>Copyright &copy; 2016 <a href="#">Company</a>.</strong> All rights reserved.
  </footer>