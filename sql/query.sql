-- ==========================================
-- VoteSecure – Simple & Essential Queries
-- ==========================================

-- 1. Display voters with their constituency (JOIN)
SELECT v.VoterID, v.VoterName, v.Email, c.ConstituencyName
FROM Voter v
JOIN Constituency c ON v.ConstituencyID = c.ConstituencyID;

-- 2. Display candidates with their party (JOIN)
SELECT c.CandidateID, c.CandidateName, p.PartyName, p.PartySymbol
FROM Candidate c
JOIN Party p ON c.PartyID = p.PartyID;

-- 3. Total registered voters per constituency (GROUP BY, COUNT)
SELECT c.ConstituencyName, COUNT(v.VoterID) AS TotalVoters
FROM Constituency c
LEFT JOIN Voter v ON c.ConstituencyID = v.ConstituencyID
GROUP BY c.ConstituencyName;

-- 4. Total votes received by each candidate (JOIN, GROUP BY, COUNT)
SELECT c.CandidateName, COUNT(v.VoteID) AS TotalVotes
FROM Candidate c
JOIN Vote v ON c.CandidateID = v.CandidateID
GROUP BY c.CandidateID, c.CandidateName
ORDER BY TotalVotes DESC;

-- 5. Winner in EACH constituency (MAX Subquery - Core Requirement)
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

-- 6. Candidate vote percentage share (Aggregate calculation)
SELECT 
    c.CandidateName, 
    COUNT(v.VoteID) AS Votes,
    ROUND(COUNT(v.VoteID) * 100.0 / (SELECT COUNT(*) FROM Vote), 2) AS VotePercentage
FROM Candidate c
JOIN Vote v ON c.CandidateID = v.CandidateID
GROUP BY c.CandidateID, c.CandidateName
ORDER BY Votes DESC;

-- 7. Total votes cast per constituency (GROUP BY, COUNT)
SELECT c.ConstituencyName, COUNT(v.VoteID) AS TotalVotes
FROM Constituency c
JOIN Vote v ON c.ConstituencyID = v.ConstituencyID
GROUP BY c.ConstituencyName;

-- 8. Candidates who received zero votes (LEFT JOIN)
SELECT c.CandidateName, p.PartyName
FROM Candidate c
JOIN Party p ON c.PartyID = p.PartyID
LEFT JOIN Vote v ON c.CandidateID = v.CandidateID
WHERE v.VoteID IS NULL;

-- 9. Candidate with highest votes overall (MAX Subquery)
SELECT c.CandidateName, COUNT(v.VoteID) AS MaxVotes
FROM Candidate c
JOIN Vote v ON c.CandidateID = v.CandidateID
GROUP BY c.CandidateID, c.CandidateName
HAVING COUNT(v.VoteID) = (
    SELECT MAX(sub.Total)
    FROM (
        SELECT COUNT(VoteID) AS Total
        FROM Vote
        GROUP BY CandidateID
    ) sub
);

-- 10. Audit log of all cast votes (JOIN)
SELECT v.VoteID, vtr.VoterName, c.CandidateName, v.VoteTimestamp
FROM Vote v
JOIN Voter vtr ON v.VoterID = vtr.VoterID
JOIN Candidate c ON v.CandidateID = c.CandidateID
ORDER BY v.VoteID;
