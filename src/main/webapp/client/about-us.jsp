<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <%@ include file="template/headLink.jsp"%>
    <title>Chuyện Nhà - The Coffee House</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/client/css/about-us.css">
</head>
<body class="mainBody-theme temp-index">
    <div class="mainHeader--height header-index">
        <%@ include file="template/header.jsp"%>
    </div>
    
    <main class="body-main">
        <div id="layout-pageAboutus">
            
            <c:if test="${not empty topBanner}">
                <div class="pageAboutus-bannertop">
                    <picture>
                        <source media="(max-width: 767px)" srcset="https://file.hstatic.net/1000075078/file/aboutus-bannertop-mb.png"/>
                        <img src="${pageContext.request.contextPath}/images/${topBanner.image}" 
                             onerror="this.src='https://file.hstatic.net/1000075078/file/aboutus-bannertop-pc.png'"/>
                    </picture>
                    <div class="pageAboutus-bannertop-wrapper">
                        <div class="title">${topBanner.title}</div>
                        <div class="subtitle">${topBanner.subtitle}</div>
                        <div class="des">${topBanner.description}</div>
                    </div>
                </div>
            </c:if>

            <c:forEach var="s" items="${bodySections}" varStatus="status">
                
                <div class="pageAboutus-banner ${status.index % 2 != 0 ? 'reversed' : ''}" id="section-${status.index}">
                    <div class="container">
                        <div class="pageAboutus-banner-wrap d-flex flex-wrap">
                            
                            <div class="pageAboutus-banner-left">
                                <h2 class="title">${s.title}</h2>
                                <div class="des">${s.description}</div> </div>
                            
                            <div class="pageAboutus-banner-right">
                                <div class="pageAboutus-banner-right-wrap text-float__container">
                                    <img src="${pageContext.request.contextPath}/images/${s.image}" 
                                         onerror="this.src='https://placehold.co/600x400?text=No+Image'"/>
                                    
                                    <div class="text-float__img-container" rotate-float="true">
                                        <div class="float-image-wrapper" style="--width: 150px; --pos-x: ${status.index % 2 != 0 ? '10%' : '80%'}; --pos-y: 80%; --pos-z: 10;">
                                            <img class="float-image" width="150" src="https://file.hstatic.net/1000075078/file/sticker1-banner1.png"/>
                                        </div>
                                    </div>
                                </div>
                            </div>

                        </div>
                    </div>
                </div>
            </c:forEach>

        </div>
    </main>
  
    <footer>
        <%@ include file="template/footer.jsp"%>
    </footer>
</body>
</html>