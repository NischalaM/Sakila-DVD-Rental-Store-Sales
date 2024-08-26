use sakila;
show tables;
#1) All films with PG-13 films with rental rate of 2.99 or lower

SELECT * from film
where  rental_rate<=2.99
 and rating = 'PG-13';

#2) All films that have deleted scenes

select * from film 
where special_features like '%Deleted Scenes%';

#3) All active customers

select * from customer
where active=1;

#4) Names of customers who rented a movie on 26th July 2005

 select r.customer_id,r.rental_date,concat(c.first_name,' ',c.last_name) full_name
 from rental r
 join customer c on r.customer_id = c.customer_id
 where date(rental_date) = '2005-07-26';
 
#5) Distinct names of customers who rented a movie on 26th July 2005

 select r.customer_id,r.rental_date,concat(c.first_name,' ',c.last_name) full_name
 from rental r
 join customer c on r.customer_id = c.customer_id
 where date(rental_date) = '2005-07-26';
 
#6) How many rentals we do on each day?

select  date(rental_date),count(rental_id) from rental
group by date(rental_date);

#7) All Sci-fi films in our catalogue


select fc.film_id,fc.category_id,c.name,f.title from category c
join film_category fc on c.category_id=fc.category_id
join film f on f.film_id = fc.film_id
where  c.name='Sci-Fi';

select * from rental;
select * from inventory;

#8) Customers and how many movies they rented from us so far?

select c.customer_id, concat(c.first_name,' ',c.last_name),count(*) 'Count'
from rental r
join customer c on c.customer_id=r.customer_id
group by c.customer_id
order by count(*) desc;


#9) Which movies should we discontinue from our catalogue (less than 2 lifetime rentals)
# created a variable called "lo_rentals" which will be a table using 'with' keyword. And I will use this variable for joining other tables
with low_rentals as
(select r.inventory_id,count(*)
from rental r
group by r.inventory_id
having count(*)<=1)
select low_rentals.inventory_id,i.film_id,f.title
from low_rentals
join inventory i on i.inventory_id = low_rentals.inventory_id
join film f on f.film_id = i.film_id;

#10) Which movies are not returned yet?

select r.customer_id,r.rental_date,f.film_id,f.title
 from rental r
 join inventory i on i.inventory_id = r.inventory_id
 join film f on f.film_id = i.film_id
 where r.return_date is null;
 
 

#H1) How many distinct last names we have in the data?
 select count(distinct last_name) from customer;
 select distinct last_name from customer;
 
#H2) How much money and rentals we make for Store 1 by day?  

 with Store1_Rentals as 
(select  r.rental_date,r.rental_id
 from rental r
 where r.staff_id =1
 group by r.return_date,r.rental_id)
 select date(p.payment_date),count(*), sum(p.amount) as TotalAmount
 from Store1_Rentals  st1
 join payment p on p.rental_id = st1.rental_id
 group by date(p.payment_date)
 order by TotalAmount desc;
 

#What are the three top earning days so far?
