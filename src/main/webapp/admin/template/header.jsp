<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<div id="wrapper">

    <ul class="navbar-nav bg-gradient-primary sidebar sidebar-dark accordion" id="accordionSidebar">

        <a class="sidebar-brand d-flex align-items-center justify-content-center" href="${pageContext.request.contextPath}/admin/hierarchy">
            <div class="sidebar-brand-icon rotate-n-15">
                <i class="fas fa-coffee"></i>
            </div>
            <div class="sidebar-brand-text mx-3">Coffee Admin</div>
        </a>

        <hr class="sidebar-divider my-0">

        <hr class="sidebar-divider">

        <div class="sidebar-heading">Quản lý</div>

        <li class="nav-item" id="nav-hierarchy">
            <a class="nav-link" href="${pageContext.request.contextPath}/admin/hierarchy">
                <i class="fas fa-sitemap"></i>
                <span>Menu (Phân cấp)</span>
            </a>
        </li>

        <li class="nav-item" id="nav-product">
            <a class="nav-link" href="${pageContext.request.contextPath}/admin/products">
                <i class="fas fa-box-open"></i>
                <span>Sản phẩm</span>
            </a>
        </li>
         <li class="nav-item" id="nav-product">
            <a class="nav-link" href="${pageContext.request.contextPath}/admin/about-manager">
                <i class="fas fa-box-open"></i>
                <span>Trang</span>
            </a>
        </li>

        <hr class="sidebar-divider d-none d-md-block">

        <div class="text-center d-none d-md-inline">
            <button class="rounded-circle border-0" id="sidebarToggle"></button>
        </div>

    </ul>
    <div id="content-wrapper" class="d-flex flex-column">

        <div id="content">

            <nav class="navbar navbar-expand navbar-light bg-white topbar mb-4 static-top shadow">

                <button id="sidebarToggleTop" class="btn btn-link d-md-none rounded-circle mr-3">
                    <i class="fa fa-bars"></i>
                </button>
                
                <h3 class="h3 mb-0 text-gray-800 ml-2">Hệ thống quản trị</h3>

                <ul class="navbar-nav ml-auto">
                    <div class="topbar-divider d-none d-sm-block"></div>
                    <li class="nav-item dropdown no-arrow">
                        <a class="nav-link dropdown-toggle" href="#" id="userDropdown" role="button" data-toggle="dropdown">
                            <span class="mr-2 d-none d-lg-inline text-gray-600 small">Administrator</span>
                            <img class="img-profile rounded-circle" src="https://source.unsplash.com/QAB-WJcbgJk/60x60">
                        </a>
                    </li>
                </ul>

            </nav>
