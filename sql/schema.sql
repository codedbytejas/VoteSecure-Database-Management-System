-- ==========================================
-- VoteSecure – Database Schema (DDL)
-- ==========================================

DROP TABLE IF EXISTS Vote CASCADE;
DROP TABLE IF EXISTS Candidate CASCADE;
DROP TABLE IF EXISTS Voter CASCADE;
DROP TABLE IF EXISTS Party CASCADE;
DROP TABLE IF EXISTS Constituency CASCADE;
DROP TABLE IF EXISTS Election CASCADE;

-- 1. Election Table
CREATE TABLE Election (
    ElectionID SERIAL PRIMARY KEY,
    ElectionName VARCHAR(100) NOT NULL,
    ElectionDate DATE NOT NULL,
    Status VARCHAR(20) DEFAULT 'Scheduled' CHECK (Status IN ('Scheduled', 'Ongoing', 'Completed'))
);

-- 2. Constituency Table
CREATE TABLE Constituency (
    ConstituencyID SERIAL PRIMARY KEY,
    ConstituencyName VARCHAR(100) NOT NULL UNIQUE
);

-- 3. Party Table
CREATE TABLE Party (
    PartyID SERIAL PRIMARY KEY,
    PartyName VARCHAR(100) NOT NULL UNIQUE,
    PartySymbol VARCHAR(50) NOT NULL
);

-- 4. Voter Table
CREATE TABLE Voter (
    VoterID SERIAL PRIMARY KEY,
    VoterName VARCHAR(100) NOT NULL,
    Email VARCHAR(100) NOT NULL UNIQUE,
    ConstituencyID INT REFERENCES Constituency(ConstituencyID),
    RegistrationDate DATE DEFAULT CURRENT_DATE
);

-- 5. Candidate Table
CREATE TABLE Candidate (
    CandidateID SERIAL PRIMARY KEY,
    CandidateName VARCHAR(100) NOT NULL,
    PartyID INT REFERENCES Party(PartyID),
    ConstituencyID INT REFERENCES Constituency(ConstituencyID),
    UNIQUE (CandidateID, ConstituencyID)
);

-- 6. Vote Table
CREATE TABLE Vote (
    VoteID SERIAL PRIMARY KEY,
    VoterID INT REFERENCES Voter(VoterID),
    CandidateID INT,
    ConstituencyID INT,
    ElectionID INT REFERENCES Election(ElectionID),
    VoteTimestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (CandidateID, ConstituencyID) REFERENCES Candidate(CandidateID, ConstituencyID),
    UNIQUE (VoterID, ElectionID) -- Prevents double voting in same election
);
