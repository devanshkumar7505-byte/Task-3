create database pizzahut;
use pizzahut;
create table orders (
order_id int not null,
order_date date not null,
order_time time not null,
primary key(order_id) ); 
select * from pizzas;
select * from pizzas where price > 20;
select pizza_id, sum(quantity) as total_quantity
from order_details
group by pizza_id
having sum(quantity)>3;
SELECT pt.name, p.size, p.price
FROM pizzas p
INNER JOIN pizza_types pt ON p.pizza_type_id = pt.pizza_type_id;
SELECT p.pizza_id, p.size, p.price, od.quantity
FROM pizzas p
LEFT JOIN order_details od ON p.pizza_id = od.pizza_id;
SELECT p.pizza_id, p.size, od.quantity
FROM pizzas p
RIGHT JOIN order_details od ON p.pizza_id = od.pizza_id;
SELECT AVG(order_total) AS average_revenue_per_order
FROM (
    SELECT od.order_id, 
           SUM(od.quantity * p.price) AS order_total
    FROM order_details od
    JOIN pizzas p ON od.pizza_id = p.pizza_id
    GROUP BY od.order_id
) AS totals;
SELECT pizza_id 
FROM order_details
GROUP BY pizza_id
HAVING SUM(quantity) > (
    SELECT AVG(total_quantity)
    FROM (
        SELECT SUM(quantity) AS total_quantity
        FROM order_details
        GROUP BY pizza_id
    ) AS t
);
SELECT order_id
FROM order_details
WHERE pizza_id = (
    SELECT pizza_id 
    FROM pizzas
    ORDER BY price DESC
    LIMIT 1
);
CREATE VIEW pizza_order_summary AS
SELECT 
    od.order_id,
    p.pizza_id,
    pt.name AS pizza_name,
    pt.category,
    od.quantity,
    p.price,
    (od.quantity * p.price) AS total_price
FROM order_details od
JOIN pizzas p ON od.pizza_id = p.pizza_id
JOIN pizza_types pt ON p.pizza_type_id = pt.pizza_type_id;
CREATE VIEW pizza_revenue AS
SELECT 
    pt.name,
    SUM(od.quantity * p.price) AS revenue
FROM order_details od
JOIN pizzas p ON od.pizza_id = p.pizza_id
JOIN pizza_types pt ON p.pizza_type_id = pt.pizza_type_id
GROUP BY pt.name;
SELECT round(SUM(od.quantity * p.price),2) AS total_revenue
FROM order_details od
JOIN pizzas p ON od.pizza_id = p.pizza_id;

















































































































select pt.name, p.size, p.price
from pizzas p
inner join pizza_types pt 
on p.pizza_type_id = pt.pizza_type_id; 
select p.pizza_id, p.size, od.quantity
from pizzas p
left join order_details od on p.pizza_id = od.pizza_id;
select p.pizza_id, p.size, od.quantity
from pizzas p
right join order_details od on p.pizza_id = od.pizza_id;
select round(avg(order_total),2) as ARPU
from (
select od.order_id, sum(od.quantity*p.price) as order_total
from order_details od
join pizzas p on od.pizza_id = p.pizza_id
group by od.order_id)
as total;
select pizza_id 
from order_details
group by pizza_id
having sum(quantity)>(
select avg(total_quantity)
from (
select sum(quantity) as total_quantity
from order_details
group by pizza_id)
as t);