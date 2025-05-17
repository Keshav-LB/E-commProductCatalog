<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin - Product Management - E-Commerce Product Catalog</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
    <link rel="stylesheet" href="/css/style.css">
</head>
<body>
    <!-- Header -->
    <jsp:include page="../common/header.jsp" />

    <div class="container mt-4">
        <div class="d-flex justify-content-between align-items-center mb-4">
            <h2>Product Management</h2>
            <a href="/admin/products/add" class="btn btn-success">
                <i class="fas fa-plus"></i> Add New Product
            </a>
        </div>
        
        <div class="card shadow">
            <div class="card-body">
                <div class="table-responsive">
                    <table class="table table-hover admin-table">
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>Image</th>
                                <th>Name</th>
                                <th>Category</th>
                                <th>Price</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:if test="${empty products}">
                                <tr>
                                    <td colspan="6" class="text-center">No products found</td>
                                </tr>
                            </c:if>
                            
                            <c:forEach items="${products}" var="product">
                                <tr>
                                    <td>${product.id}</td>
                                    <td>
                                        <img src="${product.imageUrl}" alt="${product.name}" width="50" height="50" style="object-fit: cover;">
                                    </td>
                                    <td>${product.name}</td>
                                    <td>${product.category}</td>
                                    <td>$${product.price}</td>
                                    <td>
                                        <a href="/products/${product.id}" class="btn btn-sm btn-info admin-action-btn">
                                            <i class="fas fa-eye"></i> View
                                        </a>
                                        <a href="/admin/products/edit/${product.id}" class="btn btn-sm btn-warning admin-action-btn">
                                            <i class="fas fa-edit"></i> Edit
                                        </a>
                                        <button 
                                            class="btn btn-sm btn-danger admin-action-btn delete-product-btn" 
                                            data-product-id="${product.id}" 
                                            data-product-name="${product.name}">
                                            <i class="fas fa-trash"></i> Delete
                                        </button>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>

    <!-- Footer -->
    <jsp:include page="../common/footer.jsp" />

    <!-- JavaScript -->
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    <script src="/js/main.js"></script>
</body>
</html>
