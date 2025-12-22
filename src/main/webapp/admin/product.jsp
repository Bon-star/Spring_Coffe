<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <%@ include file="template/headLink.jsp"%>
    <link href="https://cdn.datatables.net/1.13.6/css/dataTables.bootstrap4.min.css" rel="stylesheet">
    <title>Product List</title>
</head>
<body id="page-top">
    <%@ include file="template/header.jsp"%>
    
    <div class="container-fluid">
        <div class="d-sm-flex align-items-center justify-content-between mb-4">
            <h1 class="h3 mb-0 text-gray-800">Product Management</h1>
            <a href="${pageContext.request.contextPath}/product/add" class="btn btn-sm btn-primary shadow-sm">
                <i class="fas fa-plus"></i> Add New Product
            </a>
        </div>

        <div class="card shadow mb-4">
            <div class="card-header py-3">
                <h6 class="m-0 font-weight-bold text-primary">List of Products</h6>
            </div>
            <div class="card-body">
                <div class="table-responsive">
                    <table class="table table-bordered" id="productTable" width="100%" cellspacing="0">
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>Image</th> <th>Name</th>
                                <th>Price</th>
                                <th>Category</th>
                                <th>Status</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="p" items="${products}">
                                <tr>
                                    <td>${p.id}</td>
                                    <td class="text-center">
                                        <img src="${pageContext.request.contextPath}/images/${p.image}" 
                                         
                                             alt="img" style="height: 50px; width: auto; border-radius: 4px;">
                                    </td>
                                    <td>${p.name}</td>
                                    <td>${p.price} VND</td>
                                    <td>${p.categoryName}</td>
                                    <td>
                                        <a href="${pageContext.request.contextPath}/product/toggle?id=${p.id}&status=${p.active}" class="text-decoration-none">
                                            <c:choose>
                                                <c:when test="${p.active == 1}"><span class="badge badge-success">Active</span></c:when>
                                                <c:otherwise><span class="badge badge-secondary">Hidden</span></c:otherwise>
                                            </c:choose>
                                        </a>
                                    </td>
                                    <td>
                                        <a href="${pageContext.request.contextPath}/product/edit?id=${p.id}" class="btn btn-info btn-sm">Edit</a>
                                        <a href="${pageContext.request.contextPath}/product/delete?id=${p.id}" class="btn btn-danger btn-sm" onclick="return confirm('Delete this product?')">Delete</a>
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
            $('#productTable').DataTable();
        });
    </script>
</body>
</html>