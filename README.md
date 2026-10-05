# VoteSecure – Election & Voter Management System

**Academic Case Study Project**  
**Program:** B.Tech Computer Science Engineering & AI — Semester III  
**Course:** Database Management Systems (SQL & Relational Modeling)  
**Institution:** School of FutureTech, ITM Skills University  

---

## 📌 Executive Summary

**VoteSecure** is a normalized relational database management system designed to conduct, manage, and audit student council elections. The system guarantees electoral integrity by enforcing database-level constraints that restrict each registered student voter to **at most one vote per election**, prevent candidate-constituency mismatches, and dynamically calculate constituency winners through correlated aggregate subqueries.

---

## 🎯 Objectives & Key Capabilities

- **Relational Modeling:** 6 core entities with primary keys, foreign keys, unique constraints, and referential integrity.
- **3NF / BCNF Normalization:** Decoupled `Party` from `Candidate` to remove transitive dependencies and eliminate insertion, update, and deletion anomalies.
- **Duplicate Vote Prevention:** Enforced via `UNIQUE (VoterID, ElectionID)` on the `Vote` table.
- **Constituency Winner Computation:** Dynamic calculation of winners per department using `JOIN`, `GROUP BY`, `COUNT()`, and correlated `MAX()` subqueries.
- **Transaction Safety (ACID):** TCL demonstration (`BEGIN`, `COMMIT`, `ROLLBACK`) for recording valid ballots and safely rolling back duplicate/invalid submissions.

---

## 🗄️ Relational Schema & Entity Diagram

```
 +------------------+          +------------------+          +------------------+
 |     ELECTION     |          |   CONSTITUENCY   |          |      PARTY       |
 +------------------+          +------------------+          +------------------+
 | PK  ElectionID   |          | PK  Constitu.ID  |          | PK  PartyID      |
 |     ElectionName |          | UK  Constitu.Name|          | UK  PartyName    |
 |     ElectionDate |          +--------+---------+          |     PartySymbol  |
 |     Status       |                   |                    +--------+---------+
 +--------+---------+                   | 1                           | 1
          | 1                           | contains                    | fields
          | includes                    | M                           | M
          | M                  +--------v---------+          +--------v---------+
          |                    |      VOTER       |          |    CANDIDATE     |
          |                    +------------------+          +------------------+
          |                    | PK  VoterID      |          | PK  CandidateID  |
          |                    |     VoterName    |          |     CandidateName|
          |                    | UK  Email        |          | FK  PartyID      |
          |                    | FK  Constitu.ID  |          | FK  Constitu.ID  |
          |                    |     RegDate      |          | UK  (CandID,ConID|
          |                    +--------+---------+          +--------+---------+
          |                             | 1                           | 1
          |                             | casts                       | receives
          |                             | M                           | M
          |                    +--------v-----------------------------v---------+
          +------------------->|                      VOTE                      |
                               +------------------------------------------------+
                               | PK  VoteID                                     |
                               | FK  VoterID                                    |
                               | FK  CandidateID                                |
                               |     ConstituencyID                             |
                               | FK  ElectionID                                 |
                               |     VoteTimestamp                              |
                               | UK  (VoterID, ElectionID)                      |
                               +------------------------------------------------+
```

### Table Specifications:

| Table | Primary Key | Foreign Keys | Key Constraints | Description |
|:---|:---:|:---|:---|:---|
| **`Election`** | `ElectionID` | None | `CHECK (Status IN ('Scheduled', 'Ongoing', 'Completed'))` | Stores election event metadata |
| **`Constituency`** | `ConstituencyID` | None | `UNIQUE (ConstituencyName)` | Stores academic departments |
| **`Party`** | `PartyID` | None | `UNIQUE (PartyName)` | Stores student political parties and symbols |
| **`Voter`** | `VoterID` | `ConstituencyID -> Constituency` | `UNIQUE (Email)` | Stores registered student voters |
| **`Candidate`** | `CandidateID` | `PartyID -> Party`<br>`ConstituencyID -> Constituency` | `UNIQUE (CandidateID, ConstituencyID)` | Stores contesting students |
| **`Vote`** | `VoteID` | `VoterID -> Voter`<br>`ElectionID -> Election`<br>`(CandidateID, ConstituencyID) -> Candidate` | **`UNIQUE (VoterID, ElectionID)`** | Stores cast ballots securely |

---

## 📁 Project Structure

```
VoteSecure/
│
├── README.md                           # Master Academic Documentation & Viva Guide
│
├── sql/
│   ├── schema.sql                      # DDL: Clean table creation, PKs, FKs & constraints
│   ├── seed.sql                        # DML: Realistic student council election sample data
│   ├── query.sql                       # DQL: 10 essential queries (JOINs, aggregates, MAX winner)
│   └── transaction.sql                 # TCL: Transaction demo (COMMIT, ROLLBACK, ACID protection)
│
├── docs/
│   ├── VoteSecure_DBMS_Case_Study_Report_final.pdf  # Final comprehensive project report PDF
│   ├── ER_DIAGRAM.md                   # Mermaid ER diagram & cardinality summary
│   ├── SCHEMA.md                       # Data dictionary & constraint details
│   ├── NORMALIZATION.md                # 1NF -> 3NF/BCNF step-by-step analysis & anomalies
│   └── QUERY_OUTPUTS.md                # Query outputs formatted in markdown tables
│
└── screenshots/
    └── README.md                       # Evidence guide for lab submission screenshots
```

---

## 🚀 How to Run the Project

Execute the 4 SQL scripts sequentially using the PostgreSQL CLI (`psql`) or pgAdmin 4:

```bash
# 1. Create database tables and constraints
psql -d votesecure -f sql/schema.sql

# 2. Insert realistic student election sample data
psql -d votesecure -f sql/seed.sql

# 3. Execute basic & analytical queries
psql -d votesecure -f sql/query.sql

# 4. Run transaction integrity tests (COMMIT & ROLLBACK)
psql -d votesecure -f sql/transaction.sql
```

---

## 🏆 Featured Query: Constituency-Wise Winner Detection

The core requirement of this case study is determining the winning candidate for **each constituency** using `JOIN`, `GROUP BY`, `COUNT()`, and a correlated `MAX()` subquery:

```sql
SELECT c.ConstituencyID, c.CandidateName, COUNT(v.VoteID) AS WinningVotes
FROM Candidate c
JOIN Vote v ON c.CandidateID = v.CandidateID
GROUP BY c.ConstituencyID, c.CandidateID, c.CandidateName
HAVING COUNT(v.VoteID) = (
    SELECT MAX(sub.VoteCount)
    FROM (
        SELECT COUNT(v2.VoteID) AS VoteCount
        FROM Candidate c2
        JOIN Vote v2 ON c2.CandidateID = v2.CandidateID
        WHERE c2.ConstituencyID = c.ConstituencyID
        GROUP BY c2.CandidateID
    ) sub
)
ORDER BY c.ConstituencyID;
```

**Results:**
| Constituency | Winner Candidate | Winning Votes |
|:---|:---|---:|
| School of Computer Science & AI | **Aarav Sharma** | **5** |
| School of Engineering & Technology | **Vikram Malhotra** | **6** |
| School of Management Studies | **Priya Nair** | **5** |
| School of Design & Media | **Aditya Verma** | **4** |

---

## 🛡️ Transaction Control Language (TCL)

Demonstrated in [`sql/transaction.sql`](file:///Users/tejaschavan1907/Desktop/DBMS%20SEM3/sql/transaction.sql):

1. **Successful Ballot Casting (`COMMIT`):**
   ```sql
   BEGIN;
   INSERT INTO Vote (VoterID, CandidateID, ConstituencyID, ElectionID) VALUES (35, 10, 4, 1);
   COMMIT;
   ```
2. **Duplicate Vote Rejection (`ROLLBACK`):**
   ```sql
   BEGIN;
   -- Blocked by UNIQUE (VoterID, ElectionID)
   INSERT INTO Vote (VoterID, CandidateID, ConstituencyID, ElectionID) VALUES (1, 2, 1, 1);
   ROLLBACK;
   ```
3. **Manual Cancellation (`ROLLBACK`):**
   ```sql
   BEGIN;
   INSERT INTO Vote (VoterID, CandidateID, ConstituencyID, ElectionID) VALUES (35, 10, 4, 2);
   ROLLBACK;
   ```

---

## 🎓 Viva Voce Rapid Preparation Guide

| # | Question | Model Viva Answer |
|:---:|:---|:---|
| **1** | **What is VoteSecure?** | A normalized PostgreSQL database for student council elections that eliminates double voting and calculates constituency winners instantly. |
| **2** | **Why is Party separated from Candidate?** | To satisfy 3NF. If combined, party details repeat for every candidate, causing transitive dependencies and update anomalies. |
| **3** | **How is duplicate voting prevented?** | Using `UNIQUE (VoterID, ElectionID)` on the `Vote` table, blocking duplicate inserts at the database engine level with a `unique_violation` error. |
| **4** | **What is the purpose of transactions?** | Transactions guarantee **ACID** properties (Atomicity). Valid votes are saved permanently using `COMMIT`, while failed operations are aborted using `ROLLBACK`. |
| **5** | **How does the winner query work?** | It groups votes per candidate and uses a `HAVING COUNT(...) = (SELECT MAX(...) ...)` correlated subquery to isolate the highest tally in each constituency. |
| **6** | **What normal form does this database achieve?** | **3NF / BCNF** because attributes are atomic (1NF), there are no partial dependencies (2NF), no transitive dependencies (3NF), and every determinant is a superkey (BCNF). |

---

## ✅ Deliverables Checklist

- [x] **Relational Schema DDL:** [sql/schema.sql](file:///Users/tejaschavan1907/Desktop/DBMS%20SEM3/sql/schema.sql)
- [x] **Sample Dataset DML:** [sql/seed.sql](file:///Users/tejaschavan1907/Desktop/DBMS%20SEM3/sql/seed.sql)
- [x] **Analytical Queries DQL:** [sql/query.sql](file:///Users/tejaschavan1907/Desktop/DBMS%20SEM3/sql/query.sql)
- [x] **Transaction Scripts TCL:** [sql/transaction.sql](file:///Users/tejaschavan1907/Desktop/DBMS%20SEM3/sql/transaction.sql)
- [x] **ER Diagram Documentation:** [docs/ER_DIAGRAM.md](file:///Users/tejaschavan1907/Desktop/DBMS%20SEM3/docs/ER_DIAGRAM.md)
- [x] **Data Dictionary & Schema Doc:** [docs/SCHEMA.md](file:///Users/tejaschavan1907/Desktop/DBMS%20SEM3/docs/SCHEMA.md)
- [x] **Normalization Breakdown:** [docs/NORMALIZATION.md](file:///Users/tejaschavan1907/Desktop/DBMS%20SEM3/docs/NORMALIZATION.md)
- [x] **Documented Query Outputs:** [docs/QUERY_OUTPUTS.md](file:///Users/tejaschavan1907/Desktop/DBMS%20SEM3/docs/QUERY_OUTPUTS.md)
- [x] **Final Case Study PDF Report:** [docs/VoteSecure_DBMS_Case_Study_Report_final.pdf](file:///Users/tejaschavan1907/Desktop/DBMS%20SEM3/docs/VoteSecure_DBMS_Case_Study_Report_final.pdf)
- [x] **Screenshots Submission Guide:** [screenshots/README.md](file:///Users/tejaschavan1907/Desktop/DBMS%20SEM3/screenshots/README.md)
