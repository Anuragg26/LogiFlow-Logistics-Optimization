-- ============================================================
-- LogiFlow Delivery Operations — SQL Analysis
-- Database: logiflow | Table: deliveries
-- Author: Anurag Panwar
-- ============================================================


-- ============================================================
-- 1. DATABASE & TABLE SETUP
-- ============================================================

CREATE DATABASE logiflow;
USE logiflow;

CREATE TABLE deliveries (
    OrderID VARCHAR(20),
    OrderDate DATE,
    OrderDateTime DATETIME,
    Region VARCHAR(50),
    Warehouse VARCHAR(50),
    Route VARCHAR(20),
    VehicleID VARCHAR(20),
    VehicleType VARCHAR(20),
    DriverID VARCHAR(20),
    DistanceKM DECIMAL(6,2),
    ParcelWeightKG DECIMAL(6,2),
    OrderProcessingTimeMin DECIMAL(6,2),
    WarehouseLoadingTimeMin DECIMAL(6,2),
    VehicleUtilizationPct DECIMAL(5,2),
    PlannedDeliveryTime DATETIME,
    ActualDeliveryTime DATETIME,
    DeliveryStatus VARCHAR(20),
    DeliveryCostEUR DECIMAL(8,2),
    CustomerComplaint VARCHAR(5),
    RepeatCustomer VARCHAR(5),
    FlaggedInvalid VARCHAR(5)
);


-- ============================================================
-- 2. DATA IMPORT
-- Loads the CSV, converting text dates (M/D/YYYY) into proper
-- MySQL DATE/DATETIME values, and converting blank strings in
-- numeric/date columns into real NULLs (211 blanks in
-- DistanceKM, 3,728 in ActualDeliveryTime, 197 in
-- DeliveryCostEUR — intentional data-quality issues in the
-- source dataset).
-- ============================================================

LOAD DATA INFILE 'LogiFlow_Delivery_Data.csv'
INTO TABLE deliveries
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 LINES
(OrderID, @OrderDate, @OrderDateTime, Region, Warehouse, Route, VehicleID, VehicleType, DriverID,
 @DistanceKM, ParcelWeightKG, OrderProcessingTimeMin, WarehouseLoadingTimeMin, VehicleUtilizationPct,
 @PlannedDeliveryTime, @ActualDeliveryTime, DeliveryStatus, @DeliveryCostEUR,
 CustomerComplaint, RepeatCustomer, FlaggedInvalid)
SET
 OrderDate = STR_TO_DATE(@OrderDate, '%m/%d/%Y'),
 OrderDateTime = STR_TO_DATE(@OrderDateTime, '%m/%d/%Y %H:%i'),
 PlannedDeliveryTime = STR_TO_DATE(@PlannedDeliveryTime, '%m/%d/%Y %H:%i'),
 ActualDeliveryTime = STR_TO_DATE(NULLIF(@ActualDeliveryTime, ''), '%m/%d/%Y %H:%i'),
 DistanceKM = NULLIF(@DistanceKM, ''),
 DeliveryCostEUR = NULLIF(@DeliveryCostEUR, '');


-- ============================================================
-- 3. DATA VALIDATION
-- ============================================================

-- Row count check — expect 105,000
SELECT COUNT(*) FROM deliveries;

-- Spot-check the first few rows
SELECT * FROM deliveries LIMIT 5;

-- Confirm NULL counts match the known data-quality issues
-- Result: null_distance = 211, null_actual_delivery = 3728, null_cost = 197
SELECT
  SUM(DistanceKM IS NULL) AS null_distance,
  SUM(ActualDeliveryTime IS NULL) AS null_actual_delivery,
  SUM(DeliveryCostEUR IS NULL) AS null_cost
FROM deliveries;

-- Confirm the date range covers the full year
-- Result: 2025-09-01 to 2026-08-31
SELECT MIN(OrderDate) AS earliest, MAX(OrderDate) AS latest
FROM deliveries;

-- Confirm all 6 regions/warehouses are present with reasonable volumes
-- Result: Berlin 29318, Munich 20916, Hamburg 18837,
--         Frankfurt 14762, Cologne 12659, Stuttgart 8508
SELECT Region, Warehouse, COUNT(*) AS orders
FROM deliveries
GROUP BY Region, Warehouse
ORDER BY orders DESC;


-- ============================================================
-- 4. DELIVERY STATUS BREAKDOWN
-- Result: On-Time 85486 (81.4%) | Late 15786 (15.0%)
--         Failed 2180 (2.1%)    | Cancelled 1548 (1.5%)
-- ============================================================

SELECT DeliveryStatus, COUNT(*) AS count
FROM deliveries
GROUP BY DeliveryStatus
ORDER BY count DESC;


-- ============================================================
-- 5. KEY FINDING — WAREHOUSE PERFORMANCE (Hamburg bottleneck)
-- Result: Hamburg's loading time (20.96 min) and processing
-- time (32.02 min) are roughly double every other warehouse
-- (~12 min loading, ~18 min processing).
-- ============================================================

SELECT
  Warehouse,
  ROUND(AVG(WarehouseLoadingTimeMin), 2) AS avg_loading_time,
  ROUND(AVG(OrderProcessingTimeMin), 2) AS avg_processing_time,
  COUNT(*) AS total_orders
FROM deliveries
GROUP BY Warehouse
ORDER BY avg_loading_time DESC;

-- Late delivery rate by warehouse
-- Result: Hamburg 25.57% | Frankfurt 15.17% | Munich 14.58%
--         Stuttgart 14.33% | Cologne 13.61% | Berlin 9.34% (best)
SELECT
  Warehouse,
  COUNT(*) AS total_orders,
  SUM(DeliveryStatus = 'Late') AS late_orders,
  ROUND(SUM(DeliveryStatus = 'Late') / COUNT(*) * 100, 2) AS late_rate_pct
FROM deliveries
GROUP BY Warehouse
ORDER BY late_rate_pct DESC;


-- ============================================================
-- 6. KEY FINDING — PROBLEM ROUTES
-- Result (top offenders): HAM-R2 41.08%, HAM-R6 40.56%,
-- COL-R6 33.82%, FRA-R1 33.64%, MUN-R4 33.53%, STU-R2 33.50%
-- — note COL-R6/FRA-R1/MUN-R4/STU-R2 are NOT in Hamburg,
-- pointing to route-specific issues separate from the
-- Hamburg warehouse bottleneck.
-- ============================================================

SELECT
  Route,
  COUNT(*) AS total_orders,
  SUM(DeliveryStatus = 'Late') AS late_orders,
  ROUND(SUM(DeliveryStatus = 'Late') / COUNT(*) * 100, 2) AS late_rate_pct
FROM deliveries
GROUP BY Route
HAVING total_orders >= 100
ORDER BY late_rate_pct DESC
LIMIT 15;


-- ============================================================
-- 7. BUSINESS IMPACT — COMPLAINTS
-- Result: Failed 68.99% | Late 35.32% | Cancelled 22.87%
--         On-Time 3.02%
-- A late delivery makes a complaint ~12x more likely than
-- an on-time one.
-- ============================================================

SELECT
  DeliveryStatus,
  COUNT(*) AS total_orders,
  SUM(CustomerComplaint = 'Yes') AS complaints,
  ROUND(SUM(CustomerComplaint = 'Yes') / COUNT(*) * 100, 2) AS complaint_rate_pct
FROM deliveries
GROUP BY DeliveryStatus
ORDER BY complaint_rate_pct DESC;


-- ============================================================
-- 8. BUSINESS IMPACT — REPEAT CUSTOMERS
-- Result: On-Time 55.49% | Late 30.88% | Cancelled 29.39%
--         Failed 29.36%
-- Repeat customer rate nearly halves when a delivery is late.
-- ============================================================

SELECT
  DeliveryStatus,
  COUNT(*) AS total_orders,
  SUM(RepeatCustomer = 'Yes') AS repeat_customers,
  ROUND(SUM(RepeatCustomer = 'Yes') / COUNT(*) * 100, 2) AS repeat_rate_pct
FROM deliveries
GROUP BY DeliveryStatus
ORDER BY repeat_rate_pct DESC;


-- ============================================================
-- 9. SUPPORTING ANALYSIS — DELIVERY COST BY VEHICLE TYPE
-- Result: Truck €59.73 / 50.14km | Van €17.55 / 19.00km
--         Bike €4.96 / 4.25km
-- ============================================================

SELECT
  VehicleType,
  COUNT(*) AS total_orders,
  ROUND(AVG(DeliveryCostEUR), 2) AS avg_cost,
  ROUND(AVG(DistanceKM), 2) AS avg_distance
FROM deliveries
GROUP BY VehicleType
ORDER BY avg_cost DESC;
