# Project Execution & Verification Screenshots

This directory contains visual execution evidence, query outputs, and constraint validation proofs for academic submission and viva voce evaluation of the **VoteSecure** DBMS project.

---

## 📸 Recommended Submission Screenshots

Capture and store screenshots using the following standardized filenames:

| File Name | Description | Source Script / Tool |
|:---|:---|:---|
| `01_schema_ddl.png` | Successful table creation and constraint definitions | `sql/schema.sql` (pgAdmin / Terminal) |
| `02_sample_data.png` | Insertion of sample voters, candidates, parties, and votes | `sql/seed.sql` |
| `03_winner_query.png` | Execution of Query 5 showing winners across all 4 constituencies | `sql/query.sql` (Query 5) |
| `04_vote_shares.png` | Candidate vote totals and percentage share breakdown | `sql/query.sql` (Query 6) |
| `05_transaction_commit.png` | Successful transaction execution showing vote commit | `sql/transaction.sql` (Section 1) |
| `06_duplicate_vote_error.png` | PostgreSQL `unique_violation` error on duplicate vote attempt | `sql/transaction.sql` (Section 2) |
| `07_er_diagram.png` | Visual / pgAdmin Graphical Relational Schema View | `docs/ER_DIAGRAM.md` / pgAdmin ERD tool |

---

## 📝 Markdown Embedding Example

Once screenshots are captured and placed in this folder, you can embed them into your report using:

```markdown
### Schema Creation Proof
![Schema DDL Output](01_schema_ddl.png)

### Constituency Winner Query Output
![Winner Query Output](03_winner_query.png)

### Anti-Double Voting Constraint Enforcement
![Duplicate Vote Error](06_duplicate_vote_error.png)
```

---

## 💡 Pro Tips for Viva Presentation
- Make sure table column headers and row counts are clearly visible.
- Keep the terminal/pgAdmin theme readable (high contrast).
- Highlight the `UNIQUE (VoterID, ElectionID)` violation output to demonstrate electoral integrity to the examiner.
