<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <%@ include file="template/headLink.jsp"%>
    <title>${category.id == 0 ? "Add" : "Edit"} Category</title>
</head>
<body>
    <%@ include file="template/header.jsp"%>
    
    <div class="container-fluid">
        <div class="card shadow mb-4" style="max-width: 600px; margin: auto;">
            <div class="card-header py-3">
                <h6 class="m-0 font-weight-bold text-primary">${category.id == 0 ? "Add New" : "Edit"} Category</h6>
            </div>
            <div class="card-body">
                <form action="${pageContext.request.contextPath}/category/save" method="post">
                    <input type="hidden" name="id" value="${category.id}">
                    
                    <input type="hidden" name="active" value="${category.id == 0 ? 1 : category.active}">
                    
                    <div class="form-group">
                        <label>Category Name <span class="text-danger">*</span></label>
                        <input type="text" class="form-control" name="name" value="${category.name}" required>
                    </div>
                    
                    <hr>
                    
                    <button type="submit" class="btn btn-primary">
                        <i class="fas fa-save"></i> Save Category
                    </button>
                    <a href="${pageContext.request.contextPath}/category" class="btn btn-secondary">Cancel</a>
                </form>
            </div>
        </div>
    </div>
    
    <%@ include file="template/footer.jsp"%>
</body>
</html>