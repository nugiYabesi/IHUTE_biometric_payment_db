----test of simple trigger--- 
--Try a Blocked Operation (INSERT)---

INSERT INTO Transaction (TransactionID, AccountID, MerchantID, TransactionAmount, TransactionDate)
VALUES (1000, 2, 1, 49.99, SYSDATE);