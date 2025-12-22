<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <%@ include file="template/headLink.jsp"%>
    <title>${product.id == 0 ? "Add" : "Edit"} Product</title>
</head>
<body>
    <%@ include file="template/header.jsp"%>
    
    <div class="container-fluid">
        <div class="card shadow mb-4" style="max-width: 600px; margin: auto;">
            <div class="card-header py-3">
                <h6 class="m-0 font-weight-bold text-primary">${product.id == 0 ? "Add New" : "Edit"} Product</h6>
            </div>
            <div class="card-body">
                
                <form action="${pageContext.request.contextPath}/product/save" method="post" enctype="multipart/form-data">
                    
                    <input type="hidden" name="id" value="${product.id}">
                    <input type="hidden" name="active" value="${product.id == 0 ? 1 : product.active}">
                    <input type="hidden" name="currentImage" value="${product.image}">

                    <div class="form-group">
                        <label>Product Name <span class="text-danger">*</span></label>
                        <input type="text" class="form-control" name="name" value="${product.name}" required>
                    </div>
                    
                    <div class="form-group">
                        <label>Price (VND) <span class="text-danger">*</span></label>
                        <input type="number" class="form-control" name="price" value="${product.price}" min="0" required>
                    </div>
                    
                    <div class="form-group">
                        <label>Product Image</label>
                        <input type="file" class="form-control-file border p-1" name="imageFile" accept="image/*" onchange="previewImage(this)">
                        
                        <div class="mt-2">
                            <label>Preview:</label><br>
                            <img id="preview" 
                                 src="${pageContext.request.contextPath}/images/${product.image != null ? product.image : 'noimage.jpg'}" 
                                 style="max-width: 150px; max-height: 150px; border-radius: 5px; border: 1px solid #ddd; object-fit: cover;">
                        </div>
                    </div>
                    
                    <div class="form-group">
                        <label>Category</label>
                        <select class="form-control" name="categoryId">
                            <c:forEach var="c" items="${categories}">
                                <option value="${c.id}" ${c.id == product.categoryId ? 'selected' : ''}>${c.name}</option>
                            </c:forEach>
                        </select>
                    </div>
                    
                    <hr>
                    <button type="submit" class="btn btn-primary">
                        <i class="fas fa-save"></i> Save Product
                    </button>
                    <a href="${pageContext.request.contextPath}/product" class="btn btn-secondary">Cancel</a>
                </form>
            </div>
        </div>
    </div>
    
    <%@ include file="template/footer.jsp"%>

    <script>
        function previewImage(input) {
            if (input.files && input.files[0]) {
                var reader = new FileReader();
                reader.onload = function(e) {
                    $('#preview').attr('src', e.target.result);
                }
                reader.readAsDataURL(input.files[0]);
            }
        }
    </script>
</body>
</html>