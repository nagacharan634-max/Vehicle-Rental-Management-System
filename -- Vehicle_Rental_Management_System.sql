-- =====================================================
-- VEHICLE RENTAL MANAGEMENT SYSTEM
-- DATABASE MANAGEMENT SYSTEM PROJECT
-- =====================================================

-- Oracle Database Implementation
-- Tables: CUSTOMER, VEHICLE_CATEGORY, VEHICLE,
-- BOOKING, RENTAL, PAYMENT, MAINTENANCE, EMPLOYEE


-- =====================================================
-- RECORD COUNT VERIFICATION
-- =====================================================

SELECT 'CUSTOMER' AS TABLE_NAME, COUNT(*) AS RECORD_COUNT
FROM CUSTOMER
UNION ALL
SELECT 'VEHICLE_CATEGORY', COUNT(*) FROM VEHICLE_CATEGORY
UNION ALL
SELECT 'VEHICLE', COUNT(*) FROM VEHICLE
UNION ALL
SELECT 'BOOKING', COUNT(*) FROM BOOKING
UNION ALL
SELECT 'RENTAL', COUNT(*) FROM RENTAL
UNION ALL
SELECT 'PAYMENT', COUNT(*) FROM PAYMENT
UNION ALL
SELECT 'MAINTENANCE', COUNT(*) FROM MAINTENANCE
UNION ALL
SELECT 'EMPLOYEE', COUNT(*) FROM EMPLOYEE;



-- =====================================================
-- PRIMARY KEY / FOREIGN KEY VERIFICATION
-- =====================================================

SELECT
    TABLE_NAME,
    CONSTRAINT_NAME,
    CONSTRAINT_TYPE
FROM USER_CONSTRAINTS
WHERE TABLE_NAME IN (
    'CUSTOMER',
    'VEHICLE_CATEGORY',
    'VEHICLE',
    'BOOKING',
    'RENTAL',
    'PAYMENT',
    'MAINTENANCE',
    'EMPLOYEE'
)
AND CONSTRAINT_TYPE IN ('P', 'R')
ORDER BY TABLE_NAME, CONSTRAINT_TYPE;



-- =====================================================
-- FOREIGN KEY MAPPING
-- =====================================================

SELECT
    fk.TABLE_NAME AS CHILD_TABLE,
    fkc.COLUMN_NAME AS CHILD_COLUMN,
    pk.TABLE_NAME AS PARENT_TABLE,
    pkc.COLUMN_NAME AS PARENT_COLUMN
FROM USER_CONSTRAINTS fk
JOIN USER_CONS_COLUMNS fkc
    ON fk.CONSTRAINT_NAME = fkc.CONSTRAINT_NAME
JOIN USER_CONSTRAINTS pk
    ON fk.R_CONSTRAINT_NAME = pk.CONSTRAINT_NAME
JOIN USER_CONS_COLUMNS pkc
    ON pk.CONSTRAINT_NAME = pkc.CONSTRAINT_NAME
WHERE fk.CONSTRAINT_TYPE = 'R'
ORDER BY fk.TABLE_NAME;




-- =====================================================
-- CUSTOMER + BOOKING + VEHICLE
-- =====================================================

SELECT
    c.NAME AS CUSTOMER_NAME,
    v.BRAND,
    v.MODEL,
    b.START_DATE,
    b.END_DATE,
    b.BOOKING_STATUS
FROM CUSTOMER c
JOIN BOOKING b
    ON c.CUSTOMER_ID = b.CUSTOMER_ID
JOIN VEHICLE v
    ON b.VEHICLE_ID = v.VEHICLE_ID;




-- =====================================================
-- RENTAL + PAYMENT
-- =====================================================

SELECT
    r.RENTAL_ID,
    v.BRAND,
    v.MODEL,
    r.TOTAL_AMOUNT,
    p.AMOUNT AS PAYMENT_AMOUNT,
    p.PAYMENT_METHOD,
    p.PAYMENT_STATUS
FROM RENTAL r
JOIN VEHICLE v
    ON r.VEHICLE_ID = v.VEHICLE_ID
JOIN PAYMENT p
    ON r.RENTAL_ID = p.RENTAL_ID;



-- =====================================================
-- AVAILABLE VEHICLES
-- =====================================================

SELECT
    VEHICLE_ID,
    VEHICLE_NO,
    BRAND,
    MODEL,
    VEHICLE_TYPE,
    RENTAL_RATE
FROM VEHICLE
WHERE STATUS = 'Available';


-- =====================================================
-- TOTAL PAYMENT
-- =====================================================

SELECT
    SUM(AMOUNT) AS TOTAL_PAYMENT
FROM PAYMENT
WHERE PAYMENT_STATUS = 'Paid';


-- =====================================================
-- BOOKING COUNT BY STATUS
-- =====================================================

SELECT
    BOOKING_STATUS,
    COUNT(*) AS TOTAL_BOOKINGS
FROM BOOKING
GROUP BY BOOKING_STATUS;