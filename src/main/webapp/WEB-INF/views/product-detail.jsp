<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${product.name} - E-Commerce Product Catalog</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" href="/css/style.css">
</head>
<body>
    <!-- Header -->
    <jsp:include page="common/header.jsp" />

    <div class="container mt-5">
        <div class="row">
            <!-- Product Image -->
            <div class="col-md-6">
                <img src="${product.imageUrl}" alt="${product.name}" class="product-detail-img img-fluid">
            </div>
            
            <!-- Product Details -->
            <div class="col-md-6">
                <h1 class="product-detail-title">${product.name}</h1>
                <div class="product-detail-price">$${product.price}</div>
                <div class="product-detail-category">${product.category}</div>
                
                <div class="product-detail-description">
                    <h4>Description</h4>
                    <p>${product.description}</p>
                </div>
                
                <div class="mt-4">
                    <a href="/products" class="btn btn-secondary">Back to Products</a>
                    
                    <c:if test="${isAdmin eq true}">
                        <a href="/admin/products/edit/${product.id}" class="btn btn-warning ml-2">Edit Product</a>
                        <button 
                            class="btn btn-danger ml-2 delete-product-btn" 
                            data-product-id="${product.id}" 
                            data-product-name="${product.name}">
                            Delete Product
                        </button>
                    </c:if>
                </div>
            </div>
        </div>
    </div>

    <!-- Footer -->
    <jsp:include page="common/footer.jsp" />

    <!-- JavaScript -->
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    <script src="/js/main.js"></script>
</body>
</html>
