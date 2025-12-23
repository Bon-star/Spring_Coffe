<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <%@ include file="template/headLink.jsp"%>
    <title>Cấu hình Menu</title>
</head>
<body id="page-top">
    <%@ include file="template/header.jsp"%>
    <div class="container-fluid">
        <h1 class="h3 mb-4 text-gray-800">Quản lý Menu Hệ Thống</h1>
        <div class="row">
            
            <div class="col-md-4">
                <div class="card shadow border-left-primary">
                    <div class="card-header py-3 d-flex justify-content-between align-items-center">
                        <h6 class="m-0 font-weight-bold text-primary">1. Loại Gốc (Root)</h6>
                        <button class="btn btn-sm btn-primary" onclick="modal('root', 0, '')">+ Thêm</button>
                    </div>
                    <div class="list-group list-group-flush">
                        <c:forEach var="r" items="${roots}">
                            <div class="list-group-item list-group-item-action d-flex justify-content-between align-items-center ${r.id == selRootId ? 'active bg-primary text-white' : ''}">
                                <a href="hierarchy?rootId=${r.id}" class="text-decoration-none flex-grow-1 ${r.id == selRootId ? 'text-white' : 'text-dark'}"><b>${r.name}</b></a>
                                <div>
                                    <button class="btn btn-sm btn-circle btn-light text-primary" onclick="modal('root', ${r.id}, '${r.name}')"><i class="fas fa-pen"></i></button>
                                    <a href="#" onclick="del('delete_root', ${r.id})" class="btn btn-sm btn-circle btn-light text-danger"><i class="fas fa-trash"></i></a>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </div>
            </div>

            <div class="col-md-4">
                <c:if test="${not empty selRootId}">
                <div class="card shadow border-left-success">
                    <div class="card-header py-3 d-flex justify-content-between align-items-center">
                        <h6 class="m-0 font-weight-bold text-success">2. Danh mục con</h6>
                        <button class="btn btn-sm btn-success" onclick="modal('cat', 0, '', ${selRootId})">+ Thêm</button>
                    </div>
                    <div class="list-group list-group-flush">
                        <c:forEach var="c" items="${categories}">
                            <div class="list-group-item list-group-item-action d-flex justify-content-between align-items-center ${c.id == selCatId ? 'active bg-success text-white' : ''}">
                                <a href="hierarchy?rootId=${selRootId}&catId=${c.id}" class="text-decoration-none flex-grow-1 ${c.id == selCatId ? 'text-white' : 'text-dark'}">${c.name}</a>
                                <div>
                                    <button class="btn btn-sm btn-circle btn-light text-success" onclick="modal('cat', ${c.id}, '${c.name}', ${selRootId})"><i class="fas fa-pen"></i></button>
                                    <a href="#" onclick="del('delete_cat', ${c.id})" class="btn btn-sm btn-circle btn-light text-danger"><i class="fas fa-trash"></i></a>
                                </div>
                            </div>
                        </c:forEach>
                        <c:if test="${empty categories}"><div class="p-3 text-center text-muted">Trống</div></c:if>
                    </div>
                </div>
                </c:if>
            </div>

            <div class="col-md-4">
                <c:if test="${not empty selCatId}">
                <div class="card shadow border-left-info">
                    <div class="card-header py-3 d-flex justify-content-between align-items-center">
                        <h6 class="m-0 font-weight-bold text-info">3. Nhóm sản phẩm</h6>
                        <button class="btn btn-sm btn-info" onclick="modal('sub', 0, '', ${selCatId})">+ Thêm</button>
                    </div>
                    <div class="list-group list-group-flush">
                        <c:forEach var="s" items="${subcategories}">
                            <div class="list-group-item d-flex justify-content-between align-items-center">
                                <span>${s.name}</span>
                                <div>
                                    <button class="btn btn-sm btn-circle btn-light text-info" onclick="modal('sub', ${s.id}, '${s.name}', ${selCatId})"><i class="fas fa-pen"></i></button>
                                    <a href="#" onclick="del('delete_sub', ${s.id})" class="btn btn-sm btn-circle btn-light text-danger"><i class="fas fa-trash"></i></a>
                                </div>
                            </div>
                        </c:forEach>
                        <c:if test="${empty subcategories}"><div class="p-3 text-center text-muted">Trống</div></c:if>
                    </div>
                </div>
                </c:if>
            </div>
        </div>
    </div>

    <div class="modal fade" id="commonModal" tabindex="-1"><div class="modal-dialog"><div class="modal-content">
        <form action="hierarchy" method="post">
            <div class="modal-header"><h5 class="modal-title" id="mTitle"></h5><button type="button" class="close" data-dismiss="modal">&times;</button></div>
            <div class="modal-body">
                <input type="hidden" name="action" id="mAction">
                <input type="hidden" name="id" id="mId">
                <input type="hidden" name="rootId" value="${selRootId}">
                <input type="hidden" name="catId" value="${selCatId}">
                <input type="hidden" name="rootIdInput" id="mRootIdInput"> 
                <input type="hidden" name="catIdInput" id="mCatIdInput">

                <label>Tên hiển thị:</label>
                <input type="text" name="name" id="mName" class="form-control" required>
            </div>
            <div class="modal-footer"><button class="btn btn-primary">Lưu lại</button></div>
        </form>
    </div></div></div>

    <form id="delForm" action="hierarchy" method="post">
        <input type="hidden" name="action" id="dAction">
        <input type="hidden" name="id" id="dId">
        <input type="hidden" name="rootId" value="${selRootId}">
        <input type="hidden" name="catId" value="${selCatId}">
    </form>

    <%@ include file="template/footer.jsp"%>
    <script>
        function modal(type, id, name, parentId) {
            $('#mId').val(id); $('#mName').val(name);
            if(type=='root') { 
                $('#mTitle').text('Quản lý Root'); $('#mAction').val('save_root'); 
            } else if(type=='cat') { 
                $('#mTitle').text('Quản lý Danh mục'); $('#mAction').val('save_cat'); $('#mRootIdInput').val(parentId);
            } else { 
                $('#mTitle').text('Quản lý Nhóm SP'); $('#mAction').val('save_sub'); $('#mCatIdInput').val(parentId);
            }
            $('#commonModal').modal('show');
        }
        function del(action, id) {
            if(confirm('Bạn chắc chắn muốn xóa?')) {
                $('#dAction').val(action); $('#dId').val(id); $('#delForm').submit();
            }
        }
    </script>
</body>
</html>