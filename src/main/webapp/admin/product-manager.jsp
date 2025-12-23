<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html>
<head>
    <%@ include file="template/headLink.jsp"%>
    <title>Quản lý Sản phẩm</title>
</head>
<body id="page-top">
    <%@ include file="template/header.jsp"%>
    <div class="container-fluid">
        
        <div class="card mb-4 border-bottom-primary">
            <div class="card-body py-2">
                <form action="products" method="get" class="form-inline justify-content-between">
                    <div class="d-flex">
                        <div class="input-group mr-2">
                            <input type="text" name="keyword" class="form-control bg-light border-0 small" 
                                   placeholder="Tìm tên món..." value="${keyword}">
                            <div class="input-group-append">
                                <button class="btn btn-primary" type="submit">
                                    <i class="fas fa-search"></i>
                                </button>
                            </div>
                        </div>

                        <select name="sid" class="custom-select" onchange="this.form.submit()">
                            <option value="0">-- Tất cả nhóm sản phẩm --</option>
                            <c:forEach var="s" items="${subList}">
                                <option value="${s.id}" ${s.id == selSubId ? 'selected' : ''}>${s.categoryName} > ${s.name}</option>
                            </c:forEach>
                        </select>
                    </div>

                    <button type="button" class="btn btn-primary" onclick="openProdModal(0)">
                        <i class="fas fa-plus"></i> Thêm Sản Phẩm
                    </button>
                </form>
            </div>
        </div>

        <div class="card shadow">
            <div class="card-body">
                <div class="table-responsive">
                    <table class="table table-bordered table-hover">
                        <thead class="thead-light">
                            <tr>
                                <th width="60">Ảnh</th>
                                <th>Tên Sản Phẩm</th>
                                <th>Nhóm</th>
                                <th>Biến thể (Size/Giá)</th>
                                <th width="100">Thao tác</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="p" items="${products}">
                                <tr>
                                    <td><img src="${pageContext.request.contextPath}/images/${p.image}" style="height:50px; border-radius:4px;"></td>
                                    <td class="font-weight-bold">${p.name}</td>
                                    <td>${p.subCategoryName}</td>
                                    <td>
                                        <c:forEach var="v" items="${p.variants}">
                                            <span class="badge badge-light border mb-1 p-2">
                                                ${v.name} - <b class="text-success"><fmt:formatNumber value="${v.price}"/>đ</b>
                                                <a href="#" onclick="delVar(${v.id})" class="text-danger ml-2">&times;</a>
                                            </span>
                                        </c:forEach>
                                        
                                        <button class="btn btn-sm btn-outline-success py-0" 
                                                type="button"
                                                data-id="${p.id}" 
                                                data-name="${p.name}" 
                                                onclick="openVarModal(this)">+</button>
                                    </td>
                                    <td>
                                        <button class="btn btn-info btn-sm" 
                                                type="button"
                                                data-id="${p.id}"
                                                data-name="${p.name}"
                                                data-img="${p.image}"
                                                data-sub="${p.subCategoryId}"
                                                onclick="openProdModal(this)"><i class="fas fa-pen"></i></button>
                                        
                                        <a href="#" onclick="delProd(${p.id})" class="btn btn-danger btn-sm"><i class="fas fa-trash"></i></a>
                                    </td>
                                </tr>
                            </c:forEach>
                            <c:if test="${empty products}">
                                <tr><td colspan="5" class="text-center text-muted py-4">Không tìm thấy sản phẩm nào phù hợp</td></tr>
                            </c:if>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>

        <c:if test="${totalPages > 1}">
            <div class="d-flex justify-content-center mt-3">
                <nav>
                    <ul class="pagination">
                        <li class="page-item ${currentPage == 1 ? 'disabled' : ''}">
                            <a class="page-link" href="products?page=${currentPage - 1}&keyword=${keyword}&sid=${selSubId}">Trước</a>
                        </li>

                        <c:forEach begin="1" end="${totalPages}" var="i">
                            <li class="page-item ${currentPage == i ? 'active' : ''}">
                                <a class="page-link" href="products?page=${i}&keyword=${keyword}&sid=${selSubId}">${i}</a>
                            </li>
                        </c:forEach>

                        <li class="page-item ${currentPage == totalPages ? 'disabled' : ''}">
                            <a class="page-link" href="products?page=${currentPage + 1}&keyword=${keyword}&sid=${selSubId}">Sau</a>
                        </li>
                    </ul>
                </nav>
            </div>
            <div class="text-center text-muted small mb-4">
                Đang hiển thị trang ${currentPage} / ${totalPages} (Tổng ${totalItems} món)
            </div>
        </c:if>

    </div>

    <div class="modal fade" id="prodModal" tabindex="-1"><div class="modal-dialog"><div class="modal-content"><form action="products" method="post" enctype="multipart/form-data">
        <div class="modal-header"><h5 class="modal-title">Thông tin Sản phẩm</h5><button type="button" class="close" data-dismiss="modal">&times;</button></div>
        <div class="modal-body">
            <input type="hidden" name="action" value="save_product">
            <input type="hidden" name="sid" value="${selSubId}">
            <input type="hidden" name="page" value="${currentPage}">
            <input type="hidden" name="keyword" value="${keyword}">
            
            <input type="hidden" name="id" id="pId">
            <input type="hidden" name="oldImg" id="pOldImg">
            
            <div class="form-group"><label>Tên SP:</label><input type="text" name="name" id="pName" class="form-control" required></div>
            <div class="form-group"><label>Nhóm:</label>
                <select name="subCategoryId" id="pSub" class="form-control">
                    <c:forEach var="s" items="${subList}"><option value="${s.id}">${s.categoryName} > ${s.name}</option></c:forEach>
                </select>
            </div>
            <div class="form-group"><label>Ảnh:</label><input type="file" name="imageFile" class="form-control-file"></div>
        </div>
        <div class="modal-footer"><button class="btn btn-primary">Lưu</button></div>
    </form></div></div></div>

    <div class="modal fade" id="varModal" tabindex="-1"><div class="modal-dialog modal-sm"><div class="modal-content"><form action="products" method="post">
        <div class="modal-header"><h6 class="modal-title">Thêm giá: <span id="vPName" class="text-primary"></span></h6><button type="button" class="close" data-dismiss="modal">&times;</button></div>
        <div class="modal-body">
            <input type="hidden" name="action" value="add_variant">
            <input type="hidden" name="sid" value="${selSubId}">
            <input type="hidden" name="page" value="${currentPage}">
            <input type="hidden" name="keyword" value="${keyword}">

            <input type="hidden" name="productId" id="vPid"> <div class="form-group"><input type="text" name="name" class="form-control" placeholder="Tên Size (VD: Lớn)" required></div>
            <div class="form-group"><input type="number" name="price" class="form-control" placeholder="Giá tiền" required></div>
        </div>
        <div class="modal-footer"><button class="btn btn-success btn-block">Thêm</button></div>
    </form></div></div></div>

    <form id="delForm" action="products" method="post">
        <input type="hidden" name="action" id="delAction">
        <input type="hidden" name="id" id="delId">
        <input type="hidden" name="sid" value="${selSubId}">
        <input type="hidden" name="page" value="${currentPage}">
        <input type="hidden" name="keyword" value="${keyword}">
    </form>

    <%@ include file="template/footer.jsp"%>
    
    <script>
        // Mở Modal Sản Phẩm (0: Thêm mới, object: Sửa)
        function openProdModal(btn) {
            if (btn === 0) {
                // Reset form để thêm mới
                $('#pId').val(0);
                $('#pName').val('');
                $('#pOldImg').val('');
                var currentSid = $('input[name="sid"]').val();
                $('#pSub').val(currentSid != '' ? currentSid : 0);
            } 
            else {
                // Đổ dữ liệu vào form để sửa (Lấy từ data-attribute)
                var id = $(btn).data('id');
                var name = $(btn).data('name');
                var img = $(btn).data('img');
                var sub = $(btn).data('sub');

                $('#pId').val(id);
                $('#pName').val(name);
                $('#pOldImg').val(img);
                if(sub > 0) $('#pSub').val(sub);
            }
            $('#prodModal').modal('show');
        }

        // Mở Modal Biến Thể
        function openVarModal(btn) {
            var pid = $(btn).data('id');
            var pname = $(btn).data('name');
            
            $('#vPid').val(pid);
            $('#vPName').text(pname);
            $('#varModal').modal('show');
        }

        // Xóa Sản Phẩm
        function delProd(id) { 
            if(confirm('Bạn có chắc muốn xóa sản phẩm này?')) { 
                $('#delAction').val('delete_product'); 
                $('#delId').val(id); 
                $('#delForm').submit(); 
            } 
        }

        // Xóa Biến Thể
        function delVar(id) { 
            if(confirm('Xóa tùy chọn giá này?')) { 
                $('#delAction').val('delete_variant'); 
                $('#delId').val(id); 
                $('#delForm').submit(); 
            } 
        }
    </script>
</body>
</html>