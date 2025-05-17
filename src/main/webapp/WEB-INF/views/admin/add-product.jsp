<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${product.id eq null ? 'Add' : 'Edit'} Product - E-Commerce Product Catalog</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" href="/css/style.css">
</head>
<body>
    <!-- Header -->
    <jsp:include page="../common/header.jsp" />

    <div class="container mt-5">
        <div class="row justify-content-center">
            <div class="col-md-8">
                <div class="form-container">
                    <h2 class="form-title">${product.id eq null ? 'Add New Product' : 'Edit Product'}</h2>
                    
                    <form id="productForm" method="POST" action="${product.id eq null ? '/api/products' : '/api/products/'.concat(product.id)}">
                        <input type="hidden" name="_method" value="${product.id eq null ? 'POST' : 'PUT'}">
                        
                        <div class="form-group">
                            <label for="name">Product Name</label>
                            <input type="text" class="form-control" id="name" name="name" value="${product.name}" placeholder="Enter product name" required>
                        </div>
                        
                        <div class="form-group">
                            <label for="description">Description</label>
                            <textarea class="form-control" id="description" name="description" rows="4" placeholder="Enter product description">${product.description}</textarea>
                        </div>
                        
                        <div class="form-group">
                            <label for="price">Price</label>
                            <div class="input-group">
                                <div class="input-group-prepend">
                                    <span class="input-group-text">$</span>
                                </div>
                                <input type="number" class="form-control" id="price" name="price" value="${product.price}" placeholder="0.00" step="0.01" min="0" required>
                            </div>
                        </div>
                        
                        <div class="form-group">
                            <label for="category">Category</label>
                            <select class="form-control" id="category" name="category" required>
                                <option value="" disabled ${product.category eq null ? 'selected' : ''}>Select a category</option>
                                
                                <c:forEach items="${categories}" var="category">
                                    <option value="${category}" ${category eq product.category ? 'selected' : ''}>${category}</option>
                                </c:forEach>
                                
                                <option value="other">Other (New Category)</option>
                            </select>
                        </div>
                        
                        <div class="form-group" id="newCategoryGroup" style="display: none;">
                            <label for="newCategory">New Category Name</label>
                            <input type="text" class="form-control" id="newCategory" name="newCategory" placeholder="Enter new category name">
                        </div>
                        
                        <div class="form-group">
                            <label for="imageUrl">Image URL</label>
                            <input type="url" class="form-control" id="imageUrl" name="imageUrl" value="${product.imageUrl}" placeholder="https://example.com/image.jpg">
                            <small class="form-text text-muted">Enter a URL for the product image or leave blank for a placeholder image.</small>
                        </div>
                        
                        <div class="form-group d-flex justify-content-between">
                            <a href="/admin/products" class="btn btn-secondary">Cancel</a>
                            <button type="submit" class="btn btn-primary">${product.id eq null ? 'Add Product' : 'Update Product'}</button>
                        </div>
                    </form>
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
    
    <script>
        // Show/hide new category field based on selection
        document.getElementById('category').addEventListener('change', function() {
            const newCategoryGroup = document.getElementById('newCategoryGroup');
            
            if (this.value === 'other') {
                newCategoryGroup.style.display = 'block';
                document.getElementById('newCategory').setAttribute('required', 'required');
            } else {
                newCategoryGroup.style.display = 'none';
                document.getElementById('newCategory').removeAttribute('required');
            }
        });
    </script>
</body>
</html>
