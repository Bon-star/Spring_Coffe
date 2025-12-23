<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html>
<head>
    <%@ include file="template/headLink.jsp"%>
    <title>Quản lý Trang Giới Thiệu</title>
    <script src="https://cdn.ckeditor.com/4.22.1/standard/ckeditor.js"></script>
</head>
<body id="page-top">
    <%@ include file="template/header.jsp"%>
    <div class="container-fluid">

        <div class="d-flex justify-content-between align-items-center mb-4">
            <h1 class="h3 text-gray-800">Quản lý nội dung "Chuyện Nhà"</h1>
            <button class="btn btn-success" data-toggle="modal" data-target="#createModal">
                <i class="fas fa-plus"></i> Thêm nội dung mới
            </button>
        </div>

        <div class="card shadow mb-4">
            <div class="card-header py-3">
                <h6 class="m-0 font-weight-bold text-primary">Danh sách các phần hiển thị</h6>
            </div>
            <div class="card-body">
                <div class="table-responsive">
                    <table class="table table-bordered" width="100%" cellspacing="0">
                        <thead class="thead-light">
                            <tr>
                                <th>Mã Phần</th>
                                <th width="150">Ảnh</th>
                                <th>Tiêu đề / Nội dung</th>
                                <th width="120">Hành động</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="s" items="${sections}" varStatus="status">
                                <tr>
                                    <td class="font-weight-bold text-primary">
                                        <c:choose>
                                            <c:when test="${s.sectionCode == 'TOP_BANNER'}">TOP_BANNER</c:when>
                                            <c:otherwise>SECTION ${status.index}</c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td>
                                        <img src="${pageContext.request.contextPath}/images/${s.image}"
                                             style="width: 120px; border-radius: 5px; object-fit: cover;"
                                             onerror="this.src='https://placehold.co/120x80?text=No+Image'">
                                    </td>
                                    <td>
                                        <strong>${s.title}</strong>
                                        <div class="small text-muted mt-1" style="max-height: 80px; overflow: hidden;">
                                            ${s.description}
                                        </div>
                                    </td>
                                    <td class="text-center align-middle">
                                        <div id="data-title-${s.id}" style="display: none;">${s.title}</div>
                                        <div id="data-sub-${s.id}" style="display: none;">${s.subtitle}</div>
                                        <div id="data-desc-${s.id}" style="display: none;">${s.description}</div>

                                        <button class="btn btn-primary btn-sm mb-1"
                                                onclick="openEditModal(${s.id}, '${s.sectionCode}', '${s.image}')">
                                            <i class="fas fa-edit"></i>
                                        </button> 
                                        
                                        <c:if test="${s.sectionCode != 'TOP_BANNER'}">
                                            <form action="${pageContext.request.contextPath}/admin/about-manager" method="post"
                                                  style="display: inline;"
                                                  onsubmit="return confirm('Bạn có chắc muốn xóa mục này không?');">
                                                <input type="hidden" name="action" value="delete_section">
                                                <input type="hidden" name="id" value="${s.id}">
                                                <button type="submit" class="btn btn-danger btn-sm mb-1">
                                                    <i class="fas fa-trash"></i>
                                                </button>
                                            </form>
                                        </c:if>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>

    <div class="modal fade" id="createModal" tabindex="-1">
        <div class="modal-dialog modal-xl">
            <div class="modal-content">
                <form action="${pageContext.request.contextPath}/admin/about-manager" method="post" enctype="multipart/form-data">
                    <div class="modal-header">
                        <h5 class="modal-title font-weight-bold text-success">Thêm nội dung mới</h5>
                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                    </div>
                    <div class="modal-body">
                        <input type="hidden" name="action" value="create_section">

                        <div class="form-group">
                            <label class="font-weight-bold">Tiêu đề chính:</label> 
                            <input type="text" name="title" class="form-control" required placeholder="Nhập tiêu đề...">
                        </div>
                        <div class="form-group">
                            <label>Tiêu đề phụ (Không bắt buộc):</label> 
                            <input type="text" name="subtitle" class="form-control">
                        </div>
                        <div class="form-group">
                            <label class="font-weight-bold">Nội dung:</label>
                            <textarea name="description" id="createDesc" class="form-control" rows="10"></textarea>
                        </div>
                        <div class="form-group">
                            <label class="font-weight-bold">Chọn ảnh:</label> 
                            <input type="file" name="imageFile" class="form-control-file" required>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Hủy</button>
                        <button type="submit" class="btn btn-success" onclick="syncCreateEditor()">Thêm mới</button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <div class="modal fade" id="editModal" tabindex="-1" role="dialog" aria-hidden="true">
        <div class="modal-dialog modal-xl" role="document">
            <div class="modal-content">
                <form action="${pageContext.request.contextPath}/admin/about-manager" method="post" enctype="multipart/form-data">
                    <div class="modal-header">
                        <h5 class="modal-title font-weight-bold text-primary">
                            Chỉnh sửa: <span id="mSectionCode"></span>
                        </h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <input type="hidden" name="action" value="update_section">
                        <input type="hidden" name="id" id="mId"> 
                        <input type="hidden" name="oldImg" id="mOldImg">

                        <div class="row">
                            <div class="col-md-8">
                                <div class="form-group">
                                    <label class="font-weight-bold">Tiêu đề chính:</label> 
                                    <input type="text" name="title" id="mTitle" class="form-control" required>
                                </div>
                                <div class="form-group">
                                    <label class="font-weight-bold">Tiêu đề phụ (Subtitle):</label>
                                    <input type="text" name="subtitle" id="mSubtitle" class="form-control">
                                </div>
                                <div class="form-group">
                                    <label class="font-weight-bold">Nội dung chi tiết:</label>
                                    <textarea name="description" id="mDesc" class="form-control" rows="10"></textarea>
                                </div>
                            </div>
                            <div class="col-md-4">
                                <div class="form-group">
                                    <label class="font-weight-bold">Ảnh minh họa:</label>
                                    <div class="border p-2 rounded text-center bg-light">
                                        <img id="mPreview" src="" style="max-width: 100%; max-height: 200px; border-radius: 5px;">
                                    </div>
                                    <div class="mt-2">
                                        <label class="btn btn-info btn-sm btn-block" style="cursor: pointer;"> 
                                            <i class="fas fa-upload"></i> Chọn ảnh mới 
                                            <input type="file" name="imageFile" style="display: none;" onchange="previewImage(this)">
                                        </label>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Hủy</button>
                        <button type="submit" class="btn btn-primary" onclick="syncEditEditor()">Lưu thay đổi</button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <%@ include file="template/footer.jsp"%>

    <script>
        // Khởi tạo CKEditor
        CKEDITOR.replace('createDesc');
        CKEDITOR.replace('mDesc');

        function openEditModal(id, code, img) {
            $('#mId').val(id);
            $('#mSectionCode').text(code);
            $('#mOldImg').val(img);
            
            // Lấy dữ liệu từ thẻ ẩn
            var title = document.getElementById('data-title-' + id).innerText;
            var subtitle = document.getElementById('data-sub-' + id).innerText;
            var descContent = document.getElementById('data-desc-' + id).innerHTML;

            $('#mTitle').val(title);
            $('#mSubtitle').val(subtitle);
            $('#mPreview').attr('src', '${pageContext.request.contextPath}/images/' + img);

            // Đổ dữ liệu vào CKEditor
            if(CKEDITOR.instances['mDesc']) {
                CKEDITOR.instances['mDesc'].setData(descContent);
            }
            
            $('#editModal').modal('show');
        }

        // Đồng bộ dữ liệu
        function syncCreateEditor() {
            if(CKEDITOR.instances['createDesc']) {
                CKEDITOR.instances['createDesc'].updateElement();
            }
        }

        function syncEditEditor() {
            if(CKEDITOR.instances['mDesc']) {
                CKEDITOR.instances['mDesc'].updateElement();
            }
        }

        function previewImage(input) {
            if (input.files && input.files[0]) {
                var reader = new FileReader();
                reader.onload = function(e) {
                    $('#mPreview').attr('src', e.target.result);
                }
                reader.readAsDataURL(input.files[0]);
            }
        }
    </script>
</body>
</html>