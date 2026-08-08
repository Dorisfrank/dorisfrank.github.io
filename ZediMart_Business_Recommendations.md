# ZediMart: Business Recommendations

### Applied Business Intelligence Case Study — Independently Developed

---

Seven recommendations follow, one or two for each stakeholder question. Each recommendation traces directly to a specific entry in the Risk and Opportunity Register and a corresponding priority in the Executive Prioritization Matrix. Rather than applying predefined retail best practices, each recommendation is derived from evidence confirmed during this analysis.

---

## Part 1: Customer Intelligence

### Recommendation 1: Formalize the validated customer list as the single source of truth for cross-departmental use

*Traces to: O4, Query 1, Query 2*

**What I analysed:** all 500 customer records, checked for duplicate IDs, duplicate emails, duplicate phone numbers, and missing values across every field.

**What I found:** zero duplication, zero missing values. The customer base is already clean.

> **Business Insight**
>
> The brief assumed this data needed deduplication before it could be trusted. It did not. The more valuable outcome here is not a cleanup, it is confirmation that Marketing, Finance, and Store Operations can already work from one shared customer list without separate, department-specific versions drifting apart over time.

**Recommendation:** adopt this validated list as the single reference customer table across departments, rather than each team maintaining its own extract.

**Expected impact:** removes the risk of departments reporting different customer counts or contact details because they are working from different, unsynced copies of the same underlying data.

**Success metric:** zero variance between the customer count or contact details used in Marketing's next campaign and the count used in this analysis.

---

## Part 2: Revenue Interpretation

### Recommendation 2: Report Sales and Orders as two separate, clearly labeled figures, not one combined total

*Traces to: R1, O1, Query 7, Query 12*

**What I analysed:** the full date range and revenue total of both the Sales table and the Orders table.

**What I found:** Sales spans November 2024 to April 2025. Orders spans all of 2026. The two tables share zero overlapping days. Combining them produces a figure of N17,895,654 that represents two periods that never coexisted.

> **Business Insight**
>
> The natural instinct on any executive dashboard is to sum every revenue-bearing table into one headline number. Here, that instinct produces a figure that is technically additive but not meaningfully true.

**Recommendation:** until the relationship between these two tables is confirmed with the source systems, report them as two distinct figures with their date ranges clearly labeled, never as one combined total.

**Expected impact:** prevents leadership from making a decision based on a revenue figure that overstates or misrepresents current performance.

**Success metric:** the next executive dashboard iteration shows Sales and Orders as separate, dated figures, with no single blended revenue KPI combining both.

---

### Recommendation 3: Escalate the future-dated orders pattern before treating 2026 order volume as current performance

*Traces to: R2, Query 7 (date range finding)*

**What I analysed:** every order date against the date this analysis was performed.

**What I found:** 413 of 1,000 orders, 41.3%, carry a date later than the analysis date itself.

> **Business Insight**
>
> This is not a rounding error or a handful of stray records. It affects nearly half the Orders table, which means "current order volume" as a phrase cannot be answered confidently from this data until the cause is understood, a system clock issue, scheduled or recurring orders, or placeholder records.

**Recommendation:** raise this directly with whoever owns the Orders source system before any current-period order metric is presented to leadership.

**Expected impact:** avoids reporting an order volume or revenue trend that is inflated or distorted by records that have not actually occurred yet.

**Success metric:** a documented explanation for the future-dated orders, and, if needed, a corrected Orders dataset with the cause resolved.

---

## Part 3: Inventory Evidence

### Recommendation 4: Restock the six zero-stock combinations immediately, then review restocking cadence at the five highest-breach stores

*Traces to: O3, R3, Query 10*

**What I analysed:** current stock levels for all 1,000 store-product combinations against each product's defined reorder level.

**What I found:** 6 combinations are at zero stock right now. A further 154 of 1,000 combinations, 15.4%, sit below their reorder level. ZediMart Branch 9 in Kano carries the heaviest load at 21 breaches, followed by Branch 8 and Branch 2 in Lagos at 18 each.

> **Business Insight**
>
> The 6 zero-stock items are an immediate, isolated fix. The broader 154-combination pattern, concentrated in five specific stores, is a process problem, not six unrelated stockouts.

**Recommendation:** action the 6 zero-stock restocks this week. Separately, commission a structural review of restocking cadence at the five highest-breach stores, starting with Branch 9 in Kano.

**Expected impact:** reduces lost sales from immediate stockouts, and addresses the underlying cadence issue before it produces the next set of zero-stock items.

**Success metric:** zero store-product combinations at zero stock within one week. A measurable reduction in the 154-combination reorder breach count within one quarter.

---

### Recommendation 5: Add a product lifecycle status field to the Products schema

*Traces to: O5, R4, Query 9*

**What I analysed:** whether any field in the Products table could confirm which products are discontinued, as the original business question asked.

**What I found:** no such field exists. The only available proxy, zero stock across every store, currently returns no candidates, which could mean there are no discontinued products, or that discontinued products are not being tracked at all.

> **Business Insight**
>
> This is a genuine data model gap, not a data quality issue. No amount of further querying against the current schema will answer the original question with certainty.

**Recommendation:** add a status field (active, discontinued, seasonal, or similar) to the Products table before this question is asked again.

**Expected impact:** enables accurate discontinued-product reporting going forward, and closes a gap that currently leaves the business unable to distinguish "no problem" from "no visibility."

**Success metric:** the next inventory reconciliation query can answer the discontinued-product question directly, without relying on a proxy.

---

## Part 4: Executive Reporting

### Recommendation 6: Build a tiered engagement strategy around the High-value order segment

*Traces to: O2, Query 6*

**What I analysed:** the distribution of order value across all 1,000 orders, classified into High, Medium, and Low bands relative to the dataset average.

**What I found:** 216 orders, 21.6% of total volume, generate N3,863,184, 37.0% of total order revenue. This segment already carries disproportionate value without any targeted strategy in place.

> **Business Insight**
>
> The highest-value fifth of orders is producing more than a third of revenue on its own. That concentration is worth protecting and growing deliberately rather than treating every order the same.

**Recommendation:** identify the customers behind this High-value segment and build a retention and growth strategy specifically around them, before this concentration is left to chance.

**Expected impact:** protects and potentially grows the revenue share already coming from ZediMart's most valuable customers.

**Success metric:** an identified, named High-value customer segment with its own engagement plan, tracked separately from general order volume.

---

### Recommendation 7: Confirm whether an unpaid or pending payment status exists upstream before Finance treats payment data as complete

*Traces to: R5, Query 5*

**What I analysed:** the payment_method field across all 1,000 orders.

**What I found:** every order carries a completed payment method, POS, Transfer, or Cash. No pending or unpaid status exists anywhere in this table, despite the original request specifically asking for orders "including those not yet paid."

> **Business Insight**
>
> Either ZediMart genuinely has no incomplete transactions, which would be unusual for a retail operation of this size, or incomplete transactions exist upstream and are simply not flowing into this dataset.

**Recommendation:** confirm directly with the source payment system whether a pending or unpaid state exists before Finance relies on this table as a complete view of payment status.

**Expected impact:** prevents Finance from underestimating outstanding or at-risk revenue that may exist but is currently invisible in this data.

**Success metric:** a confirmed answer, either the pending state does not exist in ZediMart's operations, or it exists and a path is defined to include it in future reporting.

---

## Documentation and Governance Notes

Two smaller items surfaced during this analysis that do not warrant full recommendation treatment but should not be lost:

- **Customer records contain full name, phone number, and email address that are not listed in the published data description.** The data dictionary should be updated to reflect every field actually present in each table.
- **All six source files were supplied without header rows.** This should be documented explicitly wherever these files are shared, so the first record of each table is not silently lost during future loads.

---

## Section Summary

Every recommendation above traces to a specific, executed query in the ZediMart SQL Query Library, not to assumption or pre-written guidance. Three can be acted on immediately using evidence already available. Three depend on coordination with source-system owners before they can be resolved with confidence. One addresses a structural gap in the data model itself. Collectively, these recommendations are evidence-led responses to the findings in this analysis, rather than predetermined actions inherited from the original case study brief.

---

*ZediMart Business Recommendations*
*Applied Business Intelligence Case Study — Independently Developed*

### Document Relationships

- **Evidence Source:** Executive Risk and Opportunity Register and Executive Prioritization Matrix (jointly, not either alone)
- **Feeds Into:** Implementation Roadmap
