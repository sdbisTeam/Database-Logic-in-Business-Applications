
/* Fibonacci sequence is famous among mathematicians.
First two numbers of the sequence are 0 and 1
Starting with the third, each number is the sum of previous two)
(0, 1, 1, 2, 3, 5, 8, 13, 21, ....)
Next procedure generates and displays first N numbers from the sequence */

CREATE OR REPLACE PROCEDURE p_fibonacci_first_N_numbers
    (N IN INTEGER) 
IS
    v_actual INTEGER ;
    v_precedent INTEGER := 1 ;
    v_temp INTEGER := 0 ;
BEGIN
    CASE 
        WHEN N = 1 THEN 
            DBMS_OUTPUT.PUT_LINE( 'Number no. 1 is 0' ) ;
        WHEN N = 2 THEN 
            DBMS_OUTPUT.PUT_LINE( 'Number no. 1 is 0' ) ;
            DBMS_OUTPUT.PUT_LINE( 'Number no. 2 is 1' ) ;
        ELSE
            DBMS_OUTPUT.PUT_LINE( 'Number no. 1 is 0' ) ;
            DBMS_OUTPUT.PUT_LINE( 'Number no. 2 is 1' ) ;
            FOR i IN 3..N LOOP
                v_actual := v_precedent + v_temp ;
                v_temp := v_precedent ;
                v_precedent := v_actual ;
                DBMS_OUTPUT.PUT_LINE( 'Number no. ' || i || ' is ' || v_actual ) ;
            END LOOP ;
    END CASE;
END ;
/

BEGIN
    p_fibonacci_first_N_numbers (10) ;
END ;


