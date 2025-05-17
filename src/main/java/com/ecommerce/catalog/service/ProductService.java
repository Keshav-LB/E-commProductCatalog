package com.ecommerce.catalog.service;

import com.ecommerce.catalog.model.Product;
import com.ecommerce.catalog.repository.ProductRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.annotation.PostConstruct;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

@Service
public class ProductService {

    @Autowired
    private ProductRepository productRepository;

    /**
     * Get all products
     */
    public List<Product> getAllProducts() {
        return productRepository.findAll();
    }

    /**
     * Get product by ID
     */
    public Optional<Product> getProductById(Long id) {
        return productRepository.findById(id);
    }

    /**
     * Create a new product
     */
    public Product createProduct(Product product) {
        return productRepository.save(product);
    }

    /**
     * Update an existing product
     */
    public Product updateProduct(Product product) {
        return productRepository.save(product);
    }

    /**
     * Delete a product by ID
     */
    public void deleteProduct(Long id) {
        productRepository.deleteById(id);
    }

    /**
     * Search products by keyword (name or category)
     */
    public List<Product> searchProducts(String keyword) {
        if (keyword == null || keyword.trim().isEmpty()) {
            return getAllProducts();
        }
        return productRepository.searchByKeyword(keyword);
    }

    /**
     * Filter products by category
     */
    public List<Product> getProductsByCategory(String category) {
        return productRepository.findByCategory(category);
    }

    /**
     * Get all unique categories
     */
    public List<String> getAllCategories() {
        List<String> categories = new ArrayList<>();
        List<Product> products = productRepository.findAll();
        
        for (Product product : products) {
            if (!categories.contains(product.getCategory())) {
                categories.add(product.getCategory());
            }
        }
        
        return categories;
    }

    /**
     * Search products by name
     */
    public List<Product> searchProductsByName(String name) {
        return productRepository.findByNameContainingIgnoreCase(name);
    }

    /**
     * Initialize database with sample products if empty
     */
    @PostConstruct
    public void init() {
        if (productRepository.count() == 0) {
            // Electronics category
            createProduct(new Product(
                    "Smartphone X",
                    "Latest smartphone with advanced features and 5G capability.",
                    new BigDecimal("699.99"),
                    "Electronics",
                    "https://via.placeholder.com/300"
            ));
            
            createProduct(new Product(
                    "Laptop Pro",
                    "High-performance laptop for professional work and gaming.",
                    new BigDecimal("1299.99"),
                    "Electronics",
                    "https://via.placeholder.com/300"
            ));
            
            // Clothing category
            createProduct(new Product(
                    "Casual T-Shirt",
                    "Comfortable cotton t-shirt for everyday wear.",
                    new BigDecimal("24.99"),
                    "Clothing",
                    "https://via.placeholder.com/300"
            ));
            
            createProduct(new Product(
                    "Jeans",
                    "Classic blue jeans with straight fit.",
                    new BigDecimal("49.99"),
                    "Clothing",
                    "https://via.placeholder.com/300"
            ));
            
            // Home & Kitchen category
            createProduct(new Product(
                    "Coffee Maker",
                    "Automatic coffee maker with timer and multiple settings.",
                    new BigDecimal("89.99"),
                    "Home & Kitchen",
                    "https://via.placeholder.com/300"
            ));
            
            createProduct(new Product(
                    "Blender",
                    "High-speed blender for smoothies and food preparation.",
                    new BigDecimal("69.99"),
                    "Home & Kitchen",
                    "https://via.placeholder.com/300"
            ));
        }
    }
}
