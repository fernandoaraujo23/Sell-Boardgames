-- STEP 1
DECLARE    @STARTDATE DATETIME 
			, @ENDDATE DATETIME 
			, @DATE DATETIME
		 		  
PRINT GETDATE() 

		SELECT @STARTDATE = '1/1/1950' 
			, @ENDDATE = '1/1/2050'

		SELECT @DATE = @STARTDATE 

WHILE @DATE < @ENDDATE 
	BEGIN 

		
	INSERT INTO DIM_TIME 
	( 
			time_date, 
			time_day,
			time_day_week, 
			time_month,
			time_month_name, 
			time_quarter,
			time_quarter_name, 
			time_year 
		
	) 
	SELECT @DATE AS time_date, DATEPART(DAY,@DATE) AS time_day, 

			CASE DATEPART(DW, @DATE) 
            
			WHEN 1 THEN 'Sunday'
			WHEN 2 THEN 'Monday' 
			WHEN 3 THEN 'Tuesday' 
			WHEN 4 THEN 'Wednesday' 
			WHEN 5 THEN 'Thursday' 
			WHEN 6 THEN 'Friday' 
			WHEN 7 THEN 'Saturday' 
             
		END AS time_day_week,

			DATEPART(MONTH,@DATE) AS time_month, 

			CASE DATENAME(MONTH,@DATE) 
			
			WHEN 'January' THEN 'January'
			WHEN 'February' THEN 'February'
			WHEN 'March' THEN 'March'
			WHEN 'April' THEN 'April'
			WHEN 'May' THEN 'May'
			WHEN 'June' THEN 'June'
			WHEN 'July' THEN 'July'
			WHEN 'August' THEN 'August'
			WHEN 'September' THEN 'September'
			WHEN 'October' THEN 'October'
			WHEN 'November' THEN 'November'
			WHEN 'December' THEN 'December'
		
		END AS time_month_name,
		 
			DATEPART(qq,@DATE) time_quarter, 

			CASE DATEPART(qq,@DATE) 
			WHEN 1 THEN 'First' 
			WHEN 2 THEN 'Second' 
			WHEN 3 THEN 'Third' 
			WHEN 4 THEN 'Fourth' 
		END AS time_quarter_name 
		, DATEPART(YEAR,@DATE) time_year
	
	SELECT @DATE = DATEADD(dd,1,@DATE)
END

UPDATE DIM_TIME
SET time_day = '0' + time_day 
WHERE LEN(time_day) = 1 

UPDATE DIM_TIME
SET time_month = '0' + time_month 
WHERE LEN(time_month) = 1 

UPDATE DIM_TIME 
SET time_complete_date = time_year + time_month + time_day 
GO


--STEP 2
DECLARE C_TIME CURSOR FOR	
	SELECT time_idsk, time_complete_date, time_day_week, time_year FROM DIM_TIME
DECLARE			
			@ID INT,
			@DATE varchar(10),
			@DAYWEEK VARCHAR(20),
			@YEAR CHAR(4),
			@WEEKEND CHAR(3),
			@SEASON VARCHAR(15)
					
OPEN C_TIME
	FETCH NEXT FROM C_TIME
	INTO @ID, @DATE, @DAYWEEK, @YEAR
WHILE @@FETCH_STATUS = 0
BEGIN
			
				IF @DAYWEEK in ('Sunday','Saturday') 
				SET @WEEKEND = 'Yes'
				ELSE 
				SET @WEEKEND = 'No'

			--ATUALIZANDO ESTACOES

			IF @DATE BETWEEN CONVERT(CHAR(4),@YEAR)+'0923' 
			AND CONVERT(CHAR(4),@YEAR)+'1220'
				SET @SEASON = 'Autumn'

			ELSE IF @DATE BETWEEN CONVERT(CHAR(4),@YEAR)+'0321' 
			AND CONVERT(CHAR(4),@YEAR)+'0620'
				SET @SEASON = 'Spring'

			ELSE IF @DATE BETWEEN CONVERT(CHAR(4),@YEAR)+'0621' 
			AND CONVERT(CHAR(4),@YEAR)+'0922'
				SET @SEASON = 'Summer'

			ELSE -- @DATE between 21/12 e 20/03
				SET @SEASON = 'Winter'

			--ATUALIZANDO FINS DE SEMANA
	
			UPDATE DIM_TIME SET time_weekend = @WEEKEND
			WHERE time_idsk = @ID

			--ATUALIZANDO

			UPDATE DIM_TIME SET time_season_year = @SEASON
			WHERE time_idsk = @ID
		
	FETCH NEXT FROM C_TIME
	INTO @ID, @DATE, @DAYWEEK, @YEAR	
END
CLOSE C_TIME
DEALLOCATE C_TIME
GO

select * from DIM_TIME