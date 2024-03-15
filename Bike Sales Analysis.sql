create database inventory;

use inventory

select * from dbo.brands$
select * from dbo.categories$
select * from dbo.customer$
select * from dbo.order_items$
select * from dbo.orders$
select * from dbo.products$
select * from dbo.staffs$
select * from dbo.stock$
select * from dbo.stores$

-- Number of products by Model Year
select model_year , count(distinct product_name) as Product_Count from dbo.products$ 
group by model_year
order by model_year


--- Number of customers by state and city
select count(distinct order_id) from dbo.orders$

update dbo.customer$
set state = 'New-York' where state = 'NY'
update dbo.customer$
set state = 'California' where state = 'CA'
update dbo.customer$
set state = 'Texas' where state = 'TX'

update dbo.stores$
set state = 'New-York' where state = 'NY'
update dbo.stores$
set state = 'California' where state = 'CA'
update dbo.stores$
set state = 'Texas' where state = 'TX'

-- By city
select city, count(*) as Number_of_Customers from dbo.customer$
group by city
order by Number_of_Customers desc

-- By state
select state, count(*) as Number_of_Customers from dbo.customer$
group by state
order by Number_of_Customers desc

--- Revenue per order (after discount)
alter table dbo.order_items$ add Revenue float

update dbo.order_items$
set Revenue = quantity * list_price * (1 - discount) 

update dbo.order_items$
set Revenue = round((Revenue),2)

select order_id, sum(Revenue) as Revenue from dbo.order_items$
group by order_id
order by Revenue desc

--- Ranking customers by revenue generated 
alter table dbo.customer$ add full_name nvarchar(255)

update dbo.customer$
set full_name = first_name + ' ' + last_name

create table #CustomerSales (order_id int, customer_id int, full_name nvarchar(255), revenue float)
Insert into #CustomerSales
select ordit.order_id, ord.customer_id, cust.full_name, ordit.Revenue
from dbo.order_items$ ordit 
join dbo.orders$ ord
on ord.order_id = ordit.order_id
join dbo.customer$ cust
on ord.customer_id = cust.customer_id
group by ordit.order_id, ord.customer_id, cust.full_name, ordit.Revenue

select * from #CustomerSales

select full_name, sum(revenue) as Revenue_Generated
from #CustomerSales
group by full_name
order by Revenue_Generated desc

--- % of orders shipped early (on or before required date) and orders shipped late (after required date)
alter table dbo.orders$
alter column order_date date
go

alter table dbo.orders$
alter column required_date date
go

alter table dbo.orders$
alter column shipped_date date
go

create table #Order_Punctuality (order_id int, order_delivery nvarchar(30))
Insert into #Order_Punctuality
select order_id, (case when shipped_date > required_date then 'Late' when shipped_date < required_date then 'Early' else 'Early' end)
as order_delivery from dbo.orders$

select * from #Order_Punctuality

create table #Order_status (Early_Count float, Late_Count float)
Insert into #Order_status
select count(case when order_delivery = 'Early' then 1 end) as Early_Count,
count(case when order_delivery = 'Late' then 1 end) as Late_Count
from #Order_Punctuality
 
select round((Early_Count/(Early_Count+Late_Count))*100,2) as Early_Delivery,
round((Late_Count/(Early_Count+Late_Count))*100,2) as Late_Delivery
from #Order_status

--- Customers with the most orders (number of those shipped early or late)
create table #CustOrders (Customer_id int, Full_Name nvarchar(50), Order_id int, Order_delivery nvarchar(50))
Insert into #CustOrders
select ord.customer_id, cust.full_name, ord.order_id, ordd.order_delivery
from dbo.customer$ cust
join dbo.orders$ ord 
on ord.customer_id = cust.customer_id
join #Order_Punctuality ordd
on ord.order_id = ordd.order_id
group by ord.customer_id, cust.full_name, ord.order_id, ordd.order_delivery

select * from #CustOrders

select Customer_id, Full_Name, count(*) as Number_of_Orders,
count(case when Order_delivery = 'Early' then 1 end) as Early_Orders,
count(case when Order_delivery = 'Late' then 1 end) as Late_Orders
from #CustOrders
group by Full_Name, Customer_id
order by Number_of_Orders desc

--- Rank brands by revenue generated
select brnd.brand_id, brnd.brand_name, round(sum(ordit.Revenue),2) as Revenue_Generated
from dbo.brands$ brnd
join dbo.products$ prod
on brnd.brand_id = prod.brand_id
join dbo.order_items$ ordit
on prod.product_id = ordit.product_id
group by brnd.brand_id, brnd.brand_name
order by Revenue_Generated desc

--- Rank category by revenue generated
select cat.category_id, cat.category_name, round(sum(ordit.Revenue),2) as Revenue_Generated
from dbo.categories$ cat
join dbo.products$ prod
on cat.category_id = prod.category_id
join dbo.order_items$ ordit
on prod.product_id = ordit.product_id
group by cat.category_id, cat.category_name
order by Revenue_Generated desc

--- Ranking products by price
select product_name, list_price from dbo.products$
group by product_name, list_price
order by list_price desc

--- Ranking products by revenue generated
select prod.product_name as Product_Name, ordit.list_price as Price_per_Product_before_Discount, Revenue as Total_Revenue_Generated_after_Discount
from dbo.products$ prod
join dbo.order_items$ ordit
on prod.product_id = ordit.product_id
group by prod.product_name, ordit.list_price, ordit.Revenue 
order by Total_Revenue_Generated_after_Discount desc

--- Ranking products' model year by revenue generated
select prod.model_year as Model_Year, sum(Revenue) as Total_Revenue_Generated
from dbo.products$ prod
join dbo.order_items$ ordit
on prod.product_id = ordit.product_id
group by prod.model_year
order by Total_Revenue_Generated desc

--- Ranking staff by revenue generated
alter table dbo.staffs$ add full_name nvarchar(255)

update dbo.staffs$
set full_name = first_name + ' ' + last_name

select stf.full_name as Staff_Name, round(sum(ordit.Revenue), 2) as Total_Sales_Made
from dbo.order_items$ ordit
join dbo.orders$ ord
on ordit.order_id = ord.order_id
join dbo.staffs$ stf
on stf.staff_id = ord.staff_id
group by stf.full_name
order by Total_Sales_Made desc

--- Staff Orders (early and late)
create table #Order_Punct (order_id int, order_delivery nvarchar(30))
Insert into #Order_Punct
select order_id, (case when shipped_date > required_date then 'Late' when shipped_date < required_date then 'Early' else 'Early' end)
as order_delivery from dbo.orders$

select * from #Order_Punct

create table #StaffOrders (Staff_id int, Full_Name nvarchar(50), Order_id int, Order_delivery nvarchar(50))
Insert into #StaffOrders
select stf.staff_id, stf.full_name, ord.order_id, ordd.order_delivery
from dbo.staffs$ stf
join dbo.orders$ ord 
on ord.staff_id = stf.staff_id
join #Order_Punct ordd
on ord.order_id = ordd.order_id
group by stf.staff_id, stf.full_name, ord.order_id, ordd.order_delivery

select * from #StaffOrders

-- Staff Orders as Numbers
create table #StaffOrderPunct (Staff_id int, Full_Name nvarchar(50), Number_of_Orders float, Early_Orders float, Late_Orders float)
Insert into #StaffOrderPunct
select Staff_id, Full_Name, count(*) as Number_of_Orders,
count(case when Order_delivery = 'Early' then 1 end) as Early_Orders,
count(case when Order_delivery = 'Late' then 1 end) as Late_Orders
from #StaffOrders
group by Full_Name, Staff_id
order by Number_of_Orders desc

select * from #StaffOrderPunct

-- Staff Orders as Pct
select Staff_id, Full_Name, Number_of_Orders, round((Early_Orders/Number_of_Orders),3) * 100 as Early_Order_Pct,
round((Late_Orders/Number_of_Orders),3) * 100 as Late_Order_Pct
from #StaffOrderPunct
order by Number_of_Orders desc

--- Ranking stores by quantity of products held
select stk.store_id as Id, store.store_name as Store_Name, sum(stk.quantity) as Quantity
from dbo.stock$ stk
join dbo.stores$ store
on stk.store_id = store.store_id
group by  stk.store_id, Store_Name
order by Quantity desc

--- Ranking stores by revenue generated
select store.store_id as Id, store.store_name as Store_Name, round(sum(ordit.Revenue),2) as Revenue_Generated
from dbo.stores$ store
join dbo.orders$ ord
on ord.store_id = store.store_id
join dbo.order_items$ ordit
on ord.order_id = ordit.order_id
group by store.store_id, store.store_name
order by Revenue_Generated desc

--- Store Order Punctuality
select * from #Order_Punct

create table #StoreOrders (Store_id int, Full_Name nvarchar(50), Order_id int, Order_delivery nvarchar(50))
Insert into #StoreOrders
select store.store_id, store.store_name, ord.order_id, ordd.order_delivery
from dbo.stores$ store
join dbo.orders$ ord 
on ord.store_id = store.store_id
join #Order_Punct ordd
on ord.order_id = ordd.order_id
group by store.store_id, store.store_name, ord.order_id, ordd.order_delivery

select * from #StoreOrders

-- Store Orders as Numbers
create table #StoreOrderPunct (Store_id int, Full_Name nvarchar(50), Number_of_Orders float, Early_Orders float, Late_Orders float)
Insert into #StoreOrderPunct
select Store_id, Full_Name, count(*) as Number_of_Orders,
count(case when Order_delivery = 'Early' then 1 end) as Early_Orders,
count(case when Order_delivery = 'Late' then 1 end) as Late_Orders
from #StoreOrders
group by Full_Name, Store_id
order by Number_of_Orders desc

select * from #StoreOrderPunct
order by Number_of_Orders desc

-- Store Orders as Pct
select Store_id, Full_Name, Number_of_Orders, round((Early_Orders/Number_of_Orders),3) * 100 as Early_Order_Pct,
round((Late_Orders/Number_of_Orders),3) * 100 as Late_Order_Pct
from #StoreOrderPunct
order by Number_of_Orders desc
