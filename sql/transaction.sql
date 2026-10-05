-- ==========================================
-- VoteSecure – Transactions (TCL)
-- Demonstrates: BEGIN, COMMIT, ROLLBACK
-- ==========================================

-- 1. Successful Transaction (COMMIT)
-- Valid vote is cast and permanently saved
BEGIN;
INSERT INTO Vote (VoterID, CandidateID, ConstituencyID, ElectionID)
VALUES (35, 10, 4, 1);
COMMIT;


-- 2. Error Rollback (Duplicate Vote Blocked)
-- Voter 1 tries to vote again in Election 1 (Blocked by UNIQUE constraint)
BEGIN;
INSERT INTO Vote (VoterID, CandidateID, ConstituencyID, ElectionID)
VALUES (1, 2, 1, 1);
ROLLBACK;


-- 3. Manual Rollback (User Cancels Before Commit)
-- Vote is inserted in Election 2 but cancelled before saving
BEGIN;
INSERT INTO Vote (VoterID, CandidateID, ConstituencyID, ElectionID)
VALUES (35, 10, 4, 2);
ROLLBACK;
