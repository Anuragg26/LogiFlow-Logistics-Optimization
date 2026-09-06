LogiFlow — Delivery Operations Analytics & Bottleneck Diagnosis
A portfolio project simulating a real-world Business Analyst / Data Analyst engagement for a fictional German logistics company, LogiFlow Logistics GmbH. The company had a 15% late delivery rate and wanted to know why — this project traces that number back to its root causes using SQL and Power BI, and turns the findings into business recommendations.

The problem
LogiFlow was seeing a 15% late delivery rate across its six German warehouses (Berlin, Munich, Hamburg, Frankfurt, Cologne, Stuttgart), hurting customer satisfaction and repeat business. The question driving this project: is that 15% spread evenly across the network, or concentrated somewhere specific?

What I found
Hamburg is a systemic bottleneck. Its late delivery rate is 25.6%, nearly 3x Berlin's 9.3% (the best-performing warehouse). Hamburg's warehouse loading time (21 min) and order processing time (32 min) are roughly double every other warehouse — the delay happens before the parcel even leaves the building.
Four other routes are separate outliers. COL-R6, FRA-R1, MUN-R4, and STU-R2 all have late rates around 33-34%, despite their home warehouses performing normally — pointing to route-specific causes rather than a warehouse-wide issue.
Late delivery drives complaints. Complaint rate jumps from 3% (on-time) to 35% (late) to 69% (failed).
Late delivery costs repeat customers. Repeat-customer rate drops from 55.5% (on-time) to 30.9% (late) — a 24.6-point fall.
The problem is structural, not seasonal. The monthly late rate held steady between 14.4% and 15.6% all year, meaning this needs a real fix, not a wait-and-see approach.

Full write-up in 08_Insights and 09_Recommendations.

How this project was built
Business analysis — defined the business problem, mapped 7 stakeholders, and wrote a full requirements document with business rules (01_Business_Analysis, 02_Requirements)
Process mapping — documented the current ("As-Is") delivery process and a proposed ("To-Be") improved version in Draw.io (03_Process_Analysis)
Agile planning — ran this as a Scrum project in Jira, with 6 Epics and 9 user stories (04_Agile_Jira)
Data — a 105,000-row synthetic dataset covering a full year (Sept 2025 - Aug 2026) of delivery records, built with realistic data-quality issues (missing values) to practice cleaning (05_Data)
Database & analysis — loaded the data into MySQL and wrote SQL to find the patterns above (06_SQL)
Dashboard — built an interactive Power BI dashboard with custom DAX measures to visualize the findings (07_PowerBI)
Recommendations & presentation — turned the analysis into prioritized recommendations and a stakeholder-ready slide deck (09_Recommendations, 10_Presentation)
Tools used

MySQL · SQL · Power BI · DAX · Jira (Scrum) · Draw.io

Project structure
01_Business_Analysis/      Business problem statement, stakeholder analysis
02_Requirements/           Business requirements document
03_Process_Analysis/       As-Is / To-Be process diagrams
04_Agile_Jira/             Jira board screenshots (Scrum project, 6 Epics, 9 stories)
05_Data/                   Dataset (CSV) and data dictionary
06_SQL/                    All SQL queries with findings, from table creation to analysis
07_PowerBI/                Dashboard screenshot
08_Insights/               Key insights from the analysis
09_Recommendations/        Prioritized recommendations for management
10_Presentation/           Stakeholder presentation deck
Contact

Anurag Panwar Email: Anuragg.panwarr@gmail.com LinkedIn: linkedin.com/in/panwaranurag GitHub: github.com/Anuragg26
