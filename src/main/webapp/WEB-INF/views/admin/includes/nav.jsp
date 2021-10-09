<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.kimks.util.SessionConfig" %>
 <aside class="main-sidebar">

    <!-- sidebar: style can be found in sidebar.less -->
    <section class="sidebar">

      <!-- Sidebar user panel (optional) -->
      <div class="user-panel">
        <div class="pull-left image">
          <img src="/dist/img/user2-160x160.jpg" class="img-circle" alt="User Image">
        </div>
        <div class="pull-left info">
          <p>방문자 수:<%=SessionConfig.getVisitTotalCount() %></p>
          <!-- Status -->
          <p>현재 접속자 수:<%=SessionConfig.getCurrentCount() %></p>
        </div>
      </div>

      

      <!-- Sidebar Menu -->
      <ul class="sidebar-menu" data-widget="tree">
        <li class="header">HEADER</li>
        <!-- Optionally, you can add icons to the links -->
        <li class="active"><a href="/"><i class="fa fa-link"></i> <span>뮤직스쿨 홈</span></a></li>
        <li><a href="/admin/adminMain"><i class="fa fa-link"></i> <span>관리자 홈</span></a></li>
        <li class="treeview">
          <a href="#"><i class="fa fa-link"></i> <span>배너관리</span>
            <span class="pull-right-container">
                <i class="fa fa-angle-left pull-right"></i>
              </span>
          </a>
          <ul class="treeview-menu">
         	<li><a href="/admin/banner/edit">배너관리</a></li>
            <li><a href="/admin/banner/insert">배너추가</a></li>     
          </ul>
        </li>
        <li class="treeview">
          <a href="#"><i class="fa fa-link"></i> <span>상품관리</span>
            <span class="pull-right-container">
                <i class="fa fa-angle-left pull-right"></i>
              </span>
          </a>
          <ul class="treeview-menu">
            <li><a href="/admin/product/list">상품리스트</a></li>
            <li><a href="/admin/product/insert">상품등록</a></li>
          </ul>
        </li>
        <li class="treeview">
          <a href="#"><i class="fa fa-link"></i> <span>주문관리</span>
            <span class="pull-right-container">
                <i class="fa fa-angle-left pull-right"></i>
              </span>
          </a>
          <ul class="treeview-menu">
            <li><a href="/admin/order/list">주문리스트(전체)</a></li>
          </ul>
        </li>
        <li class="treeview">
          <a href="#"><i class="fa fa-link"></i> <span>회원관리</span>
            <span class="pull-right-container">
                <i class="fa fa-angle-left pull-right"></i>
              </span>
          </a>
          <ul class="treeview-menu">
            <li><a href="/admin/member/list">회원리스트</a></li>
            
          </ul>
        </li>
        <li class="treeview">
          <a href="#"><i class="fa fa-link"></i> <span>통계관리</span>
            <span class="pull-right-container">
                <i class="fa fa-angle-left pull-right"></i>
              </span>
          </a>
          <ul class="treeview-menu">
            <li><a href="/admin/chart/statistics">연도별 매출통계</a></li>
            <li><a href="/admin/chart/monthStatistics">월별 매출통계</a></li>
            <li><a href="/admin/chart/weekStatistics">주간 매출통계</a></li>
   		  </ul>
       <li class="treeview">
          <a href="#"><i class="fa fa-link"></i> <span>계정관리</span>
            <span class="pull-right-container">
                <i class="fa fa-angle-left pull-right"></i>
              </span>
          </a>
          <ul class="treeview-menu">
            <li><a href="/admin/adminPWChange">비밀번호변경</a></li>
          </ul>
        </li>
        </ul>
      <!-- /.sidebar-menu -->
    </section>
    <!-- /.sidebar -->
  </aside>