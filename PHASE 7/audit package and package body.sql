--- audit package and package body----





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





---Package Body------




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