USE coffe
GO

-- 1. Bảng Danh Mục (Cải tiến: Thêm Parent ID để làm menu cha con)
CREATE TABLE CH_Category(
	cat_id int identity(1, 1) constraint pk_CH_category primary key,
	cat_name nvarchar(200) constraint default_CH_Category_name default N'Chưa đặt tên',
    cat_slug varchar(200), -- Để làm đường dẫn URL đẹp (vd: tra-trai-cay)
    cat_parent_id int null, -- Nếu NULL là danh mục cha, có số là danh mục con
	cat_active int constraint default_CH_Category_active default 1,
    constraint fk_category_parent foreign key (cat_parent_id) references CH_Category(cat_id)
)
GO

-- 2. Bảng Nhãn/Tag (Để hiển thị "Must Try", "New", "Best Seller")
CREATE TABLE CH_Tag(
    tag_id int identity(1, 1) constraint pk_CH_tag primary key,
    tag_name nvarchar(50) not null,
    tag_color varchar(20) default 'Orange', -- Màu nền của nhãn
    tag_active int default 1
)
GO

-- 3. Bảng Sản Phẩm (Cải tiến: Thêm mô tả và tăng độ dài ảnh)
CREATE TABLE CH_Product(
	pro_id int identity(1, 1) constraint pk_CH_product primary key,
	pro_name nvarchar(200) constraint default_CH_Product_name default N'Chưa đặt tên',
    pro_description nvarchar(500), -- Dòng mô tả nhỏ (VD: Trà Xanh - Chocolate)
	pro_price decimal(18, 0) constraint default_CH_Product_price default 0,
	pro_image nvarchar(500) constraint default_CH_Product_image default 'noimage.jpg', -- Tăng lên 500
	pro_active int constraint default_CH_Product_active default 1,
	cat_id int constraint fk_product_category references CH_Category(cat_id)
)
GO

-- 4. Bảng Nối Sản phẩm - Tag (Một món có thể vừa là New vừa là Must Try)
CREATE TABLE CH_Product_Tag_Map(
    pro_id int,
    tag_id int,
    constraint pk_CH_product_tag primary key (pro_id, tag_id),
    constraint fk_map_product foreign key (pro_id) references CH_Product(pro_id),
    constraint fk_map_tag foreign key (tag_id) references CH_Tag(tag_id)
)
GO

-- 5. Bảng Thành Phố (Cho chức năng tìm cửa hàng)
CREATE TABLE CH_City(
    city_id int identity(1,1) constraint pk_CH_city primary key,
    city_name nvarchar(100)
)
GO

-- 6. Bảng Cửa Hàng
CREATE TABLE CH_Store(
    store_id int identity(1,1) constraint pk_CH_store primary key,
    store_name nvarchar(200),
    store_address nvarchar(500),
    city_id int constraint fk_store_city references CH_City(city_id),
    store_active int default 1
)
GO

																-- PROC
-- Tạo danh mục mới (Có hỗ trợ danh mục cha)
CREATE PROC new_category
	@cat_name nvarchar(200),
    @cat_parent_id int = NULL, -- Mặc định là NULL
	@cat_active int
AS 
BEGIN
	INSERT INTO CH_Category(cat_name, cat_parent_id, cat_active)
	VALUES(@cat_name, @cat_parent_id, @cat_active)
END
GO

-- Lấy toàn bộ danh mục đang active
CREATE PROC get_categories
AS
BEGIN
	SELECT * FROM CH_Category WHERE cat_active = 1
END
GO

-- Tạo sản phẩm mới đầy đủ thông tin
CREATE PROC new_product
	@pro_name nvarchar(200),
    @pro_desc nvarchar(500),
	@pro_price decimal(18,0),
	@pro_image nvarchar(500),
	@cat_id int
AS
BEGIN
	INSERT INTO CH_Product(pro_name, pro_description, pro_price, pro_image, cat_id, pro_active)
	VALUES(@pro_name, @pro_desc, @pro_price, @pro_image, @cat_id, 1)
END
GO

-- Lấy sản phẩm hiển thị ra Menu (kèm tên Tag nếu có)
CREATE PROC get_menu_items
    @cat_id int -- Lọc theo danh mục
AS
BEGIN
    SELECT 
        p.pro_id, p.pro_name, p.pro_price, p.pro_description, p.pro_image,
        t.tag_name, t.tag_color
    FROM CH_Product p
    LEFT JOIN CH_Product_Tag_Map m ON p.pro_id = m.pro_id
    LEFT JOIN CH_Tag t ON m.tag_id = t.tag_id
    WHERE p.cat_id = @cat_id AND p.pro_active = 1
END
GO

CREATE PROC new_tag
    @tag_name nvarchar(50),
    @tag_color varchar(20)
AS
BEGIN
    INSERT INTO CH_Tag(tag_name, tag_color) VALUES (@tag_name, @tag_color)
END
GO

-- Gán tag cho sản phẩm
CREATE PROC add_tag_to_product
    @pro_id int,
    @tag_id int
AS
BEGIN
    INSERT INTO CH_Product_Tag_Map(pro_id, tag_id) VALUES (@pro_id, @tag_id)
END
GO

CREATE PROC new_tag
    @tag_name nvarchar(50),
    @tag_color varchar(20)
AS
BEGIN
    INSERT INTO CH_Tag(tag_name, tag_color) VALUES (@tag_name, @tag_color)
END
GO

-- Gán tag cho sản phẩm
CREATE PROC add_tag_to_product
    @pro_id int,
    @tag_id int
AS
BEGIN
    INSERT INTO CH_Product_Tag_Map(pro_id, tag_id) VALUES (@pro_id, @tag_id)
END
GO
														--DATA
-- 1. Tạo Danh Mục
-- Danh mục Cha
EXEC new_category N'Cà Phê', NULL, 1     -- ID 1
EXEC new_category N'Trà', NULL, 1        -- ID 2
EXEC new_category N'Đồ Ăn', NULL, 1      -- ID 3

-- Danh mục Con (Matcha thuộc Trà, Espresso thuộc Cà Phê)
EXEC new_category N'Espresso', 1, 1      -- ID 4 (Thuộc Cà Phê)
EXEC new_category N'Matcha Tây Bắc', 2, 1 -- ID 5 (Thuộc Trà)
EXEC new_category N'Bánh Ngọt', 3, 1     -- ID 6 (Thuộc Đồ Ăn)

-- 2. Tạo Tag
EXEC new_tag N'Must Try', 'Orange'       -- ID 1
EXEC new_tag N'Best Seller', 'Orange'    -- ID 2
EXEC new_tag N'New', 'Red'               -- ID 3

-- 3. Tạo Sản Phẩm (Dựa trên ảnh Matcha)
-- Matcha Latte
EXEC new_product N'Matcha Latte Tây Bắc', N'Trà Xanh - Chocolate', 45000, 'matcha-latte.jpg', 5
EXEC new_product N'Matcha Latte Tây Bắc (Nóng)', N'Trà Xanh - Chocolate', 49000, 'matcha-hot.jpg', 5

-- Gán Tag "Best Seller" cho món Matcha đầu tiên (ID sản phẩm là 1)
EXEC add_tag_to_product 1, 2

-- 4. Tạo Sản Phẩm (Dựa trên ảnh Espresso)
EXEC new_product N'Espresso Nóng', N'Cà Phê', 45000, 'espresso-hot.jpg', 4
EXEC new_product N'Latte Nóng', N'Cà Phê', 59000, 'latte-hot.jpg', 4

-- 5. Tạo Sản Phẩm (Dựa trên ảnh Đồ ăn)
EXEC new_product N'Salad Rau Rocket', N'Salad', 49000, 'salad.jpg', 6
-- Gán tag "New" cho Salad (ID sản phẩm là 5)
EXEC add_tag_to_product 5, 3

												--TEST
-- Lấy danh sách món trong danh mục Matcha Tây Bắc (ID 5)
EXEC get_menu_items 5