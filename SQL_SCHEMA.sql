-- Create the User table
CREATE TABLE [dbo].[User] (
    [UserID] INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
    [UserName] VARCHAR(100) NOT NULL,
    [Email] VARCHAR(100) NOT NULL,
    [Password] VARCHAR(100) NOT NULL,
    [MobileNo] VARCHAR(15) NOT NULL,
    [Address] VARCHAR(100) NOT NULL,
    [IsActive] BIT NOT NULL
);
-- Create the Product table
CREATE TABLE [dbo].[Product] (
    [ProductID] INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
    [ProductName] VARCHAR(100) NOT NULL,
    [ProductPrice] DECIMAL(10,2) NOT NULL,
    [ProductCode] VARCHAR(100) NOT NULL,
    [Description] VARCHAR(100) NOT NULL,
    [UserID] INT NOT NULL FOREIGN KEY REFERENCES [User](UserID)
)

-- Insert records into User
INSERT INTO [dbo].[User] 
([dbo].[User].[UserName], 
[dbo].[User].[Email], 
[dbo].[User].[Password], 
[dbo].[User].[MobileNo], 
[dbo].[User].[Address], 
[dbo].[User].[IsActive])
VALUES 
('Namra Pithwa', 'namra@gmail.com', 'Namra@123', '9173316294', 'Navlanagar-1', 1),
('Sumit Chauhan', 'sumit@gmail.com', 'Sumit@123', '9054277510', 'Speedwell', 1);


-- Insert records into Product
INSERT INTO [dbo].[Product] 
([dbo].[Product].[ProductName], 
[dbo].[Product].[ProductPrice], 
[dbo].[Product].[ProductCode], 
[dbo].[Product].[Description], 
[dbo].[Product].[UserID])
VALUES 
('Espresso', 2.50, 'P001', 'Rich and bold coffee', 1),
('Latte', 3.50, 'P002', 'Smooth coffee with milk', 2),
('Cappuccino', 3.00, 'P003', 'Coffee with foam', 2),
('Mocha', 4.00, 'P004', 'Coffee with chocolate', 1),
('Americano', 2.00, 'P005', 'Espresso with water', 1);

-- Stored Procdure Insert Product
CREATE PROCEDURE [dbo].[PR_Product_Insert]
    @ProductName VARCHAR(100),
    @ProductPrice DECIMAL(10,2),
    @ProductCode VARCHAR(100),
    @Description VARCHAR(100),
    @UserID INT
AS
BEGIN
    INSERT INTO [dbo].[Product]([dbo].[Product].[ProductName], [dbo].[Product].[ProductPrice], [dbo].[Product].[ProductCode], [dbo].[Product].[Description], [dbo].[Product].[UserID])
	VALUES (@ProductName, @ProductPrice, @ProductCode, @Description, @UserID);
END;

-- Stored Procdure Insert User
CREATE OR ALTER PROCEDURE [dbo].[PR_User_Insert]
    @UserName VARCHAR(100),
    @Email VARCHAR(100),
    @Password VARCHAR(100),
    @MobileNo VARCHAR(15),
    @Address VARCHAR(100),
    @IsActive BIT
AS
BEGIN
    INSERT INTO [dbo].[User]([dbo].[User].[UserName], [dbo].[User].[Email], [dbo].[User].[Password], [dbo].[User].[MobileNo], [dbo].[User].[Address], [dbo].[User].[IsActive])
	VALUES (@UserName, @Email, @Password, @MobileNo, @Address, @IsActive);
END;


-- Stored Procdure Update Product

CREATE OR ALTER PROCEDURE [dbo].[PR_Product_UpdateByPk]
    @ProductID INT,
    @ProductName VARCHAR(100),
    @ProductPrice DECIMAL(10,2),
    @ProductCode VARCHAR(100),
    @Description VARCHAR(100),
    @UserID INT
AS
BEGIN
    UPDATE [dbo].[Product]
    SET [dbo].[Product].[ProductName] = @ProductName, 
        [dbo].[Product].[ProductPrice] = @ProductPrice, 
        [dbo].[Product].[ProductCode] = @ProductCode, 
        [dbo].[Product].[Description] = @Description, 
        [dbo].[Product].[UserID] = @UserID
    WHERE [dbo].[Product].[ProductID] = @ProductID;
END;


-- Stored Procdure Update User

CREATE OR ALTER PROCEDURE [dbo].[PR_User_UpdateByPk]
    @UserID INT,
    @UserName VARCHAR(100),
    @Email VARCHAR(100),
    @Password VARCHAR(100),
    @MobileNo VARCHAR(15),
    @Address VARCHAR(100),
    @IsActive BIT
AS
BEGIN
    UPDATE [dbo].[User]
    SET [dbo].[User].[UserName] = @UserName, 
        [dbo].[User].[Email] = @Email, 
        [dbo].[User].[Password] = @Password, 
        [dbo].[User].[MobileNo] = @MobileNo, 
        [dbo].[User].[Address] = @Address, 
        [dbo].[User].[IsActive] = @IsActive
    WHERE [dbo].[User].[UserID] = @UserID;
END;

-- Stored Procdure Delete Product

CREATE OR ALTER PROCEDURE [dbo].[PR_Product_DeleteByPk]
    @ProductID INT
AS
BEGIN
    DELETE FROM [dbo].[Product]
    WHERE [dbo].[Product].[ProductID] = @ProductID;
END;

-- Stored Procdure Delete User

CREATE OR ALTER PROCEDURE [dbo].[PR_User_DeleteByPk]
    @UserID INT
AS
BEGIN
    DELETE FROM [dbo].[User]
    WHERE [dbo].[User].[UserID] = @UserID;
END;


-- Stored Procdure Select All Product
CREATE OR ALTER PROCEDURE [dbo].[PR_Product_SelectAll]
AS
BEGIN
    SELECT [dbo].[Product].[ProductID], 
           [dbo].[Product].[ProductName], 
           [dbo].[Product].[ProductPrice], 
           [dbo].[Product].[ProductCode], 
           [dbo].[Product].[Description], 
		   [dbo].[Product].[UserID], 
           [dbo].[User].[UserName],
		   [dbo].[User].[Address],
		   [dbo].[User].[IsActive]
    FROM [dbo].[Product]
	INNER JOIN [dbo].[User] ON [dbo].[User].[UserID]=[dbo].[Product].[UserID]
	ORDER BY [dbo].[User].[UserName],[dbo].[Product].[ProductName];
END;

-- Stored Procdure Select All User
CREATE OR ALTER PROCEDURE [dbo].[PR_User_SelectAll]
AS
BEGIN
    SELECT [dbo].[User].[UserID], 
           [dbo].[User].[UserName], 
           [dbo].[User].[Email], 
           [dbo].[User].[Password], 
           [dbo].[User].[MobileNo], 
           [dbo].[User].[Address], 
           [dbo].[User].[IsActive]
    FROM [dbo].[User]
    ORDER BY [dbo].[User].[UserName];
END;

-- Stored Procdure Product by ID
CREATE OR ALTER PROCEDURE [dbo].[PR_Product_SelectByPk]
    @ProductID INT
AS
BEGIN
    SELECT [dbo].[Product].[ProductID], 
           [dbo].[Product].[ProductName], 
           [dbo].[Product].[ProductPrice], 
           [dbo].[Product].[ProductCode], 
           [dbo].[Product].[Description], 
		   [dbo].[Product].[UserID], 
           [dbo].[User].[UserName],
		   [dbo].[User].[Address],
		   [dbo].[User].[IsActive]
    FROM [dbo].[Product]
	INNER JOIN [dbo].[User] ON [dbo].[User].[UserID]=[dbo].[Product].[UserID]
    WHERE [dbo].[Product].[ProductID] = @ProductID
	ORDER BY [dbo].[User].[UserName],[dbo].[Product].[ProductName];
END;

-- Stored Procdure User by ID

CREATE OR ALTER PROCEDURE [dbo].[PR_User_SelectByPk]
    @UserID INT
AS
BEGIN
    SELECT [dbo].[User].[UserID], 
           [dbo].[User].[UserName], 
           [dbo].[User].[Email], 
           [dbo].[User].[Password], 
           [dbo].[User].[MobileNo], 
           [dbo].[User].[Address], 
           [dbo].[User].[IsActive]
    FROM [dbo].[User]
    WHERE [dbo].[User].[UserID] = @UserID
    ORDER BY [dbo].[User].[UserID];
END;


--Product DropDown
GO
CREATE OR ALTER PROCEDURE [dbo].[PR_Product_DropDown]
AS
BEGIN
    SELECT
		[dbo].[Product].[ProductID],
        [dbo].[Product].[ProductName]
    FROM
        [dbo].[Product]
END
GO

--User DropDown
GO
CREATE OR ALTER PROCEDURE [dbo].[PR_User_DropDown]
AS
BEGIN
    SELECT
		[dbo].[User].[UserName],
		[dbo].[User].[UserID]
    FROM
        [dbo].[User]
END

--User Login
GO
CREATE PROCEDURE [dbo].[PR_User_Login]
    @UserName NVARCHAR(50),
    @Password NVARCHAR(50)
AS
BEGIN
    SELECT 
        [dbo].[User].[UserID], 
        [dbo].[User].[UserName], 
        [dbo].[User].[MobileNo], 
        [dbo].[User].[Email], 
        [dbo].[User].[Password],
        [dbo].[User].[Address]
    FROM 
        [dbo].[User] 
    WHERE 
        [dbo].[User].[UserName] = @UserName 
        AND [dbo].[User].[Password] = @Password;
END