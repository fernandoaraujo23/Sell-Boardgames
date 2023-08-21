---------------------------------------
--- VIEW V_TREND_GA_PRODUCTS
---------------------------------------
CREATE VIEW V_TREND_GA_PRODUCTS as
with CTE_GA_PRODUCTS as
(select	
	TIME_YEAR_MONTH,
	GA_VALUE,
	sum(GA_SESSIONS) GA_SESSIONS
from 
	DW_FACT_GA ga
	inner join DIM_TIME t on ga.GA_DATE = t.TIME_DATE
where 
	GA_CATEGORY = 'products'
group by 
	TIME_YEAR_MONTH,
	GA_VALUE
),
CTE_GA_PRODUCTS_2 as
(select
	GA_VALUE,
	sum(GA_SESSIONS) GA_SESSIONS,
	row_number() over(order by sum(GA_SESSIONS) desc) LINHA
from 
	CTE_GA_PRODUCTS
group by 
	GA_VALUE)

select
	GA_VALUE,
	isnull([202001],0) M_202001,
	isnull([202002],0) M_202002,
	isnull([202003],0) M_202003,
	isnull([202004],0) M_202004,
	isnull([202005],0) M_202005,
	isnull([202006],0) M_202006,
	isnull([202007],0) M_202007,
	isnull([202008],0) M_202008,
	isnull([202009],0) M_202009,
	isnull([202010],0) M_202010,
	isnull([202011],0) M_202011,
	isnull([202012],0) M_202012,
	isnull([202101],0) M_202101,
	isnull([202102],0) M_202102,
	isnull([202103],0) M_202103,
	isnull([202104],0) M_202104,
	isnull([202105],0) M_202105,
	isnull([202106],0) M_202106,
	isnull([202107],0) M_202107,
	isnull([202108],0) M_202108,
	isnull([202109],0) M_202109,
	isnull([202110],0) M_202110,
	isnull([202111],0) M_202111,
	isnull([202112],0) M_202112,
	isnull([202201],0) M_202201,
	isnull([202202],0) M_202202,
	isnull([202203],0) M_202203,
	isnull([202204],0) M_202204,
	isnull([202205],0) M_202205,
	isnull([202206],0) M_202206,
	isnull([202207],0) M_202207,
	isnull([202208],0) M_202208
from
	CTE_GA_PRODUCTS
	PIVOT
	(
	sum(GA_SESSIONS)
	FOR TIME_YEAR_MONTH IN 
		(
        [202001],
		[202002],
		[202003],
		[202004],
		[202005],
		[202006],
		[202007],
		[202008],
		[202009],
		[202010],
		[202011],
		[202012],
		[202101],
		[202102],
		[202103],
		[202104],
		[202105],
		[202106],
		[202107],
		[202108],
		[202109],
		[202110],
		[202111],
		[202112],
		[202201],
		[202202],
		[202203],
		[202204],
		[202205],
		[202206],
		[202207],
		[202208]
		)
	) AS pivot_table
where GA_VALUE in (select GA_VALUE from CTE_GA_PRODUCTS_2 where linha <=20)

---------------------------------------
--- VIEW V_TREND_DIM_ORDERS
---------------------------------------
CREATE VIEW V_TREND_DIM_ORDERS as
with CTE_DIM_ORDERS as
(select	
	TIME_YEAR_MONTH,
	GA_VALUE,
	sum(GA_SESSIONS) GA_SESSIONS
from 
	DW_FACT_GA ga
	inner join DIM_TIME t on ga.GA_DATE = t.TIME_DATE
where 
	GA_CATEGORY = 'products'
group by 
	TIME_YEAR_MONTH,
	GA_VALUE
),
CTE_DIM_ORDERS_2 as
(select
	GA_VALUE,
	sum(GA_SESSIONS) GA_SESSIONS,
	row_number() over(order by sum(GA_SESSIONS) desc) LINHA
from 
	CTE_GA_PRODUCTS
group by 
	GA_VALUE)

select
	GA_VALUE,
	isnull([202001],0) M_202001,
	isnull([202002],0) M_202002,
	isnull([202003],0) M_202003,
	isnull([202004],0) M_202004,
	isnull([202005],0) M_202005,
	isnull([202006],0) M_202006,
	isnull([202007],0) M_202007,
	isnull([202008],0) M_202008,
	isnull([202009],0) M_202009,
	isnull([202010],0) M_202010,
	isnull([202011],0) M_202011,
	isnull([202012],0) M_202012,
	isnull([202101],0) M_202101,
	isnull([202102],0) M_202102,
	isnull([202103],0) M_202103,
	isnull([202104],0) M_202104,
	isnull([202105],0) M_202105,
	isnull([202106],0) M_202106,
	isnull([202107],0) M_202107,
	isnull([202108],0) M_202108,
	isnull([202109],0) M_202109,
	isnull([202110],0) M_202110,
	isnull([202111],0) M_202111,
	isnull([202112],0) M_202112,
	isnull([202201],0) M_202201,
	isnull([202202],0) M_202202,
	isnull([202203],0) M_202203,
	isnull([202204],0) M_202204,
	isnull([202205],0) M_202205,
	isnull([202206],0) M_202206,
	isnull([202207],0) M_202207,
	isnull([202208],0) M_202208
from
	CTE_GA_PRODUCTS
	PIVOT
	(
	sum(GA_SESSIONS)
	FOR TIME_YEAR_MONTH IN 
		(
        [202001],
		[202002],
		[202003],
		[202004],
		[202005],
		[202006],
		[202007],
		[202008],
		[202009],
		[202010],
		[202011],
		[202012],
		[202101],
		[202102],
		[202103],
		[202104],
		[202105],
		[202106],
		[202107],
		[202108],
		[202109],
		[202110],
		[202111],
		[202112],
		[202201],
		[202202],
		[202203],
		[202204],
		[202205],
		[202206],
		[202207],
		[202208]
		)
	) AS pivot_table
where GA_VALUE in (select GA_VALUE from CTE_GA_PRODUCTS_2 where linha <=20)


---------------------------------------
--- VIEW V_QUAD_YEAR
---------------------------------------
CREATE VIEW V_QUAD_YEAR as
with CTE_DIM_ORDERS as
(
select
	TIME_YEAR,
	CUSTOMER_ID,
	sum(ORDER_TOTAL) ORDER_TOTAL,
	count(CUSTOMER_ID) AMOUNT_TOTAL,
	(case 
		when sum(ORDER_TOTAL) >= 500 then 'TOTAL_A' 
		else 'TOTAL_B' 
	end) QUAD_TOTAL,
	(case 
		when count(CUSTOMER_ID) >= 3 then 'AMOUNT_A' 
		else 'AMOUNT_B' 
	end) QUAD_AMOUNT,
	(case 
		when sum(ORDER_TOTAL) >= 500 and count(CUSTOMER_ID) >= 3 then 1
		when sum(ORDER_TOTAL) >= 500 and count(CUSTOMER_ID) < 3 then 2
		when sum(ORDER_TOTAL) < 500 and count(CUSTOMER_ID) >= 3 then 3 
		else 4
	end) QUAD_YEAR
from 
	DIM_ORDERS o 
	inner join DIM_TIME t on o.CUSTOMER_CREATED_TIME_IDSK = t.TIME_IDSK 
	inner join DIM_CUSTOMERS c on o.ORDER_CUSTOMER_ID = c.CUSTOMER_IDSK
group by
	TIME_YEAR,
	CUSTOMER_ID
)

select
	CUSTOMER_ID,
	isnull([2014],0) Y_2014,
	isnull([2015],0) Y_2015,
	isnull([2016],0) Y_2016,
	isnull([2017],0) Y_2017,
	isnull([2018],0) Y_2018,
	isnull([2019],0) Y_2019,
	isnull([2020],0) Y_2020,
	isnull([2021],0) Y_2021,
	isnull([2022],0) Y_2022
from
	CTE_DIM_ORDERS
	PIVOT
	(
	sum(QUAD_YEAR)
	FOR TIME_YEAR IN 
		(
		[2014],
		[2015],
		[2016],
		[2017],
		[2018],
		[2019],
		[2020],
		[2021],
		[2022]
		)
	) AS pivot_table


---------------------------------------
--- VIEWS V_QUAD
---------------------------------------	
CREATE VIEW V_QUAD_FINAL as
select
	CUSTOMER_ID,
	sum(ORDER_TOTAL) ORDER_TOTAL,
	count(CUSTOMER_ID) AMOUNT_TOTAL,
	(case 
		when sum(ORDER_TOTAL) >= 500 then 'TOTAL_A' 
		else 'TOTAL_B' 
	end) QUAD_TOTAL,
	(case 
		when count(CUSTOMER_ID) >= 3 then 'AMOUNT_A' 
		else 'AMOUNT_B' 
	end) QUAD_AMOUNT,
	(case 
		when sum(ORDER_TOTAL) >= 500 and count(CUSTOMER_ID) >= 3 then 1
		when sum(ORDER_TOTAL) >= 500 and count(CUSTOMER_ID) < 3 then 2
		when sum(ORDER_TOTAL) < 500 and count(CUSTOMER_ID) >= 3 then 3 
		else 4
	end) QUAD_FINAL
from 
	DIM_ORDERS o 
	inner join DIM_TIME t on o.CUSTOMER_CREATED_TIME_IDSK = t.TIME_IDSK 
	inner join DIM_CUSTOMERS c on o.ORDER_CUSTOMER_ID = c.CUSTOMER_IDSK
group by
	TIME_YEAR,
	CUSTOMER_ID

CREATE VIEW V_QUAD_TOTAL_DIST as
select 
	QUAD_TOTAL,
	count(QUAD_TOTAL) AMOUNT_QUAD_TOTAL,
	count(QUAD_TOTAL)*1.0/(select count(*) from V_QUAD_FINAL) PCT_QUAD_TOTAL
from 
	V_QUAD_FINAL
group by
	QUAD_TOTAL

CREATE VIEW V_QUAD_AMOUNT_DIST as
select 
	QUAD_AMOUNT,
	count(QUAD_AMOUNT) AMOUNT_QUAD_AMOUNT,
	count(QUAD_AMOUNT)*1.0/(select count(*) from V_QUAD_FINAL) PCT_QUAD_AMOUNT
from 
	V_QUAD_FINAL
group by
	QUAD_AMOUNT

CREATE VIEW V_QUAD_FINAL_DIST as
select 
	QUAD_FINAL,
	count(QUAD_FINAL) AMOUNT_QUAD,
	count(QUAD_FINAL)*1.0/(select count(*) from V_QUAD_FINAL) PCT_QUAD
from 
	V_QUAD_FINAL
group by
	QUAD_FINAL

CREATE VIEW SEASONALITY_ANALYSIS AS
select 
	t1.TIME_SEASON_YEAR,
	t1.GA_SESSIONS,
	t2.ORDER_TOTAL
from
	(
	select	
		TIME_SEASON_YEAR,
		sum(GA_SESSIONS) GA_SESSIONS
	from 
		DW_FACT_GA ga
		inner join DIM_TIME t on ga.GA_DATE = t.TIME_DATE
	group by 
		TIME_SEASON_YEAR
	) t1
	inner join
	(
	select	
		TIME_SEASON_YEAR,
		sum(ORDER_TOTAL) ORDER_TOTAL
	from 
		DIM_ORDERS o
		inner join DIM_TIME t on o.ORDER_CREATED_TIME_IDSK = t.TIME_IDSK
	group by 
		TIME_SEASON_YEAR
	) t2 on t1.TIME_SEASON_YEAR = t2.TIME_SEASON_YEAR


CREATE VIEW V_DOLLARPERSESSION_ANALYSIS AS
select 
	t1.TIME_MONTH_NAME,
	t1.TIME_MONTH,
	t1.GA_SESSIONS,
	t2.ORDER_TOTAL
from
	(
	select	
		TIME_MONTH_NAME,
		TIME_MONTH,
		sum(GA_SESSIONS) GA_SESSIONS
	from 
		DW_FACT_GA ga
		inner join DIM_TIME t on ga.GA_DATE = t.TIME_DATE
	group by 
		TIME_MONTH_NAME,
		TIME_MONTH		
	) t1
	inner join
	(
	select	
		TIME_MONTH_NAME,
		TIME_MONTH,
		sum(ORDER_TOTAL) ORDER_TOTAL
	from 
		DIM_ORDERS o
		inner join DIM_TIME t on o.ORDER_CREATED_TIME_IDSK = t.TIME_IDSK
	group by 
		TIME_MONTH_NAME,
		TIME_MONTH
	) t2 on t1.TIME_MONTH_NAME = t2.TIME_MONTH_NAME

select 
	* 
from 
	(
	select	
		GA_VALUE PRODUCT,
		sum(GA_SESSIONS) GA_SESSIONS,
		row_number() over(order by sum(GA_SESSIONS) desc) POSITION
	from 
		DW_FACT_GA ga
		inner join DIM_TIME t on ga.GA_DATE = t.TIME_DATE
	where 
		GA_CATEGORY = 'products'
	group by 
		GA_VALUE
	) tb
where 
	PRODUCT like '%bundle%'
order by 
	POSITION asc

CREATE VIEW DASH_BASE_TIME_NEW_ORDERS as 
select 
	date_amount.TIME_DATE,
	NUMBER_ORDERS,
	NUMBER_ORDERS-isnull(NUMBER_ORDERS_CHURN_90,0) NUMBER_ORDERS_90_MINUS,
	isnull(NUMBER_ORDERS_CHURN_90,0)-isnull(NUMBER_ORDERS_CHURN_180,0) NUMBER_ORDERS_90_180,
	isnull(NUMBER_ORDERS_CHURN_180,0)-isnull(NUMBER_ORDERS_CHURN_LAST,0) NUMBER_ORDERS_180_PLUS,
	isnull(NUMBER_ORDERS_CHURN_LAST,0) NUMBER_ORDERS_CHURN_LAST
from
	(
	select 
		TIME_DATE,
		count(CUSTOMER_ID) NUMBER_ORDERS
	from 
		DASH_BASE_CUSTOMERS_ORDERS
	group by 
		TIME_DATE
	) date_amount
	left join
	(
	select 
		TIME_DATE,
		count(CUSTOMER_ID) NUMBER_ORDERS_CHURN_90
	from 
		DASH_BASE_CUSTOMERS_ORDERS 
	where
		datediff(day,TIME_DATE,NEXT_SELL)>=90 or NEXT_CUSTOMER <> CUSTOMER_ID
	group by 
		TIME_DATE
	) date_amount_churn90 on date_amount.TIME_DATE = date_amount_churn90.TIME_DATE
	left join
	(
	select 
		TIME_DATE,
		count(CUSTOMER_ID) NUMBER_ORDERS_CHURN_180
	from 
		DASH_BASE_CUSTOMERS_ORDERS 
	where
		datediff(day,TIME_DATE,NEXT_SELL)>=180 or NEXT_CUSTOMER <> CUSTOMER_ID
	group by 
		TIME_DATE
	) date_amount_churn180 on date_amount.TIME_DATE = date_amount_churn180.TIME_DATE
	left join
	(
	select 
		TIME_DATE,
		count(CUSTOMER_ID) NUMBER_ORDERS_CHURN_LAST
	from 
		DASH_BASE_CUSTOMERS_ORDERS 
	where
		NEXT_CUSTOMER <> CUSTOMER_ID
	group by 
		TIME_DATE
	) date_amount_churn_last on date_amount.TIME_DATE = date_amount_churn_last.TIME_DATE

