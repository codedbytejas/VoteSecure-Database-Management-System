# VoteSecure – Relational Database Schema

| Table | Primary Key | Foreign Keys | Key Constraints | Purpose |
|:---|:---:|:---|:---|:---|
| **`Election`** | `ElectionID` | None | `CHECK (Status IN ('Scheduled', 'Ongoing', 'Completed'))` | Stores election events |
| **`Constituency`** | `ConstituencyID` | None | `UNIQUE (ConstituencyName)` | Stores academic departments |
| **`Party`** | `PartyID` | None | `UNIQUE (PartyName)` | Stores student political parties & symbols |
| **`Voter`** | `VoterID` | `ConstituencyID -> Constituency` | `UNIQUE (Email)` | Stores registered student voters |
| **`Candidate`** | `CandidateID` | `PartyID -> Party`<br>`ConstituencyID -> Constituency` | `UNIQUE (CandidateID, ConstituencyID)` | Stores contesting students |
| **`Vote`** | `VoteID` | `VoterID -> Voter`<br>`ElectionID -> Election`<br>`(CandidateID, ConstituencyID) -> Candidate` | **`UNIQUE (VoterID, ElectionID)`** | Stores cast ballots securely |
