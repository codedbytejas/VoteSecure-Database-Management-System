# VoteSecure – Normalization Analysis (1NF to 3NF/BCNF)

## 1. Normal Forms Breakdown

- **1NF (Atomic Attributes):** Every attribute contains atomic (single) values. Surrogate keys (`SERIAL PRIMARY KEY`) uniquely identify each record.
- **2NF (No Partial Dependency):** Every non-prime attribute depends fully on the primary key, eliminating partial dependencies.
- **3NF (No Transitive Dependency):** `Party` is separated into its own table `(PartyID, PartyName, PartySymbol)`. `Candidate` stores `PartyID` as a foreign key, removing transitive dependencies (`CandidateID -> PartyName -> PartySymbol`).
- **BCNF:** For all non-trivial functional dependencies, the determinant is a candidate key / superkey.

## 2. Anomalies Eliminated

1. **Insertion Anomaly:** New political parties can be registered without requiring candidates to be nominated immediately.
2. **Update Anomaly:** Updating a party symbol requires changing only one row in `Party`, automatically reflecting across all candidates.
3. **Deletion Anomaly:** Deleting a candidate record does not wipe out information about their political party.
