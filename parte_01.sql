CREATE OR REPLACE
DIRECTORY USER_DIR AS '/u01/app/oracle/product/12.2.0/SE';

GRANT READ ON
DIRECTORY USER_DIR TO PUBLIC;

GRANT WRITE ON
DIRECTORY USER_DIR TO PUBLIC;

CREATE OR REPLACE
PROCEDURE ABC IS
    FILE UTL_FILE.FILE_TYPE;
	EVEN_NUMBERS_COUNTER NUMBER := 0;
    INPUT_STRING VARCHAR2(100);
    N_RESULT NUMBER(3);
    LOOP_INDEX NUMBER(3);
BEGIN
FILE := UTL_FILE.FOPEN('USER_DIR', 'pares.txt', 'w');
FOR LOOP_INDEX IN 1..100
LOOP
    SELECT MOD(LOOP_INDEX, 2) INTO N_RESULT FROM DUAL;

    IF (N_RESULT = 0) THEN
        EVEN_NUMBERS_COUNTER := EVEN_NUMBERS_COUNTER + 1;
        SELECT ('Total de pares: ' || EVEN_NUMBERS_COUNTER) INTO INPUT_STRING FROM DUAL;
        dbms_output.put_line(INPUT_STRING);
        UTL_FILE.PUT_LINE(FILE, INPUT_STRING);
    END IF;
END LOOP;
UTL_FILE.FCLOSE(FILE);
END;
/
