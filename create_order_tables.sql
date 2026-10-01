USE BookStoreDB;
GO

IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='orders' and xtype='U')
BEGIN
    CREATE TABLE orders (
        order_id int IDENTITY(1,1) PRIMARY KEY,
        user_id int FOREIGN KEY REFERENCES users(id),
        order_date datetime DEFAULT GETDATE(),
        total_money decimal(18, 2),
        address nvarchar(max),
        status nvarchar(50) DEFAULT 'Pending'
    );
END
GO

IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='order_details' and xtype='U')
BEGIN
    CREATE TABLE order_details (
        detail_id int IDENTITY(1,1) PRIMARY KEY,
        order_id int FOREIGN KEY REFERENCES orders(order_id),
        book_id int FOREIGN KEY REFERENCES books(bookid),
        quantity int,
        price decimal(18, 2)
    );
END
GO
