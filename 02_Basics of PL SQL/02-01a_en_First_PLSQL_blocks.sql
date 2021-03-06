-----------------------------------------------------------------------------
--      (Extremely) Simple Anonymous PL/SQL Blocks
-----------------------------------------------------------------------------


-- 1 -- display all the days of the week for October 2018
-- the day of the week will be displayed in the current language
--   example of WHILE loop
DECLARE 
	v_date DATE ;
	v_first_date DATE ;
BEGIN
	v_first_date := TO_DATE('01/10/2018', 'DD/MM/YYYY') ;
	v_date := v_first_date ;
	WHILE v_date <= LAST_DAY(v_first_date) LOOP 
		DBMS_OUTPUT.PUT_LINE( v_date || ' falls/fell on a ' || 
			TO_CHAR(v_date, 'DAY')) ;		
    v_date := v_date + INTERVAL '1' DAY ;
	END LOOP ;
END ;
/

-- 1.1 -- display all the days of the week for October 2018 in English
DECLARE 
	v_date DATE ;
	v_first_date DATE ;
BEGIN
	v_first_date := TO_DATE('01/10/2018', 'DD/MM/YYYY') ;
	v_date := v_first_date ;
	WHILE v_date <= LAST_DAY(v_first_date) LOOP 
		DBMS_OUTPUT.PUT_LINE( v_date || ' falls/fell on a ' || 
			TO_CHAR(v_date, 'DAY', 'NLS_DATE_LANGUAGE=ENGLISH')) ;		
    v_date := v_date + INTERVAL '1' DAY ;
	END LOOP ;
END ;
/

-- 1.2 -- display all the days of the week for October 2018 in Romanian
DECLARE 
	v_date DATE ;
	v_first_date DATE ;
BEGIN
	v_first_date := TO_DATE('01/10/2018', 'DD/MM/YYYY') ;
	v_date := v_first_date ;
	WHILE v_date <= LAST_DAY(v_first_date) LOOP 
		DBMS_OUTPUT.PUT_LINE( v_date || ' falls/fell on a ' || 
			TO_CHAR(v_date, 'DAY', 'NLS_DATE_LANGUAGE=ROMANIAN')) ;		
    v_date := v_date + INTERVAL '1' DAY ;
	END LOOP ;
END ;
/

-------------------------------------------------------------------------------
-- 2.1 -- display weekends for October 2018
DECLARE     
	v_date DATE ;
	v_first_date DATE ;
BEGIN
	v_first_date := TO_DATE('01/10/2018', 'DD/MM/YYYY') ;
	v_date := v_first_date ;
	WHILE v_date <= LAST_DAY(v_first_date) LOOP 
		IF TO_CHAR(v_date, 'D') IN ('6', '7') THEN
			DBMS_OUTPUT.PUT_LINE( v_date || ' falls on a ' || 
				TO_CHAR(v_date, 'DAY')) ;		
		END IF ;
		v_date := v_date + 1 ;
	END LOOP ;
END ;
/


------------------------------------------------------------------------------------
-- 2.2 -- display weekends for October 2018 - version 2
DECLARE
	v_date DATE ;
	v_first_date DATE ;
BEGIN
	v_first_date := TO_DATE('01/10/2018', 'DD/MM/YYYY') ;
	v_date := v_first_date ;
	WHILE v_date <= LAST_DAY(v_first_date) LOOP
		IF rtrim(TO_CHAR(v_date, 'DAY')) IN ('SÂMBĂTĂ', 'DUMINICĂ') THEN
			DBMS_OUTPUT.PUT_LINE( v_date || ' falls on a ' ||
			    TO_CHAR(v_date, 'DAY')) ;
		END IF ;
		v_date := v_date + 1 ;
	END LOOP ;
END ;
/  


-- 2.3 -- display weekends for October 2018 - version 3
DECLARE
	v_date DATE ;
	v_first_date DATE ;
BEGIN
	v_first_date := TO_DATE('01/10/2018', 'DD/MM/YYYY') ;
	v_date := v_first_date ;
	WHILE v_date <= LAST_DAY(v_first_date) LOOP
		IF rtrim(TO_CHAR(v_date, 'DAY', 'NLS_DATE_LANGUAGE=ROMANIAN')) IN 
		    ('SÂMBĂTĂ', 'DUMINICĂ') THEN
			DBMS_OUTPUT.PUT_LINE( v_date || ' falls on a ' ||
			    TO_CHAR(v_date, 'DAY')) ;
		END IF ;
		v_date := v_date + 1 ;
	END LOOP ;
END ;
/  



-----------------------------------------------------------------------------
-- 3.1 -- display all days of the week for octomber 2018 - version 2
--   example of FOR loop
DECLARE 
	v_first_date DATE := TO_DATE('01/10/2018', 'DD/MM/YYYY') ;
	v_current_date DATE ;
	v_last_date NUMBER(2) ;
BEGIN
	v_last_date := TO_NUMBER(TO_CHAR(LAST_DAY(v_first_date), 'DD'))  ;
	
	FOR i IN 1..v_last_date LOOP 
		v_current_date := TO_DATE( i || '/10/2015', 'DD/MM/YYYY') ;
		DBMS_OUTPUT.PUT_LINE( v_current_date || ' falls on a ' || 
			TO_CHAR(v_current_date, 'DAY')) ;		
	END LOOP ;
END;
/


-----------------------------------------------------------------------------
-- 3.2 -- display all days of the week for octomber 2018 - version 3
DECLARE 
	v_first_date DATE := TO_DATE('01/10/2018', 'DD/MM/YYYY') ;
	v_current_date DATE ;
	v_last_date NUMBER(2) ;
BEGIN
	v_last_date := TO_NUMBER(TO_CHAR(LAST_DAY(v_first_date), 'DD'))  ;
	
	FOR i IN 0..v_last_date - 1 LOOP 
		v_current_date := v_first_date + i ;
		DBMS_OUTPUT.PUT_LINE( v_current_date || ' falls on a ' || 
			TO_CHAR(v_current_date, 'DAY')) ;		
	END LOOP ;
END;
/



--------------------------------------------------------------------------------------------------
-- 4.1 -- transform the anonymous block into a procedure which will work for any year and month
CREATE OR REPLACE PROCEDURE p_calendar (year_ NUMBER, month_ NUMBER)
AS
	v_date DATE ;
	v_first_date DATE ;
BEGIN
	v_first_date := TO_DATE('01/' || month_ || '/' || year_, 'DD/MM/YYYY') ;
	v_date := v_first_date ;
	WHILE v_date <= LAST_DAY(v_first_date) LOOP 
		DBMS_OUTPUT.PUT_LINE( v_date || ' falls on a ' || 
			TO_CHAR(v_date, 'DAY')) ;		
		v_date := v_date + 1 ;
	END LOOP ;
END ;	
/

-- call (execute) the procedure from another anonymous block
begin
    p_calendar(2018, 10) ;
end;
/

begin
    p_calendar(2018, 10) ;
end;
/
 
-- call the procedure directly (in SQL Developer)
exec p_calendar(2018, 10)  


--------------------------------------------------------------------------------------------------
-- 4.2 -- change above procedure adding a new parameter - language
-- select userenv('language') from dual 

CREATE OR REPLACE PROCEDURE p_calendar_lang (year_ NUMBER, month_ NUMBER, 
    language VARCHAR)
AS
	v_date DATE ;
	v_first_date DATE ;
BEGIN
	v_first_date := TO_DATE('01/' || month_ || '/' || year_, 'DD/MM/YYYY') ;
	v_date := v_first_date ;
	WHILE v_date <= LAST_DAY(v_first_date) LOOP 
		DBMS_OUTPUT.PUT_LINE( v_date || ' falls on a ' || 
			TO_CHAR(v_date, 'DAY', 'NLS_DATE_LANGUAGE='||language )) ;		
		v_date := v_date + 1 ;
	END LOOP ;
END ;	
/

-- call the procedure directly (in SQL Developer)
exec p_calendar_lang(2018, 10, 'FRENCH')  







