----Triggers to block unauthorized access or manipulation and Functions and packages to automate audit tracking----------




CREATE OR REPLACE TRIGGER trg_secure_transaction_dml
FOR INSERT OR UPDATE OR DELETE ON Transaction
COMPOUND TRIGGER

    -- Shared variables
    v_day       VARCHAR2(10);
    v_holiday   INT;
    v_status    VARCHAR2(10) := 'ALLOWED';
    v_user      VARCHAR2(50);
    v_table     VARCHAR2(50) := 'Transaction';
    v_block     BOOLEAN := FALSE;

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
    END IF;
END BEFORE STATEMENT;

BEFORE EACH ROW IS
BEGIN
    IF NOT Audit_Pkg.Is_Authorized(v_user) THEN
        v_status := 'DENIED';
        RAISE_APPLICATION_ERROR(-20003, '❌ Access Denied: Unauthorized user.');
    END IF;

    IF v_block THEN
        RAISE_APPLICATION_ERROR(-20002, '❌ DML blocked on weekday or holiday.');
    END IF;
END BEFORE EACH ROW;

AFTER STATEMENT IS
BEGIN
    Audit_Pkg.Log_Audit(
        p_user   => v_user,
        p_action => ORA_SYSEVENT,
        p_status => v_status,
        p_table  => v_table
    );
END AFTER STATEMENT;

END;
/
  