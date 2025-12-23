<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<!DOCTYPE html>
<html lang="vi">
<head>
<%@ include file="template/headLink.jsp"%>
<title>The Coffee House - Trang chủ</title>

<link rel="stylesheet"
	href="${pageContext.request.contextPath}/client/css/home.css">
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/swiper@10/swiper-bundle.min.css" />
</head>

<body class="mainBody-theme temp-index">

	<div class="loader_overlay"></div>
	<div class="mainBody-theme-container">
		<div class="mainHeader--height header-index">
			<%@ include file="template/header.jsp"%>
		</div>

		<main class="body-main">
			<div class="section-home-slider" id="homepage-slider">
				<div class="slider-owl swiper">
					<div class="swiper-wrapper">
						<div class="swiper-slide slider-item">
							<div class="slide--image">
								<a href="#"><img
									src="//cdn.hstatic.net/themes/1000075078/1001392287/14/slide_1_img.jpg?v=2213"
									alt="" /></a>
							</div>
						</div>
						<div class="swiper-slide slider-item">
							<div class="slide--image">
								<a href="#"><img
									src="//cdn.hstatic.net/themes/1000075078/1001392287/14/slide_3_img.jpg?v=2213"
									alt="" /></a>
							</div>
						</div>
					</div>
					<div class="home-swiper-pagination"></div>
					<div class="home-slider-button home-slider-button-prev"></div>
					<div class="home-slider-button home-slider-button-next"></div>
				</div>
			</div>

			<section class="home-text-slider">
				<div class="slick marquee">
					<div class="slick-slide">
						<div class="inner">FROM A LEADING LOCAL ESPRESSO CHAIN</div>
					</div>
					<div class="slick-slide">
						<div class="inner">FROM A LEADING LOCAL ESPRESSO CHAIN</div>
					</div>
					<div class="slick-slide">
						<div class="inner">FROM A LEADING LOCAL ESPRESSO CHAIN</div>
					</div>
				</div>
			</section>

			<section class="home-aboutus">
				<div class="container">
					<div class="home-aboutus-wrap">
						<div class="home-aboutus-title">CHUYỆN “NHÀ”</div>
						<div class="home-aboutus-des">The Coffee House tin rằng, nụ
							cười là hương vị ngọt ngào nhất...</div>
						<div class="home-aboutus-actions">
							<a href="about-us">TÌM HIỂU</a>
						</div>
						<div class="home-aboutus-banner text-float__container">
							<img class="main-image"
								src="https://file.hstatic.net/1000075078/file/banner-home-aboutus.png"
								alt="" />
						</div>
					</div>
				</div>
			</section>

			<section class="home-collectiontabs">
				<div class="container text-center">
					<div class="subtitle">FEATURED PRODUCT</div>
					<h2>“NHÀ” COLLECTION</h2>

					<div class="tabs-product-head">
						<c:forEach var="c" items="${categories}" varStatus="status">
							<div class="tab-item ${status.first ? 'active' : ''}"
								onclick="switchTab('cat-${c.id}', this)">${c.name}</div>
						</c:forEach>
					</div>

					<div class="tabs-product-body">
						<c:forEach var="c" items="${categories}" varStatus="status">
							<div id="cat-${c.id}"
								class="tab-content ${status.first ? 'active' : ''}">
								<div class="swiper product-swiper product-swiper-${c.id}">
									<div class="swiper-wrapper">
										<c:forEach var="sub" items="${c.subCategories}">
											<c:forEach var="p" items="${sub.products}">
												<c:if test="${p.active == 1}">
													<div class="swiper-slide">
														<div class="product-inner">
															<div class="product-image">
																<a href="#"> <img
																	src="${pageContext.request.contextPath}/images/${p.image}"
																	alt="${p.name}"
																	onerror="this.src='https://placehold.co/300x300/222/fff?text=No+Image'" />
																</a>
															</div>
															<div class="product-info text-left">
																<div
																	style="font-size: 12px; color: #666; margin-bottom: 5px;">${c.name}</div>
																<h3>
																	<a href="#">${p.name}</a>
																</h3>
																<div class="product-price">
																	<c:choose>
																		<c:when test="${p.minPrice > 0}">
																			<fmt:formatNumber value="${p.minPrice}"
																				type="currency" currencySymbol="" /> đ
                                                                        </c:when>
																		<c:otherwise>Liên hệ</c:otherwise>
																	</c:choose>
																</div>
															</div>
														</div>
													</div>
												</c:if>
											</c:forEach>
										</c:forEach>
									</div>
									<div class="swiper-button-next"></div>
									<div class="swiper-button-prev"></div>
								</div>
								<div class="tabs-product-viewmore">
									<a href="collection"> XEM THÊM <i
										class="fas fa-arrow-right"></i></a>
								</div>
							</div>
						</c:forEach>
					</div>
				</div>
			</section>

			<c:if test="${not empty aboutSections}">
				<section class="home-aboutus-slide">
					<div class="home-aboutus-slide-wrap home-slide">
						<div class="swiper about-swiper">
							<div class="swiper-wrapper">

								<c:forEach var="s" items="${aboutSections}" varStatus="status">
									<div class="swiper-slide banner-slide"
										style="background: ${status.index % 2 == 0 ? '#ED7542' : '#809B67'}">

										<div class="banner">
											<img
												src="${pageContext.request.contextPath}/images/${s.image}"
												alt="${s.title}"
												onerror="this.src='https://placehold.co/600x400?text=No+Image'" />
										</div>
										<div class="content">
											<h2>${s.title}</h2>
											<div class="action">
												<a href="about-us"><span>XEM THÊM</span></a>
											</div>
										</div>
									</div>
								</c:forEach>

							</div>

							<div class="swiper-button-next"></div>
							<div class="swiper-button-prev"></div>
							<div class="swiper-pagination"></div>
						</div>
					</div>
				</section>
			</c:if>

			<section class="home-stores">
				<div class="container text-float__container">
					<div class="home-stores-wrap">
						<div class="home-stores-content">
							<h2>Tìm nhà gần bạn</h2>
							<div class="home-stores-des">Dù bạn ở đâu, “Nhà” cũng luôn
								ở gần...</div>
						</div>
						<div class="home-stores-viewmore">
							<a href="#"><span>XEM DANH SÁCH CỬA HÀNG</span></a>
						</div>
					</div>
				</div>
			</section>

			<section class="home-information">
				<div class="container">
					<div class="row home-information-row">
						<div class="col-lg-6 col-12">
							<div class="home-instagram">
								<div class="heading">
									<h2>INSTAGRAM</h2>
								</div>
								<div class="home-instagram-lists">
									<div class="item effect-image">
										<img
											src="https://file.hstatic.net/1000075078/file/instagram1.png" />
									</div>
									<div class="item effect-image">
										<img
											src="https://file.hstatic.net/1000075078/file/instagram2.png" />
									</div>
								</div>
							</div>
						</div>
						<div class="col-lg-6 col-12">
							<div class="home-news">
								<div class="heading">
									<h2>NEWS</h2>
								</div>
								<div class="content">
									<div class="article-loop">
										<div class="article-detail">
											<h3 class="article-title">
												<a href="#">BẮT GẶP SÀI GÒN XƯA...</a>
											</h3>
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

	<script
		src="https://cdn.jsdelivr.net/npm/swiper@10/swiper-bundle.min.js"></script>

	<script>
        // Slider Sản Phẩm
        var productSwipers = document.querySelectorAll('.product-swiper');
        productSwipers.forEach(function(element) {
            new Swiper(element, {
                slidesPerView: 4,
                spaceBetween: 30,
                loop: true, 
                observer: true,
                observeParents: true,
                autoplay: {
                    delay: 3000,
                    disableOnInteraction: false,
                    pauseOnMouseEnter: true
                },
                navigation: {
                    nextEl: element.querySelector('.swiper-button-next'),
                    prevEl: element.querySelector('.swiper-button-prev'),
                },
                breakpoints: {
                    0:    { slidesPerView: 2, spaceBetween: 15 },
                    768:  { slidesPerView: 3, spaceBetween: 20 },
                    1024: { slidesPerView: 4, spaceBetween: 30 },
                }
            });
        });

        // Slider About Us (Đã sửa lỗi đen màn hình)
        if (document.querySelector('.about-swiper')) {
            new Swiper('.about-swiper', {
                slidesPerView: 1,
                spaceBetween: 0,
                loop: true,
                speed: 800,
                // BỎ effect: 'fade' ĐỂ TRÁNH LỖI ĐEN MÀN HÌNH
                autoplay: {
                    delay: 4000,
                    disableOnInteraction: false,
                },
                navigation: {
                    nextEl: '.home-aboutus-slide .swiper-button-next',
                    prevEl: '.home-aboutus-slide .swiper-button-prev',
                },
                pagination: {
                    el: ".home-aboutus-slide .swiper-pagination",
                    clickable: true,
                },
            });
        }

        function switchTab(tabId, element) {
            document.querySelectorAll('.tab-item').forEach(el => el.classList.remove('active'));
            document.querySelectorAll('.tab-content').forEach(el => el.classList.remove('active'));
            
            element.classList.add('active');
            var targetContent = document.getElementById(tabId);
            targetContent.classList.add('active');

            var swiperContainer = targetContent.querySelector('.swiper');
            if (swiperContainer && swiperContainer.swiper) {
                swiperContainer.swiper.update();
                swiperContainer.swiper.navigation.update();
            }
        }
    </script>
</body>
</html>