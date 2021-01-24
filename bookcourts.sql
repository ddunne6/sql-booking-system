CREATE TABLE TennisClub(
	ClubID INT NOT NULL,
    ClubName VARCHAR(100) NOT NULL,
    Email VARCHAR(70) NOT NULL,
    NumCourts INT NOT NULL DEFAULT 0,
	Street VARCHAR(100) NOT NULL,
    Town VARCHAR(100),
    County VARCHAR(100) NOT NULL,
    PRIMARY KEY(ClubID),
    CONSTRAINT check_clubemail CHECK(Email LIKE "%@%")
);

INSERT INTO TennisClub VALUES(1, "TCD Tennis Club", "tennis@tcd.ie", 0, "Botany Bay", "Trinity College Dublin", "Dublin");
INSERT INTO TennisClub VALUES(2, "Malahide Lawn Tennis & Croquet Club", "info@mltcc.com", 0, "The Square", "Malahide", "Dublin");
INSERT INTO TennisClub VALUES(3, "Sutton Lawn Tennis Club", "info@suttonltc.com", 0, "176 Howth Rd", "Burrow", "Dublin");
INSERT INTO TennisClub VALUES(4, "Fitzwilliam Lawn Tennis Club", "info@fltc.ie", 0, "Winton Rd", "Ranelagh", "Dublin");
INSERT INTO TennisClub VALUES(5, "Lansdowne Tennis Club", "info@lansdowneltc.ie", 0, "4 Londonbridge Road", NULL, "Dublin");

CREATE TABLE ClubMember( 
	UserID INT NOT NULL,
    Email VARCHAR(70) NOT NULL,
    Fname VARCHAR(30) NOT NULL,
    Lname VARCHAR(30) NOT NULL,
    BirthDate DATE,
    Com_Role VARCHAR(30) DEFAULT NULL,
    Club_ID INT NOT NULL,
    MemType VARCHAR(10) NOT NULL,
    PRIMARY KEY(UserID),
    FOREIGN KEY(Club_ID) REFERENCES TennisClub(ClubID),
    CONSTRAINT check_member_type CHECK(MemType IN ("Junior", "Senior", "Student")),
    CONSTRAINT check_mememail CHECK(Email LIKE "%@%")
);

INSERT INTO ClubMember VALUES (1, "lacy123@gmail.com", "Lacy", "Mcculloch", '1986-06-04', NULL, 1, "Senior");
INSERT INTO ClubMember VALUES (2, "nuhanuha@gmail.com", "Nuha", "Howarth", '1996-09-16', "Chairperson", 1, "Student");
INSERT INTO ClubMember VALUES (3, "alvo@yahoo.co.uk", "Sam", "Alvarez", '2007-01-26', NULL, 1, "Junior");
INSERT INTO ClubMember VALUES (4, "kadenpate15@gmail.com", "Kaden", "Pate", '1959-10-05', "Teasurer", 2, "Senior");
INSERT INTO ClubMember VALUES (5, "usman@uzzy.ie", "Usman", "Wilcox", '1988-01-29', "Secretary", 3, "Senior");
INSERT INTO ClubMember VALUES (6, "fahmida@gmail.com", "Fahmida", "Dillon", '1986-05-28', "Chairperson", 3, "Student");
INSERT INTO ClubMember VALUES (7, "alenahla@gmail.com", "Nahla", "Allen", '1999-03-12', NULL, 4, "Senior");
INSERT INTO ClubMember VALUES (8, "delores@deloresdesigns.ie", "Delores", "Redfern", '1949-6-29', NULL, 4, "Senior");
INSERT INTO ClubMember VALUES (9, "ameliaorrose@gmail.com", "Amelia-Rose", "Ochoa", '1982-11-06', NULL, 4, "Senior");
INSERT INTO ClubMember VALUES (10, "number1@nadal.com", "Rafael", "Nadal", '1986-06-03', "Chairperson", 5, "Senior");

CREATE TABLE Court(
	CourtID INT NOT NULL,
    CourtName VARCHAR(50),
    CourtType VARCHAR(50),
    Club_ID INT NOT NULL,
    PRIMARY KEY(CourtID),
    FOREIGN KEY(Club_ID) REFERENCES TennisClub(ClubID),
    CONSTRAINT check_court_type CHECK(CourtType IN ("Hard", "Grass", "Carpet", "Clay"))
);

INSERT INTO Court VALUES (1, "Botany 1", "Hard", 1);
INSERT INTO Court VALUES (2, "Botany 2", "Hard", 1);
INSERT INTO Court VALUES (3, "Centre Court", "Grass", 2);
INSERT INTO Court VALUES (4, "Fred Perry", "Hard", 2);
INSERT INTO Court VALUES (5, "Court 3", "Hard", 2);
INSERT INTO Court VALUES (6, "Court 1", "Clay", 3);
INSERT INTO Court VALUES (7, "Fitz 1", "Hard", 4);
INSERT INTO Court VALUES (8, "Court 1", "Hard", 5);

CREATE TABLE BookingSlot (
	SlotID INT NOT NULL,
    StartTime DATETIME NOT NULL,
    EndTime DATETIME NOT NULL,
    Member_ID INT DEFAULT NULL,
    Court_ID INT NOT NULL,
    PRIMARY KEY(SlotID),
    FOREIGN KEY(Court_ID) REFERENCES Court(CourtID),
    FOREIGN KEY(Member_ID) REFERENCES ClubMember(UserID),
    CONSTRAINT chk_times CHECK(StartTime < EndTime)
);

INSERT INTO BookingSlot VALUES (1, '2021-01-01 10:00:00', '2021-01-01 10:59:00', 1, 1);
INSERT INTO BookingSlot VALUES (2, '2021-01-01 11:00:00', '2021-01-01 11:59:00', 1, 1);
INSERT INTO BookingSlot VALUES (3, '2021-01-01 10:00:00', '2021-01-01 10:59:00', NULL, 2);
INSERT INTO BookingSlot VALUES (4, '2021-01-01 10:00:00', '2021-01-01 10:59:00', 4, 5);
INSERT INTO BookingSlot VALUES (5, '2021-01-01 10:00:00', '2021-01-01 10:59:00', 10, 8);
INSERT INTO BookingSlot VALUES (6, '2021-01-01 11:00:00', '2021-01-01 11:59:00', NULL, 8);
INSERT INTO BookingSlot VALUES (7, '2021-01-01 13:00:00', '2021-01-01 13:59:00', 3, 1);
INSERT INTO BookingSlot VALUES (8, '2021-01-01 13:00:00', '2021-01-01 13:59:00', 2, 2);
INSERT INTO BookingSlot VALUES (9, '2021-01-01 14:00:00', '2021-01-01 14:59:00', NULL, 2);

CREATE TABLE Company (
	CompID INT NOT NULL,
    CompName VARCHAR(100),
    Email VARCHAR(70),
    PRIMARY KEY(CompID),
    CONSTRAINT check_compemail CHECK(Email LIKE "%@%")
);

INSERT INTO Company VALUES (1, "Wilson", "info@wilson.com");
INSERT INTO Company VALUES (2, "Babolat", "info@babolat.com");
INSERT INTO Company VALUES (3, "Tretorn", "accounts@tretorn.co.uk");
INSERT INTO Company VALUES (4, "Siam Thai Malahide", "info@siamthai.ie");
INSERT INTO Company VALUES (5, "Nike", "info@nike.com");

CREATE TABLE Sponsership (
	Comp_ID INT NOT NULL,
    Club_ID INT NOT NULL,
    PRIMARY KEY(Comp_ID, Club_ID),
    FOREIGN KEY(Comp_ID) REFERENCES Company(CompID),
    FOREIGN KEY(Club_ID) REFERENCES TennisClub(ClubID)
);

INSERT INTO Sponsership VALUES (1,1);
INSERT INTO Sponsership VALUES (2,1);
INSERT INTO Sponsership VALUES (3,4);
INSERT INTO Sponsership VALUES (1,4);
INSERT INTO Sponsership VALUES (3,2);
INSERT INTO Sponsership VALUES (4,2);
INSERT INTO Sponsership VALUES (5,3);

-- Calibrates numcourts for every club 
UPDATE TennisClub SET NumCourts=(SELECT COUNT(*) FROM Court WHERE Court.Club_ID=TennisClub.ClubID) WHERE ClubID<=5;

-- Triggers
CREATE TRIGGER delete_courts
AFTER DELETE 
ON Court FOR EACH ROW
	UPDATE TennisClub
    SET TennisClub.numcourts=TennisClub.numcourts-1
    WHERE OLD.Club_ID = TennisClub.ClubID;
    
CREATE TRIGGER add_courts
AFTER INSERT
ON Court FOR EACH ROW
	UPDATE TennisClub
    SET TennisClub.numcourts=TennisClub.numcourts+1
    WHERE NEW.Club_ID = TennisClub.ClubID;

-- Test the triggers for numcourts
-- SELECT * FROM Court;
-- SELECT * FROM TennisClub;
-- DELETE FROM Court WHERE CourtID=8;
-- SELECT * FROM Court;
-- SELECT * FROM TennisClub;

-- SELECT * FROM Court;
-- SELECT * FROM TennisClub;
-- INSERT INTO Court VALUES (9, "Court 2", "Grass", 5);
-- SELECT * FROM Court;
-- SELECT * FROM TennisClub;

-- We need to prevent double bookings on courts
DELIMITER $$
CREATE TRIGGER dub_book_insert BEFORE INSERT ON BookingSlot
FOR EACH ROW
	BEGIN
	 IF EXISTS (SELECT StartTime, EndTime, Court_ID FROM BookingSlot WHERE 
     ((NEW.Court_ID=Court_ID) AND ((NEW.StartTime BETWEEN StartTime AND EndTime) OR (NEW.EndTime BETWEEN EndTime AND StartTime)))) 
     THEN
	 SIGNAL SQLSTATE '45000'
	 SET MESSAGE_TEXT = 'Error; Double Booking';
	 END IF;
	END $$
DELIMITER ;

DELIMITER $$
CREATE TRIGGER dub_book_update BEFORE UPDATE ON BookingSlot
FOR EACH ROW
	BEGIN
	 IF EXISTS (SELECT StartTime, EndTime, Court_ID FROM BookingSlot WHERE 
     ((NEW.Court_ID=Court_ID) AND ((NEW.StartTime BETWEEN StartTime AND EndTime) OR (NEW.EndTime BETWEEN EndTime AND StartTime)))) 
     THEN 
	 SIGNAL SQLSTATE '45000'
	 SET MESSAGE_TEXT = 'Error; Double Booking';
	 END IF;
	END $$
DELIMITER ;

-- Test a double booking
-- INSERT INTO BookingSlot VALUES (10, '2021-01-01 11:00:00', '2021-01-01 12:30:00', 3, 1);

CREATE VIEW all_bookings AS
	SELECT Court.CourtName AS "Court Name", TennisClub.ClubName AS "Club", StartTime AS "Start", EndTime AS "Finish" , CONCAT_WS(" ", ClubMember.Fname, ClubMember.Lname) AS "Name"
    FROM BookingSlot
	LEFT JOIN ClubMember
    ON ClubMember.UserID=Member_ID
    JOIN Court
	ON Court.CourtID=Court_ID
    JOIN TennisClub
    ON TennisClub.ClubID=Court.Club_ID
    ORDER BY TennisClub.ClubName, Court.CourtName;

CREATE VIEW user_bookings_tcd_read AS
	SELECT Court.CourtName AS "Court Name", StartTime AS "Start", EndTime AS "Finish" , CONCAT_WS(" ", ClubMember.Fname, ClubMember.Lname) AS "Name"
    FROM BookingSlot
	LEFT JOIN ClubMember
    ON ClubMember.UserID=Member_ID
    JOIN Court
	ON Court.CourtID=Court_ID
    WHERE Court.Club_ID=1; -- 1 represent Trinity Tennis Club. For deployment this should be the user's Club_ID 

CREATE VIEW user_bookings_tcd_write AS
	SELECT BookingSlot.Member_ID AS "ID"
    FROM BookingSlot
	LEFT JOIN ClubMember
    ON ClubMember.UserID=Member_ID
    JOIN Court
	ON Court.CourtID=Court_ID
    WHERE Court.Club_ID=1 AND BookingSlot.Member_ID IS NULL; -- 1 represent Trinity Tennis Club. For deployment this should be the user's Club_ID 
    
CREATE VIEW user_bookings_tcd_com AS
	SELECT SlotID, Court.CourtName, StartTime, EndTime, Member_ID, Court_ID FROM BookingSlot
	LEFT JOIN Court
	ON Court.CourtID=Court_ID
    WHERE Court.Club_ID=1; -- 1 represent Trinity Tennis Club. For deployment this should be the user's Club_ID 

CREATE ROLE TCDMemberRole;
GRANT SELECT ON user_bookings_tcd_read TO TCDMemberRole;
GRANT UPDATE ON user_bookings_tcd_write TO TCDMemberRole;

CREATE ROLE TCDComRole; -- Committee member
GRANT SELECT ON user_bookings_tcd_read TO TCDComRole;
GRANT SELECT ON user_bookings_tcd_com TO TCDComRole;
GRANT UPDATE ON user_bookings_tcd_com TO TCDComRole;
GRANT INSERT ON user_bookings_tcd_com TO TCDComRole;
GRANT DELETE ON user_bookings_tcd_com TO TCDComRole;

