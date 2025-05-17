// Wait for the DOM to be fully loaded
document.addEventListener('DOMContentLoaded', function() {
    // Configure delete product buttons
    setupDeleteButtons();
    
    // Configure form validation
    setupFormValidation();
    
    // Setup filters
    setupFilters();
});

/**
 * Setup delete confirmation for product buttons
 */
function setupDeleteButtons() {
    const deleteButtons = document.querySelectorAll('.delete-product-btn');
    
    deleteButtons.forEach(button => {
        button.addEventListener('click', function(e) {
            e.preventDefault();
            
            const productId = this.getAttribute('data-product-id');
            const productName = this.getAttribute('data-product-name');
            
            if (confirm(`Are you sure you want to delete "${productName}"?`)) {
                deleteProduct(productId);
            }
        });
    });
}

/**
 * Delete a product via AJAX
 */
function deleteProduct(productId) {
    fetch(`/api/products/${productId}`, {
        method: 'DELETE',
        headers: {
            'Content-Type': 'application/json'
        },
        credentials: 'same-origin'
    })
    .then(response => {
        if (response.ok) {
            // Reload the page to reflect the deletion
            window.location.reload();
        } else {
            throw new Error('Failed to delete product');
        }
    })
    .catch(error => {
        console.error('Error:', error);
        alert('An error occurred while deleting the product. Please try again.');
    });
}

/**
 * Setup form validation for product forms
 */
function setupFormValidation() {
    const productForm = document.getElementById('productForm');
    
    if (productForm) {
        productForm.addEventListener('submit', function(e) {
            if (!validateProductForm()) {
                e.preventDefault();
            }
        });
    }
    
    const loginForm = document.getElementById('loginForm');
    
    if (loginForm) {
        loginForm.addEventListener('submit', function(e) {
            if (!validateLoginForm()) {
                e.preventDefault();
            }
        });
    }
}

/**
 * Validate the product form
 */
function validateProductForm() {
    const nameInput = document.getElementById('name');
    const priceInput = document.getElementById('price');
    const categoryInput = document.getElementById('category');
    
    let isValid = true;
    
    // Reset error messages
    clearErrorMessages();
    
    // Validate name
    if (!nameInput.value.trim()) {
        displayError(nameInput, 'Product name is required');
        isValid = false;
    }
    
    // Validate price
    if (!priceInput.value.trim()) {
        displayError(priceInput, 'Price is required');
        isValid = false;
    } else if (isNaN(priceInput.value) || parseFloat(priceInput.value) <= 0) {
        displayError(priceInput, 'Price must be a positive number');
        isValid = false;
    }
    
    // Validate category
    if (!categoryInput.value.trim()) {
        displayError(categoryInput, 'Category is required');
        isValid = false;
    }
    
    return isValid;
}

/**
 * Validate the login form
 */
function validateLoginForm() {
    const usernameInput = document.getElementById('username');
    const passwordInput = document.getElementById('password');
    
    let isValid = true;
    
    // Reset error messages
    clearErrorMessages();
    
    // Validate username
    if (!usernameInput.value.trim()) {
        displayError(usernameInput, 'Username is required');
        isValid = false;
    }
    
    // Validate password
    if (!passwordInput.value.trim()) {
        displayError(passwordInput, 'Password is required');
        isValid = false;
    }
    
    return isValid;
}

/**
 * Display error message for form input
 */
function displayError(inputElement, message) {
    const errorDiv = document.createElement('div');
    errorDiv.className = 'invalid-feedback';
    errorDiv.textContent = message;
    
    inputElement.classList.add('is-invalid');
    inputElement.parentNode.appendChild(errorDiv);
}

/**
 * Clear all error messages
 */
function clearErrorMessages() {
    const errorMessages = document.querySelectorAll('.invalid-feedback');
    const invalidInputs = document.querySelectorAll('.is-invalid');
    
    errorMessages.forEach(errorMsg => errorMsg.remove());
    invalidInputs.forEach(input => input.classList.remove('is-invalid'));
}

/**
 * Setup filter functionality
 */
function setupFilters() {
    const categorySelect = document.getElementById('categoryFilter');
    const searchInput = document.getElementById('searchInput');
    const searchForm = document.getElementById('searchForm');
    
    if (categorySelect) {
        categorySelect.addEventListener('change', function() {
            if (searchForm) {
                searchForm.submit();
            }
        });
    }
}

/**
 * Handle login via AJAX
 */
function login(e) {
    e.preventDefault();
    
    const username = document.getElementById('username').value;
    const password = document.getElementById('password').value;
    const errorMessage = document.getElementById('errorMessage');
    
    if (!username || !password) {
        errorMessage.textContent = 'Please enter both username and password';
        errorMessage.style.display = 'block';
        return;
    }
    
    const formData = new FormData();
    formData.append('username', username);
    formData.append('password', password);
    
    fetch('/api/users/login', {
        method: 'POST',
        body: formData,
        credentials: 'same-origin'
    })
    .then(response => response.json())
    .then(data => {
        if (data.success) {
            window.location.href = '/products';
        } else {
            errorMessage.textContent = data.message || 'Invalid username or password';
            errorMessage.style.display = 'block';
        }
    })
    .catch(error => {
        console.error('Error:', error);
        errorMessage.textContent = 'An error occurred. Please try again.';
        errorMessage.style.display = 'block';
    });
}

/**
 * Handle logout via AJAX
 */
function logout() {
    fetch('/api/users/logout', {
        method: 'POST',
        credentials: 'same-origin'
    })
    .then(response => response.json())
    .then(data => {
        if (data.success) {
            window.location.href = '/login';
        }
    })
    .catch(error => {
        console.error('Error:', error);
        alert('An error occurred while logging out. Please try again.');
    });
}
