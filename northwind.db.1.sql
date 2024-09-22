1. En Pahalı Ürünü Getirin

SELECT productname , unitprice from Products
where unitprice = (SELECT max (unitprice) from Products)

2. En Son Verilen Siparişi Bulun

SELECT orderid , orderdate from Orders
where orderdate = (SELECT max(orderdate) from Orders)

3. Fiyatı Ortalama Fiyattan Yüksek Olan Ürünleri Getirin

SELECT unitprice , productid from Products
where unitprice > (SELECT AVG(unitprice) from Products)

4. Belirli Kategorilerdeki Ürünleri Listeleyin

select * from Products,Categories where Products.CategoryID= Categories.CategoryID and Categories.CategoryName in('Produce','Seafood')

5. En Yüksek Fiyatlı Ürünlere Sahip Kategorileri Listeleyin

SELECT Categories.CategoryID,Categories.CategoryName,Categories.Description  
FROM Products,Categories 
where Products.CategoryID=Categories.CategoryID
GROUP BY Products.categoryid
ORDER BY MAX(Products.unitprice) DESC


6. Bir Ülkedeki Müşterilerin Verdiği Siparişleri Listeleyin

select * from Orders
where customerid in (select customerid from customers where country = ('Mexico'))


7. Her Kategori İçin Ortalama Fiyatın Üzerinde Olan Ürünleri Listeleyin

SELECT products.unitprice, products.productid , products.categoryid, Categories.CategoryID FROM Products,Categories
where unitprice > (SELECT avg(unitprice) from Products)
AND Products.CategoryID =Categories.CategoryID

8. Her Müşterinin En Son Verdiği Siparişi Listeleyin

SELECT  Customers.CustomerID,orders.OrderID,orders.OrderDate 
FROM Orders,Customers 
where customers.CustomerID=orders.CustomerID
GROUP BY Orders.customerid
order by max(Orders.orderdate) desc

9. Her Çalışanın Kendi Departmanındaki Ortalama Maaşın Üzerinde Maaş Alıp Almadığını Bulun

10. En Az 10 Ürün Satın Alınan Siparişleri Listeleyin

 select OD.quantity ,Orders.* FROM Orders ,'Order Details' OD where Orders.OrderID=od.OrderID and od.Quantity>= 10

11. Her Kategoride En Pahalı Olan Ürünlerin Ortalama Fiyatını Bulun

select AVG(unitprice) from Products where productid in(SELECT Products.ProductID 
FROM Products,Categories 
where Products.CategoryID=Categories.CategoryID
GROUP BY Products.categoryid
ORDER BY MAX(Products.unitprice) DESC)

12. Müşterilerin Verdiği Toplam Sipariş Sayısına Göre Sıralama Yapın

SELECT Customers.CustomerID, COUNT(Orders.OrderID) AS TotalOrders 
from Orders,Customers 
where Orders.CustomerID=Customers.CustomerID 
GROUP BY Customers.CustomerID
ORDER BY totalorders DESC


13. En Fazla Sipariş Vermiş 5 Müşteriyi ve Son Sipariş Tarihlerini Listeleyin

SELECT Customers.CustomerID, COUNT(Orders.OrderID) AS TotalOrders ,Max(Orders.OrderDate)
from Orders,Customers 
where Orders.CustomerID=Customers.CustomerID 
GROUP BY Customers.CustomerID
ORDER BY totalorders DESC
LIMIT 5

14. Toplam Ürün Sayısı 15ten Fazla Olan Kategorileri Listeleyin

SELECT CategoryID, COUNT(ProductID) AS total_products
FROM Products
GROUP BY CategoryID
HAVING COUNT(ProductID) > 15

15. En Fazla 5 Farklı Ürün Sipariş Eden Müşterileri Listeleyin

SELECT O.CustomerID
FROM Orders AS O,'Order Details' OD where O.OrderID = OD.OrderID
GROUP BY O.CustomerID
HAVING COUNT(DISTINCT OD.ProductID) > 5;

16. 20den Fazla Ürün Sağlayan Tedarikçileri Listeleyin

SELECT Suppliers.SupplierID,Suppliers.CompanyName 
FROM Products,Suppliers
WHERE Products.SupplierID=Suppliers.SupplierID
GROUP BY Products.supplierid
HAVING COUNT(Products.productid)>3

17. Her Müşteri İçin En Pahalı Ürünü Bulun

SELECT o.CustomerID, p.ProductID, p.unitprice
FROM Orders o,'Order Details' od,Products p
Where o.OrderID = od.OrderID
AND od.ProductID = p.ProductID
AND (o.CustomerID, p.unitprice) IN (
    SELECT o2.CustomerID, MAX(p2.unitprice)
    FROM Orders o2,'Order Details' od2,Products p2
    Where o2.OrderID = od2.OrderID
    AND od2.ProductID = p2.ProductID
    GROUP BY o2.CustomerID)

18. 10.000den Fazla Sipariş Değeri Olan Çalışanları Listeleyin

19. Kategorisine Göre En Çok Sipariş Edilen Ürünü Bulun

20. Müşterilerin En Son Sipariş Verdiği Ürün ve Tarihlerini Listeleyin

SELECT  Customers.CustomerID,orders.OrderID,Products.ProductName,orders.OrderDate 
FROM Orders,Customers, Products ,'Order Details' OD
where customers.CustomerID=orders.CustomerID and orders.OrderID=od.OrderID and Products.ProductID =od.ProductID
GROUP BY Orders.customerid
order by max(Orders.orderdate) desc

21. Her Çalışanın Teslim Ettiği En Pahalı Siparişi ve Tarihini Listeleyin

SELECT e.EmployeeID, o.OrderID, MAX(od.UnitPrice * od.Quantity) as Price , MAX(o.OrderDate) as lastOrderDate
FROM Employees e,Orders o,"Order Details" od where e.EmployeeID =o.EmployeeID
and o.OrderID = od.OrderID
GROUP BY e.EmployeeID

22. En Fazla Sipariş Verilen Ürünü ve Bilgilerini Listeleyin

select p.ProductID, p.ProductName,od.quantity
from products p,'order details' od,orders o 
where p.ProductID = od.productid And od.orderid = o.OrderID
group by p.ProductID, p.ProductName
order by sum(od.quantity) desc 
limit 1
