create DATABASE Project

select * from fact
select * from Location
select * from Product
select * from fact
---TASKS 

--Q1. Display the number of states present in the LocationTable. 
SELECT COUNT(DISTINCT state) as [Count of States] from Location 

--Q2. How many products are of regular type?
select COUNT(Product) as [count of Product] from Product
where type = 'regular'

--Q3. How much spending has been done on marketing of product ID 1?
SELECT SUM(marketing) as [Sum of Marketing]
from fact
where ProductId= 1

--Q4. What is the minimum sales of a product?
SELECT MIN(sales) as [Minimun Sales of Product]
from fact

--Q5. Display the max Cost of Good Sold (COGS). 
select max(COGS) AS [Cost of Good Sold]
FROM fact

--Q6. Display the details of the product where product type is coffee. 
SELECT * FROM Product
where Product_type = 'Coffee'


--Q7. Display the details where total expenses are greater than 40. 
SELECT * FROM fact
where Total_Expenses > 40 

--Q8. What is the average sales in area code 719?
SELECT avg(Sales) as [Average_Sales] 
FROM fact
WHERE Area_Code = 719

--Q9. Find out the total profit generated by Colorado state.
SELECT SUM(profit) as [Sum_of_Profit]
from fact F
inner join
Location L
on F.Area_Code = L.Area_Code
WHERE State='Colorado'

--10. Display the average inventory for each product ID. 
SELECT 
AVG(Inventory) as [Avg_Inventory],ProductId
from fact
GROUP BY ProductId
ORDER BY ProductId


--11. Display state in a sequential order in a Location Table. 
SELECT * from Location
order by State

--12. Display the average budget of the Product where the average budget margin should be greater than 100. 
SELECT productId, avg(Budget_Margin) as [Budget_margin]
FROM fact
GROUP BY productId
having avg(Budget_Margin)>100

--13. What is the total sales done on date 2010-01-01?
SELECT sum(Sales) as [Total_sales] from fact
where Date = '2010-01-01'

--14. Display the average total expense of each product ID on an individual date. 
SELECT Date, ProductId,avg(Total_Expenses) as[Total_Expenses]
FROM fact
GROUP BY Date,ProductId
ORDER BY Date, ProductId

---15. Display the table with the following attributes 
--such as date, productID, product_type, product, sales, profit, state, area_code. 
SELECT F.Date, P.ProductId,P.Product_Type,P.Product, F.Sales, F.Profit, L.State, L.Area_Code
FROM fact F
inner join 
Location L
on F.Area_code = L.Area_code
inner join
Product P
on P.ProductId=F.ProductId
ORDER BY ProductId asc

--16. Display the rank without any gap to show the sales wise rank. 
SELECT Date,ProductId, Sales,Profit,Area_code, DENSE_RANK() over (order by Sales asc)
as Sales_rank
from fact

--17. Find the state wise profit and sales. 
SELECT State,Sum(profit) as [Profit Value], sum(sales) as[Sales Value]
from fact F
inner join location L
on F.Area_code = L.Area_code
group by State
order by State

--18. Find the state wise profit and sales along with the productname. 
SELECT P.Product, State,Sum(profit) as [Profit Value], sum(sales) as[Sales Value]
from fact F
inner join location L
on F.Area_code = L.Area_code
INNER JOIN Product P
on
F.ProductId=P.ProductId
group by L.State,P.Product
order by L.State,P.Product

--19. If there is an increase in sales of 5%, calculate the increasedsales. 
--(5% = 1+0.05)
SELECT Sales,(Sales*1.05) as [Increase In Sales]
from fact

--20. Find the maximum profit along with the product ID and producttype. 
SELECT P.ProductId,P.Product_Type,MAX(Profit) as [Profit]
from fact F
inner join Product P
on F.ProductId = P.ProductId
group by  P.ProductId,P.Product_Type


--21. Create a stored procedure to fetch the result according to the product type from Product Table. 
Create proc Ptype(@prod_type Varchar(20))
AS
BEGIN
SELECT * FROM Product
WHERE Product_Type = @prod_type
END
Ptype @prod_type ='Coffee'

--22. Write a query by creating a condition in which if the total expenses is less than 60 then it is a profit or else loss. 
Select Total_Expenses,IIF (Total_Expenses<60,'Profit','Loss') as [Status]
from fact


--23. Apply union and intersection operator on the tables which consist of attribute area code. 
SELECT Area_Code from Location
intersect 
Select Area_Code from fact

SELECT Area_Code from Location
intersect 
Select Area_Code from fact

--24. Create a user-defined function for the product table to fetch a particular product type based upon the user�s preference. 
create function producttable(@product_type VARCHAR(50))
returns table 
as 
return
SELECT * FROM [product]
where product_type = @product_type

SELECT * FROM producttable('coffee')


--25. Change the product type from coffee to tea where product ID is 1 and undo it. 
begin transaction 
update[Product]

set Product_Type='tea'
WHERE ProductId = 1

select * from [product]
rollback transaction


--26. Display the date, product ID and sales where total expenses are between 100 to 200. 
select Date, ProductId, Sales from [fact]
WHERE Total_Expenses between 100 and 200


--27. Delete the records in the Product Table for regular type. 
DELETE from Product
where type = 'Regular'

select * from Product

--28. Display the ASCII value of the fifth character from the columnProduct.
SELECT Product,ASCII(SUBSTRING (Product,5,1)) as[CHAR] FROM Product





















