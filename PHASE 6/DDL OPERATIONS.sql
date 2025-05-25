-----DDL OPERATIONS-----

-- Create Analysis Table to Store Aggregated Data-----



CREATE TABLE Transaction_Analysis (
    AnalysisID INT PRIMARY KEY,
    UserID INT NOT NULL,
    TotalSpent DECIMAL(10, 2) NOT NULL,
    AvgTransactionAmount DECIMAL(10, 2) NOT NULL,
    HighestSpendingMerchant VARCHAR(100),
    AnalysisDate DATE NOT NULL,
    FOREIGN KEY (UserID) REFERENCES Client(UserID)
);