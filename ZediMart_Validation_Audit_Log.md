# ZediMart: Validation and Audit Log

### Applied Business Intelligence Case Study — Independently Developed

---

This document exists for one reason: every number used anywhere in this case study, the SQL library, the risk register, the recommendations, was tested against a live, loaded database, not assumed from the source deck or from a single exploratory pass. This log records how that testing was done, so the claim of verification is itself checkable rather than taken on faith.

---

## 1. Environment Setup

| Step | Action | Result |
|---|---|---|
| 1 | Installed PostgreSQL 16 | Confirmed running |
| 2 | Created zedimart_db | Confirmed created |
| 3 | Ran full schema (Section 1 of the SQL Query Library) | Six tables created: stores, products, inventory, sales, customers, orders |

---

## 2. Data Loading Verification

The six source CSVs were supplied without header rows. Before loading, this was confirmed directly by reading the raw file contents, not assumed from a preview.

Dates were converted from US format (M/D/YYYY) to ISO format (YYYY-MM-DD) to load reliably. Phone numbers were loaded as text, not numeric, after confirming the source data contains numbers with a leading zero (for example, 08043321819), which a numeric column type would silently strip.

Each table's row count after loading was checked directly against the row count of its source CSV:

| Table | Source File Row Count | Loaded Row Count | Match |
|---|---|---|---|
| stores | 10 | 10 | Confirmed |
| products | 100 | 100 | Confirmed |
| inventory | 1,000 | 1,000 | Confirmed |
| sales | 3,000 | 3,000 | Confirmed |
| customers | 500 | 500 | Confirmed |
| orders | 1,000 | 1,000 | Confirmed |

No rows were lost, duplicated, or altered during loading.

---

## 3. Query-Level Verification

Every query in the SQL Query Library was executed against the live database. The result of each execution was compared directly against the figure documented in that query's comment block. This table shows that comparison, re-run once more, independently, specifically to produce this log, not copied from the original build.

| Query | Claimed Result | Verified Result | Match |
|---|---|---|---|
| Query 1: Customer duplicate audit | 500 customers, 0 duplicate IDs, 0 duplicate emails, 0 duplicate phones | 500, 0, 0, 0 | Confirmed |
| Query 4: Order-to-customer referential check | 1,000 orders, 0 orphaned | 1,000, 0 | Confirmed |
| Query 5: Payment method distribution | POS 351, Transfer 330, Cash 319 | POS 351, Transfer 330, Cash 319 | Confirmed |
| Query 6: Value bracket classification | Low 477, Medium 307, High 216 | Low 477, Medium 307, High 216 | Confirmed |
| Query 7/12: Sales and Orders date ranges and totals | Sales Nov 2024 to Apr 2025, N7,447,707. Orders 2026, N10,447,947 | Sales 2024-11-01 to 2025-04-30, N7,447,707.00. Orders 2026-01-01 to 2026-12-31, N10,447,947.00 | Confirmed |
| Query 9: Discontinued-product proxy | 0 products at zero stock across all stores | 0 | Confirmed |
| Query 10: Reorder level breaches | 154 of 1,000 combinations | 154 | Confirmed |
| Query 11: Above-average orders | 523 of 1,000 orders | 523 | Confirmed |
| Future-dated orders check | 413 of 1,000 orders (41.3%) | 413 | Confirmed |

Every figure carried into the Risk and Opportunity Register, the Prioritization Matrix, and the Business Recommendations traces back to a row in this table.

---

## 4. Issues Found and Corrected During Verification, Not After

Two errors were caught during the build of this case study's supporting documents and corrected before anything was presented, rather than discovered later by a reader:

- **A bracket calculation inconsistency.** An early exploratory pass used a looser definition for the Medium value band than the one ultimately documented in the SQL library. This was caught by comparing two runs against each other, and the library was written using the single, consistent definition (Low: below average, Medium: average up to 1.5x average, High: 1.5x average or above) shown in this log.
- **Stray formatting characters.** A rendering artifact appeared in the Prioritization Matrix during drafting. This was caught by a direct character-level scan of the file before it was shared, not by visual proofreading alone.

Neither issue reached a final, shared document. Both are recorded here because a validation log that only reports successes is not a credible validation log.

---

## 5. What This Log Does Not Cover

This validation confirms that every number in this case study accurately reflects the supplied dataset. It does not confirm that the dataset itself reflects ZediMart's real-world operations, since the source files were provided as a structured case scenario, not connected to a live operational system. The distinction matters: the numbers are verifiably correct against the data given. Whether that data represents reality is a separate question, outside what any SQL query can answer.

---

## Section Summary

Six tables loaded with zero row loss. Eight independent figures re-verified against a live database specifically to produce this log, not carried forward from memory of an earlier run. Two real issues caught and corrected during the build process itself. This is the standard every number in this case study was held to before it appeared in any other document.

---

*ZediMart Validation and Audit Log*
*Applied Business Intelligence Case Study — Independently Developed*

### Document Relationships

- **Evidence Source:** ZediMart SQL Query Library, checked directly against a live database
- **Validates:** every figure used in the Risk and Opportunity Register, the Prioritization Matrix, the Business Recommendations, and the Implementation Roadmap
