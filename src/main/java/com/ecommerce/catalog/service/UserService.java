package com.ecommerce.catalog.service;

import com.ecommerce.catalog.model.User;
import com.ecommerce.catalog.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.annotation.PostConstruct;
import java.util.Optional;

@Service
public class UserService {

    @Autowired
    private UserRepository userRepository;

    /**
     * Find a user by username
     */
    public Optional<User> findByUsername(String username) {
        return userRepository.findByUsername(username);
    }

    /**
     * Authenticate a user with username and password
     */
    public Optional<User> authenticate(String username, String password) {
        Optional<User> userOptional = userRepository.findByUsername(username);
        
        if (userOptional.isPresent()) {
            User user = userOptional.get();
            if (user.getPassword().equals(password)) {
                return Optional.of(user);
            }
        }
        
        return Optional.empty();
    }

    /**
     * Create a new user
     */
    public User createUser(User user) {
        return userRepository.save(user);
    }

    /**
     * Initialize database with sample users if empty
     */
    @PostConstruct
    public void init() {
        if (userRepository.count() == 0) {
            // Create admin user
            createUser(new User("admin", "admin123", true));
            
            // Create regular user
            createUser(new User("user", "user123", false));
        }
    }
}
