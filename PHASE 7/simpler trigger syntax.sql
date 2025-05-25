-----simple trigger ------

CREATE OR REPLACE TRIGGER trg_prevent_dml_weekday_holiday
BEFORE INSERT OR UPDATE OR DELETE ON Transaction
FOR EACH ROW
DECLARE
    v_today DATE := SYSDATE;
    v_day   VARCHAR2(10);
    v_holiday_count INT;
BEGIN
    v_day := TO_CHAR(v_today, 'DY', 'NLS_DATE_LANGUAGE=ENGLISH');

    SELECT COUNT(*) INTO v_holiday_count
    FROM Holidays
    WHERE HolidayDate = TRUNC(v_today)
      AND HolidayDate BETWEEN TRUNC(SYSDATE)
                          AND TRUNC(ADD_MONTHS(SYSDATE, 1));

    IF v_day IN ('MON', 'TUE', 'WED', 'THU', 'FRI') OR v_holiday_count > 0 THEN
        RAISE_APPLICATION_ERROR(-20001, '❌ DML operations are blocked on weekdays or holidays within the upcoming month.');
    END IF;
END;
/