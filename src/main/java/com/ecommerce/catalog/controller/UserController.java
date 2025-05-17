package com.ecommerce.catalog.controller;

import com.ecommerce.catalog.model.User;
import com.ecommerce.catalog.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.Map;
import java.util.Optional;

@RestController
@RequestMapping("/api/users")
public class UserController {

    @Autowired
    private UserService userService;

    /**
     * Authenticate a user
     */
    @PostMapping("/login")
    public ResponseEntity<Map<String, Object>> login(
            @RequestParam String username, 
            @RequestParam String password,
            HttpSession session) {
        
        Map<String, Object> response = new HashMap<>();
        
        Optional<User> userOptional = userService.authenticate(username, password);
        
        if (userOptional.isPresent()) {
            User user = userOptional.get();
            
            // Store user information in session
            session.setAttribute("user", user);
            session.setAttribute("username", user.getUsername());
            session.setAttribute("isAdmin", user.isAdmin());
            
            response.put("success", true);
            response.put("username", user.getUsername());
            response.put("isAdmin", user.isAdmin());
            
            return new ResponseEntity<>(response, HttpStatus.OK);
        } else {
            response.put("success", false);
            response.put("message", "Invalid username or password");
            
            return new ResponseEntity<>(response, HttpStatus.UNAUTHORIZED);
        }
    }

    /**
     * Logout a user
     */
    @PostMapping("/logout")
    public ResponseEntity<Map<String, Object>> logout(HttpSession session) {
        Map<String, Object> response = new HashMap<>();
        
        // Invalidate the session
        session.invalidate();
        
        response.put("success", true);
        response.put("message", "Logged out successfully");
        
        return new ResponseEntity<>(response, HttpStatus.OK);
    }

    /**
     * Check if a user is authenticated
     */
    @GetMapping("/check-auth")
    public ResponseEntity<Map<String, Object>> checkAuthentication(HttpSession session) {
        Map<String, Object> response = new HashMap<>();
        
        User user = (User) session.getAttribute("user");
        
        if (user != null) {
            response.put("authenticated", true);
            response.put("username", user.getUsername());
            response.put("isAdmin", user.isAdmin());
        } else {
            response.put("authenticated", false);
        }
        
        return new ResponseEntity<>(response, HttpStatus.OK);
    }
}
