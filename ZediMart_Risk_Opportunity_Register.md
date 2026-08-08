# ZediMart: Executive Risk and Opportunity Register

### Applied Business Intelligence Case Study — Independently Developed

---

## OPPORTUNITY REGISTER

| # | Opportunity | Evidence | Source Query | Priority | Owner |
|---|---|---|---|---|---|
| O1 | Restore confidence in executive revenue reporting by reporting Sales and Orders separately until their time periods can be reconciled | Sales spans Nov 2024 to Apr 2025. Orders spans all of 2026. Zero overlapping days between the two revenue-bearing tables | Query 7, Query 12 | HIGH | Data/BI Team |
| O2 | Build a tiered engagement strategy around the High-value order segment | 216 orders (21.6% of volume) generate N3,863,184, 37.0% of total order revenue. This segment is already disproportionately valuable without any targeted strategy in place | Query 6 | HIGH | Marketing |
| O3 | Prioritize restocking at the five stores carrying the heaviest reorder breach load, rather than treating all 154 breaches as equal priority | ZediMart Branch 9 (Kano) carries 21 breaches, the highest of any store, followed by Branch 8 and Branch 2 (Lagos, 18 each), then Branch 6 (Port Harcourt) and Branch 10 (Lagos) at 15 each | Query 10 | MEDIUM | Inventory / Store Ops |
| O4 | Use the customer base as a reliable foundation for marketing and segmentation work without further cleanup cost | 500 of 500 customer records are complete and unique, zero duplicate IDs, zero duplicate emails, zero duplicate phone numbers, zero missing fields, confirmed rather than assumed | Query 1, Query 2 | MEDIUM | Marketing |
| O5 | Close the product lifecycle gap by adding a status field to the Products schema | No field currently distinguishes active from discontinued products. The only available proxy (zero stock across every store) returns no candidates, meaning the business currently cannot tell whether it has no discontinued products or simply cannot see them | Query 9 | MEDIUM | Data/BI Team |

---

## RISK REGISTER

| # | Risk | Description | Impact | Probability | Risk Level | Mitigation |
|---|---|---|---|---|---|---|
| R1 | Executive revenue figures misrepresent two disconnected reporting periods as one continuous stream | Combining Sales (N7,447,707) and Orders (N10,447,947) into a single N17,895,654 figure, the natural first move for a dashboard, implies one continuous revenue timeline that the underlying data does not support | HIGH: any dashboard built on the naive combined figure misleads leadership about actual current-period performance | HIGH: this is the default behavior of most reporting tools unless explicitly prevented | CRITICAL | Report Sales and Orders as separate, clearly labeled figures until the source systems generating each table are reconciled or reconfirmed as genuinely separate data streams |
| R2 | 41.3% of all orders are dated after the date this analysis was performed | 413 of 1,000 orders carry a date later than 2026-07-30. This raises a direct question about data entry integrity, system clock configuration, or the presence of forward-dated placeholder records | HIGH: current order volume and revenue cannot be taken at face value until this is explained | HIGH: affects nearly half of the entire Orders table | CRITICAL | Confirm with the source system owner whether future-dated orders reflect scheduled/recurring orders, a system clock issue, or test data before these records are used in any current-period report |
| R3 | Six store-product combinations are at zero stock right now, inside a broader pattern of 154 combinations below reorder level | Immediate stockouts risk lost sales and customer dissatisfaction at the point of sale. The broader 154-combination pattern (15.4% of all inventory records) signals a restocking cadence that is not keeping pace with demand | HIGH for the 6 immediate stockouts, MEDIUM for the broader pattern | HIGH: already occurring, not a projection | HIGH | Immediate restock at the 6 zero-stock combinations. Structural review of restocking cadence at the five highest-breach stores, led by Branch 9 in Kano |
| R4 | The data model cannot confirm which products are discontinued | The stakeholder request to flag discontinued products cannot be fulfilled with certainty, since no lifecycle or status field exists. The only proxy available (zero stock everywhere) currently shows no candidates | MEDIUM: the business cannot distinguish "no discontinued products" from "discontinued products we cannot see" | MEDIUM: becomes more likely to matter as the product catalogue grows or ages | MEDIUM | Add a product status field to the schema. Until then, do not report on discontinued products as a confirmed category, only as an unanswerable question |
| R5 | The data model cannot confirm which orders remain unpaid | Every order in this dataset already carries a completed payment method (POS, Transfer, or Cash). No pending or unpaid status exists anywhere in the Orders table, meaning Finance's request for a payment-completeness view cannot be answered from this data | MEDIUM: Finance may be operating without visibility into incomplete transactions if they exist upstream and are not being captured here | MEDIUM: depends on whether pending payments genuinely do not occur, or simply are not recorded | MEDIUM | Confirm with the source system whether an unpaid/pending order state exists upstream and, if so, ensure it flows into this dataset |
| R6 | Customer records contain full name, phone number, and email address that are not documented in the published data description | Three fields present in the actual Customers table (FullName, Phone, Email) do not appear in the official data dictionary. Anyone relying on the published description would not know these fields exist | LOW to MEDIUM: a documentation and governance gap, independent of whether the underlying data is fictional or real | MEDIUM: likely to recur if the data dictionary is not updated alongside the schema | LOW-MEDIUM | Update the data dictionary to reflect all fields actually present in each table before this dataset or its structure is reused |
| R7 | Source files were supplied without header rows | All six CSVs begin directly with data, no column titles. Any tool or person loading these files without knowing this convention silently loses the first record of every table | LOW: a one-time data loss risk during onboarding, not an ongoing one once documented | LOW: only affects first-time handling of the raw files | LOW | Document this explicitly wherever the raw files are distributed, and confirm all downstream loads account for it |

---

## SUMMARY MATRIX

| Priority | Count | Opportunities | Risks |
|---|---|---|---|
| Critical | 1 | None | R1: Naive revenue combination |
| High | 3 | O1, O2 | R2, R3 |
| Medium | 4 | O3, O4, O5 | R4, R5 |
| Low to Medium | 1 | None | R6 |
| Low | 1 | None | R7 |

**Revenue concentration confirmed:** 216 orders (21.6% of volume) account for 37.0% of total order revenue (N3,863,184 of N10,447,947).

**Reporting integrity confirmed:** zero overlapping days exist between Sales and Orders, the two tables most likely to be combined into a single executive revenue figure.

**Data completeness confirmed:** 500 of 500 customer records pass full duplication and completeness checks, and 1,000 of 1,000 orders reference valid customers, with zero orphaned records anywhere in the dataset.

Every figure in this register traces directly to a query in the ZediMart SQL Query Library, executed and verified against a live PostgreSQL database. Nothing here is estimated or assumed.

---

*ZediMart Executive Risk and Opportunity Register*
*Applied Business Intelligence Case Study — Independently Developed*

### Document Relationships

- **Evidence Source:** ZediMart SQL Query Library
- **Feeds Into:** Executive Prioritization Matrix, Business Recommendations
