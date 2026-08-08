# ZediMart: Implementation Roadmap

### Applied Business Intelligence Case Study — Independently Developed

---

Four phases, sequenced by what each action actually depends on, not by convenience. Phase 1 needs nothing from anyone outside the data team. Phase 2 depends on other teams responding. Phase 3 depends on what Phase 2 uncovers. Phase 4 only exists once the first three have something to monitor.

---

## Phase 1: Immediate Fixes

**Duration:** Week 1
**Depends on:** nothing. Every action here uses data already verified in this analysis.

| Activity | Traces To | Owner |
|---|---|---|
| Restock the 6 zero-stock store-product combinations | Recommendation 4 | Store Operations |
| Update the executive dashboard to show Sales and Orders as two separate, labeled figures instead of one combined total | Recommendation 2 | Data/BI Team |
| Identify the customers behind the High-value order segment and hand the list to Marketing | Recommendation 6 | Data/BI Team, Marketing |
| Update the data dictionary to document the FullName, Phone, and Email fields | Governance Note 1 | Data/BI Team |
| Document the missing-header-row convention for future data handoffs | Governance Note 2 | Data/BI Team |

**Exit criteria:** zero store-product combinations at zero stock. Dashboard no longer displays a single blended revenue figure. High-value segment list delivered to Marketing.

---

## Phase 2: Investigation and Escalation

**Duration:** Weeks 2 to 6
**Depends on:** response time from teams outside the data function. This phase cannot be accelerated by the data team alone.

| Activity | Traces To | Owner |
|---|---|---|
| Escalate the future-dated orders pattern (41.3% of all orders) to the Orders source system owner and request an explanation | Recommendation 3 | Data/BI Team, IT/Systems |
| Confirm with the source payment system whether an unpaid or pending order status exists upstream | Recommendation 7 | Data/BI Team, Finance |
| Begin data gathering for the restocking cadence review at the five highest-breach stores, starting with Branch 9 in Kano | Recommendation 4 | Inventory / Store Ops |
| Launch the tiered engagement strategy for the High-value segment identified in Phase 1 | Recommendation 6 | Marketing |

**Exit criteria:** a documented explanation for the future-dated orders, confirmed either as a system issue, scheduled orders, or data error. A confirmed answer on whether a pending payment state exists upstream. Restocking cadence data collected across the five target stores.

---

## Phase 3: Structural Change

**Duration:** Months 2 to 4
**Depends on:** findings from Phase 2. What gets built here is defined by what Phase 2 uncovers, not decided in advance.

| Activity | Traces To | Owner |
|---|---|---|
| Add a product lifecycle status field to the Products schema | Recommendation 5 | Data/BI Team |
| Implement restocking cadence changes at the five highest-breach stores, based on what Phase 2's investigation found | Recommendation 4 | Inventory / Store Ops |
| If Phase 2 confirms Sales and Orders describe genuinely separate systems, formalize permanent separate reporting. If Phase 2 finds they should reconcile, build the corrected join logic | Recommendation 2, Recommendation 3 | Data/BI Team |
| If Phase 2 confirms a pending payment state exists upstream, build it into the Orders data model | Recommendation 7 | Data/BI Team |

**Exit criteria:** schema updated with a working product status field. Measurable reduction in the 154-combination reorder breach count. Sales and Orders reporting relationship formally resolved, not left as an open question.

---

## Phase 4: Validation and Monitoring

**Duration:** Month 3 onward, ongoing
**Depends on:** Phases 1 through 3 having something in place to monitor.

| Activity | Traces To | Owner |
|---|---|---|
| Re-run the customer duplication and completeness audit quarterly as new customers are added | Recommendation 1 | Data/BI Team |
| Track the High-value segment's revenue share over time to confirm the engagement strategy is working, not just launched | Recommendation 6 | Marketing, Data/BI Team |
| Monitor the reorder breach count monthly across all ten stores, not only the original five | Recommendation 4 | Inventory / Store Ops |
| Re-verify that no single combined revenue figure has quietly reappeared on any dashboard | Recommendation 2 | Data/BI Team |

**Exit criteria:** this phase has no end date. It is the ongoing discipline that keeps Phases 1 through 3 from silently reverting.

---

## Section Summary

Every action in this roadmap is either already actionable from data in hand, or explicitly waiting on a named team's response before it can move. Nothing is scheduled to start before its actual dependency is resolved. Phase 3's content is deliberately left conditional on Phase 2's findings rather than pre-decided, because committing to a fix before the investigation concludes would repeat the same mistake this entire analysis was built to catch: treating an assumption as a confirmed fact.

---

*ZediMart Implementation Roadmap*
*Applied Business Intelligence Case Study — Independently Developed*

### Document Relationships

- **Evidence Source:** Business Recommendations
- **Note:** Phase 3 of this roadmap is deliberately left conditional on Phase 2's findings rather than pre-decided, so this document's own internal sequencing carries the same evidence-before-conclusion standard as its source documents
