/* Using recursivity to generate the N-th number in Fibbonacci's sequence
    (see also Oracle PL/SQL documentation) */


CREATE OR REPLACE FUNCTION f_n_th_from_fibonacci
		(n IN INTEGER) RETURN INTEGER
IS
BEGIN
    IF n = 1 THEN
        RETURN 0 ;
    END IF ;
    IF n = 2 THEN 
        RETURN 1 ;
    END IF ;
    
    RETURN f_n_th_from_fibonacci (n - 2) + f_n_th_from_fibonacci ( n - 1 ) ;
END ;
/


--  test
SELECT f_n_th_from_fibonacci(1) FROM dual ;
SELECT f_n_th_from_fibonacci(2) FROM dual ;
SELECT f_n_th_from_fibonacci(3) FROM dual ;
SELECT f_n_th_from_fibonacci(4) FROM dual ;
SELECT f_n_th_from_fibonacci(5) FROM dual ;
SELECT f_n_th_from_fibonacci(6) FROM dual ;
SELECT f_n_th_from_fibonacci(10) FROM dual ;
SELECT f_n_th_from_fibonacci(20) FROM dual ;


