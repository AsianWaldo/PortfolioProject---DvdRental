-- Menggunakan database dvd rental tampilkan total pemasukan dan jumlah
-- berapa kali penyewaan untuk setiap bulan tahun
select 
	 to_char(payment_date , 'yyyy-mm') as month_and_year,
	 sum(amount) as total_rev,
	 count(p.rental_id) as total_rent
from
	payment p 
join rental r 
	on p.rental_id = r.rental_id and p.customer_id = r.customer_id 
group by month_and_year
order by total_rev desc

-- Menggunakan database dvd rental tampilkan total pemasukan dari besar ke kecil
-- dan jumlah berapa kali penyewaan dari paling banyak ke paling sedikit untuk
-- Setiap customer per store_id
select 
	p.customer_id ,
	concat(c.first_name, ' ', c.last_name) as cust_name,
	c.store_id ,
	sum(amount) as total_rev,
	count(p.rental_id) as total_rent
from payment p 
join rental r
	on p.rental_id = r.rental_id 
join  customer c 
	on r.customer_id = c.customer_id 
group by p.customer_id, cust_name, c.store_id 
order by total_rev desc


--need revision
-- Tampilkan film_id, title, description, release_year, dan tambahan kolom bernama
-- ‘demand_category’.
select 
	f.film_id ,
	title ,
	description ,
	release_year ,
(case
	when count(r.rental_id) >= 30 then 'High Demand'
	when count(r.rental_id) < 30 and count(r.rental_id) >= 15 then 'Medium Demand'
	else 'Low Demand'
end) as demand_category
from rental r 
left join inventory i 
	on r.inventory_id = i.inventory_id
left join film f 
	on i.film_id = f.film_id 
group by f.film_id 
order by release_year
