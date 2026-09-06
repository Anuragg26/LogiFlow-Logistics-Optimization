# LogiFlow Delivery Data — Data Dictionary

**File:** LogiFlow_Delivery_Data.csv
**Rows:** 105,000 orders
**Period:** Sept 1, 2025 – Aug 31, 2026 (full year)

| Column | Description |
|---|---|
| OrderID | Unique order identifier |
| OrderDate | Date the order was dispatched |
| OrderDateTime | Full dispatch timestamp |
| Region | One of 6 German regions: Berlin, Hamburg, Munich, Frankfurt, Cologne, Stuttgart |
| Warehouse | Warehouse that processed the order (one per region) |
| Route | Named delivery route within the region |
| VehicleID | Vehicle used for the delivery |
| VehicleType | Van, Truck, or Bike |
| DriverID | Driver assigned to the delivery |
| DistanceKM | Delivery distance in kilometers |
| ParcelWeightKG | Weight of the parcel |
| OrderProcessingTimeMin | Time (minutes) to process the order before loading (BR-006 / FR-007) |
| WarehouseLoadingTimeMin | Time (minutes) to load the vehicle (BR-006 / FR-007) |
| VehicleUtilizationPct | % of vehicle capacity used on this run (BRL-006) |
| PlannedDeliveryTime | Promised delivery timestamp |
| ActualDeliveryTime | Actual delivery timestamp (blank if Failed/Cancelled) |
| DeliveryStatus | On-Time / Late / Failed / Cancelled (BRL-001, BRL-002, BRL-005) |
| DeliveryCostEUR | Total delivery cost — fuel/distance, vehicle, weight, processing overhead (BRL-007) |
| CustomerComplaint | Yes/No — whether the customer complained about this order (BR-010 / FR-011) |
| RepeatCustomer | Yes/No — proxy signal for repeat business tied to this order's outcome |
| FlaggedInvalid | Yes/No — rows with intentionally injected missing/invalid data, for data validation practice (BRL-010) |

## Known patterns in this data (for your own investigation — don't just state these, verify them yourself with SQL/Power BI)
- One warehouse has a consistently longer processing/loading time than the others.
- A small number of named routes have a significantly higher late-delivery rate than the rest.
- Late and Failed orders have a much higher customer complaint rate than On-Time orders.
