USE SELL_DW
GO

CREATE PROC LOAD_GA_AGGREGATE
AS

drop table LOAD_GA_AGGREGATE_1
drop table LOAD_GA_AGGREGATE_2


select 
	row_number() over (order by TOTAL_GA_SESSIONS desc) LINHA,
	GA_VALUE,
	TOTAL_GA_SESSIONS,
	TOTAL_SESSION_GROUP,
	TOTAL_GA_SESSIONS/(TOTAL_SESSION_GROUP*1.0) PCT_SESSION 
into LOAD_GA_AGGREGATE_1
from 
	DASH_GA_AGGREGATE 
	cross join (select sum(TOTAL_GA_SESSIONS) TOTAL_SESSION_GROUP from DASH_GA_AGGREGATE) t


select 
	t1.LINHA,sum(t2.PCT_SESSION) TOTAL_PCT_SESSION,
	(case 
		when sum(t2.PCT_SESSION)<= 0.8 then 'A' 
		when sum(t2.PCT_SESSION)<=0.95 then 'B' 
		else 'C' 
	end
	) PARETO
into LOAD_GA_AGGREGATE_2
from 
	LOAD_GA_AGGREGATE_1 t1
	inner join LOAD_GA_AGGREGATE_1 t2 on t1.LINHA >= t2.LINHA
group by 
	t1.LINHA


GO










