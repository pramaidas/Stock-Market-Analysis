-- create schema named 'assignment'
create database Assignment;

use Assignment;

-- Create a new table named 'bajaj1' containing the date, close price, 20 Day MA and 50 Day MA. 
-- (This has to be done for all 6 stocks)

create table bajaj1
  as (select Date, `Close Price`, 
  avg(`Close Price`) over (order by Date asc rows 19 preceding) as `20 Day MA`,
  avg(`Close Price`) over (order by Date asc rows 49 preceding) as `50 Day MA`
  from `bajaj auto`);
  
select * from bajaj1;

drop table if exists `bajaj auto`;

create table eicher1
  as (select Date, `Close Price`, 
  avg(`Close Price`) over (order by Date asc rows 19 preceding) as `20 Day MA`,
  avg(`Close Price`) over (order by Date asc rows 49 preceding) as `50 Day MA`
  from `eicher motors`);
  
drop table if exists `eicher motors`;

create table hero1
  as (select Date, `Close Price`, 
  avg(`Close Price`) over (order by Date asc rows 19 preceding) as `20 Day MA`,
  avg(`Close Price`) over (order by Date asc rows 49 preceding) as `50 Day MA`
  from `hero motocorp`);
  
drop table if exists `hero motocorp`;

create table infosys1
  as (select Date, `Close Price`, 
  avg(`Close Price`) over (order by Date asc rows 19 preceding) as `20 Day MA`,
  avg(`Close Price`) over (order by Date asc rows 49 preceding) as `50 Day MA`
  from `infosys`);
  
drop table if exists `infosys`;

create table tcs1
  as (select Date, `Close Price`, 
  avg(`Close Price`) over (order by Date asc rows 19 preceding) as `20 Day MA`,
  avg(`Close Price`) over (order by Date asc rows 49 preceding) as `50 Day MA`
  from `tcs`);
  
drop table if exists `tcs`;

create table tvs1
  as (select Date, `Close Price`, 
  avg(`Close Price`) over (order by Date asc rows 19 preceding) as `20 Day MA`,
  avg(`Close Price`) over (order by Date asc rows 49 preceding) as `50 Day MA`
  from `tvs motors`);
  
drop table if exists `tvs motors`;

-- Create a master table containing the date and close price of all the six stocks. 
-- (Column header for the price is the name of the stock)

create table master
select bajaj1.Date , bajaj1.`Close Price` as Bajaj , tcs1.`Close Price` as TCS , 
tvs1.`Close Price` as TVS , infosys1.`Close Price` as Infosys , eicher1.`Close Price` as Eicher , hero1.`Close Price` as Hero
from bajaj1
inner join tcs1 
using (Date)
inner join tvs1 
using (Date)
inner join infosys1 
using (Date)
inner join eicher1 
using (Date)
inner join hero1 
using (Date);

select * from master;

-- Use the table created in Part(1) to generate buy and sell signal. Store this in another table named 
-- 'bajaj2'. Perform this operation for all stocks.

create table bajaj2 (
	`date` date,
	`Close Price` decimal(10,2),
    `signal` varchar(15)
);

create table eicher2 like bajaj2;
create table hero2 like bajaj2;
create table infosys2 like bajaj2;
create table tcs2 like bajaj2;
create table tvs2 like bajaj2;

-- insert data into tables bajaj2, eicher2, hero2, infosys2, tcs2, tvs2

insert into bajaj2 (date,`Close Price`,`signal`) 
	select date, `Close Price`,
		(case
			when `20 Day MA` >= `50 Day MA` and (lead(`20 Day MA`,1) over (order by date)) < (lead(`50 Day MA`,1) over (order by date)) 
				then 'Sell'
			when `20 Day MA` <= `50 Day MA` and (lead(`20 Day MA`,1) over (order by date)) > (lead(`50 Day MA`,1) over (order by date))
				then 'Buy'
			else 'Hold'	
		end	)
	from  bajaj1
	order by date;

insert into eicher2 (date,`Close Price`,`signal`) 
	select date, `Close Price`,
		(case
			when `20 Day MA` >= `50 Day MA` and (lead(`20 Day MA`,1) over (order by date)) < (lead(`50 Day MA`,1) over (order by date)) 
				then 'Sell'
			when `20 Day MA` <= `50 Day MA` and (lead(`20 Day MA`,1) over (order by date)) > (lead(`50 Day MA`,1) over (order by date))
				then 'Buy'
			else 'Hold'	
		end	)
	from  eicher1
	order by date;


insert into hero2 (date,`Close Price`,`signal`) 
	select date, `Close Price`,
		(case
			when `20 Day MA` >= `50 Day MA` and (lead(`20 Day MA`,1) over (order by date)) < (lead(`50 Day MA`,1) over (order by date)) 
				then 'Sell'
			when `20 Day MA` <= `50 Day MA` and (lead(`20 Day MA`,1) over (order by date)) > (lead(`50 Day MA`,1) over (order by date))
				then 'Buy'
			else 'Hold'	
		end	)
	from  hero1
	order by date;
    
insert into infosys2 (date,`Close Price`,`signal`) 
	select date, `Close Price`,
		(case
			when `20 Day MA` >= `50 Day MA` and (lead(`20 Day MA`,1) over (order by date)) < (lead(`50 Day MA`,1) over (order by date)) 
				then 'Sell'
			when `20 Day MA` <= `50 Day MA` and (lead(`20 Day MA`,1) over (order by date)) > (lead(`50 Day MA`,1) over (order by date))
				then 'Buy'
			else 'Hold'	
		end	)
	from  infosys1
	order by date;
    
insert into tcs2 (date,`Close Price`,`signal`) 
	select date, `Close Price`,
		(case
			when `20 Day MA` >= `50 Day MA` and (lead(`20 Day MA`,1) over (order by date)) < (lead(`50 Day MA`,1) over (order by date)) 
				then 'Sell'
			when `20 Day MA` <= `50 Day MA` and (lead(`20 Day MA`,1) over (order by date)) > (lead(`50 Day MA`,1) over (order by date))
				then 'Buy'
			else 'Hold'	
		end	)
	from  tcs1
	order by date;
    
    
insert into tvs2 (date,`Close Price`,`signal`) 
	select date, `Close Price`,
		(case
			when `20 Day MA` >= `50 Day MA` and (lead(`20 Day MA`,1) over (order by date)) < (lead(`50 Day MA`,1) over (order by date)) 
				then 'Sell'
			when `20 Day MA` <= `50 Day MA` and (lead(`20 Day MA`,1) over (order by date)) > (lead(`50 Day MA`,1) over (order by date))
				then 'Buy'
			else 'Hold'	
		end	)
	from  tvs1
	order by date;

-- view all the tables bajaj2, eicher2, hero2, infosys2, tcs2, tvs2   
 
select * from bajaj2;
select * from eicher2;
select * from hero2;
select * from infosys2;
select * from tcs2;
select * from tvs2;

-- Create a User defined function, that takes the date as input and returns the signal 
-- for that particular day (Buy/Sell/Hold) for the Bajaj stock.

drop function if exists getSignalForBajaj;

delimiter $$

create function getSignalForBajaj(input_date date) 
  returns varchar(15) 
  deterministic
begin   
  declare output_signal varchar(15);
  
  select bajaj2.signal into output_signal from bajaj2 
  where date = input_date;
  
  return output_signal ;
end
  

$$ delimiter ;

-- Retrieving data using the getSignalForBajaj function for Bajaj Stock

select getSignalForBajaj('2015-05-15') as `Signal`;

-- For Inference purpose
-- getting the lowest close price for Buy and highest closing price for Sell for all 6 Stocks.

select date, `Close Price`
from bajaj2
where `signal` = 'Buy'
order by `Close Price`
limit 1;

select date, `Close Price`
from bajaj2
where `signal` = 'Sell'
order by `Close Price` desc
limit 1;

select date, `Close Price`
from eicher2
where `signal` = 'Buy'
order by `Close Price`
limit 1;

select date, `Close Price`
from eicher2
where `signal` = 'Sell'
order by `Close Price` desc
limit 1;

select date, `Close Price`
from hero2
where `signal` = 'Buy'
order by `Close Price`
limit 1;

select date, `Close Price`
from hero2
where `signal` = 'Sell'
order by `Close Price` desc
limit 1;

select date, `Close Price`
from infosys2
where `signal` = 'Buy'
order by `Close Price`
limit 1;

select date, `Close Price`
from infosys2
where `signal` = 'Sell'
order by `Close Price` desc
limit 1;

select date, `Close Price`
from tcs2
where `signal` = 'Buy'
order by `Close Price`
limit 1;

select date, `Close Price`
from tcs2
where `signal` = 'Sell'
order by `Close Price` desc
limit 1;

select date, `Close Price`
from tvs2
where `signal` = 'Buy'
order by `Close Price`
limit 1;

select date, `Close Price`
from tvs2
where `signal` = 'Sell'
order by `Close Price` desc
limit 1;
