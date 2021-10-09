<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<style>
  @media all and (min-width: 992px) {
    .navbar .nav-item .dropdown-menu{ display: none; }
    .navbar .nav-item:hover .nav-link{   }
    .navbar .nav-item:hover .dropdown-menu{ display: block; }
    .navbar .nav-item .dropdown-menu{ margin-top:0; }
  }
  #myBtn {
  display: none;
  position: fixed;
  bottom: 15px;
  right: 25px;
  z-index: 99;
  font-size: 18px;
  border: none;
  outline: none;
  background-color: rgb(136, 150, 163);
  color: white;
  cursor: pointer;
  padding: 15px;
  border-radius: 4px;
}

#myBtn:hover {
  background-color: #555;
}

</style>
<header>
<button onclick="topFunction()" id="myBtn" title="Go to top">Top</button>
<nav class="navbar navbar-expand-lg navbar-light bg-light">

  <a class="navbar-brand" href="/">뮤직스쿨</a>
  <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
    <span class="navbar-toggler-icon"></span>
  </button>

  <div class="collapse navbar-collapse" id="navbarSupportedContent">

    <ul class="navbar-nav mr-auto" id="categorymenu">
      <c:forEach items="${mainCategory }" var="mainCate">
      <li class="nav-item dropdown">
        <a class="nav-link dropdown-toggle" href="${mainCate.cate_code}" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
          ${mainCate.cate_name}
        </a>
        <div class="dropdown-menu" aria-labelledby="navbarDropdown">
          
        </div>
      </li>
      </c:forEach>
    </ul>
  

    <form id="searchForm" action="/product/find" method="GET" class="form-inline ">
    	<div class="form-group mb-6">
						<select name="type" class="form-control">
							<option value="N" <c:out value="${pageMaker.cri.type eq 'N'? 'selected' : '' }"/>>상품명</option>
							<option value="D" <c:out value="${pageMaker.cri.type eq 'D'? 'selected' : '' }"/>>내용</option>
							<option value="C" <c:out value="${pageMaker.cri.type eq 'C'? 'selected' : '' }"/>>제조사</option>
							<option value="ND" <c:out value="${pageMaker.cri.type eq 'ND'? 'selected' : '' }"/>>상품명+내용</option>
							<option value="NC" <c:out value="${pageMaker.cri.type eq 'NC'? 'selected' : '' }"/>>상품명+제조사</option>
							<option value="NDC" <c:out value="${pageMaker.cri.type eq 'NDC'? 'selected' : '' }"/>>상품명+내용+제조사</option>
						</select>
					</div>
					<div class="form-group mx-sm-3 mb-6">	
						<input type="text" name="keyword" class="form-control" value="<c:out value="${pageMaker.cri.keyword}"/>">
					</div>	
						<input type="hidden" name="pageNum" value=1>
						<input type="hidden" name="amount" value=4>
						<div class="form-group mx-sm-3 mb-8">	
						<button type="submit" class="btn btn-default">검색</button>
						</div>
						
	</form>

  </div>
    <c:if test="${sessionScope.loginStatus == null }">
    	<ul class="navbar-nav my-2 my-lg-0">
    		<li class="nav-item mr-sm-2"><a href="/member/login">로그인</a></li>
    		<li class="nav-item mr-sm-2"><a href="/cart/list">장바구니</a></li>
    		<li class="nav-item mr-sm-2"><a href="/order/orderCodeSearch">주문조회</a></li>
    		<li class="nav-item mr-sm-2"><a href="/member/join">회원가입</a></li>
    	</ul>
    </c:if>
    <c:if test="${sessionScope.loginStatus != null }">
    	<ul class="navbar-nav my-2 my-lg-0">
    		<li class="nav-item mr-sm-2"><a href="/member/mypage">내정보</a></li>
    		<li class="nav-item mr-sm-2"><a href="/cart/list">장바구니</a></li>
    		<li class="nav-item mr-sm-2"><a href="/order/userOrderInfo/1">주문내역</a></li>
    		<li class="nav-item mr-sm-2"><a href="/member/logout">로그아웃</a></li>
    	</ul>
    </c:if>

</nav>	
</header>
<script src="https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/3.0.3/handlebars.js"></script>
<script id="subCategoryTemplate" type="text/x-handlebars-template">
    {{#each. }}
    <a class="dropdown-item" href="{{cate_code}}">{{cate_name}}</a>
    {{/each}}
  </script>
  <script>
    let subCategoryView = function(subCategory, target, templateObject){
      let template = Handlebars.compile(templateObject.html());
      let options = template(subCategory);
      target.empty();
      target.append(options);
    }
  </script>
  <script>
    $(function () {
        $("#categorymenu li a").on("mouseover", function(e){
            e.preventDefault();
            let mainCategory = $(this).attr("href");
            let url = "/product/subCategory/" + mainCategory;
      
            $.getJSON(url, function(data){
              //console.log(data[0]);
              subCategoryView(data, $(".dropdown-menu"), $("#subCategoryTemplate"));
            });
          });

        $(".dropdown-menu").on("click","a", function(e){
            e.preventDefault();
            
            let subCategory = $(this).attr("href");
            console.log(subCategory);
            //actionForm.append("<input type='hidden' name='subCategory' value='"+subCategory+"'>");
			//actionForm.attr("action", "/product/list");
			//actionForm.submit();
			location.href = "/product/list?subCategory="+subCategory;
          });
        
        let loginForm = $("#loginForm");
        
          $("#adminLogin").on("click", function(e){
        	$("input[name='u_id']").attr("name", "admin_id");
        	$("input[name='u_pw']").attr("name", "admin_pw");
            loginForm.attr("action", "/admin/login");
            loginForm.submit();
          });
      
          $("#searchForm").on("submit", function(){
            if($("input[name='keyword']").val() == "") {
              alert("검색어를 입력해주세요.");
              return false;
            }
          });
    })
   </script>
   <script>
//Get the button
var mybutton = document.getElementById("myBtn");

// When the user scrolls down 20px from the top of the document, show the button
window.onscroll = function() {scrollFunction()};

function scrollFunction() {
  if (document.body.scrollTop > 20 || document.documentElement.scrollTop > 20) {
    mybutton.style.display = "block";
  } else {
    mybutton.style.display = "none";
  }
}

// When the user clicks on the button, scroll to the top of the document
function topFunction() {
  document.body.scrollTop = 0;
  document.documentElement.scrollTop = 0;
}
</script>