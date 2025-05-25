---COMPOUND TRIGGER SYNTAX----

CREATE OR REPLACE TRIGGER trg_compound_dml_blocker
FOR INSERT OR UPDATE OR DELETE ON Transaction
COMPOUND TRIGGER

    -- Shared variables across all trigger sections
    v_day       VARCHAR2(10);
    v_holiday   INT;
    v_status    VARCHAR2(10) := 'ALLOWED';
    v_user      VARCHAR2(50);
    v_table     VARCHAR2(50) := 'Transaction';
    v_block     BOOLEAN := FALSE;
    v_reason    VARCHAR2(200);

BEFORE STATEMENT IS
BEGIN
    v_user := SYS_CONTEXT('USERENV', 'SESSION_USER');

    v_day := TO_CHAR(SYSDATE, 'DY', 'NLS_DATE_LANGUAGE=ENGLISH');

    SELECT COUNT(*) INTO v_holiday
    FROM Holidays
    WHERE HolidayDate = TRUNC(SYSDATE)
      AND HolidayDate BETWEEN TRUNC(SYSDATE) AND TRUNC(ADD_MONTHS(SYSDATE, 1));

    IF v_day IN ('MON', 'TUE', 'WED', 'THU', 'FRI') OR v_holiday > 0 THEN
        v_block := TRUE;
        v_status := 'DENIED';
        v_reason := 'DML blocked on weekday or holiday';
    END IF;
END BEFORE STATEMENT;

BEFORE EACH ROW IS
BEGIN
    IF v_block THEN
        RAISE_APPLICATION_ERROR(-20002, '❌ DML blocked on weekday or holiday');
    END IF;
END BEFORE EACH ROW;

AFTER STATEMENT IS
BEGIN
    -- Log user attempt
    INSERT INTO Audit_Log (Username, Action, ActionTime, Status, TableName)
    VALUES (
        v_user,
        ORA_SYSEVENT,
        SYSTIMESTAMP,
        v_status,
        v_table
    );
   
END AFTER STATEMENT;

END trg_compound_dml_blocker;
/