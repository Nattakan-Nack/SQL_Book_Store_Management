CREATE DATABASE Bookstore;

USE Bookstore;

-- สร้างตาราง Books
CREATE TABLE Books (
    book_id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255),
    price DECIMAL(5,2),
    stock INT
);

-- สร้างตาราง Authors
CREATE TABLE Authors (
    author_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255),
    email VARCHAR(255)
);

-- สร้างตาราง Customers
CREATE TABLE Customers (
    customer_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255),
    email VARCHAR(255),
    address TEXT
);

-- สร้างตาราง Orders
CREATE TABLE Orders (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    order_date DATE,
    customer_id INT,
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
);

-- ตารางเก็บรายละเอียดของการสั่งซื้อ
CREATE TABLE OrderDetails (
    order_detail_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT,
    book_id INT,
    quantity INT,
    FOREIGN KEY (order_id) REFERENCES Orders(order_id),
    FOREIGN KEY (book_id) REFERENCES Books(book_id)
);
-- ข้อมูลหนังสือ
INSERT INTO Books (title, price, stock)
VALUES ('Learn SQL', 19.99, 10),
       ('Mastering MySQL', 29.99, 5);

-- ข้อมูลผู้เขียน
INSERT INTO Authors (name, email)
VALUES ('John Doe', 'john@example.com'),
       ('Jane Smith', 'jane@example.com');

-- ข้อมูลลูกค้า
INSERT INTO Customers (name, email, address)
VALUES ('Alice', 'alice@example.com', '123 Wonderland'),
       ('Bob', 'bob@example.com', '456 Elm Street');

-- ข้อมูลการสั่งซื้อ
INSERT INTO Orders (order_date, customer_id)
VALUES ('2024-10-22', 1),
       ('2024-10-22', 2);

-- รายละเอียดการสั่งซื้อ
INSERT INTO OrderDetails (order_id, book_id, quantity)
VALUES (1, 1, 2), (2, 2, 1);

SELECT Orders.order_id, Customers.name, Books.title, OrderDetails.quantity
FROM Orders
JOIN Customers ON Orders.customer_idcustomer_id = Customers.customer_id
JOIN OrderDetails ON Orders.order_id = OrderDetails.order_id
JOIN Books ON OrderDetails.book_id = Books.book_id;

-- สร้าง view 
CREATE VIEW SalesSummary AS
SELECT Books.title, SUM(OrderDetails.quantity) AS total_sold
FROM OrderDetails
JOIN Books ON OrderDetails.book_id = Books.book_id
GROUP BY Books.title;

-- เรียกดู หนังสือไหนขายดีที่สุด หลังจากที่เราได้สร้าง view เเล้ว 
SELECT * FROM SalesSummary;

-- คำสั่งลบ View (if you needed)
DROP VIEW SalesSummary;

-- ต้องการเพิ่มคำสั้งซื้อใหม่
DELIMITER //
CREATE PROCEDURE AddOrder(IN customer INT, IN book INT, IN quantity INT)
BEGIN
    -- ขั้นตอนที่ 1: เพิ่มข้อมูลการสั่งซื้อใหม่ลงในตาราง Orders
    INSERT INTO Orders (order_date, customer_id) VALUES (CURDATE(), customer);
    
    -- ขั้นตอนที่ 2: เพิ่มรายละเอียดของการสั่งซื้อใหม่ในตาราง OrderDetails
    INSERT INTO OrderDetails (order_id, book_id, quantity) 
    VALUES (LAST_INSERT_ID(), book, quantity);
END //
DELIMITER ;

CALL AddOrder(1, 1, 2);
