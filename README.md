# Bookstore Management System

This project demonstrates a simple **Bookstore Management System** using MySQL. It includes tables for managing books, authors, customers, orders, and order details. The system is designed to handle adding new orders and generating sales reports.

## Project Structure

The system consists of the following components:

### 1. Tables:
- **Books**: Stores information about the books, including title, price, and stock.
- **Authors**: Stores information about authors, including name and email.
- **Customers**: Stores information about customers, including name, email, and address.
- **Orders**: Stores information about customer orders, including the order date and customer ID.
- **OrderDetails**: Stores information about the details of each order, including which book was ordered and the quantity.

### 2. Views:
- **SalesSummary**: A view that provides a summary of the total number of books sold. It aggregates the sales data for each book.

### 3. Stored Procedures:
- **AddOrder**: A stored procedure that allows the user to add a new order to the system. It takes customer ID, book ID, and quantity as input and updates the relevant tables (Orders and OrderDetails).

## How to Use

### Step 1: Setup the Database
1. Create the database and tables by running the provided SQL scripts (`bookstore.sql`).
2. Insert sample data into the tables to start testing the system.

### Step 2: Add a New Order
You can add a new order using the stored procedure **AddOrder**. It requires the customer ID, book ID, and quantity as input.

Example:
```sql
CALL AddOrder(1, 2, 3);
