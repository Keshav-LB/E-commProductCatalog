# E-Commerce Product Catalog

A Java Spring Boot web application that provides a complete product catalog system with user and admin views.

## Features

- **Product Management**: View, add, edit, and delete products
- **User Authentication**: Login system with different access levels (admin/regular user)
- **Image Upload**: Upload product images directly from your local system
- **Responsive Design**: Works on both desktop and mobile devices
- **Search and Filter**: Find products by name or category
- **Categories**: Organize products into different categories

## Technology Stack

- **Backend**: Java 17, Spring Boot 2.7.9
- **Database**: H2 In-Memory Database (can be easily switched to MySQL/PostgreSQL)
- **Frontend**: JSP, HTML5, CSS3, JavaScript, Bootstrap 4.5
- **Build Tool**: Maven

## Prerequisites

To run this application, you need:

- Java JDK 17 or higher
- Maven 3.6 or higher

## Setup and Installation

1. **Clone the repository**
   ```
   git clone https://github.com/yourusername/ecommerce-catalog.git
   cd ecommerce-catalog
   ```

2. **Build the application**
   ```
   ./mvnw clean install
   ```

3. **Run the application**
   ```
   ./mvnw spring-boot:run
   ```

4. **Access the application**
   
   Open your web browser and go to: `http://localhost:5000`

## Default Accounts

The application is pre-configured with two user accounts:

- **Admin User**
  - Username: `admin`
  - Password: `admin123`
  - Has full access to create, update, and delete products

- **Regular User**
  - Username: `user`
  - Password: `user123`
  - Can browse products and view details

## Database Configuration

The application uses an H2 in-memory database by default. The database console is available at:

- URL: `http://localhost:5000/h2-console`
- JDBC URL: `jdbc:h2:mem:ecommercedb`
- Username: `sa`
- Password: ` ` (empty password)

## Customizing the Application

### Changing to a persistent database

To switch to a persistent database like MySQL or PostgreSQL, update the `application.properties` file:

```properties
# MySQL Example
spring.datasource.url=jdbc:mysql://localhost:3306/ecommercedb
spring.datasource.username=root
spring.datasource.password=yourpassword
spring.datasource.driver-class-name=com.mysql.cj.jdbc.Driver
spring.jpa.properties.hibernate.dialect=org.hibernate.dialect.MySQL8Dialect
```

Don't forget to add the corresponding database driver dependency to the `pom.xml`.

### File Upload Configuration

The file upload settings can be modified in the `application.properties`:

```properties
# File Upload Configuration
spring.servlet.multipart.max-file-size=10MB
spring.servlet.multipart.max-request-size=15MB
```

## Project Structure

- `src/main/java/com/ecommerce/catalog` - Java source files
  - `controller` - API and web controllers
  - `model` - Data models/entities
  - `repository` - Data access interfaces
  - `service` - Business logic
  - `config` - Application configuration
- `src/main/resources` - Configuration files and static resources
- `src/main/webapp/WEB-INF/views` - JSP views

## API Endpoints

The application provides RESTful API endpoints:

- `GET /api/products` - Get all products
- `GET /api/products/{id}` - Get a specific product
- `POST /api/products` - Create a new product
- `POST /api/products/with-image` - Create a new product with an image
- `PUT /api/products/{id}` - Update a product
- `PUT /api/products/{id}/with-image` - Update a product with an image
- `DELETE /api/products/{id}` - Delete a product
- `GET /api/products/search?keyword=value` - Search products by keyword
- `GET /api/products/category/{category}` - Get products by category
- `GET /api/products/categories` - Get all categories

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.
