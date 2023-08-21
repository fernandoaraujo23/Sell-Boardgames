CREATE VIEW REP_YEAR_BY_YEAR AS
select 
	TIME_MONTH,
	TIME_MONTH_NAME,
	isnull([2020],0) Y_2020,
	isnull([2021],0) Y_2021,
	isnull([2022],0) Y_2022
from
	(
	select 
		TIME_YEAR,
		TIME_MONTH,
		TIME_MONTH_NAME,
		sum(ORDER_TOTAL) ORDER_TOTAL
	from 
		DIM_ORDERS o 
		inner join DIM_TIME t on o.ORDER_CREATED_TIME_IDSK = t.TIME_IDSK
	group by
		TIME_YEAR,
		TIME_MONTH,
		TIME_MONTH_NAME
	) t
	PIVOT
	(
	SUM(ORDER_TOTAL) 
    FOR TIME_YEAR IN 
		(
        [2020], 
        [2021], 
        [2022]
		)
	) AS pivot_table


