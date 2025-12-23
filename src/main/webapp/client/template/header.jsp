<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
	<div class="snowflakes" id="snowflakes"></div>

<header class="mainHeader " >
  <div class="container">
    <div class="header-wrapper">
      <div class="wrap-logo">
        
        <a href="/">
          <picture class="logo-black">
            <source media="(max-width: 767px)" srcset="//cdn.hstatic.net/themes/1000075078/1001392287/14/logo-mb.png?v=2213"/>
            <source media="(min-width: 768px)" srcset="//cdn.hstatic.net/themes/1000075078/1001392287/14/logo.png?v=2213"/>
            <img class="logomb-black" src="//cdn.hstatic.net/themes/1000075078/1001392287/14/logo.png?v=2213" alt=""/>
          </picture>
          <picture class="logo-white">
            <source media="(max-width: 767px)" srcset="//cdn.hstatic.net/themes/1000075078/1001392287/14/logo-mb-white.png?v=2213"/>
            <source media="(min-width: 768px)" srcset="//cdn.hstatic.net/themes/1000075078/1001392287/14/logo-white.png?v=2213"/>
            <img class="logomb-white" src="//cdn.hstatic.net/themes/1000075078/1001392287/14/ logo-white.png?v=2213" alt=""/>
          </picture>
          
        </a>			
        <h1 style="display:none"><a href="${pageContext.request.contextPath}/home">The Coffee House</a></h1>
        
      </div>
      <div class="main-nav d-none d-md-block">
        <ul>
          <li>
            <a href="${pageContext.request.contextPath}/home">TRANG CHỦ</a>
          </li>
          <li>
            <a href="${pageContext.request.contextPath}/collection">"NHÀ" COLLECTION</a>
          </li>
          <li>
            <a href="${pageContext.request.contextPath}/about-us">CHUYỆN "NHÀ"</a>
          </li>
          <li>
            <a href="https://thecoffeehouse.com/blogs/coffeeholic">TIN TỨC</a>
          </li>
          <li>
            <a href="/pages/danh-sach-cua-hang">CỬA HÀNG</a>
          </li>
          <li>
            <a href="https://thecoffeehouse.com/pages/lien-he">LIÊN HỆ</a>
          </li>
            <li class="download-app">
              <a href="https://thecoffeehouse.com/pages/chinh-sach-bao-mat-thong-tin?view=download-app" style="background: #FCECB0; color:#000000">
                APP DOWNLOAD
              </a>
            </li>
        </ul>
      </div>
      <div class="header-language d-none d-md-block">
        <ul>
          <li class="VI active">VI</li>
          <li class="EN">EN</li>
        </ul>
      </div>
      <div class="header-menu-mobile d-md-none">
        <a class="header-action__link" name="icon-menu-mobile" href="javascript:void(0)" aria-label="Menu" title="Menu">
          <span class="box-icon">								
            <span class="hamburger-menu"  aria-hidden="true">
              <svg width="31" height="32" viewBox="0 0 31 32" fill="none" xmlns="http://www.w3.org/2000/svg">
                <path d="M3.875 16H27.125M3.875 8.25H27.125M3.875 23.75H27.125" stroke="black" stroke-width="4" stroke-linecap="round" stroke-linejoin="round"/>
              </svg>
            </span>
            <span class="box-icon--close">
              <svg  viewBox="0 0 19 19" role="presentation"><path d="M9.1923882 8.39339828l7.7781745-7.7781746 1.4142136 1.41421357-7.7781746 7.77817459 7.7781746 7.77817456L16.9705627 19l-7.7781745-7.7781746L1.41421356 19 0 17.5857864l7.7781746-7.77817456L0 2.02943725 1.41421356.61522369 9.1923882 8.39339828z"  fill-rule="evenodd"></path></svg>
            </span>											
          </span>	
        </a>
      </div>
    </div>
  </div>
</header>

