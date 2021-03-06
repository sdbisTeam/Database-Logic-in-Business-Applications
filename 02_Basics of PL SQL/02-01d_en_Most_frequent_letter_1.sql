
-- next procedure finds and displays the most frequent letter in a given string

CREATE OR REPLACE PROCEDURE p_most_freq_letter (string_ VARCHAR2)
IS
    v_letters VARCHAR2(35) := 'ABCDEFGHIJKLMNOPQRSTUVWXYZĂÎȘȚÂ' ;
    v_no_max NUMBER(5) := 0 ;
    v_lett_max CHAR(1) ;
    v_no NUMBER(5) ;
    v_displayed VARCHAR2(4000) ;
BEGIN 

    -- take a letter...
    FOR i IN 1..LENGTH (v_letters) LOOP
        -- count how many times it appears in the string_
        v_no := 0 ;
        FOR j IN 1..LENGTH(string_) LOOP
            IF UPPER(SUBSTR(string_, j, 1)) = UPPER(SUBSTR(v_letters, i, 1)) THEN
                v_no := v_no + 1 ;
            END IF ;
        END LOOP ;
        
        -- compare the number of occurences of this letter with maximum one
        IF v_no > v_no_max THEN
            v_no_max := v_no ;
            v_lett_max := SUBSTR(v_letters, i, 1) ;
        END IF ;
    END LOOP ;

    -- we can display the letter (v_lett_max) and its number of occurences...
    --   but what if there are two or more letters with the same maximum number of occurences?
    -- we need another loop
    
    v_displayed := 'The most frequent letter/letters is/are: ' ;
    FOR i IN 1..LENGTH (v_letters) LOOP
        v_no := 0 ;
        FOR j IN 1..LENGTH(string_) LOOP
            IF UPPER(SUBSTR(string_, j, 1)) = UPPER(SUBSTR(v_letters, i, 1)) THEN
                v_no := v_no + 1 ;
            END IF ;
        END LOOP ;
        IF v_no = v_no_max THEN
            v_displayed := v_displayed ||  SUBSTR(v_letters, i, 1) || ', ' ;
        END IF ;
    END LOOP ;
    
    DBMS_OUTPUT.PUT_LINE (v_displayed || '  which appears/appear in the string ' || v_no_max || ' times.') ;
END ;
/
 

-- test
EXEC p_most_freq_letter ('Ana are mere') 

-- 
/* If the database default language is not Romanian, the first version of the 
function can generate an error:
ORA-06502: PL/SQL: numeric or value error: character string buffer too small
ORA-06512: at "SIA.p_most_freq_letter", line 3
06502. 00000 -  "PL/SQL: numeric or value error%s"
*Cause:    
*Action:

that is because romanian letters need more than a byte for internal representation
*/


CREATE OR REPLACE PROCEDURE p_most_freq_letter (string_ VARCHAR2)
IS
    v_letters VARCHAR2(35 CHAR) := 'ABCDEFGHIJKLMNOPQRSTUVWXYZĂÎȘȚÂ' ; -- -- here's a change
    v_no_max NUMBER(5) := 0 ;
    v_lett_max CHAR(1 CHAR) ; -- here is another change
    v_no NUMBER(5) ;
    v_displayed VARCHAR2(4000) ;
BEGIN 

    -- take a letter...
    FOR i IN 1..LENGTH (v_letters) LOOP
        -- count how many times it appears in the string_
        v_no := 0 ;
        FOR j IN 1..LENGTH(string_) LOOP
            IF UPPER(SUBSTR(string_, j, 1)) = UPPER(SUBSTR(v_letters, i, 1)) THEN
                v_no := v_no + 1 ;
            END IF ;
        END LOOP ;
        
        -- compare the number of occurences of this letter with maximum one
        IF v_no > v_no_max THEN
            v_no_max := v_no ;
            v_lett_max := SUBSTR(v_letters, i, 1) ;
        END IF ;
    END LOOP ;

    -- we can display the letter (v_lett_max) and its number of occurences...
    --   but what if there are two or more letters with the same maximum number of occurences?
    -- we need another loop
    
    v_displayed := 'The most frequent letter/letters is/are: ' ;
    FOR i IN 1..LENGTH (v_letters) LOOP
        v_no := 0 ;
        FOR j IN 1..LENGTH(string_) LOOP
            IF UPPER(SUBSTR(string_, j, 1)) = UPPER(SUBSTR(v_letters, i, 1)) THEN
                v_no := v_no + 1 ;
            END IF ;
        END LOOP ;
        IF v_no = v_no_max THEN
            v_displayed := v_displayed ||  SUBSTR(v_letters, i, 1) || ', ' ;
        END IF ;
    END LOOP ;
    
    DBMS_OUTPUT.PUT_LINE (v_displayed || '  which appears/appear in the string ' || v_no_max || ' times.') ;
END ;
/

-- test
EXEC p_most_freq_letter ('Ana are mere') 

EXEC p_most_freq_letter ('Ana are mere ăăăăăăăă') 

EXEC p_most_freq_letter ('Șir de test ăăîîșșțțȚȚ') 



