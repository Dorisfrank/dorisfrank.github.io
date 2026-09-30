# EcoGrow Evidence Index

**Prepared by:** Doris Frank, Business Analyst  
**Purpose:** Controlled index of retained delivery evidence supporting the current story-level validation record.

## 1. Evidence Control Principles

I maintain this index as a traceability layer between Jira delivery records, business requirements, acceptance criteria, and retained supporting evidence.

The index follows these rules:

- Evidence is retained only where it supports a distinct delivery or validation claim.
- Duplicate evidence is excluded where it adds no additional evidential value.
- Story-level prototype and acceptance-testing evidence is not represented as formal MVP acceptance or release approval.
- ECO-10 / FR-08 retains a canonical and supplementary evidence distinction.
- Evidence remains mapped to the requirement and Jira issue it supports.
- Open governance gates remain open unless separately evidenced and formally cleared.

## 2. Evidence Count and Source-of-Record Rule

The original Jira evidence inventory contained **19 attachments: 13 PNG files and 6 MP4 files**.

The retained evidence set contains **17 files: 13 PNG files and 4 MP4 files**.

The difference is intentional. I reviewed all six videos personally and excluded two as duplicate demonstration evidence, ECO-5 and ECO-12, because in both cases the video and the retained screenshot show the identical outcome. The video adds a demonstration of how the result was reached, but no information the screenshot doesn't already carry.

The Jira attachment record is the system of record for attachment names. This index preserves the attachment-name strings captured in the governed evidence register rather than silently renaming them.

Where an attachment name contains a GUID-style suffix, duplicate extension, or stray space, I have retained that string for traceability. Those strings are not independently re-verified against the live Jira attachment metadata in this correction pass.

## 3. Local Working Copy Rule

I do not treat local working copies as a second system of record.

An earlier version of this index attempted to map Jira attachment names to local filenames. That created avoidable ambiguity, since local downloads can receive suffixes or altered names that don't exactly match the Jira attachment record.

To preserve audit integrity, I no longer maintain local-copy filename mappings in this index. A local copy may be used for convenience, but the Jira attachment name in the Evidence Register below is the authoritative traceability reference.

## 4. Evidence Register

| Evidence File (attachment name recorded in source register) | Jira Issue | Requirement | Evidence Type | Classification | Supports |
|---|---|---|---|---|---|
| `ECO-5_FR-01_Plant_Library_Search_Evidence_Screenshot_2026-08-27.png` | ECO-5 / US-01 | FR-01 | PNG | Primary outcome evidence | Plant Library search returning a matching plant entry |
| `ECO-6_FR-02_Vetted_Content_Evidence_Screenshot_2026-08-27.png` | ECO-6 / US-02 | FR-02 | PNG | Primary outcome evidence | Content-verified badge and last-reviewed date display |
| `ECO-7_FR-05_Prototype_Evidence_2026-08-23 (279328c5-089a-4182-b72e-4ec0c3759152).png` | ECO-7 / US-03 | FR-05 | PNG | Acceptance evidence | Plant type and planting-date capture |
| `ECO-7_FR-05_Prototype_Evidence2_2026-08-23 .png` | ECO-7 / US-03 | FR-05 | PNG | Acceptance evidence | Successful planting-event recording |
| `ECO-8_FR-06_Prototype_Evidence_2026-08-23  .png` | ECO-8 / US-04 | FR-06 | PNG | Acceptance evidence | Existing planting selection before harvest recording |
| `ECO-8_FR-06_Prototype_Evidence2_2026-08-23 .png` | ECO-8 / US-04 | FR-06 | PNG | Acceptance evidence | Harvest-detail entry and recording |
| `ECO-8_FR-06_Prototype_Evidence3_2026-08-23  .png` | ECO-8 / US-04 | FR-06 | PNG | Acceptance evidence | Recorded harvest confirmation |
| `ECO-8_FR-06_Prototype_Evidence4_2026-08-23  .png` | ECO-8 / US-04 | FR-06 | PNG | Acceptance evidence | Planting-to-harvest linkage and traceability |
| `ECO-9_FR-03_Prototype_Evidence_AC1_2026-08-26.mp4.mp4` | ECO-9 / US-05 | FR-03 | MP4 | Process evidence | Forum post creation demonstration supporting AC1. Read together with the AC3 screenshot below, not as a standalone artifact, the post content is long enough that I recorded it as video rather than a static capture, and the screenshot shows the resulting output that this video produces |
| `ECO-9_FR-03_Prototype_Evidence_AC2_2026-08-26.mp4.mp4` | ECO-9 / US-05 | FR-03 | MP4 | Process evidence | Forum tagging demonstration supporting AC2. Same input-to-output relationship with the AC3 screenshot as the AC1 video above |
| `ECO-9_FR-03_Prototype_Evidence_AC3_2026-08-26.png` | ECO-9 / US-05 | FR-03 | PNG | Outcome evidence | Published Community Forum post with associated tagging information supporting AC3. This screenshot is the output of the AC1/AC2 videos above and should be read alongside them, not in isolation |
| `ECO-10_FR-08_Usage_Event_Evidence_Video_2026-08-25.mp4.mp4` | ECO-10 / US-06 | FR-08 | MP4 | Canonical behavioural evidence | Usage-event capture following supported Plant Library and Harvest Tracker actions. I confirmed the video content directly, the three action cards (Log a Planting, Record a Harvest, View Plant Library), the usage-event confirmation banner, and a table of recorded events (UE-001 through UE-010) spanning Plant Library, Harvest Log, and Planting Log, each marked Status: Recorded, with the portfolio-test disclaimer visible |
| `ECO-10_FR-08_Usage_Event_Evidence_Community_Forum_2026-08-26.mp4` | ECO-10 / US-06 | FR-08 | MP4 | Supplementary behavioural evidence | Community Forum usage-event capture completing the third capability |
| `ECO-10_FR-08_Usage_Event_Evidence_Community_Forum_2026-08-26.png` | ECO-10 / US-06 | FR-08 | PNG | Supplementary outcome evidence | Recorded Community Forum usage event |
| `ECO-10_FR-08_Usage_Event_Evidence2_Community_Forum_2026-08-26.png .png` | ECO-10 / US-06 | FR-08 | PNG | Supplementary outcome evidence | Community Forum event details and recorded state |
| `ECO-12_FR-09_Prototype_Evidence_Screenshot_2026-08-27.png` | ECO-12 / US-07 | FR-09 | PNG | Acceptance evidence | Post-harvest satisfaction prompt and rating interaction |
| `ECO-12_FR-09_Prototype_Evidence2_Screenshot_2026-08-27.png` | ECO-12 / US-07 | FR-09 | PNG | Acceptance evidence | Submitted satisfaction signal and recorded test-session traceability |

## 5. Excluded Duplicate Evidence

I excluded the following files from the retained evidence set because the corresponding screenshot already captures the identical evidential outcome, with nothing distinct added by the video:

| Excluded File | Reason |
|---|---|
| `ECO-5_FR-01_Plant_Library_Search_Prototype_Evidence_Video_2026-08-27.mp4` | Same search outcome as the retained screenshot, I reviewed both directly and they show identical content, only one demonstrates it dynamically |
| `ECO-12_FR-09_Prototype_Evidence_Video_2026-08-27 (3c4dd5fc-c49a-48a6-b965-eceb49f405c5).mp4` | Same acceptance outcome as the retained screenshots, same basis for exclusion as ECO-5 above |

## 6. ECO-10 Canonical and Supplementary Rule

ECO-10 / FR-08 is governed by a specific evidence structure:

- The broader usage-event prototype is the canonical evidence source.
- It demonstrates Plant Library and Harvest Tracker actions.
- The Community Forum evidence is supplementary.
- The supplementary evidence completes coverage of the Community Forum capability.
- Together, the canonical and supplementary evidence cover the required FR-08 capability scope.
- The canonical evidence alone must not be described as covering all three capabilities.

## 7. Validation Position

This index supports the current story-level evidence record for:

- ECO-5 / FR-01
- ECO-6 / FR-02
- ECO-7 / FR-05
- ECO-8 / FR-06
- ECO-9 / FR-03
- ECO-10 / FR-08
- ECO-12 / FR-09

The retained evidence supports prototype demonstration and story-level acceptance-testing outcomes. It does not replace the outstanding governance gates for formal all-persona Sprint Review, final RTM validation, formal MVP/product acceptance, Go/No-Go approval, or operational benefits evidence.

## 8. Evidence Review Boundary

I personally reviewed all six video files in the original evidence inventory before making any exclusion decision in this index.

For ECO-5 and ECO-12, I confirmed the video and its paired screenshot show the same outcome, the video adds no distinct evidential content beyond demonstrating how that outcome was reached, so I excluded the video and retained the screenshot alone.

For ECO-9, I confirmed the relationship runs the other way. The AC1 and AC2 videos and the AC3 screenshot are not duplicates of each other, they're an input-to-output pair.

The Community Forum post content was too long to capture cleanly as a single static screenshot, so I recorded the creation and tagging process as video, and the screenshot shows the resulting published post. Both are retained, and I've noted in the Evidence Register that the PNG should be read alongside the video rather than treated as a self-contained artifact.

For ECO-10, I confirmed the video's content directly, the three action cards, the usage-event confirmation banner, and the UE-001 through UE-010 event table across Plant Library, Harvest Log, and Planting Log, each Recorded, with the portfolio-test disclaimer visible. This matches the canonical prototype content already documented elsewhere in the project.

These classifications are based on my own direct review of each file, not inferred from filenames or descriptions alone.
