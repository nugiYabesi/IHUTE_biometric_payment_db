---Procedure for Data Analysis----






CREATE OR REPLACE PROCEDURE Analyze_Spending
IS
    CURSOR trans_cursor IS 
        SELECT 
            t.AccountID, 
            SUM(t.TransactionAmount) AS TotalSpent, 
            AVG(t.TransactionAmount) AS AvgSpent,
            (SELECT m.MerchantName 
             FROM Transaction t2 
             JOIN Merchant m ON t2.MerchantID = m.MerchantID 
             WHERE t2.AccountID = t.AccountID 
             GROUP BY m.MerchantName 
             ORDER BY SUM(t2.TransactionAmount) DESC 
             FETCH FIRST 1 ROW ONLY) AS HighestSpendingMerchant
        FROM Transaction t
        GROUP BY t.AccountID;
        
    rec trans_cursor%ROWTYPE;
BEGIN
    FOR rec IN trans_cursor LOOP
        -- Insert the analysis data with sequence-generated AnalysisID
        INSERT INTO Transaction_Analysis 
        (AnalysisID, UserID, TotalSpent, AvgTransactionAmount, HighestSpendingMerchant, AnalysisDate)
        VALUES 
        (AnalysisID_Seq.NEXTVAL, rec.AccountID, rec.TotalSpent, rec.AvgSpent, rec.HighestSpendingMerchant, SYSDATE);
    END LOOP;
 COMMIT;
END Analyze_Spending;
/



BEGIN
    Analyze_Spending;
END;
/



SELECT * FROM Transaction_Analysis;