<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <%@ include file="template/headLink.jsp"%>
    <link href="https://cdn.datatables.net/1.13.6/css/dataTables.bootstrap4.min.css" rel="stylesheet">
    <title>Category List</title>
</head>

<body id="page-top">
    <%@ include file="template/header.jsp"%>

    <div class="container-fluid">
        <c:if test="${param.error == 'cannot_delete'}">
            <div class="alert alert-danger alert-dismissible fade show" role="alert">
                <strong>Error!</strong> Cannot delete this category because it contains products.
                <button type="button" class="close" data-dismiss="alert">&times;</button>
            </div>
        </c:if>
        <c:if test="${param.msg == 'deleted'}">
            <div class="alert alert-success alert-dismissible fade show" role="alert">
                Category deleted successfully!
                <button type="button" class="close" data-dismiss="alert">&times;</button>
            </div>
        </c:if>

        <div class="d-sm-flex align-items-center justify-content-between mb-4">
            <h1 class="h3 mb-0 text-gray-800">Category Management</h1>
            <a href="${pageContext.request.contextPath}/category/add" class="btn btn-sm btn-primary shadow-sm">
                <i class="fas fa-plus"></i> Add New Category
            </a>
        </div>

        <div class="card shadow mb-4">
            <div class="card-header py-3">
                <h6 class="m-0 font-weight-bold text-primary">List of Categories</h6>
            </div>
            <div class="card-body">
                <div class="table-responsive">
                    <table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>Name</th>
                                <th>Status (Click to toggle)</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="c" items="${categories}">
                                <tr>
                                    <td>${c.id}</td>
                                    <td><strong>${c.name}</strong></td>
                                    <td>
                                        <a href="${pageContext.request.contextPath}/category/toggle?id=${c.id}&status=${c.active}" 
                                           class="text-decoration-none" 
                                           title="Click to change status">
                                            <c:choose>
                                                <c:when test="${c.active == 1}">
                                                    <span class="badge badge-success px-2 py-1">Active</span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="badge badge-secondary px-2 py-1">Hidden</span>
                                                </c:otherwise>
                                            </c:choose>
                                        </a>
                                    </td>
                                    <td>
                                        <a href="${pageContext.request.contextPath}/category/edit?id=${c.id}" class="btn btn-info btn-sm">
                                            <i class="fas fa-pencil-alt"></i> Edit
                                        </a>
                                        <a href="${pageContext.request.contextPath}/category/delete?id=${c.id}" 
                                           class="btn btn-danger btn-sm"
                                           onclick="return confirm('Are you sure? Note: You cannot delete categories containing products.')">
                                            <i class="fas fa-trash"></i> Delete
                                        </a>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
    
    <%@ include file="template/footer.jsp"%>
    
    <script src="https://cdn.datatables.net/1.13.6/js/jquery.dataTables.min.js"></script>
    <script src="https://cdn.datatables.net/1.13.6/js/dataTables.bootstrap4.min.js"></script>
    <script>
        $(document).ready(function() {
            $('#dataTable').DataTable();
        });
    </script>
</body>
</html>