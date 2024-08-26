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
select  f.film_id,f.title,count(r.rental_id) as Total_Movies
from rental r
join inventory i on i.inventory_id = r.inventory_id
join film f on f.film_id = i.film_id
group by f.film_id
order by Total_Movies ;

select  


#10) Which movies are not returned yet?

#H1) How many distinct last names we have in the data?
 select count(distinct last_name) from customer;
 select distinct last_name from customer;
#H2) How much money and rentals we make for Store 1 by day?  

#What are the three top earning days so far?
