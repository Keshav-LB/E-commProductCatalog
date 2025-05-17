<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Products - E-Commerce Product Catalog</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" href="/css/style.css">
</head>
<body>
    <!-- Header -->
    <jsp:include page="common/header.jsp" />

    <div class="container mt-4">
        <!-- Filter Section -->
        <div class="row">
            <div class="col-md-12">
                <div class="filter-section d-flex justify-content-between align-items-center">
                    <form id="searchForm" action="/products" method="get" class="d-flex flex-grow-1">
                        <div class="form-group mr-3 mb-0 flex-grow-1">
                            <input type="text" class="form-control" id="searchInput" name="search" placeholder="Search products..." value="${searchTerm}">
                        </div>
                        
                        <div class="form-group mr-3 mb-0">
                            <select class="form-control" id="categoryFilter" name="category">
                                <option value="">All Categories</option>
                                <c:forEach items="${categories}" var="category">
                                    <option value="${category}" ${category eq selectedCategory ? 'selected' : ''}>${category}</option>
                                </c:forEach>
                            </select>
                        </div>
                        
                        <button type="submit" class="btn btn-primary">Search</button>
                    </form>
                </div>
            </div>
        </div>
        
        <!-- Products Grid -->
        <div class="row mt-4">
            <c:if test="${empty products}">
                <div class="col-md-12 text-center">
                    <div class="alert alert-info">
                        No products found. Please try a different search or category.
                    </div>
                </div>
            </c:if>
            
            <c:forEach items="${products}" var="product">
                <div class="col-md-4 col-sm-6 mb-4">
                    <div class="card h-100">
                        <img src="${product.imageUrl}" class="card-img-top" alt="${product.name}">
                        <div class="card-body">
                            <h5 class="card-title">${product.name}</h5>
                            <p class="card-text">${product.description.length() > 100 ? product.description.substring(0, 100).concat('...') : product.description}</p>
                            <div class="card-price">$${product.price}</div>
                            <div class="card-category">${product.category}</div>
                            <a href="/products/${product.id}" class="btn btn-primary mt-3">View Details</a>
                        </div>
                    </div>
                </div>
            </c:forEach>
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
