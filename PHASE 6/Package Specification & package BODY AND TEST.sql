----Package Specification & package BODY & TEST-----

CREATE OR REPLACE PACKAGE Data_Analysis_Pkg AS
    -- Procedure to analyze spending
    PROCEDURE Analyze_Spending;

    -- Function to get cumulative spending for a user
    FUNCTION Get_Cumulative_Spending(p_UserID INT) RETURN DECIMAL;
END Data_Analysis_Pkg;
/



CREATE OR REPLACE PACKAGE BODY Data_Analysis_Pkg AS

    -- Procedure to analyze total and average spending
    PROCEDURE Analyze_Spending IS
        CURSOR trans_cursor IS 
            SELECT AccountID, SUM(TransactionAmount) AS TotalSpent, 
                   AVG(TransactionAmount) AS AvgSpent
            FROM Transaction
            GROUP BY AccountID;

        rec trans_cursor%ROWTYPE;
        analysis_id INT := 1;
    BEGIN
        -- Delete previous analysis results
        DELETE FROM Transaction_Analysis;

        -- Loop through aggregated data and insert new records
        FOR rec IN trans_cursor LOOP
            INSERT INTO Transaction_Analysis (
                AnalysisID, UserID, TotalSpent, AvgTransactionAmount, AnalysisDate
            ) VALUES (
                analysis_id, rec.AccountID, rec.TotalSpent, rec.AvgSpent, SYSDATE
            );

            analysis_id := analysis_id + 1;
        END LOOP;

        COMMIT;
    END Analyze_Spending;

    -- Function to get cumulative spending for a user
    FUNCTION Get_Cumulative_Spending(p_UserID INT) RETURN DECIMAL IS
        total_spent DECIMAL(10, 2);
    BEGIN
        SELECT SUM(TransactionAmount) INTO total_spent
        FROM Transaction
        WHERE AccountID = p_UserID;

        RETURN NVL(total_spent, 0); -- Return 0 if null
    END Get_Cumulative_Spending;

END Data_Analysis_Pkg;
/











BEGIN
    
    Data_Analysis_Pkg.Analyze_Spending;
    DBMS_OUTPUT.PUT_LINE('Spending analysis completed.');

    -- Test the cumulative spending function for a specific user
    DBMS_OUTPUT.PUT_LINE('Total spent by user 1: ' || Data_Analysis_Pkg.Get_Cumulative_Spending(1));

    DBMS_OUTPUT.PUT_LINE('Total spent by user 2: ' || Data_Analysis_Pkg.Get_Cumulative_Spending(2));
END;
/