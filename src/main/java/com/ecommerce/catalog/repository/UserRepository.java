package com.ecommerce.catalog.repository;

import com.ecommerce.catalog.model.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface UserRepository extends JpaRepository<User, Long> {
    
    // Find a user by username
    Optional<User> findByUsername(String username);
    
    // Check if a user exists with the given username and password
    boolean existsByUsernameAndPassword(String username, String password);
}
