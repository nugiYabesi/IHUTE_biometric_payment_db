SELECT * FROM Holidays WHERE HolidayDate = TRUNC(SYSDATE);



INSERT INTO Transaction (TransactionID, AccountID, MerchantID, TransactionAmount, TransactionDate)
VALUES (999, 1, 1, 99.99, SYSDATE);




CREATE TABLE Audit_Log (
    AuditID       NUMBER GENERATED BY DEFAULT ON NULL AS IDENTITY PRIMARY KEY,
    UserID        VARCHAR2(50),       -- Who attempted it
    Action        VARCHAR2(20),       -- INSERT, UPDATE, DELETE
    ActionTime    TIMESTAMP,          -- When it happened
    Status        VARCHAR2(10),       -- ALLOWED or DENIED
    TableName     VARCHAR2(50)        -- Which table was targeted
);
























 
CREATE TABLE Audit_Log2 (
    AuditID       NUMBER GENERATED BY DEFAULT ON NULL AS IDENTITY PRIMARY KEY,
    UserID        VARCHAR2(50),
    Action        VARCHAR2(20),
    ActionTime    TIMESTAMP,
    Status        VARCHAR2(10),
    TableName     VARCHAR2(50)
);



















CREATE OR REPLACE PACKAGE Audit_Pkg AS
    PROCEDURE Log_Audit(
        p_user    VARCHAR2,
        p_action  VARCHAR2,
        p_status  VARCHAR2,
        p_table   VARCHAR2
    );
END Audit_Pkg;
/








CREATE OR REPLACE PACKAGE BODY Audit_Pkg AS
    PROCEDURE Log_Audit(
        p_user    VARCHAR2,
        p_action  VARCHAR2,
        p_status  VARCHAR2,
        p_table   VARCHAR2
    ) IS
    BEGIN
        INSERT INTO Audit_Log (
            UserID,
            Action,
            ActionTime,
            Status,
            TableName
        )
        VALUES (
            p_user,
            p_action,
            SYSTIMESTAMP,
            p_status,
            p_table
        );
    END Log_Audit;
END Audit_Pkg;
/




























CREATE OR REPLACE PACKAGE Audit_Pkg AS
    PROCEDURE Log_Audit(
        p_user    VARCHAR2,
        p_action  VARCHAR2,
        p_status  VARCHAR2,
        p_table   VARCHAR2
    );

    FUNCTION Is_Authorized(p_user VARCHAR2) RETURN BOOLEAN;
END Audit_Pkg;
/

































CREATE OR REPLACE PACKAGE BODY Audit_Pkg AS

    PROCEDURE Log_Audit(
        p_user    VARCHAR2,
        p_action  VARCHAR2,
        p_status  VARCHAR2,
        p_table   VARCHAR2
    ) IS
    BEGIN
        INSERT INTO Audit_Log (UserID, Action, ActionTime, Status, TableName)
        VALUES (p_user, p_action, SYSTIMESTAMP, p_status, p_table);
    END;

    FUNCTION Is_Authorized(p_user VARCHAR2) RETURN BOOLEAN IS
    BEGIN
        RETURN UPPER(p_user) IN ('SYS', 'ADMIN');
    END;

END Audit_Pkg;
/




























































































DELETE FROM Holidays WHERE HolidayDate = TRUNC(SYSDATE);
COMMIT;



INSERT INTO Transaction (TransactionID, AccountID, MerchantID, TransactionAmount, TransactionDate)
VALUES (6001, 1, 1, 250.00, SYSDATE);



SHOW ERRORS TRIGGER trg_secure_transaction_dml;


SHOW ERRORS PACKAGE BODY Audit_Pkg;

DROP TRIGGER TRG_COMPOUND_DML_BLOCKER;

SELECT TRIGGER_NAME, STATUS
FROM USER_TRIGGERS
WHERE TABLE_NAME = 'TRANSACTION';

DROP TRIGGER trg_audit_transaction_dml;





INSERT INTO Transaction (TransactionID, AccountID, MerchantID, TransactionAmount, TransactionDate)
VALUES (6001, 1, 1, 250.00, SYSDATE);











INSERT INTO Transaction (TransactionID, AccountID, MerchantID, TransactionAmount, TransactionDate)
VALUES (6001, 1, 1, 250.00, SYSDATE);



INSERT INTO Transaction (TransactionID, AccountID, MerchantID, TransactionAmount, TransactionDate)
VALUES (6001, 1, 1, 250.00, SYSDATE);










DROP TRIGGER TRG_COMPOUND_DML_BLOCKER;



















INSERT INTO Transaction (TransactionID, AccountID, MerchantID, TransactionAmount, TransactionDate)
VALUES (6001, 1, 1, 250.00, SYSDATE);














SELECT * FROM Audit_Log ORDER BY ActionTime DESC;





























INSERT INTO Transaction (TransactionID, AccountID, MerchantID, TransactionAmount, TransactionDate)
VALUES (7001, 1, 1, 99.99, SYSDATE);







SELECT * FROM Audit_Log ORDER BY ActionTime DESC;





















CREATE OR REPLACE PACKAGE BODY Audit_Pkg AS

  PROCEDURE Log_Audit(
      p_user    VARCHAR2,
      p_action  VARCHAR2,
      p_status  VARCHAR2,
      p_table   VARCHAR2
  ) IS
      PRAGMA AUTONOMOUS_TRANSACTION;
  BEGIN
      INSERT INTO Audit_Log (UserID, Action, ActionTime, Status, TableName)
      VALUES (p_user, p_action, SYSTIMESTAMP, p_status, p_table);
      COMMIT; -- Required for autonomous block
  END;

  FUNCTION Is_Authorized(p_user VARCHAR2) RETURN BOOLEAN IS
  BEGIN
      RETURN UPPER(p_user) IN ('SYS', 'ADMIN');
  END;

END Audit_Pkg;
/
























CREATE OR REPLACE PACKAGE BODY Audit_Pkg AS

  PROCEDURE Log_Audit(
      p_user    VARCHAR2,
      p_action  VARCHAR2,
      p_status  VARCHAR2,
      p_table   VARCHAR2
  ) IS
      PRAGMA AUTONOMOUS_TRANSACTION;
  BEGIN
      INSERT INTO Audit_Log (UserID, Action, ActionTime, Status, TableName)
      VALUES (p_user, p_action, SYSTIMESTAMP, p_status, p_table);
      COMMIT; -- Required for autonomous block
  END;

  FUNCTION Is_Authorized(p_user VARCHAR2) RETURN BOOLEAN IS
  BEGIN
      RETURN UPPER(p_user) IN ('SYS', 'ADMIN');
  END;

END Audit_Pkg;
/























CREATE OR REPLACE TRIGGER trg_secure_transaction_dml
FOR INSERT OR UPDATE OR DELETE ON Transaction
COMPOUND TRIGGER

    v_day     VARCHAR2(10);
    v_holiday INT;
    v_user    VARCHAR2(50);
    v_table   VARCHAR2(50) := 'Transaction';
    v_status  VARCHAR2(10) := 'ALLOWED';
    v_block   BOOLEAN := FALSE;

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
        Audit_Pkg.Log_Audit(v_user, ORA_SYSEVENT, v_status, v_table);
        RAISE_APPLICATION_ERROR(-20003, '❌ Access Denied: Unauthorized user.');
    END IF;

    IF v_block THEN
        v_status := 'DENIED';
        Audit_Pkg.Log_Audit(v_user, ORA_SYSEVENT, v_status, v_table);
        RAISE_APPLICATION_ERROR(-20002, '❌ DML blocked on weekday or holiday.');
    END IF;

    -- If no error, log as allowed
    Audit_Pkg.Log_Audit(v_user, ORA_SYSEVENT, 'ALLOWED', v_table);
END BEFORE EACH ROW;

END;
/


















































INSERT INTO Transaction (TransactionID, AccountID, MerchantID, TransactionAmount, TransactionDate)
VALUES (8001, 1, 1, 88.00, SYSDATE);






















SELECT * FROM Audit_Log ORDER BY ActionTime DESC;
