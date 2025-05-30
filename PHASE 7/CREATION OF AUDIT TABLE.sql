---CREATION OF AUDIT TABLE-----



CREATE TABLE Audit_Log (
    AuditID       NUMBER GENERATED BY DEFAULT ON NULL AS IDENTITY PRIMARY KEY,
    UserID        VARCHAR2(50),       -- Who attempted it
    Action        VARCHAR2(20),       -- INSERT, UPDATE, DELETE
    ActionTime    TIMESTAMP,          -- When it happened
    Status        VARCHAR2(10),       -- ALLOWED or DENIED
    TableName     VARCHAR2(50)        -- Which table was targeted
);