# ZediMart: Executive Prioritization Matrix

### Applied Business Intelligence Case Study — Independently Developed

---

## How This Matrix Works

Every opportunity and risk from the Risk and Opportunity Register is plotted here by two questions only: how much it matters, and how much it costs to act on. That produces four honest categories. Nothing is placed here to pad the page, if a category has fewer entries than the others, that is the accurate picture, not a gap to fill.

---

## QUICK WINS
### High Impact, Low Effort. Act on these first

| Action | Traces To | Why It's Fast |
|---|---|---|
| Report Sales and Orders as two separate, clearly labeled figures instead of one combined total | R1, O1 | A reporting and labeling change, not a data or system fix. Can be implemented in the next dashboard refresh |
| Restock the 6 store-product combinations currently at zero stock | R3 | The exact products and stores are already identified. This is a procurement action, not further analysis |
| Launch a tiered engagement strategy around the High-value order segment | O2 | The segment is already defined: 216 orders, 21.6% of volume, 37.0% of revenue. Marketing can act on this immediately |

---

## MAJOR PROJECTS
### High Impact, High Effort. Plan and resource these deliberately

| Action | Traces To | Why It Takes Longer |
|---|---|---|
| Investigate the 41.3% of orders dated after the analysis date with the source system owner | R2 | Requires cross-team escalation and likely a system-level explanation before any fix can be trusted |
| Conduct a structural review of restocking cadence at the five highest-breach stores, led by Branch 9 in Kano | O3, R3 | 154 store-product combinations across 10 stores. This is a process redesign, not a single restock order |
| Add a product lifecycle or status field to the Products schema | O5, R4 | A schema change with downstream effects on every query and report that touches product status going forward |

---

## SUPPORTING ACTIONS
### Lower Impact, Low Effort. Worth doing, not worth delaying anything else for

| Action | Traces To | Note |
|---|---|---|
| Update the data dictionary to document FullName, Phone, and Email fields | R6 | A documentation fix. Low effort, closes a real governance gap |
| Document the missing-header-row convention for anyone handling these files going forward | R7 | Prevents the exact data loss this analysis had to work around |
| Formalize the validated customer base as a ready-to-use asset for Marketing | O4 | The validation work is already done. This is a handoff, not new analysis |

---

## MONITOR
### Depends on further information before it can be sized

| Action | Traces To | What's Needed First |
|---|---|---|
| Confirm with the source system whether an unpaid or pending order status exists upstream | R5 | Cannot size the effort or impact of this until it's known whether the gap is in the data model or the business process itself |

---

## Sequencing Recommendation

**Now:** all three Quick Wins. None of them require new data collection or system access, they use findings already sitting in the SQL library.

**Next:** open the three Major Projects in parallel, since each depends on a different team (source system owner, store operations, data/BI). Sequencing them one after another would waste the time each one spends waiting on another team's response.

**Alongside:** the three Supporting Actions can be completed by whoever has spare capacity during the Major Projects, they do not block or depend on anything else on this list.

**Watch:** R5 stays open until the source system question is answered. It may turn out to belong in Quick Wins, Major Projects, or nowhere at all, that answer determines which.

---

*ZediMart Executive Prioritization Matrix*
*Applied Business Intelligence Case Study — Independently Developed*

### Document Relationships

- **Evidence Source:** Executive Risk and Opportunity Register
- **Feeds Into:** Business Recommendations, Implementation Roadmap
