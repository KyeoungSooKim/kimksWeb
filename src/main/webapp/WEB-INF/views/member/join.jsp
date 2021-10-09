<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>뮤직스쿨 - 회원가입</title>
<%@ include file="/WEB-INF/views/includes/common.jsp" %>
<script>
  var iRegExp = /^(?=.*[a-zA-Z])(?=.*[^a-zA-Z0-9]|.*[0-9]).{4,12}$/;
  var pRegExp = /^[0-9]{2,3}-[0-9]{3,4}-[0-9]{4}$/;
  var eRegExp = /^([\w-]+(?:\.[\w-]+)*)@((?:[\w-]+\.)*\w[\w-]{0,66})\.([a-z]{2,6}(?:\.[a-z]{2})?)$/;

  
    $(document).ready(function(){



        $("#btnUserIdCheck").on("click", function(e){
            
            let u_id = $("#u_id");

            if(u_id.val() == "" || u_id.val() == null){
                alert("아이디를 입력하세요");
                $("#idCheck").html("");
                u_id.focus();
                return;
            }else if(!iRegExp.test(u_id.val())){
                alert("아이디 형식이 맞지않습니다.");
                $("#idCheck").html("");
                u_id.focus();
                return;
            }
            $.ajax({
                url:'/member/idCheck',
                type:'post',
                dataType:'text',
                data:{u_id: u_id.val()},
                success: function(data){
                    console.log(data);
                    if(data=="yes"){
                        $("#idCheck").html("아이디 사용가능합니다.");
                    }else{
                        $("#idCheck").html("아이디가 존재합니다.");
                        u_id.val("");
                    }
                }
            });
        });
    });
    
    function sendit(){
    	if(document.getElementById("u_name").value == "") {
    		alert("이름을 입력해주세요.");
    		document.getElementById("u_name").focus();
    		return;
    	}else if(document.getElementById("u_id").value == "") {
    		alert("아이디를 입력해주세요.");
    		document.getElementById("u_id").focus();
    		return;
    	}else if(document.getElementById("u_pw").value == "") {
    		alert("비밀번호를 입력해주세요.");
    		document.getElementById("u_pw").focus();
    		return;
    	}else if(document.getElementById("u_cpw").value == "") {
    		alert("비밀번호를 확인해주세요.");
    		document.getElementById("u_cpw").focus();
    		return;
    	}else if(document.getElementById("u_email").value == "") {
    		alert("이메일을 입력해주세요.");
    		document.getElementById("u_email").focus();
    		return;
    	}else if(!eRegExp.test(document.getElementById("u_email").value)) {
    		alert("이메일 형식에 맞게 입력해주세요.");
    		document.getElementById("u_email").focus();
    		return;
    	}else if(document.getElementById("sample2_postcode").value == "") {
    		alert("우편번호를 입력해주세요.");
    		document.getElementById("sample2_postcode").focus();
    		return;
    	}else if(document.getElementById("sample2_address").value == "") {
    		alert("주소를 입력해주세요.");
    		document.getElementById("sample2_address").focus();
    		return;
    	}else if(document.getElementById("sample2_detailAddress").value == "") {
    		alert("상세주소를 입력해주세요.");
    		document.getElementById("sample2_detailAddress").focus();
    		return;
    	}else if(document.getElementById("u_phone").value == "") {
    		alert("전화번호를 입력해주세요.");
    		document.getElementById("u_phone").focus();
    		return;
    	}else if(!pRegExp.test(document.getElementById("u_phone").value)) {
    		alert("전화번호 형식에 맞게 입력해주세요.");
    		document.getElementById("u_phone").focus();
    		return;
    	}else if(document.getElementById("u_pw").value != document.getElementById("u_cpw").value) {
    		alert("비밀번호를 확인해주세요.");
    		document.getElementById("u_cpw").focus();
    		return;
    	}else if(document.getElementById("idCheck").innerHTML == "") {
    		alert("중복검사를 해주세요.");
    		document.getElementById("u_id").focus();
    		return;
    	}
    		document.getElementById("joinForm").submit();	
    }
</script>
</head>
<body>
<%@include file="/WEB-INF/views/includes/header.jsp" %>
<article class="container">
<form id="joinForm" class="form-horizontal" action="/member/join" method="post">
<fieldset>

<!-- Form Name -->
<legend>회원가입</legend>

<!-- Text input-->
<div class="form-group">
  <label class="col-md-4 control-label" for="u_name">이름</label>  
  <div class="col-md-4">
  <input id="u_name" name="u_name" type="text" class="form-control input-md" required="">
    
  </div>
</div>

<!-- Text input-->
<div class="form-group">
  <label class="col-md-4 control-label" for="u_id">아이디</label>  
  <div class="col-md-4">
  <input id="u_id" name="u_id" type="text" class="form-control input-md" required=""><div style="color: gray;">4~12자의 영문 대소문자와 숫자 혼합(특수문자 사용가능)</div>
  <button id="btnUserIdCheck" class="btn btn-light" type="button" >중복검사</button><span id="idCheck"></span>
  </div>
</div>

<!-- Text input-->
<div class="form-group">
  <label class="col-md-4 control-label" for="u_pw">비밀번호</label>  
  <div class="col-md-4">
  <input id="u_pw" name="u_pw" type="password" class="form-control input-md">
    
  </div>
</div>

<!-- Password input-->
<div class="form-group">
  <label class="col-md-4 control-label" for="u_cpw">비밀번호 확인</label>
  <div class="col-md-4">
    <input id="u_cpw" type="password" placeholder="비밀번호 확인" class="form-control input-md">
    
  </div>
</div>
<!-- Text input-->
<div class="form-group">
  <label class="col-md-4 control-label" for="u_email">이메일</label>  
  <div class="col-md-4">
  <input id="u_email" name="u_email" type="text" class="form-control input-md" placeholder="email@naver.com">
    
  </div>
</div>

<div class="form-group">
  <label class="col-md-4 control-label" for="sample2_postcode">우편번호</label>  
  <div class="col-md-4">
  <input id="sample2_postcode" name="u_zipcode" type="text" class="form-control input-md">
  <button class="btn btn-light" type="button" onclick="sample2_execDaumPostcode()">우편번호 찾기</button>  
  </div>
</div>

<div class="form-group">
  <label class="col-md-4 control-label" for="sample2_address">기본주소</label>  
  <div class="col-md-4">
  <input id="sample2_address" name="u_addr" type="text" class="form-control input-md">
  </div>
</div>

<div class="form-group">
  <label class="col-md-4 control-label" for="sample2_detailAddress">상세주소</label>  
  <div class="col-md-4">
  <input id="sample2_detailAddress" name="u_addr_d" type="text" class="form-control input-md">
  <input type="hidden" id="sample2_extraAddress"> 
  </div>
</div>

<div class="form-group">
  <label class="col-md-4 control-label" for="u_phone">전화번호</label>  
  <div class="col-md-4">
  <input id="u_phone" name="u_phone" type="text" class="form-control input-md" placeholder="'-'를 입력해주세요">
  </div>
</div>

<div class="form-group">
  <label class="col-md-4 control-label" for="save"></label>
  <div class="col-md-8">
    <button id="btnSubmit" class="btn btn-success" type="button" onclick="sendit();">가입하기</button>
    <button id="clear" name="clear" class="btn btn-danger" type="reset">다시작성</button>
  </div>
</div>

</fieldset>
</form>
</article>
<%@include file="/WEB-INF/views/includes/footer.jsp" %>
<!-- 다음 우편번호 API -->
<div id="layer" style="display:none;position:fixed;overflow:hidden;z-index:1;-webkit-overflow-scrolling:touch;">
<img src="//t1.daumcdn.net/postcode/resource/images/close.png" id="btnCloseLayer" style="cursor:pointer;position:absolute;right:-3px;top:-3px;z-index:1" onclick="closeDaumPostcode()" alt="닫기 버튼">
</div>
<!-- iOS에서는 position:fixed 버그가 있음, 적용하는 사이트에 맞게 position:absolute 등을 이용하여 top,left값 조정 필요 -->
<div id="layer" style="display:none;position:fixed;overflow:hidden;z-index:1;-webkit-overflow-scrolling:touch;">
<img src="//t1.daumcdn.net/postcode/resource/images/close.png" id="btnCloseLayer" style="cursor:pointer;position:absolute;right:-3px;top:-3px;z-index:1" onclick="closeDaumPostcode()" alt="닫기 버튼">
</div>

<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
    // 우편번호 찾기 화면을 넣을 element
    var element_layer = document.getElementById('layer');

    function closeDaumPostcode() {
        // iframe을 넣은 element를 안보이게 한다.
        element_layer.style.display = 'none';
    }

    function sample2_execDaumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                // 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var addr = ''; // 주소 변수
                var extraAddr = ''; // 참고항목 변수

                //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                    addr = data.roadAddress;
                } else { // 사용자가 지번 주소를 선택했을 경우(J)
                    addr = data.jibunAddress;
                }

                // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
                if(data.userSelectedType === 'R'){
                    // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                    // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                    if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                        extraAddr += data.bname;
                    }
                    // 건물명이 있고, 공동주택일 경우 추가한다.
                    if(data.buildingName !== '' && data.apartment === 'Y'){
                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                    }
                    // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                    if(extraAddr !== ''){
                        extraAddr = ' (' + extraAddr + ')';
                    }
                    // 조합된 참고항목을 해당 필드에 넣는다.
                    document.getElementById("sample2_extraAddress").value = extraAddr;
                
                } else {
                    document.getElementById("sample2_extraAddress").value = '';
                }

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById('sample2_postcode').value = data.zonecode;
                document.getElementById("sample2_address").value = addr;
                // 커서를 상세주소 필드로 이동한다.
                document.getElementById("sample2_detailAddress").focus();

                // iframe을 넣은 element를 안보이게 한다.
                // (autoClose:false 기능을 이용한다면, 아래 코드를 제거해야 화면에서 사라지지 않는다.)
                element_layer.style.display = 'none';
            },
            width : '100%',
            height : '100%',
            maxSuggestItems : 5
        }).embed(element_layer);

        // iframe을 넣은 element를 보이게 한다.
        element_layer.style.display = 'block';

        // iframe을 넣은 element의 위치를 화면의 가운데로 이동시킨다.
        initLayerPosition();
    }

    // 브라우저의 크기 변경에 따라 레이어를 가운데로 이동시키고자 하실때에는
    // resize이벤트나, orientationchange이벤트를 이용하여 값이 변경될때마다 아래 함수를 실행 시켜 주시거나,
    // 직접 element_layer의 top,left값을 수정해 주시면 됩니다.
    function initLayerPosition(){
        var width = 300; //우편번호서비스가 들어갈 element의 width
        var height = 400; //우편번호서비스가 들어갈 element의 height
        var borderWidth = 5; //샘플에서 사용하는 border의 두께

        // 위에서 선언한 값들을 실제 element에 넣는다.
        element_layer.style.width = width + 'px';
        element_layer.style.height = height + 'px';
        element_layer.style.border = borderWidth + 'px solid';
        // 실행되는 순간의 화면 너비와 높이 값을 가져와서 중앙에 뜰 수 있도록 위치를 계산한다.
        element_layer.style.left = (((window.innerWidth || document.documentElement.clientWidth) - width)/2 - borderWidth) + 'px';
        element_layer.style.top = (((window.innerHeight || document.documentElement.clientHeight) - height)/2 - borderWidth) + 'px';
    }
</script>
</body>
</html>