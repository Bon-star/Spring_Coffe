<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <%@ include file="template/headLink.jsp"%>
    <title>Thực đơn - The Coffee House</title>
    
    <link rel="stylesheet" href="${pageContext.request.contextPath}/client/css/collection.css">
</head>

<body class="mainBody-theme temp-index">
    <div class="mainHeader--height header-index">
        <%@ include file="template/header.jsp"%>
    </div>
    
    <main class="body-main">
        <div id="collection">
            <div class="collection-banner">
                <div class="collection-banner-slider swiper">
                    <div class="swiper-wrapper">
                        <div class="item swiper-slide"><img src="https://file.hstatic.net/1000075078/file/banner-collection.jpg" alt="Banner" /></div>
                    </div>
                </div>
            </div>

            <div class="menu-horizontal-wrap">
                <div class="container">
                    <ul class="menu-horizontal">
                        <c:forEach var="root" items="${menuTree}" varStatus="status">
                            <li class="menu-item-horizontal">
                                <a href="#section-root-${root.id}">
                                    <c:choose>
                                        <c:when test="${root.id == 1 || status.index == 0}">
                                            <svg viewBox="0 0 24 24"><path d="M12 2C6.48 2 2 6.48 2 12s4.48 10 10 10 10-4.48 10-10S17.52 2 12 2zm-1 17.93c-3.95-.49-7-3.85-7-7.93 0-.62.08-1.21.21-1.79L9 15v1c0 1.1.9 2 2 2v1.93zm6.9-2.54c-.26-.81-1-1.39-1.9-1.39h-1v-3c0-.55-.45-1-1-1H8v-2h2c.55 0 1-.45 1-1V7h2c1.1 0 2-.9 2-2v-.41c2.93 1.19 5 4.06 5 7.41 0 2.08-.8 3.97-2.1 5.39z"/></svg>
                                        </c:when>
                                        <c:when test="${root.name.contains('Cà phê') || root.name.contains('Coffee')}">
                                            <svg viewBox="0 0 24 24"><path d="M18.5 3H6c-1.1 0-2 .9-2 2v5.71c0 3.83 2.95 7.18 6.78 7.29 3.96.12 7.22-3.06 7.22-7v-1h.5c1.93 0 3.5-1.57 3.5-3.5S20.43 3 18.5 3zM16 8.99c0 2.2-.41 4.25-1.43 6.01C13.43 14.33 12.33 14 11.02 14c-.37 0-.73.03-1.08.08C12.44 12.18 14.15 9.77 14.15 7h-2.3c0 3.97-2.17 7.42-5.4 9.38C6.98 15.34 8.79 12.59 11 11.05V5h7v3.99zm2.5-1.99h-1.5v-2h1.5c.83 0 1.5.67 1.5 1.5s-.67 1.5-1.5 1.5z"/></svg>
                                        </c:when>
                                        <c:when test="${root.name.contains('Trà') || root.name.contains('Tea')}">
                                            <svg viewBox="0 0 24 24"><path d="M20 3H4v10c0 2.21 1.79 4 4 4h6c2.21 0 4-1.79 4-4v-3h2c1.1 0 2-.9 2-2V5c0-1.1-.9-2-2-2zm0 5h-2V5h2v3zM4 19h16v2H4z"/></svg>
                                        </c:when>
                                        <c:otherwise>
                                            <svg viewBox="0 0 24 24"><path d="M12 2C6.48 2 2 6.48 2 12s4.48 10 10 10 10-4.48 10-10S17.52 2 12 2zm1 15h-2v-6h2v6zm0-8h-2V7h2v2z"/></svg>
                                        </c:otherwise>
                                    </c:choose>
                                    ${root.name}
                                </a>
                            </li>
                        </c:forEach>
                    </ul>
                </div>
            </div>

            <div id="collection-wrap">
                <div class="container">
                    <div class="collection-title" style="margin-top: 30px;">
                        <div class="collection-title-heading">
                            <div class="subtitle" style="color: #888;">MỜI BẠN CHỌN</div>
                            <div class="title" style="color: #fff;">DANH MỤC SẢN PHẨM</div>
                        </div>
                    </div>

                    <div class="collection-section-wrap">
                        <c:forEach var="root" items="${menuTree}">
                            <section class="py-5" id="section-root-${root.id}">
                                <div class="row">
                                    
                                    <div class="col-md-3">
                                        <div class="sticky-menu">
                                            <h2 class="sticky-menu-title">
                                                <span>${root.name} <sup class="count">${root.categories.size()}</sup></span>
                                            </h2>
                                            <div class="sticky-menu-lists">
                                                <c:forEach var="cat" items="${root.categories}">
                                                    <a href="#section-cat-${cat.id}" class="menu-item">${cat.name}</a>
                                                </c:forEach>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="col-md-9">
                                        <c:forEach var="cat" items="${root.categories}">
                                            <div class="section-product-wrap" id="section-cat-${cat.id}">
                                                <h4 class="section-product-title">${cat.name}</h4>
                                                
                                                <c:forEach var="sub" items="${cat.subCategories}">
                                                    <c:if test="${not empty sub.products}">
                                                        <div class="row">
                                                            <c:forEach var="p" items="${sub.products}">
                                                                <div class="col-md-3 col-6">
                                                                    <div class="product-inner">
                                                                        <div class="product-image">
                                                                            <a href="#"> 
                                                                                <img src="${pageContext.request.contextPath}/images/${p.image}" 
                                                                                     alt="${p.name}" 
                                                                                     onerror="this.src='https://placehold.co/300x300/222/fff?text=No+Image'"/>
                                                                            </a>
                                                                        </div>
                                                                        <div class="product-info">
                                                                            <div class="product-type">${cat.name}</div>
                                                                            <h3><a href="#">${p.name}</a></h3>
                                                                            <div class="product-price">
                                                                                <c:choose>
                                                                                    <c:when test="${p.minPrice > 0}">
                                                                                        <fmt:formatNumber value="${p.minPrice}" type="currency" currencySymbol=""/> đ
                                                                                    </c:when>
                                                                                    <c:otherwise>Liên hệ</c:otherwise>
                                                                                </c:choose>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </c:forEach>
                                                        </div>
                                                    </c:if>
                                                </c:forEach>
                                            </div>
                                        </c:forEach>
                                    </div>

                                </div>
                            </section>
                            <hr style="border-top: 1px solid #333; margin: 0;">
                        </c:forEach>
                    </div>
                </div>
            </div>
        </div>
    </main>
    <footer>
        <%@ include file="template/footer.jsp"%>
    </footer>
    
    <script>
        document.querySelectorAll('a[href^="#"]').forEach(anchor => {
            anchor.addEventListener('click', function (e) {
                e.preventDefault();
                var targetId = this.getAttribute('href');
                var targetElement = document.querySelector(targetId);
                
                if (targetElement) {
                    // Trừ hao khoảng cách đã tăng ở CSS (90px + margin)
                    var headerOffset = 180; 
                    var elementPosition = targetElement.getBoundingClientRect().top;
                    var offsetPosition = elementPosition + window.pageYOffset - headerOffset;
            
                    window.scrollTo({
                        top: offsetPosition,
                        behavior: "smooth"
                    });
                }
            });
        });
    </script>
</body>
</html>