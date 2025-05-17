package com.ecommerce.catalog.controller;

import com.ecommerce.catalog.model.Product;
import com.ecommerce.catalog.service.ProductService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;
import java.util.List;
import java.util.Optional;

@Controller
public class WebController {

    @Autowired
    private ProductService productService;

    /**
     * Home page - redirect to products page
     */
    @GetMapping("/")
    public String home() {
        return "redirect:/products";
    }

    /**
     * Login page
     */
    @GetMapping("/login")
    public String loginPage(HttpSession session) {
        // If user is already logged in, redirect to products page
        if (session.getAttribute("username") != null) {
            return "redirect:/products";
        }
        
        return "login";
    }

    /**
     * Products listing page
     */
    @GetMapping("/products")
    public String productsPage(
            @RequestParam(required = false) String category,
            @RequestParam(required = false) String search,
            Model model, 
            HttpSession session) {
        
        List<Product> products;
        
        // Filter products by category and/or search term
        if (category != null && !category.isEmpty()) {
            products = productService.getProductsByCategory(category);
            model.addAttribute("selectedCategory", category);
        } else if (search != null && !search.isEmpty()) {
            products = productService.searchProducts(search);
            model.addAttribute("searchTerm", search);
        } else {
            products = productService.getAllProducts();
        }
        
        // Get all categories for the filter dropdown
        List<String> categories = productService.getAllCategories();
        
        model.addAttribute("products", products);
        model.addAttribute("categories", categories);
        
        // Add authentication information to the model
        model.addAttribute("username", session.getAttribute("username"));
        model.addAttribute("isAdmin", session.getAttribute("isAdmin"));
        
        return "products";
    }

    /**
     * Product detail page
     */
    @GetMapping("/products/{id}")
    public String productDetailPage(@PathVariable Long id, Model model, HttpSession session) {
        Optional<Product> productOptional = productService.getProductById(id);
        
        if (productOptional.isPresent()) {
            model.addAttribute("product", productOptional.get());
            
            // Add authentication information to the model
            model.addAttribute("username", session.getAttribute("username"));
            model.addAttribute("isAdmin", session.getAttribute("isAdmin"));
            
            return "product-detail";
        } else {
            return "redirect:/products";
        }
    }

    /**
     * Admin page for product management
     */
    @GetMapping("/admin/products")
    public String adminProductsPage(Model model, HttpSession session) {
        // Check if the user is an admin
        Boolean isAdmin = (Boolean) session.getAttribute("isAdmin");
        
        if (isAdmin == null || !isAdmin) {
            return "redirect:/login";
        }
        
        List<Product> products = productService.getAllProducts();
        model.addAttribute("products", products);
        
        // Add authentication information to the model
        model.addAttribute("username", session.getAttribute("username"));
        model.addAttribute("isAdmin", isAdmin);
        
        return "admin/admin-products";
    }

    /**
     * Add product page
     */
    @GetMapping("/admin/products/add")
    public String addProductPage(Model model, HttpSession session) {
        // Check if the user is an admin
        Boolean isAdmin = (Boolean) session.getAttribute("isAdmin");
        
        if (isAdmin == null || !isAdmin) {
            return "redirect:/login";
        }
        
        List<String> categories = productService.getAllCategories();
        model.addAttribute("categories", categories);
        model.addAttribute("product", new Product());
        
        // Add authentication information to the model
        model.addAttribute("username", session.getAttribute("username"));
        model.addAttribute("isAdmin", isAdmin);
        
        return "admin/add-product";
    }

    /**
     * Edit product page
     */
    @GetMapping("/admin/products/edit/{id}")
    public String editProductPage(@PathVariable Long id, Model model, HttpSession session) {
        // Check if the user is an admin
        Boolean isAdmin = (Boolean) session.getAttribute("isAdmin");
        
        if (isAdmin == null || !isAdmin) {
            return "redirect:/login";
        }
        
        Optional<Product> productOptional = productService.getProductById(id);
        
        if (productOptional.isPresent()) {
            List<String> categories = productService.getAllCategories();
            
            model.addAttribute("categories", categories);
            model.addAttribute("product", productOptional.get());
            
            // Add authentication information to the model
            model.addAttribute("username", session.getAttribute("username"));
            model.addAttribute("isAdmin", isAdmin);
            
            return "admin/add-product";
        } else {
            return "redirect:/admin/products";
        }
    }
}
