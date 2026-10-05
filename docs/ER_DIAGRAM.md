# VoteSecure – Entity-Relationship (ER) Diagram

```mermaid
erDiagram
    ELECTION {
        int ElectionID PK
        varchar ElectionName
        date ElectionDate
        varchar Status
    }

    CONSTITUENCY {
        int ConstituencyID PK
        varchar ConstituencyName UK
    }

    PARTY {
        int PartyID PK
        varchar PartyName UK
        varchar PartySymbol
    }

    VOTER {
        int VoterID PK
        varchar VoterName
        varchar Email UK
        int ConstituencyID FK
        date RegistrationDate
    }

    CANDIDATE {
        int CandidateID PK
        varchar CandidateName
        int PartyID FK
        int ConstituencyID FK
    }

    VOTE {
        int VoteID PK
        int VoterID FK
        int CandidateID FK
        int ConstituencyID
        int ElectionID FK
        timestamp VoteTimestamp
    }

    CONSTITUENCY ||--o{ VOTER : "registers (1:M)"
    CONSTITUENCY ||--o{ CANDIDATE : "contests in (1:M)"
    PARTY ||--o{ CANDIDATE : "fields (1:M)"
    VOTER ||--o{ VOTE : "casts (1:M)"
    CANDIDATE ||--o{ VOTE : "receives (1:M)"
    ELECTION ||--o{ VOTE : "includes (1:M)"
```

---

## Entity Relationship Overview

1. **Constituency $\rightarrow$ Voter (1 : M):** A department has multiple registered voters; each voter belongs to one department.
2. **Constituency $\rightarrow$ Candidate (1 : M):** A department has multiple candidates contesting elections.
3. **Party $\rightarrow$ Candidate (1 : M):** A student party fields multiple candidates across departments.
4. **Voter $\rightarrow$ Vote (1 : M):** A voter casts ballots in elections, restricted to **at most 1 vote per election** via `UNIQUE (VoterID, ElectionID)`.
5. **Candidate $\rightarrow$ Vote (1 : M):** A candidate receives votes from voters within their constituency.
6. **Election $\rightarrow$ Vote (1 : M):** An election contains all ballots cast during that event.
