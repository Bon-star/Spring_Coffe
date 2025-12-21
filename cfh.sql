create database coffe
go

use coffe
go

create table CH_Category(
	c_id int identity(1, 1) constraint pk_CH_category primary key,
	c_name nvarchar(200) constraint default_pk_CH_Category_name default 'untitle',
	c_active int  constraint default_pk_CH_Category_active default 1
)
go

create table CH_Product(
	c_idp int identity(1, 1) constraint pk_CH_product primary key,
	c_name nvarchar(200) constraint default_pk_CH_Product_name default 'untitle',
	c_price decimal(18, 0) constraint default_pk_Product_price default 0,
	c_image nvarchar(50) constraint default_pk_Product_image default 'noimage.jpg',
	c_active int  constraint default_pk_CH_Product_active default 1,
	c_cid int constraint fk_product_to_category references ch_category(c_id)
)
go

create proc new_category
@c_name nvarchar(200),
@c_active int
as 
begin
	insert into CH_Category(c_name, c_active)
	values(@c_name, @c_active)
end
go

exec new_category 'cate2', '2'

select * from CH_Category
go

delete from CH_Category

dbcc checkident ('ch_category', reseed, 0)


create proc update_category
    @c_id int,
    @c_name nvarchar(200),
    @c_active int
as
begin
    update CH_Category
    set c_name = @c_name,
        c_active = @c_active
    where c_id = @c_id
end
go

create proc delete_category
    @c_id int
as
begin
    update CH_Category
    set c_active = 0
    where c_id = @c_id
end
go

create proc get_categories
as
begin
    select * from CH_Category
end
go