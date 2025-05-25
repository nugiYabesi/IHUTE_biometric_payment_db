-----TEST : CAN THE TRIGGER BLOCK UNAUTHORIZED USERS FROM MANIPULATING DATA?-------




INSERT INTO Transaction (TransactionID, AccountID, MerchantID, TransactionAmount, TransactionDate)
VALUES (6001, 1, 1, 250.00, SYSDATE);