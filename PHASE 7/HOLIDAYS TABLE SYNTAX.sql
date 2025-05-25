---Creating and inserting data in the Reference Table for Holidays---

CREATE TABLE Holidays (
    HolidayDate DATE PRIMARY KEY,
    Description VARCHAR2(100)
);

INSERT INTO Holidays (HolidayDate, Description) VALUES (TO_DATE('2025-06-01', 'YYYY-MM-DD'), 'Independence Day');
INSERT INTO Holidays (HolidayDate, Description) VALUES (TO_DATE('2025-06-07', 'YYYY-MM-DD'), 'National Heroes Day');

COMMIT;