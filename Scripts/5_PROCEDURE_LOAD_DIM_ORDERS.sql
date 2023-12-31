USE SELL_DW
GO

CREATE PROC LOAD_ORDERS
AS

DECLARE @FINAL_DATE DATETIME 
DECLARE	@START_DATE DATETIME
		
set @FINAL_DATE = (SELECT   MAX(TIME_DATE)
FROM SELL_DW.DBO.DIM_TIME T)

set @START_DATE = (SELECT  MAX(TIME_DATE)
	FROM SELL_DW.DBO.DIM_ORDERS FT
	JOIN SELL_DW.DBO.DIM_TIME T ON (FT.CUSTOMER_CREATED_TIME_IDSK=T.TIME_IDSK))

IF @START_DATE IS NULL
BEGIN
	set @START_DATE = (SELECT  MIN(TIME_DATE)
	FROM SELL_DW.DBO.DIM_TIME T)
END

INSERT INTO SELL_DW.DBO.DIM_ORDERS(
	ORDER_ID,
	ORDER_CREATED_TIME_IDSK,
	CURRENCY_CODE_ID,
	ORDER_SUBTOTAL,
	ORDER_TOTAL,
	FULFILLMENT_STATUS_ID,
	ORDER_CUSTOMER_ID,
	CUSTOMER_CREATED_TIME_IDSK
	)
SELECT
	O.ORDER_ID AS ORDER_ID,
	T1.TIME_IDSK AS ORDER_CREATED_TIME_IDSK,
	CC.CURRENCY_CODE_ID AS CURRENCY_CODE_ID,
	O.ORDER_SUBTOTAL AS ORDER_SUBTOTAL,
	O.ORDER_TOTAL AS ORDER_TOTAL,
	FS.FULFILLMENT_STATUS_ID AS FULFILLMENT_STATUS_ID,	
	C.CUSTOMER_IDSK as ORDER_CUSTOMER_ID,
	T2.TIME_IDSK as CUSTOMER_CREATED_TIME_IDSK
	
FROM
	SELL_STAGE.DBO.ST_ORDERS O

	INNER JOIN DBO.DIM_CUSTOMERS C
	on (O.ORDER_CUSTOMER_ID=C.CUSTOMER_ID)	 

	INNER JOIN DBO.DIM_FULFILLMENT_STATUS FS
	on (O.FULFILLMENT_STATUS_ID=FS.FULFILLMENT_STATUS_ID)

		INNER JOIN DBO.DIM_CURRENCY_CODES CC
	on (O.CURRENCY_CODE_ID=CC.CURRENCY_CODE_ID)

				INNER JOIN DBO.DIM_TIME T1
	ON (CONVERT(VARCHAR, T1.TIME_DATE,102) = CONVERT(VARCHAR,
	O.ORDER_CREATED_AT,102))
	and O.ORDER_CREATED_AT BETWEEN @START_DATE AND @FINAL_DATE

				INNER JOIN DBO.DIM_TIME T2
	ON (CONVERT(VARCHAR, T2.TIME_DATE,102) = CONVERT(VARCHAR,
	O.ORDER_CUSTOMER_CREATED_AT,102))
	and O.ORDER_CUSTOMER_CREATED_AT BETWEEN @START_DATE AND @FINAL_DATE
GO










