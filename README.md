# LogiFlow — Delivery Operations Analytics & Bottleneck Diagnosis

> **Turning 105,000 delivery records into a data-backed diagnosis of why 15% of deliveries were late — and what management should do about it.**

**LogiFlow Logistics GmbH** is a fictional German logistics company created for this portfolio project. The business was experiencing a **15% late-delivery rate** across six warehouses and needed to understand where the problem originated.

This project simulates a complete **Business Analyst / Data Analyst engagement** — from defining the business problem and requirements to analysing operational data, identifying bottlenecks, building a Power BI dashboard, and translating findings into actionable recommendations.

### 🔎 Project at a Glance

|                      |                                                                       |
| -------------------- | --------------------------------------------------------------------- |
| **Industry**         | Logistics & Delivery Operations                                       |
| **Records analysed** | 105,000                                                               |
| **Warehouses**       | 6 across Germany                                                      |
| **Period**           | September 2025 – August 2026                                          |
| **Primary tools**    | MySQL · SQL · Power BI · DAX                                          |
| **Business focus**   | Late deliveries · Bottlenecks · Customer impact · Process improvement |

---

## 📊 Dashboard

**Interactive Power BI dashboard:**
[View Dashboard](LogiFlow-Logistics-Optimization/07_PowerBI/LogiFlow_Dashboard_Screenshot.png)

The dashboard provides management with a single view of:

* Late-delivery performance
* Warehouse and route comparisons
* Delivery-status breakdowns
* Monthly performance trends
* Operational bottlenecks
* Key performance indicators

---

# 🎯 The Business Problem

LogiFlow was experiencing a **15% late-delivery rate** across its six German warehouses:

**Berlin · Munich · Hamburg · Frankfurt · Cologne · Stuttgart**

Management knew deliveries were being delayed, but did not know **where the problem was occurring or what was causing it**.

The central business question was:

> **Is the 15% late-delivery rate spread evenly across the network, or is it concentrated in specific warehouses or routes?**

The objective of this project was to answer that question using data — and turn the findings into clear actions for management.

---

# 🔍 What the Analysis Found

### 1. Hamburg is a systemic warehouse bottleneck

Hamburg has a **25.6% late-delivery rate**, nearly three times Berlin's **9.3%**, the best-performing warehouse.

The operational data points to a warehouse-level problem:

* **21 min** average warehouse loading time
* **32 min** average order processing time
* Both are roughly double the levels seen across the other warehouses

This indicates that the delay is occurring **before the parcel leaves the warehouse**, pointing toward internal warehouse operations rather than traffic or driving distance.

---

### 2. Four routes are separate operational outliers

Four routes significantly underperform even though their home warehouses are otherwise performing normally:

| Route      | Warehouse | Late Rate |
| ---------- | --------- | --------: |
| **COL-R6** | Cologne   |     33.8% |
| **FRA-R1** | Frankfurt |     33.6% |
| **MUN-R4** | Munich    |     33.5% |
| **STU-R2** | Stuttgart |     33.5% |

This suggests these are **route-specific problems**, rather than warehouse-wide problems.

Potential areas for investigation include:

* Driver assignment
* Traffic conditions
* Route characteristics
* Delivery distance

A warehouse-wide solution would therefore not address these four routes.

---

### 3. Late deliveries strongly affect customer complaints

Customer complaints increase substantially as delivery performance deteriorates:

**3%** → on-time
**35%** → late
**69%** → failed

This demonstrates that delivery performance is not simply an operational KPI — it has a direct relationship with customer experience.

---

### 4. Late deliveries affect customer retention

The repeat-customer rate falls from:

**55.5%** for on-time deliveries
to
**30.9%** for late deliveries.

That's a **24.6 percentage-point decline**.

This connects operational delivery performance directly to **customer retention and potential revenue impact**.

---

### 5. The problem is structural, not seasonal

The monthly late-delivery rate remained between approximately **14.4% and 15.6% throughout the year**.

This means the problem is not limited to a particular month or season.

> **The data suggests a persistent operational issue that requires intervention rather than a wait-and-see approach.**

---

# 🛠️ How the Project Was Built

This project was designed as an end-to-end **Business Analyst + Data Analyst workflow**.

### 01 — Business Analysis

Defined the business problem, identified and mapped **7 stakeholders**, and documented the project objectives.

📁 [01_Business_Analysis](LogiFlow-Logistics-Optimization/01_Business_Analysis)

---

### 02 — Requirements Engineering

Created a structured requirements document covering the business needs and expected analytical outcomes.

📁 [02_Requirements](LogiFlow-Logistics-Optimization/02_Requirements)

---

### 03 — Process Analysis

Mapped the existing **As-Is delivery process** and designed a proposed **To-Be process** to identify opportunities for improvement.

Created using **Draw.io**.

📁 [03_Process_Analysis](LogiFlow-Logistics-Optimization/03_Process_Analysis)

---

### 04 — Agile & Jira

Managed the project using a simulated **Scrum workflow in Jira**, including:

* 6 Epics
* 9 User Stories
* Backlog structure
* Agile project organisation

📁 [04_Agile_Jira](LogiFlow-Logistics-Optimization/04_Agile_Jira)

---

### 05 — Data

Worked with a **105,000-row synthetic dataset** representing one full year of delivery operations from September 2025 to August 2026.

The dataset intentionally included realistic data-quality issues such as missing values to simulate a real-world analytics environment.

📁 [05_Data](LogiFlow-Logistics-Optimization/05_Data)

---

### 06 — SQL Analysis

Loaded the dataset into **MySQL** and performed data cleaning and analytical queries.

Analysis covered:

* Warehouse performance
* Route performance
* Late-delivery rates
* Loading times
* Order-processing times
* Customer outcomes
* Operational trends

📁 [06_SQL](LogiFlow-Logistics-Optimization/06_SQL)

---

### 07 — Power BI Dashboard

Built an interactive **Power BI dashboard** using custom **DAX measures** to make the findings accessible to business stakeholders.

📁 [07_PowerBI](LogiFlow-Logistics-Optimization/07_PowerBI)

---

### 08 — Insights

Consolidated the analytical findings into a structured set of business insights, separating warehouse-level issues from route-level outliers.

📁 [08_InsightsLogiFlow-Logistics-Optimization/08_Insights)

---

### 09 — Recommendations

Translated the findings into **prioritised, business-impact-driven recommendations** for management.

📁 [09_Recommendations](LogiFlow-Logistics-Optimization/09_Recommendations)

---

### 10 — Stakeholder Presentation

Created a stakeholder-ready presentation summarising the problem, findings, business impact, and recommended actions.

📁 [10_Presentation](LogiFlow-Logistics-Optimization/10_Presentation)

---

# 💡 Key Business Recommendations

Based on the analysis, two different problems require two different approaches.

### 1. Review Hamburg's warehouse operations

Investigate:

* Staffing levels
* Shift patterns
* Workflow layout
* Loading processes
* Order-processing procedures

Benchmark Hamburg against **Berlin**, the best-performing warehouse.

### 2. Investigate the four outlier routes

Review **COL-R6, FRA-R1, MUN-R4 and STU-R2** individually.

Focus on:

* Driver assignment
* Traffic
* Route characteristics
* Delivery distance

### 3. Treat delivery performance as a customer-retention issue

The significant difference in repeat-customer rates suggests that late deliveries should be treated as more than an operational problem.

### 4. Monitor performance continuously

Refresh the Power BI dashboard monthly to determine whether operational interventions are actually improving delivery performance.

---

# 🧰 Tools & Technologies

**Data & Database**

`MySQL` · `SQL`

**Business Intelligence**

`Power BI` · `DAX`

**Business Analysis**

`Requirements Analysis` · `Process Analysis` · `Stakeholder Analysis`

**Agile**

`Jira` · `Scrum`

**Process Mapping**

`Draw.io`

---

# 📁 Project Structure

```text
LogiFlow/
│
├── 01_Business_Analysis/
│   └── Business problem statement & stakeholder analysis
│
├── 02_Requirements/
│   └── Business requirements document
│
├── 03_Process_Analysis/
│   └── As-Is / To-Be process diagrams
│
├── 04_Agile_Jira/
│   └── Jira Scrum board, Epics & User Stories
│
├── 05_Data/
│   ├── Dataset (CSV)
│   └── Data Dictionary
│
├── 06_SQL/
│   └── SQL queries from database creation to analysis
│
├── 07_PowerBI/
│   └── Power BI dashboard
│
├── 08_Insights/
│   └── Key analytical findings
│
├── 09_Recommendations/
│   └── Prioritised business recommendations
│
└── 10_Presentation/
    └── Stakeholder presentation deck
```

---

# 🎓 What This Project Demonstrates

This project demonstrates my ability to:

* Translate a **business problem into analytical questions**
* Identify and document **stakeholders and requirements**
* Map and analyse **business processes**
* Work within an **Agile/Scrum framework**
* Clean and analyse large datasets using **SQL**
* Identify operational **bottlenecks and patterns**
* Build interactive **Power BI dashboards**
* Communicate data findings to **non-technical stakeholders**
* Connect operational metrics to **customer and business impact**
* Turn analysis into **prioritised recommendations**

---

# 👤 Contact

**Anurag Panwar**

📧 [Anuragg.panwarr@gmail.com](mailto:Anuragg.panwarr@gmail.com)

🔗 [LinkedIn](https://linkedin.com/in/panwaranurag)

💻 [GitHub](https://github.com/Anuragg26)
