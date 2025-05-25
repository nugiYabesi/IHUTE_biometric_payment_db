-----Implement a Simple Function Using Window Functions AND TEST-----



CREATE OR REPLACE FUNCTION Get_Cumulative_Spending (p_UserID INT) 
RETURN DECIMAL
IS
    total_spent DECIMAL(10, 2);
BEGIN
    SELECT SUM(TransactionAmount) INTO total_spent
    FROM Transaction
    WHERE AccountID = p_UserID;
    
    RETURN total_spent;
END Get_Cumulative_Spending;
/







SELECT Get_Cumulative_Spending(1) AS TotalSpent_User1 FROM DUAL;


