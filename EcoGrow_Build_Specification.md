# EcoGrow: Master Build Specification
### A single source of truth for the report, the six tool workspaces, and the golden-thread traceability chain

---

## HOW TO USE THIS DOCUMENT

This is not a report. It is the specification the report is built from.

Every heading below defines a place where real content goes: a real stakeholder name, a real RACI assignment, a real sprint outcome, a real KPI figure. Nothing in this document should be read as a claim that any of that work has happened yet.

Where I've included example row structures, they exist to show the shape of the data expected, not the data itself. I've marked every one of those clearly.

The rule that keeps everything aligned: **nothing gets written into any of the 9 report sections, or into Jira, Confluence, Miro, Lucidchart, Excel, or Power BI, unless it can be traced back to this specification.** If a document doesn't have a home here, it doesn't belong in the build. If this specification is missing something the engagement actually needs, we update the specification first, then the downstream artefacts.

---

## PART A: THE GOLDEN THREAD

Everything in this engagement must trace through this chain. This table is the master index. Every row gets an ID. Every ID gets referenced by name, not restated, everywhere else in the build.

| Chain link | Where it's defined | Where it's referenced |
|---|---|---|
| Business Problem | Section 2 | RTM, Backlog, Power BI |
| Business Objective | Section 2 | RTM, Section 4, Power BI |
| Stakeholder Need | Section 1, Stakeholder Register | RTM |
| Requirement | Section 3, Requirements Catalogue | RTM, Backlog |
| Feature | Section 4/5, Feature Catalogue | RTM, Jira |
| User Story | Section 5, Jira | RTM, Sprint Plan |
| Acceptance Criteria | Section 3/5, Jira | RTM, Section 7 validation |
| Sprint | Section 6, Jira | Burndown, Section 7 |
| Validation | Section 7 | RTM, Section 8 |
| Release | Section 8 | Section 9 |
| KPI | Section 8, Power BI | Section 9 |
| Expected Business Benefit | Section 4, Section 9 | Power BI |

**ID convention (lock this before any content is written):**
- Business Objective: `BO-01`, `BO-02`...
- Requirement: `REQ-01`, `REQ-02`...
- Epic: `EPIC-01`, `EPIC-02`...
- Feature: `FEAT-01`, `FEAT-02`...
- User Story: `US-01`, `US-02`...
- Risk: `RISK-01`...
- Decision: `DEC-01`...

Every one of these IDs is assigned once, in the RTM, and reused verbatim everywhere else. No artefact invents its own numbering.

---

## PART B: REPORT STRUCTURE, ALL 9 SECTIONS

For each section below: the subsection list is locked per your architecture. Under each, I've noted what real input is required before that subsection can be drafted, and which Part C template it pulls from.

### SECTION 1: Project Initiation & Discovery
| Subsection | Requires |
|---|---|
| Business context | The EcoGrow brief (already have) |
| Engagement mandate | Confirmation of who commissioned this engagement and your scope of authority |
| Problem framing | The 3 brief-stated problems, reframed as your discovery narrative |
| Stakeholder discovery | Real stakeholder identification, see Part C.1 |
| Stakeholder Register | Real names, roles, interest/power levels, see Part C.1 |
| Power-Interest analysis | Plotted from the real Stakeholder Register |
| RACI | Real names against real activities, see Part C.2 |
| Communication Plan | Real cadence, real channels, real owners |
| Governance | Real decision-making authority and escalation path |
| Discovery questions | Questions you actually asked or plan to ask |
| Initial decisions | Real decisions made during discovery |
| Delivery Reflection | Only if a real tension or trade-off occurred here |
| Executive Takeaway | Written last, once the section is real |

### SECTION 2: Business Analysis & Problem Definition
Business problem, root-cause analysis, business objectives, current-state analysis, future-state direction, stakeholder needs, business requirements, non-functional considerations, problem-to-outcome mapping, Delivery Reflection, Executive Takeaway.

**Requires:** the 3 brief-stated problems run through a real root-cause technique (5 Whys or fishbone), business objectives that trace to `BO-xx` IDs.

### SECTION 3: Requirements Engineering
Requirements catalogue, functional requirements, non-functional requirements, prioritisation, acceptance criteria, traceability, requirement dependencies, Definition of Ready, Definition of Done, validation approach, Delivery Reflection, Executive Takeaway.

**Requires:** real requirements elicited against the 3 core capabilities (Plant Library, Harvest Tracker, Community Forum), each assigned a `REQ-xx` ID, see Part C.3.

### SECTION 4: Product Strategy & Delivery Planning
Product Vision, Strategic Business Objectives, Expected Business Outcomes, Success Measures, Benefits Realisation Framework, Feature Value Assessment, Product Roadmap, MVP Definition, Epic Catalogue, Feature Catalogue, Release Strategy, Delivery Reflection, Executive Takeaway, Executive Close.

**Requires:** a real MVP decision (which features are in/out and why), real Epic list mapped to the 3 core capabilities, see Part C.4.

### SECTION 5: Backlog Engineering
Epic, Feature, Story, Task, Acceptance Criteria, Story Points, Definition of Ready, Definition of Done, Dependency Matrix, Story Mapping, Backlog Refinement, Traceability, Delivery Reflection, Executive Takeaway.

**Requires:** the actual Jira backlog once built, exported back into this section, not drafted independently of Jira.

### SECTION 6: Sprint Planning & Agile Delivery
Sprint Planning, Sprint Goals, Capacity Planning, Estimation, Sprint 1, Sprint 2, Sprint 3, Velocity, Risk Review, Sprint Execution, Daily Scrum support, Decision Register updates, Scope/change control, Delivery Reflection, Executive Takeaway.

**Requires:** real sprint dates (3 sprints, 2-week cycles, per the brief), real velocity once sprints run. **This section cannot be honestly written until the sprints have actually happened, or are clearly framed as planned/in-progress rather than complete.**

### SECTION 7: Business Validation & Product Acceptance
Sprint Reviews, Stakeholder Feedback, Acceptance Criteria validation, Product Acceptance, Backlog Updates, Retrospective, Business Validation, Future enhancement decisions, Delivery Reflection, Executive Takeaway.

**Requires:** real feedback from real sprint reviews. Same constraint as Section 6, this section describes things that have to actually happen first.

### SECTION 8: Release Readiness, Deployment & Benefits Realisation
Release Readiness Checklist, Go/No-Go Assessment, Deployment Strategy, Deployment Phases, Operational Handover, Hypercare, Benefits Monitoring, Executive KPI Dashboard, Delivery Reflection, Executive Takeaway.

**Requires:** a real go/no-go decision. Benefits Monitoring and the KPI Dashboard can only report actuals once EcoGrow is live, before that, they report the measurement framework only, per your own Power BI rule in Part C.6.

### SECTION 9: Executive Delivery Summary & Next Steps
Deliverables, Achievements, Expected Business Outcomes, Recommendations, Future Roadmap, Benefits measurement, Executive Close.

**Requires:** this is written last, once Sections 1-8 are real, and summarises only what's actually true by that point.

---

## PART C: TEMPLATES FOR EACH TOOL

### C.1 Stakeholder Register (Excel + Confluence)
Blank template, columns only:

| ID | Name | Role | Department | Interest (H/M/L) | Power (H/M/L) | Engagement strategy | Primary contact method |
|---|---|---|---|---|---|---|---|
| STK-01 | *[real name]* | *[real role]* | | | | | |

### C.2 RACI (Excel)
Blank template. Rows are real activities from Sections 1-8. Columns are real names, not placeholder titles.

| Activity | *[Name 1]* | *[Name 2]* | *[Name 3]* |
|---|---|---|---|
| *[real activity]* | R/A/C/I | R/A/C/I | R/A/C/I |

### C.3 Requirements Traceability Matrix (Excel, master version, not duplicated from Jira)

| REQ ID | Business Objective | Stakeholder Need | Epic | Feature | User Story | Acceptance Criteria | Validation Status | Release |
|---|---|---|---|---|---|---|---|---|
| REQ-01 | BO-xx | *[real need]* | EPIC-xx | FEAT-xx | US-xx | *[real criteria]* | *[Not started/In progress/Validated]* | *[release version]* |

### C.4 Epic Catalogue (Section 4 + Jira)
Structural starting point, mapped to the 3 stated core capabilities. Real epic names and descriptions still need to be written against real requirements.

| Epic ID | Core Capability | Working title | Status |
|---|---|---|---|
| EPIC-01 | Plant Library | *[to be named from real requirements]* | Not started |
| EPIC-02 | Harvest Tracker | *[to be named from real requirements]* | Not started |
| EPIC-03 | Community Forum | *[to be named from real requirements]* | Not started |

### C.5 Sprint Structure (Jira, locked to the brief)
Brief requires 3 sprints, 2-week cycles. This is the only part of the sprint schedule that's fixed before real planning happens.

| Sprint | Duration | Start | End | Goal |
|---|---|---|---|---|
| Sprint 1 | 2 weeks | *[real date]* | *[real date]* | *[set at real Sprint Planning]* |
| Sprint 2 | 2 weeks | *[real date]* | *[real date]* | *[set at real Sprint Planning]* |
| Sprint 3 | 2 weeks | *[real date]* | *[real date]* | *[set at real Sprint Planning]* |

### C.6 Power BI Reporting Layer, two states
**Pre-operational state (what the dashboard shows before EcoGrow has real usage data):** the measurement framework itself, what will be tracked, how, and against what target, with no live numbers.

**Post-operational state (once real data exists):** Product Adoption, Weekly Active Users, Feature Usage, Customer Satisfaction, Retention, Benefits Achievement, Release Performance, plus Jira-derived delivery reporting (Sprint progress, Velocity, Burndown, Defects, Release status).

**Rule:** the dashboard never shows the second state until the first state has real data behind it.

### C.7 Confluence Space Structure
Project Home, Engagement Overview, Product Vision, Business Objectives, Stakeholder Management, Requirements, Decision Register, RAID, Meeting Notes, Release Documentation, Benefits Realisation.

Each page is created empty with its heading structure, then populated as the real section it mirrors gets written.

### C.8 Miro Boards
Discovery Workshop, Stakeholder Mapping, User Journey, Impact Mapping, Story Map, Feature Prioritisation, Value Matrix Workshop.

Each board is built when its corresponding real activity actually happens, not in advance of it.

### C.9 Lucidchart Models
Current-State Process, Future-State Process, Swimlane, User Flow, System Context. Built only once the process being modelled is actually understood from real discovery.

---

## STATUS UPDATE: WHERE THE BUILD ACTUALLY STANDS

This document was written before Section 1 existed. It's kept as-is above because it's the original plan, and the plan is worth being able to check the real build against. Here's that check, added after the fact rather than rewritten into the plan itself:

| Planned (Part D) | Actual |
|---|---|
| Days 1-3, stakeholder discovery, Section 1 | Complete, persona-based per the confidentiality decision made during the real engagement |
| Days 3-5, root-cause analysis, Sections 2-3 | Complete |
| Days 5-7, MVP decision, Section 4 | Complete |
| Days 7-8, backlog build, Section 5 | Complete |
| Sprint timeline conflict (see original open decision below) | Resolved, this is a 4-month real engagement, the 2-week window was for starting the report, not compressing delivery |
| Sprint 1 | Closed with real Jira evidence, Section 6.5 |
| Sprint 2 | In progress |
| Sprint 3, Section 7, Section 8, Section 9 | Pending further real sprint output |

The open decision below is left in its original form for the audit trail, it was a real question at the time, and it was genuinely resolved before Section 1 was drafted, not silently dropped.

---

## PART D: THE TWO-WEEK SEQUENCE

Given the deadline, here's the order that keeps the golden thread intact instead of building six disconnected pieces:

**Days 1-3:** Real stakeholder discovery, Stakeholder Register, RACI, Communication Plan, Governance. This unlocks Section 1 and the Confluence stakeholder pages.

**Days 3-5:** Real root-cause analysis and requirements elicitation. This unlocks Sections 2 and 3, the RTM skeleton, and the Requirements page in Confluence.

**Days 5-7:** Real MVP decision, Epic Catalogue, Feature Catalogue. This unlocks Section 4 and the Jira project/Epic structure.

**Days 7-8:** Backlog build in Jira, exported into Section 5.

**Days 8-9 to Day 9+12 (three 2-week sprints don't fit inside a 2-week deadline as literal elapsed time):** this is the one real scheduling conflict in the plan. Three genuine 2-week sprints require 6 weeks minimum.

Before we go further, we need to decide: are the sprints compressed/simulated for documentation purposes within your 2-week window, or does the engagement's actual delivery window extend beyond this 2-week reporting deadline, with the report itself due in 2 weeks but referencing sprints that complete later? This changes how Sections 6-9 get written and I don't want to guess.

---

## OPEN DECISION BEFORE WE BUILD SECTION 1

The sprint timeline conflict above is real and needs your call before anything else starts. Everything upstream of Section 6 can begin immediately regardless of how that's resolved.

**Resolved:** this is a 4-month real engagement. The 2-week window was for starting the report, not for compressing three real sprints into two weeks. See the status table above for what that unlocked.
