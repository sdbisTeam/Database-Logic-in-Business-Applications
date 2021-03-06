/* General form:
  ax^2 + b * x + c = 0
  Given a, b and c values, which are the x1 and x2 values ?
*/  


-- anonymous block containing  a, b, c initialization

DECLARE
    a NUMBER(5) ;
    b NUMBER(5) ;
    c NUMBER(5) ;
    delta NUMBER (18,8) ;
    x1 NUMBER (18,8) ;
    x2 NUMBER (18,8) ;
BEGIN
    -- set values for a, b, and c
    a := 0 ;
    b := 1 ;
    c := 1 ;

    -- if a is zero, then equation is not of grade II
    IF a = 0 THEN 
        DBMS_OUTPUT.PUT_LINE('Equation is not of grade II') ;
        -- if also b equals zero, there must be an indeterminations of an imposibility (depending on c)
        IF b = 0 THEN
            -- test c
            IF c = 0 THEN
                DBMS_OUTPUT.PUT_LINE('Indetermination !') ;
            ELSE
                DBMS_OUTPUT.PUT_LINE('Impossibility !') ;
            END IF ;
        ELSE    -- a is zero,  b is not zero, so the equation is of grade I 
            x1:= -c / b ;
            DBMS_OUTPUT.PUT_LINE( 'Grade I equation. x=' || x1 ) ;
        END IF ;
    ELSE    -- a is different from zero, so the equation is of grade II
        -- compute DELTA
        delta := b * b  -  4 * a * c ;
        IF delta > 0 THEN
            x1 := (-b - SQRT(delta)) / (2*a) ;
            x2 := (-b + SQRT(delta)) / (2*a) ;
            DBMS_OUTPUT.PUT_LINE('x1='||x1||',    x2='||x2) ;
        ELSE
            IF delta = 0 THEN
                x1 := (-b) / (2*a) ;
                DBMS_OUTPUT.PUT_LINE('x1 = x2 = ' || x1) ;
            ELSE
                -- this is when DELTA < 0
                DBMS_OUTPUT.PUT_LINE('x1 and x2 are complex numbers !') ;				
            END IF ;
        END IF ;
    END IF ;
    -- end !
END ; 
/


-------------------------------------------------------------------
-- transform the anonymous block into a parameterized function 
CREATE OR REPLACE FUNCTION f_grade_2_equation (
    a NUMBER, b NUMBER, c NUMBER ) RETURN VARCHAR
AS
    delta NUMBER (18,8) ;
    x1 NUMBER (18,8) ;
    x2 NUMBER (18,8) ;
    string VARCHAR(100) ;
BEGIN

    -- if a is zero, then equation is not of grade II
    IF a = 0 THEN 
        -- if also b equals zero, there must be an indeterminations of an imposibility (depending on c)
        IF b = 0 THEN
            -- test c
            IF c = 0 THEN
                string := ' Indetermination !' ;
            ELSE
                string := 'Impossibility !' ;
            END IF ;
        ELSE    -- a is zero,  b is not zero, so the equation is of grade I 
            x1:= -c / b ;
            string := 'Grade I equation. x=' || x1  ;
        END IF ;
    ELSE    -- a is different from zero, so the equation is of grade II
        -- compute DELTA
        delta := b * b  -  4 * a * c ;
        IF delta > 0 THEN
            x1 := (-b - SQRT(delta)) / (2*a) ;
            x2 := (-b + SQRT(delta)) / (2*a) ;
            string := 'x1='||x1||',    x2='||x2 ;
        ELSE
            IF delta = 0 THEN
                x1 := (-b) / (2*a) ;
                string := 'x1 = x2 = ' || x1  ;
            ELSE
                -- this is when DELTA < 0
                string := 'x1 and x2 are complex numbers !' ;				
            END IF ;
        END IF ;
    END IF ;
    RETURN string ;
    
    -- end !
END ; 
/

-- function call from an anonymous block
BEGIN
    DBMS_OUTPUT.PUT_LINE(f_grade_2_equation(1, 344, 1));
END ;
/


-- function call from a SELECT
SELECT f_grade_2_equation(1, 344, 1) FROM dual ;



