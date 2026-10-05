-- ==========================================
-- VoteSecure – Sample Data (DML)
-- ==========================================

TRUNCATE TABLE Vote, Candidate, Voter, Party, Constituency, Election RESTART IDENTITY CASCADE;

-- 1. Elections
INSERT INTO Election (ElectionName, ElectionDate, Status) VALUES
('Student Council General Election 2026', '2026-03-15', 'Completed'),
('Sports Council Election 2026', '2026-04-10', 'Scheduled'),
('Cultural Committee Election 2025', '2025-11-20', 'Completed');

-- 2. Constituencies
INSERT INTO Constituency (ConstituencyName) VALUES
('School of Computer Science & AI'),
('School of Engineering & Technology'),
('School of Management Studies'),
('School of Design & Media');

-- 3. Parties
INSERT INTO Party (PartyName, PartySymbol) VALUES
('Student Unity Front', 'Flaming Torch'),
('Future Leaders Party', 'Rising Sun'),
('Campus Reform Group', 'Open Book'),
('Independent Student Alliance', 'Golden Shield');

-- 4. Candidates (3 candidates per constituency)
INSERT INTO Candidate (CandidateName, PartyID, ConstituencyID) VALUES
-- Const 1 (CS & AI)
('Aarav Sharma', 1, 1),
('Riya Patil', 2, 1),
('Rohan Deshmukh', 3, 1),
-- Const 2 (Engineering)
('Ananya Iyer', 1, 2),
('Vikram Malhotra', 2, 2),
('Sneha Kulkarni', 4, 2),
-- Const 3 (Management)
('Kabir Mehta', 2, 3),
('Priya Nair', 3, 3),
('Tanvi Joshi', 4, 3),
-- Const 4 (Design & Media)
('Aditya Verma', 1, 4),
('Meera Sen', 4, 4),
('Sahil Shinde', 3, 4); -- Receives 0 votes

-- 5. Registered Voters (35 students)
INSERT INTO Voter (VoterName, Email, ConstituencyID) VALUES
('Ishaan Gupta', 'ishaan@campus.edu', 1),
('Kavya Shah', 'kavya@campus.edu', 1),
('Aditi Rao', 'aditi@campus.edu', 1),
('Varun Reddy', 'varun@campus.edu', 1),
('Neha Pillai', 'neha@campus.edu', 1),
('Manish Tiwari', 'manish@campus.edu', 1),
('Pooja Hegde', 'pooja@campus.edu', 1),
('Karan Johar', 'karan@campus.edu', 1),
('Diya Mirza', 'diya@campus.edu', 1),
('Aryan Khan', 'aryan@campus.edu', 1),
('Rahul Varma', 'rahul@campus.edu', 2),
('Simran Kaur', 'simran@campus.edu', 2),
('Dev Patel', 'dev@campus.edu', 2),
('Anjali Menon', 'anjali@campus.edu', 2),
('Sameer Joshi', 'sameer@campus.edu', 2),
('Tara Sutaria', 'tara@campus.edu', 2),
('Gaurav Chopra', 'gaurav@campus.edu', 2),
('Sanya Malhotra', 'sanya@campus.edu', 2),
('Nikhil Kamath', 'nikhil@campus.edu', 2),
('Shraddha Kapoor', 'shraddha@campus.edu', 2),
('Akash Ambani', 'akash@campus.edu', 3),
('Roshni Nadar', 'roshni@campus.edu', 3),
('Kunal Shah', 'kunal@campus.edu', 3),
('Vineeta Singh', 'vineeta@campus.edu', 3),
('Aman Gupta', 'aman@campus.edu', 3),
('Namita Thapar', 'namita@campus.edu', 3),
('Peyush Bansal', 'peyush@campus.edu', 3),
('Anupam Mittal', 'anupam@campus.edu', 3),
('Alia Bhatt', 'alia@campus.edu', 4),
('Ranbir Roy', 'ranbir@campus.edu', 4),
('Deepika Padukone', 'deepika@campus.edu', 4),
('Ranveer Singh', 'ranveer@campus.edu', 4),
('Katrina Kaif', 'katrina@campus.edu', 4),
('Vicky Kaushal', 'vicky@campus.edu', 4),
('Siddharth Malhotra', 'siddharth@campus.edu', 4);

-- 6. Votes in Election 1 (34 cast ballots)
INSERT INTO Vote (VoterID, CandidateID, ConstituencyID, ElectionID) VALUES
-- Const 1: Aarav (5), Riya (3), Rohan (2) -> Aarav Wins
(1, 1, 1, 1), (2, 1, 1, 1), (3, 1, 1, 1), (4, 1, 1, 1), (5, 1, 1, 1),
(6, 2, 1, 1), (7, 2, 1, 1), (8, 2, 1, 1),
(9, 3, 1, 1), (10, 3, 1, 1),
-- Const 2: Ananya (3), Vikram (6), Sneha (1) -> Vikram Wins
(11, 4, 2, 1), (12, 4, 2, 1), (13, 4, 2, 1),
(14, 5, 2, 1), (15, 5, 2, 1), (16, 5, 2, 1), (17, 5, 2, 1), (18, 5, 2, 1), (19, 5, 2, 1),
(20, 6, 2, 1),
-- Const 3: Kabir (2), Priya (5), Tanvi (1) -> Priya Wins
(21, 7, 3, 1), (22, 7, 3, 1),
(23, 8, 3, 1), (24, 8, 3, 1), (25, 8, 3, 1), (26, 8, 3, 1), (27, 8, 3, 1),
(28, 9, 3, 1),
-- Const 4: Aditya (4), Meera (2), Sahil (0) -> Aditya Wins
(29, 10, 4, 1), (30, 10, 4, 1), (31, 10, 4, 1), (32, 10, 4, 1),
(33, 11, 4, 1), (34, 11, 4, 1);
