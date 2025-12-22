<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %> <!DOCTYPE html>
<html lang="vi">
<head>
    <%@ include file="template/headLink.jsp"%>
    <title>The Coffee House - Delivery 1800 6936</title>
</head>

<body class="mainBody-theme temp-index" itemscope itemtype="http://schema.org/Website">

    <div class="loader_overlay"></div>
    <div class="mainBody-theme-container">
        <div class="mainHeader--height header-index">
            <%@ include file="template/header.jsp"%>
        </div>

        <main class="body-main">
            <div class="section-home-slider" id="homepage-slider">
                <div class="slider-owl swiper ">
                    <div class="swiper-wrapper ">
                        <div class="swiper-slide slider-item">
                            <div class="slide--image">
                                <a href="#" title="" aria-label=""> 
                                    <picture>
                                        <source media="(max-width: 767px)" srcset="//cdn.hstatic.net/themes/1000075078/1001392287/14/slide_1_mb.jpg?v=2213" />
                                        <source media="(min-width: 768px)" class="lazyload" srcset="//cdn.hstatic.net/themes/1000075078/1001392287/14/slide_1_img.jpg?v=2213" />
                                        <img src="//cdn.hstatic.net/themes/1000075078/1001392287/14/slide_1_img.jpg?v=2213" alt="" /> 
                                    </picture>
                                </a>
                            </div>
                        </div>
                        <div class="swiper-slide slider-item">
                            <div class="slide--image">
                                <a href="#" title="" aria-label=""> 
                                    <picture>
                                        <source media="(max-width: 767px)" srcset="//cdn.hstatic.net/themes/1000075078/1001392287/14/slide_3_mb.jpg?v=2213" />
                                        <source media="(min-width: 768px)" srcset="//cdn.hstatic.net/themes/1000075078/1001392287/14/slide_3_img.jpg?v=2213" />
                                        <img src="//cdn.hstatic.net/themes/1000075078/1001392287/14/slide_3_img.jpg?v=2213" alt="" /> 
                                    </picture>
                                </a>
                            </div>
                        </div>
                    </div>
                    <div class="home-swiper-pagination"></div>
                    <div class="home-slider-button home-slider-button-prev"></div>
                    <div class="home-slider-button home-slider-button-next"></div>
                </div>
                
                <div class="info-fixed " style="background: #F15A25">
                    <div class="logo"><img src="https://file.hstatic.net/1000075078/file/logotch.png" alt="The Coffee House" /></div>
                    <div class="content">
                        <div class="name">MATCHA LATTE TÂY BẮC</div>
                        <div class="price"><span>(chỉ)</span>45.000Đ</div>
                        <div class="action"><a target="_blank" href="#">MUA NGAY</a></div>
                    </div>
                    <div class="banner"><img src="https://file.hstatic.net/1000075078/file/img-product.png" alt="The Coffee House" /></div>
                    <div class="circle"><img src="https://file.hstatic.net/1000075078/file/circle-text.png" alt="circle text" /></div>
                    <div class="close" id="closeBtn">
                        <svg xmlns="http://www.w3.org/2000/svg" width="30" height="28" viewBox="0 0 30 28" fill="none">
                            <path d="M5.06211 4.67773L25.1356 24.4939M24.7844 4.68991L4.71094 24.5061" stroke="black" stroke-width="2" stroke-linecap="round" />
                        </svg>
                    </div>
                </div>
                <div class="mini-icon" id="miniIcon"><img src="https://cdn.hstatic.net/files/1000075078/file/brandmark.png" alt="The Coffee House" /></div>
            </div>

            <section class="home-text-slider">
                <div class="slick marquee">
                    <div class="slick-slide"><div class="inner">FROM A LEADING LOCAL ESPRESSO CHAIN</div></div>
                    <div class="slick-slide"><div class="inner">FROM A LEADING LOCAL ESPRESSO CHAIN</div></div>
                    <div class="slick-slide"><div class="inner">FROM A LEADING LOCAL ESPRESSO CHAIN</div></div>
                    <div class="slick-slide"><div class="inner">FROM A LEADING LOCAL ESPRESSO CHAIN</div></div>
                    <div class="slick-slide"><div class="inner">FROM A LEADING LOCAL ESPRESSO CHAIN</div></div>
                </div>
            </section>

            <section class="home-aboutus">
                <div class="container">
                    <div class="home-aboutus-wrap">
                        <div class="home-aboutus-title">CHUYỆN “NHÀ”</div>
                        <div class="home-aboutus-des">The Coffee House tin rằng, nụ cười là hương vị ngọt ngào nhất...</div>
                        <div class="home-aboutus-actions"><a href="#">TÌM HIỂU</a></div>
                        <div class="home-aboutus-banner text-float__container">
                            <img class="main-image" src="https://file.hstatic.net/1000075078/file/banner-home-aboutus.png" alt="" />
                            </div>
                    </div>
                </div>
            </section>

            <section class="home-collectiontabs">
                <div class="container text-float__container">
                    <div class="subtitle">FEATURED PRODUCT</div>
                    <h2>“NHÀ” COLLECTION</h2>
                    <div class="text-float__img-container" rotate-float="true">
                        <div class="float-image-wrapper mobile" style="--width: 150px; --pos-x: 10%; --pos-y: 0%;">
                            <img class="float-image" height="auto" width="150" src="https://file.hstatic.net/1000075078/file/sticker-collectiontabs.png" alt="" />
                        </div>
                    </div>
                    
                    <div class="tabs-product">
                        <div class="tabs-product-head">
                            <c:forEach var="c" items="${categories}" varStatus="status">
                                <div class="tab-item ${status.first ? 'active' : ''}" data-handle="cat-${c.id}">
                                    ${c.name}
                                </div>
                            </c:forEach>
                        </div>

                        <div class="tabs-product-body js-tab">
                            <div class="tab-product-slider home-slide">
                                <div class="swiper">
                                    <div class="swiper-wrapper">
                                        
                                        <c:forEach var="p" items="${products}">
                                            <c:if test="${p.active == 1}">
                                                <div class="swiper-slide">
                                                    <div class="product-inner">
                                                        <div class="product-image effect-image">
                                                            <a class="icon-quickview" href="#"> 
                                                                <img src="${pageContext.request.contextPath}/images/${p.image}"
	                                                                     alt="${p.name}" />
                                                            </a>
                                                        </div>
                                                        <div class="product-info">
                                                            <div class="product-type">${p.categoryName}</div>
                                                            <h3>
                                                                <a class="icon-quickview" href="#">${p.name}</a>
                                                            </h3>
                                                            <div class="product-price">
                                                                <fmt:formatNumber value="${p.price}" type="number" /> đ
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </c:if>
                                        </c:forEach>

                                    </div>
                                </div>
                                
                                <div class="home-slide-button home-slide-button-prev collectiontabs-prev">
                                    <svg width="23" height="23" viewBox="0 0 16 16" fill="none"><path d="M7.37175 1.14954C7.71889 0.802499 8.28141 0.802442 8.62852 1.14955C8.97562 1.49665 8.97556 2.05918 8.62852 2.40632L7.37175 1.14954ZM1.14935 8.62871C0.802245 8.28161 0.802303 7.71908 1.14935 7.37194L7.37175 1.14954L8.62852 2.40632L3.92331 7.11152L14.2223 7.11152C14.7131 7.11153 15.1112 7.50923 15.1113 8.00007C15.1113 8.49099 14.7132 8.88913 14.2223 8.88913L3.92331 8.88913L8.62852 13.5938L7.37174 14.8511L1.14935 8.62871ZM8.62852 14.8511C8.28143 15.1981 7.71886 15.198 7.37174 14.8511L8.62852 13.5938C8.97565 13.9409 8.97565 14.504 8.62852 14.8511Z" fill="black" /></svg>
                                </div>
                                <div class="home-slide-button home-slide-button-next collectiontabs-next">
                                    <svg width="23" height="23" viewBox="0 0 16 16" fill="none"><path d="M8.62825 1.14954C8.28111 0.802499 7.71859 0.802442 7.37148 1.14955C7.02438 1.49665 7.02444 2.05918 7.37148 2.40632L8.62825 1.14954ZM14.8507 8.62871C15.1978 8.28161 15.1977 7.71908 14.8507 7.37194L8.62825 1.14954L7.37148 2.40632L12.0767 7.11152L1.77773 7.11152C1.28687 7.11153 0.888765 7.50923 0.888671 8.00007C0.888671 8.49099 1.28681 8.88913 1.77773 8.88913L12.0767 8.88913L7.37148 13.5938L8.62826 14.8511L14.8507 8.62871ZM7.37148 14.8511C7.71857 15.1981 8.28114 15.198 8.62826 14.8511L7.37148 13.5938C7.02435 13.9409 7.02435 14.504 7.37148 14.8511Z" fill="black" /></svg>
                                </div>
                            </div>
                        </div>
                        
                        <div class="tabs-product-viewmore">
                            <a href="#"> <span>XEM THÊM</span> <svg width="16" height="16" viewBox="0 0 16 16" fill="none"><g clip-path="url(#clip0_360_8589)"><path d="M3.8457 20.8453C3.19482 21.496 2.14008 21.4962 1.48926 20.8453C0.838438 20.1945 0.838547 19.1398 1.48926 18.4889L3.8457 20.8453ZM15.5127 6.8219C16.1635 7.47271 16.1634 8.52745 15.5127 9.17834L3.8457 20.8453L1.48926 18.4889L10.3115 9.66662H-8.99902C-9.91939 9.66662 -10.6658 8.92093 -10.666 8.00061C-10.666 7.08013 -9.9195 6.33361 -8.99902 6.33361H10.3115L1.48926 -2.48767L3.8457 -4.8451L15.5127 6.8219ZM1.48926 -4.8451C2.14004 -5.4957 3.19486 -5.49559 3.8457 -4.8451L1.48926 -2.48767C0.838384 -3.13855 0.838384 -4.19422 1.48926 -4.8451Z" fill="black" /></g><defs><clipPath id="clip0_360_8589"><rect width="16" height="16" fill="white" /></clipPath></defs></svg></a>
                        </div>
                    </div>
                </div>
            </section>
            <section class="home-aboutus-slide">
                <div class="home-aboutus-slide-wrap home-slide">
                    <div class="swiper">
                        <div class="swiper-wrapper">
                            <div class="swiper-slide banner-slide" style="background: #ED7542">
                                <div class="banner"><img src="https://cdn.hstatic.net/files/1000075078/file/rectangle_45__1_.jpg" alt="" /></div>
                                <div class="content">
                                    <h2>☕ Nguyên bản từ giá trị hạt cà phê chất lượng</h2>
                                    <div class="des">Mọi nụ cười ở The Coffee House đều bắt đầu từ một hạt cà phê nguyên bản.</div>
                                    <div class="action"><a href="#"><span>XEM THÊM</span></a></div>
                                </div>
                            </div>
                            <div class="swiper-slide banner-slide" style="background: #809B67">
                                <div class="banner"><img src="https://cdn.hstatic.net/files/1000075078/file/rectangle_45.jpg" alt="" /></div>
                                <div class="content">
                                    <h2>🍃 Chất lượng khởi nguồn từ những đồi trà tuyển chọn</h2>
                                    <div class="des">Giữa những đồi trà xanh mướt trong sương sớm...</div>
                                    <div class="action"><a href="#"><span>XEM THÊM</span></a></div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="home-aboutus-pagination"></div>
                </div>
            </section>

            <section class="home-stores">
                <div class="container text-float__container">
                    <div class="home-stores-wrap">
                        <div class="home-stores-content">
                            <h2>Tìm nhà gần bạn</h2>
                            <div class="home-stores-des">Dù bạn ở đâu, “Nhà” cũng luôn ở gần...</div>
                        </div>
                        <div class="home-stores-selectbox">
                            <div class="home-stores-filter">
                                <div class="custom_select_wrap">
                                    <select id="filter_city" class="filter_city">
                                        <option selected value="default">Chọn Thành phố</option>
                                        <option value="Hồ Chí Minh">Hồ Chí Minh</option>
                                        <option value="Hà Nội">Hà Nội</option>
                                    </select>
                                </div>
                                <div class="custom_select_wrap">
                                    <select id="filter_ward" class="filter_ward">
                                        <option selected value="default">Chọn Phường/Xã</option>
                                    </select>
                                </div>
                            </div>
                            <div class="home-stores-viewmore"><a href="#"><span>XEM DANH SÁCH CỬA HÀNG</span></a></div>
                        </div>
                    </div>
                    </div>
            </section>

            <section class="home-information">
                <div class="container">
                    <div class="row home-information-row">
                        <div class="col-lg-6 col-12">
                            <div class="home-instagram">
                                <div class="subtitle">KẾT NỐI VỚI NHÀ</div>
                                <div class="heading"><h2>INSTAGRAM</h2></div>
                                <div class="home-instagram-lists">
                                    <div class="item effect-image"><img src="https://file.hstatic.net/1000075078/file/instagram1.png" /></div>
                                    <div class="item effect-image"><img src="https://file.hstatic.net/1000075078/file/instagram2.png" /></div>
                                    <div class="item effect-image"><img src="https://file.hstatic.net/1000075078/file/instagram3.png" /></div>
                                </div>
                            </div>
                        </div>
                        <div class="col-lg-6 col-12">
                            <div class="home-news">
                                <div class="heading"><h2>NEWS</h2></div>
                                <div class="content">
                                    <div class="article-loop">
                                        <div class="article-image effect-image">
                                            <a href="#"><img class="lazyload" src="//file.hstatic.net/1000075078/article/thecoffeehouse_caphehighlight01_de40c0102a954c50a328f7befcdd82bd_1024x1024.jpg" alt="" /></a>
                                        </div>
                                        <div class="article-detail">
                                            <h3 class="article-title"><a href="#">BẮT GẶP SÀI GÒN XƯA...</a></h3>
                                            <div class="article-post-content">Dẫu qua bao nhiêu lớp sóng thời gian...</div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </section>
        </main>
    </div>
    
    <footer>
        <%@ include file="template/footer.jsp"%>
    </footer>
</body>
</html>