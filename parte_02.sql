CREATE OR REPLACE
DIRECTORY USER_DIR AS '/u01/app/oracle/product/12.2.0/SE';

GRANT READ ON
DIRECTORY USER_DIR TO PUBLIC;

CREATE TABLE TEMP_LAB (
    NOME VARCHAR2(200),
    IDADE NUMBER(2),
    DATA_NASCIMENTO DATE
);

CREATE OR REPLACE
PROCEDURE SAVE_FILE_CONTENT IS
	FILE_LINE VARCHAR2(200);
    FILE UTL_FILE.FILE_TYPE;
    FIRST_COMMA NUMBER(3);
    SECOND_COMMA NUMBER(3);
    THIRD_COMMA NUMBER(3);
    NAME VARCHAR2(200);
    AGE VARCHAR2(200);
    BORN_DATE VARCHAR2(200);
BEGIN
FILE := UTL_FILE.FOPEN('USER_DIR','temp.txt','R');
LOOP
BEGIN
    UTL_FILE.GET_LINE(FILE, FILE_LINE);

    SELECT INSTR(FILE_LINE, ';') INTO FIRST_COMMA FROM DUAL;
    SELECT INSTR(FILE_LINE, ';', 1, 2) INTO SECOND_COMMA FROM DUAL;
    SELECT INSTR(FILE_LINE, ';', 1, 3) INTO THIRD_COMMA FROM DUAL;

    SELECT SUBSTR(FILE_LINE, 0, FIRST_COMMA - 1) INTO NAME FROM DUAL;
    SELECT SUBSTR(FILE_LINE, FIRST_COMMA + 1, SECOND_COMMA - FIRST_COMMA - 1) INTO AGE FROM DUAL;
    SELECT SUBSTR(FILE_LINE, SECOND_COMMA + 1, 10) INTO BORN_DATE FROM DUAL;

    INSERT INTO TEMP_LAB VALUES (NAME, TO_NUMBER(AGE), TO_DATE(BORN_DATE, 'DD/MM/YYYY'));

    EXCEPTION WHEN NO_DATA_FOUND THEN EXIT; END;
END LOOP;
UTL_FILE.FCLOSE(FILE);
END;
/
