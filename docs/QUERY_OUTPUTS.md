# VoteSecure – Query Execution Results

### Query 1: Voters with Constituency (JOIN)
| VoterID | VoterName | Email | ConstituencyName |
|---:|:---|:---|:---|
| 1 | Ishaan Gupta | ishaan@campus.edu | School of Computer Science & AI |
| 2 | Kavya Shah | kavya@campus.edu | School of Computer Science & AI |
| 11 | Rahul Varma | rahul@campus.edu | School of Engineering & Technology |
| 21 | Akash Ambani | akash@campus.edu | School of Management Studies |
| 29 | Alia Bhatt | alia@campus.edu | School of Design & Media |
| ... | *(35 registered student records)* | ... | ... |

---

### Query 2: Candidates with Party (JOIN)
| CandidateID | CandidateName | PartyName | PartySymbol |
|---:|:---|:---|:---|
| 1 | Aarav Sharma | Student Unity Front | Flaming Torch |
| 2 | Riya Patil | Future Leaders Party | Rising Sun |
| 3 | Rohan Deshmukh | Campus Reform Group | Open Book |
| 4 | Ananya Iyer | Student Unity Front | Flaming Torch |
| 5 | Vikram Malhotra | Future Leaders Party | Rising Sun |
| 6 | Sneha Kulkarni | Independent Student Alliance | Golden Shield |
| 7 | Kabir Mehta | Future Leaders Party | Rising Sun |
| 8 | Priya Nair | Campus Reform Group | Open Book |
| 9 | Tanvi Joshi | Independent Student Alliance | Golden Shield |
| 10 | Aditya Verma | Student Unity Front | Flaming Torch |
| 11 | Meera Sen | Independent Student Alliance | Golden Shield |
| 12 | Sahil Shinde | Campus Reform Group | Open Book |

---

### Query 3: Voter Count per Constituency (GROUP BY, COUNT)
| ConstituencyName | TotalVoters |
|:---|---:|
| School of Computer Science & AI | 10 |
| School of Engineering & Technology | 10 |
| School of Management Studies | 8 |
| School of Design & Media | 7 |

---

### Query 4: Total Votes per Candidate (JOIN, GROUP BY, COUNT)
| CandidateName | TotalVotes |
|:---|---:|
| Vikram Malhotra | 6 |
| Aarav Sharma | 5 |
| Priya Nair | 5 |
| Aditya Verma | 4 |
| Riya Patil | 3 |
| Ananya Iyer | 3 |
| Rohan Deshmukh | 2 |
| Kabir Mehta | 2 |
| Meera Sen | 2 |
| Tanvi Joshi | 1 |
| Sneha Kulkarni | 1 |

---

### Query 5: Winner in EACH Constituency (MAX Subquery - Core Requirement)
| ConstituencyID | CandidateName | WinningVotes |
|---:|:---|---:|
| 1 (CS & AI) | Aarav Sharma | **5** |
| 2 (Engineering) | Vikram Malhotra | **6** |
| 3 (Management) | Priya Nair | **5** |
| 4 (Design & Media) | Aditya Verma | **4** |

---

### Query 6: Candidate Vote Percentage Share
| CandidateName | Votes | VotePercentage |
|:---|---:|---:|
| Vikram Malhotra | 6 | 17.65% |
| Aarav Sharma | 5 | 14.71% |
| Priya Nair | 5 | 14.71% |
| Aditya Verma | 4 | 11.76% |
| Riya Patil | 3 | 8.82% |
| Ananya Iyer | 3 | 8.82% |
| Rohan Deshmukh | 2 | 5.88% |
| Kabir Mehta | 2 | 5.88% |
| Meera Sen | 2 | 5.88% |
| Tanvi Joshi | 1 | 2.94% |
| Sneha Kulkarni | 1 | 2.94% |

---

### Query 7: Total Votes Cast per Constituency (GROUP BY)
| ConstituencyName | TotalVotes |
|:---|---:|
| School of Computer Science & AI | 10 |
| School of Engineering & Technology | 10 |
| School of Management Studies | 8 |
| School of Design & Media | 6 |

---

### Query 8: Zero-Vote Candidates (LEFT JOIN)
| CandidateName | PartyName |
|:---|:---|
| Sahil Shinde | Campus Reform Group |

---

### Query 9: Candidate with Highest Votes Overall (MAX Subquery)
| CandidateName | MaxVotes |
|:---|---:|
| Vikram Malhotra | 6 |

---

### Query 10: Audit Log of All Cast Votes (JOIN)
*(34 recorded votes with Voter Name, Candidate Name, and Timestamp)*
