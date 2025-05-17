<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<header>
    <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
        <div class="container">
            <a class="navbar-brand" href="/products">E-Commerce Product Catalog</a>
            
            <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            
            <div class="collapse navbar-collapse" id="navbarSupportedContent">
                <ul class="navbar-nav mr-auto">
                    <li class="nav-item">
                        <a class="nav-link" href="/products">Products</a>
                    </li>
                    
                    <c:if test="${isAdmin eq true}">
                        <li class="nav-item">
                            <a class="nav-link" href="/admin/products">Admin Panel</a>
                        </li>
                    </c:if>
                </ul>
                
                <div class="navbar-nav">
                    <c:choose>
                        <c:when test="${username ne null}">
                            <span class="nav-item nav-link">Welcome, ${username}!</span>
                            <a class="nav-link" href="#" onclick="logout(); return false;">Logout</a>
                        </c:when>
                        <c:otherwise>
                            <a class="nav-link" href="/login">Login</a>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
        </div>
    </nav>
</header>
