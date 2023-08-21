CREATE PROCEDURE LOAD_ST_JSON AS
DECLARE @json AS NVARCHAR(MAX)

SELECT @json = BulkColumn 
FROM OPENROWSET (BULK 'C:\SELL\Data\shopify_orders.json', SINGLE_CLOB) as Datafile

INSERT INTO ST_JSON
SELECT 
	convert(bigint,replace(tb.id,'gid://shopify/Order/','')) ID,
	tb.PROCESSED_AT,
	tb.CURRENCY_CODE,
	tb.CURRENT_SUBTOTAL_PRICE_SET_AMOUNT,
	tb.ORIGINAL_TOTAL_DUTIES_SET,
	tb.ORIGINAL_TOTAL_PRICE_SET_AMOUNT,
	tb.DISPLAY_FULFILLMENT_STATUS,
	convert(bigint,replace(tb.customer_id,'gid://shopify/Customer/','')) CUSTOMER_ID,
	tb.CUSTOMER_CREATED_AT
FROM 
	OPENJSON(@json) 
	WITH (
	   id VARCHAR(200)	'$.id',
	   processed_at datetime	'$.processedAt',
	   currency_code VARCHAR(3) '$.currencyCode',
	   current_subtotal_price_set_amount numeric(10,2) '$.currentSubtotalPriceSet.shopMoney.amount',
	   original_total_duties_set VARCHAR(200)	'$.originalTotalDutiesSet',
	   original_total_price_set_amount numeric(10,2) '$.originalTotalPriceSet.shopMoney.amount',
	   display_fulfillment_status VARCHAR(20)	'$.displayFulfillmentStatus',
	   customer_id VARCHAR(200) '$.customer.id',
	   customer_created_at  datetime '$.customer.createdAt'
	) AS tb

