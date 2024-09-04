
DROP DATABASE IF EXISTS CTO;

CREATE DATABASE IF NOT EXISTS CTO; 

USE CTO;

CREATE TABLE IF NOT EXISTS diseaseTeam (
	team_ID INT NOT NULL UNIQUE AUTO_INCREMENT,
    team_name VARCHAR(100) NOT NULL UNIQUE,
    PRIMARY KEY(team_ID)
    

);

ALTER TABLE diseaseTeam AUTO_INCREMENT = 1000;

CREATE TABLE IF NOT EXISTS coordinators (
	psh_ID INT NOT NULL UNIQUE, 
	first_name VARCHAR(80) NOT NULL,
    last_name VARCHAR(80) NOT NULL,
    skill_level INT NOT NULL,
    credential VARCHAR(5) NOT NULL,
    primary_diseaseTeam VARCHAR(100) NOT NULL, 
    secondary_diseaseTeam VARCHAR(100) NOT NULL,
    in_training TINYINT NOT NULL,
    FOREIGN KEY(primary_diseaseTeam) REFERENCES diseaseTeam(team_name),
    FOREIGN KEY(secondary_diseaseTeam) REFERENCES diseaseTeam(team_name),
    PRIMARY KEY(psh_ID)
    
);

CREATE TABLE IF NOT EXISTS physicians (
	investigator_ID INT NOT NULL UNIQUE AUTO_INCREMENT,
	first_name VARCHAR(80) NOT NULL, 
	last_name VARCHAR(80) NOT NULL,
	credential VARCHAR(5) NOT NULL, 
	primary_diseaseTeam VARCHAR(100) NOT NULL,
	secondary_diseaseTeam VARCHAR(100) NOT NULL,
	FOREIGN KEY(primary_diseaseTeam) REFERENCES diseaseTeam(team_name), 
	FOREIGN KEY(secondary_diseaseTeam) REFERENCES diseaseTeam(team_name),
	PRIMARY KEY(investigator_ID)

);

ALTER TABLE physicians AUTO_INCREMENT = 20;


CREATE TABLE IF NOT EXISTS data_managers (
	psh_ID INT NOT NULL UNIQUE, 
    first_name VARCHAR(80) NOT NULL, 
    last_name VARCHAR(80) NOT NULL, 
    PRIMARY KEY(psh_ID)


);

CREATE TABLE IF NOT EXISTS studies (

	protocol_number VARCHAR(20) NOT NULL UNIQUE, 
    study_name VARCHAR(350) NOT NULL, 
    treatment_acuityLevel INT NOT NULL,
    followup_acuityLevel INT NOT NULL,
    IRB_number INT NOT NULL,
    site_number INT NOT NULL,
    study_phase INT NOT NULL, 
    coordinator_ID INT NOT NULL,
    investigator_ID INT NOT NULL,
    data_manager_ID INT NOT NULL, 
    disease_team VARCHAR(100) NOT NULL,
    sponsor VARCHAR(100) NOT NULL,
    activity_status ENUM('active','pending','suspended','completed') NOT NULL,
    
    PRIMARY KEY(protocol_number), 
    FOREIGN KEY(coordinator_ID) REFERENCES coordinators(psh_ID), 
    FOREIGN KEY(investigator_ID) REFERENCES physicians(investigator_ID),
    FOREIGN KEY(data_manager_ID) REFERENCES data_managers(psh_ID),
    FOREIGN KEY(disease_team) REFERENCES diseaseTeam(team_name)
    
    
);

CREATE TABLE IF NOT EXISTS participants (
	subject_ID INT NOT NULL UNIQUE, 
    first_name VARCHAR(80) NOT NULL, 
    last_name VARCHAR(80) NOT NULL, 
    disease_team VARCHAR(100) NOT NULL,
    study_protocol VarChar(20) NOT NULL,
    physician_ID INT NOT NULL,
    coordinator_ID INT NOT NULL, 
    consented TINYINT NOT NULL, 
    on_treatment TINYINT NOT NULL,
    
    PRIMARY KEY(subject_ID), 
    FOREIGN KEY (disease_team) REFERENCES diseaseTeam(team_name),
    FOREIGN KEY (study_protocol) REFERENCES studies(protocol_number),
    FOREIGN KEY (coordinator_ID) REFERENCES coordinators(psh_ID),
    FOREIGN KEY (physician_ID) REFERENCES physicians(investigator_ID)
    
    
);


#data insertions 

INSERT INTO diseaseTeam (team_name) VALUES ("Lung");
INSERT INTO diseaseTeam (team_name) VALUES ("Melanoma");
INSERT INTO diseaseTeam (team_name) VALUES ("Breast");
INSERT INTO diseaseTeam (team_name) VALUES ("GU");
INSERT INTO diseaseTeam (team_name) VALUES ("GI");
INSERT INTO diseaseTeam (team_name) VALUES ("Heme");
INSERT INTO diseaseTeam (team_name) VALUES ("Head and Neck");
INSERT INTO diseaseTeam (team_name) VALUES ("None");


INSERT INTO coordinators (psh_ID, first_name, last_name, skill_level, credential, primary_diseaseTeam, secondary_diseaseTeam, in_training)
VALUES (58421, "Cindy", "Black", 3, "RN", "Breast", "None", 0);

INSERT INTO coordinators (psh_ID, first_name, last_name, skill_level, credential, primary_diseaseTeam, secondary_diseaseTeam, in_training)
VALUES (78324, "Irina", "Goji", 8, "RN", "Lung", "Melanoma", 0);

INSERT INTO coordinators (psh_ID, first_name, last_name, skill_level, credential, primary_diseaseTeam, secondary_diseaseTeam, in_training)
VALUES (24376, "Peter", "Hornbach", 1, "RN", "Lung", "Melanoma", 1);

INSERT INTO coordinators (psh_ID, first_name, last_name, skill_level, credential, primary_diseaseTeam, secondary_diseaseTeam, in_training)
VALUES (12895, "Hannah", "Evans", 1, "RN", "Head and Neck", "GU", 1);

INSERT INTO coordinators (psh_ID, first_name, last_name, skill_level, credential, primary_diseaseTeam, secondary_diseaseTeam, in_training)
VALUES (22574, "Meredith", "Belga", 1, "RN", "GI", "GU", 1);

INSERT INTO coordinators (psh_ID, first_name, last_name, skill_level, credential, primary_diseaseTeam, secondary_diseaseTeam, in_training)
VALUES (98437, "Rachel", "Brooks", 5, "RN", "Heme", "None", 0);

INSERT INTO coordinators (psh_ID, first_name, last_name, skill_level, credential, primary_diseaseTeam, secondary_diseaseTeam, in_training)
VALUES (49274, "Kathleen", "Rice", 8, "RN", "GI", "GU", 0);




Insert INTO physicians (first_name, last_name, credential, primary_diseaseTeam, secondary_diseaseTeam) VALUES ("Patrick", "Ma", "MD", "Lung", "None");
Insert INTO physicians (first_name, last_name, credential, primary_diseaseTeam, secondary_diseaseTeam) VALUES ("Mitch", "Machtay", "MD", "Lung", "Melanoma");
Insert INTO physicians (first_name, last_name, credential, primary_diseaseTeam, secondary_diseaseTeam) VALUES ("John", "Miccio", "MD", "GU", "GI");
Insert INTO physicians (first_name, last_name, credential, primary_diseaseTeam, secondary_diseaseTeam) VALUES ("Joe", "Drabick", "MD", "Melanoma", "None");
Insert INTO physicians (first_name, last_name, credential, primary_diseaseTeam, secondary_diseaseTeam) VALUES ("Jane", "Joshi", "MD", "Breast", "None");

INSERT INTO data_managers (psh_ID, first_name, last_name) VALUES (34981, "Jen", "Lucier");
INSERT INTO data_managers (psh_ID, first_name, last_name) VALUES (26816, "Robin", "Smith");


Insert INTO studies (protocol_number, study_name, treatment_acuityLevel, followup_acuityLevel, IRB_number, site_number,
						study_phase, coordinator_ID, Investigator_ID, data_manager_ID, disease_team, sponsor, activity_status)
                        VALUES ("20-025", "Randomized Pembrolizumab Post-Resection Study", 3, 1, 57326, 24789, 3, 58421, 20, 34981, "Lung", "NRG", "active") ; 
INSERT INTO studies 
(protocol_number, study_name, treatment_acuityLevel, followup_acuityLevel, IRB_number, site_number, study_phase, coordinator_ID, Investigator_ID, data_manager_ID, disease_team, sponsor, activity_status)
VALUES 
("21-037", "Phase II Study of Pembrolizumab in Lung Cancer", 4, 2, 57330, 24790, 2, 12895, 21, 26816, "Lung", "SWOG", "pending");

INSERT INTO studies 
(protocol_number, study_name, treatment_acuityLevel, followup_acuityLevel, IRB_number, site_number, study_phase, coordinator_ID, Investigator_ID, data_manager_ID, disease_team, sponsor, activity_status)
VALUES 
("22-046", "Adjuvant Therapy with Nivolumab for Melanoma", 3, 1, 57340, 24791, 3, 22574, 22, 34981, "Melanoma", "Big-Ten", "active");

INSERT INTO studies 
(protocol_number, study_name, treatment_acuityLevel, followup_acuityLevel, IRB_number, site_number, study_phase, coordinator_ID, Investigator_ID, data_manager_ID, disease_team, sponsor, activity_status)
VALUES 
("23-052", "Randomized Trial of Ipilimumab for Breast Cancer", 2, 1, 57350, 24792, 1, 24376, 23, 26816, "Breast", "NRG", "suspended");

INSERT INTO studies 
(protocol_number, study_name, treatment_acuityLevel, followup_acuityLevel, IRB_number, site_number, study_phase, coordinator_ID, Investigator_ID, data_manager_ID, disease_team, sponsor, activity_status)
VALUES 
("24-063", "Combination Therapy for GI Cancer", 4, 3, 57360, 24793, 2, 49274, 24, 34981, "GI", "SWOG", "active");

INSERT INTO studies 
(protocol_number, study_name, treatment_acuityLevel, followup_acuityLevel, IRB_number, site_number, study_phase, coordinator_ID, Investigator_ID, data_manager_ID, disease_team, sponsor, activity_status)
VALUES 
("25-074", "Targeted Therapy for GU Malignancies", 3, 2, 57370, 24794, 3, 78324, 20, 26816, "GU", "Big-Ten", "pending");
INSERT INTO studies 
(protocol_number, study_name, treatment_acuityLevel, followup_acuityLevel, IRB_number, site_number, study_phase, coordinator_ID, Investigator_ID, data_manager_ID, disease_team, sponsor, activity_status)
VALUES 
("26-075", "Study of Durvalumab in Head and Neck Cancer", 4, 2, 57380, 24795, 2, 98437, 21, 34981, "Head and Neck", "NRG", "active");

INSERT INTO studies 
(protocol_number, study_name, treatment_acuityLevel, followup_acuityLevel, IRB_number, site_number, study_phase, coordinator_ID, Investigator_ID, data_manager_ID, disease_team, sponsor, activity_status)
VALUES 
("27-076", "Phase I Study of Pembrolizumab for Heme Malignancies", 3, 1, 57390, 24796, 1, 12895, 22, 26816, "Heme", "SWOG", "pending");

INSERT INTO studies 
(protocol_number, study_name, treatment_acuityLevel, followup_acuityLevel, IRB_number, site_number, study_phase, coordinator_ID, Investigator_ID, data_manager_ID, disease_team, sponsor, activity_status)
VALUES 
("28-077", "Adjuvant Therapy for Lung Cancer with Nivolumab", 4, 3, 57400, 24797, 3, 22574, 20, 34981, "Lung", "Big-Ten", "suspended");

INSERT INTO studies 
(protocol_number, study_name, treatment_acuityLevel, followup_acuityLevel, IRB_number, site_number, study_phase, coordinator_ID, Investigator_ID, data_manager_ID, disease_team, sponsor, activity_status)
VALUES 
("29-078", "Combination Therapy for Melanoma with Ipilimumab", 3, 2, 57410, 24798, 2, 24376, 23, 26816, "Melanoma", "NRG", "active");

INSERT INTO studies 
(protocol_number, study_name, treatment_acuityLevel, followup_acuityLevel, IRB_number, site_number, study_phase, coordinator_ID, Investigator_ID, data_manager_ID, disease_team, sponsor, activity_status)
VALUES 
("30-079", "Targeted Therapy for Breast Cancer with Durvalumab", 4, 1, 57420, 24799, 3, 49274, 24, 34981, "Breast", "SWOG", "pending");

INSERT INTO studies 
(protocol_number, study_name, treatment_acuityLevel, followup_acuityLevel, IRB_number, site_number, study_phase, coordinator_ID, Investigator_ID, data_manager_ID, disease_team, sponsor, activity_status)
VALUES 
("31-080", "Randomized Study of Pembrolizumab in GI Cancer", 2, 1, 57430, 24800, 1, 58421, 20, 26816, "GI", "Big-Ten", "active");

INSERT INTO studies 
(protocol_number, study_name, treatment_acuityLevel, followup_acuityLevel, IRB_number, site_number, study_phase, coordinator_ID, Investigator_ID, data_manager_ID, disease_team, sponsor, activity_status)
VALUES 
("32-081", "Phase II Study of Nivolumab for GU Malignancies", 3, 2, 57440, 24801, 2, 78324, 21, 34981, "GU", "NRG", "suspended");

INSERT INTO studies 
(protocol_number, study_name, treatment_acuityLevel, followup_acuityLevel, IRB_number, site_number, study_phase, coordinator_ID, Investigator_ID, data_manager_ID, disease_team, sponsor, activity_status)
VALUES 
("33-082", "Study of Ipilimumab in Head and Neck Cancer", 4, 3, 57450, 24802, 3, 98437, 22, 26816, "Head and Neck", "SWOG", "active");

INSERT INTO studies 
(protocol_number, study_name, treatment_acuityLevel, followup_acuityLevel, IRB_number, site_number, study_phase, coordinator_ID, Investigator_ID, data_manager_ID, disease_team, sponsor, activity_status)
VALUES 
("34-083", "Adjuvant Therapy for Heme Malignancies with Durvalumab", 3, 1, 57460, 24803, 1, 12895, 23, 34981, "Heme", "Big-Ten", "pending");

INSERT INTO studies 
(protocol_number, study_name, treatment_acuityLevel, followup_acuityLevel, IRB_number, site_number, study_phase, coordinator_ID, Investigator_ID, data_manager_ID, disease_team, sponsor, activity_status)
VALUES 
("35-084", "Combination Therapy for Lung Cancer with Pembrolizumab", 4, 2, 57470, 24804, 2, 22574, 24, 26816, "Lung", "NRG", "active");

INSERT INTO studies 
(protocol_number, study_name, treatment_acuityLevel, followup_acuityLevel, IRB_number, site_number, study_phase, coordinator_ID, Investigator_ID, data_manager_ID, disease_team, sponsor, activity_status)
VALUES 
("36-085", "Phase I Study of Nivolumab for Melanoma", 2, 1, 57480, 24805, 1, 24376, 20, 34981, "Melanoma", "SWOG", "suspended");

INSERT INTO studies 
(protocol_number, study_name, treatment_acuityLevel, followup_acuityLevel, IRB_number, site_number, study_phase, coordinator_ID, Investigator_ID, data_manager_ID, disease_team, sponsor, activity_status)
VALUES 
("37-086", "Study of Ipilimumab in Breast Cancer", 3, 2, 57490, 24806, 2, 49274, 21, 26816, "Breast", "Big-Ten", "active");

INSERT INTO studies 
(protocol_number, study_name, treatment_acuityLevel, followup_acuityLevel, IRB_number, site_number, study_phase, coordinator_ID, Investigator_ID, data_manager_ID, disease_team, sponsor, activity_status)
VALUES 
("38-087", "Randomized Study of Pembrolizumab in GI Cancer", 4, 3, 57500, 24807, 3, 58421, 22, 34981, "GI", "NRG", "pending");

INSERT INTO studies 
(protocol_number, study_name, treatment_acuityLevel, followup_acuityLevel, IRB_number, site_number, study_phase, coordinator_ID, Investigator_ID, data_manager_ID, disease_team, sponsor, activity_status)
VALUES 
("39-088", "Phase II Study of Nivolumab for GU Malignancies", 3, 1, 57510, 24808, 1, 78324, 23, 26816, "GU", "SWOG", "active");

INSERT INTO studies 
(protocol_number, study_name, treatment_acuityLevel, followup_acuityLevel, IRB_number, site_number, study_phase, coordinator_ID, Investigator_ID, data_manager_ID, disease_team, sponsor, activity_status)
VALUES 
("40-089", "Study of Ipilimumab in Head and Neck Cancer", 4, 2, 57520, 24809, 2, 98437, 24, 34981, "Head and Neck", "Big-Ten", "suspended");

INSERT INTO studies 
(protocol_number, study_name, treatment_acuityLevel, followup_acuityLevel, IRB_number, site_number, study_phase, coordinator_ID, Investigator_ID, data_manager_ID, disease_team, sponsor, activity_status)
VALUES 
("41-090", "Adjuvant Therapy for Heme Malignancies with Durvalumab", 3, 1, 57530, 24810, 3, 12895, 20, 26816, "Heme", "NRG", "active");

INSERT INTO studies 
(protocol_number, study_name, treatment_acuityLevel, followup_acuityLevel, IRB_number, site_number, study_phase, coordinator_ID, Investigator_ID, data_manager_ID, disease_team, sponsor, activity_status)
VALUES 
("42-091", "Combination Therapy for Lung Cancer with Pembrolizumab", 4, 3, 57540, 24811, 1, 22574, 21, 34981, "Lung", "SWOG", "pending");

INSERT INTO studies 
(protocol_number, study_name, treatment_acuityLevel, followup_acuityLevel, IRB_number, site_number, study_phase, coordinator_ID, Investigator_ID, data_manager_ID, disease_team, sponsor, activity_status)
VALUES 
("43-092", "Phase I Study of Nivolumab for Melanoma", 2, 1, 57550, 24812, 2, 24376, 22, 26816, "Melanoma", "Big-Ten", "active");

INSERT INTO studies 
(protocol_number, study_name, treatment_acuityLevel, followup_acuityLevel, IRB_number, site_number, study_phase, coordinator_ID, Investigator_ID, data_manager_ID, disease_team, sponsor, activity_status)
VALUES 
("44-093", "Study of Ipilimumab in Breast Cancer", 3, 2, 57560, 24813, 3, 49274, 23, 34981, "Breast", "NRG", "suspended");

INSERT INTO studies 
(protocol_number, study_name, treatment_acuityLevel, followup_acuityLevel, IRB_number, site_number, study_phase, coordinator_ID, Investigator_ID, data_manager_ID, disease_team, sponsor, activity_status)
VALUES 
("45-094", "Randomized Study of Pembrolizumab in GI Cancer", 4, 1, 57570, 24814, 2, 58421, 24, 26816, "GI", "SWOG", "active");

INSERT INTO studies 
(protocol_number, study_name, treatment_acuityLevel, followup_acuityLevel, IRB_number, site_number, study_phase, coordinator_ID, Investigator_ID, data_manager_ID, disease_team, sponsor, activity_status)
VALUES 
("46-095", "Phase II Study of Nivolumab for GU Malignancies", 3, 2, 57580, 24815, 3, 78324, 20, 34981, "GU", "Big-Ten", "pending");

INSERT INTO studies 
(protocol_number, study_name, treatment_acuityLevel, followup_acuityLevel, IRB_number, site_number, study_phase, coordinator_ID, Investigator_ID, data_manager_ID, disease_team, sponsor, activity_status)
VALUES 
("47-096", "Study of Ipilimumab in Head and Neck Cancer", 4, 3, 57590, 24816, 1, 98437, 21, 26816, "Head and Neck", "NRG", "active");

INSERT INTO studies 
(protocol_number, study_name, treatment_acuityLevel, followup_acuityLevel, IRB_number, site_number, study_phase, coordinator_ID, Investigator_ID, data_manager_ID, disease_team, sponsor, activity_status)
VALUES 
("48-097", "Adjuvant Therapy for Heme Malignancies with Durvalumab", 3, 2, 57600, 24817, 2, 12895, 22, 34981, "Heme", "SWOG", "suspended");

INSERT INTO studies 
(protocol_number, study_name, treatment_acuityLevel, followup_acuityLevel, IRB_number, site_number, study_phase, coordinator_ID, Investigator_ID, data_manager_ID, disease_team, sponsor, activity_status)
VALUES 
("49-098", "Combination Therapy for Lung Cancer with Pembrolizumab", 4, 1, 57610, 24818, 3, 22574, 23, 26816, "Lung", "Big-Ten", "active");

INSERT INTO studies 
(protocol_number, study_name, treatment_acuityLevel, followup_acuityLevel, IRB_number, site_number, study_phase, coordinator_ID, Investigator_ID, data_manager_ID, disease_team, sponsor, activity_status)
VALUES 
("50-099", "Phase I Study of Nivolumab for Melanoma", 2, 1, 57620, 24819, 1, 24376, 24, 34981, "Melanoma", "NRG", "pending");

INSERT INTO studies 
(protocol_number, study_name, treatment_acuityLevel, followup_acuityLevel, IRB_number, site_number, study_phase, coordinator_ID, Investigator_ID, data_manager_ID, disease_team, sponsor, activity_status)
VALUES 
("51-100", "Study of Ipilimumab in Breast Cancer", 3, 2, 57630, 24820, 2, 49274, 20, 26816, "Breast", "SWOG", "active");

INSERT INTO studies 
(protocol_number, study_name, treatment_acuityLevel, followup_acuityLevel, IRB_number, site_number, study_phase, coordinator_ID, Investigator_ID, data_manager_ID, disease_team, sponsor, activity_status)
VALUES 
("52-101", "Randomized Study of Pembrolizumab in GI Cancer", 4, 3, 57640, 24821, 3, 58421, 21, 34981, "GI", "Big-Ten", "suspended");

INSERT INTO studies 
(protocol_number, study_name, treatment_acuityLevel, followup_acuityLevel, IRB_number, site_number, study_phase, coordinator_ID, Investigator_ID, data_manager_ID, disease_team, sponsor, activity_status)
VALUES 
("53-102", "Phase II Study of Nivolumab for GU Malignancies", 3, 2, 57650, 24822, 1, 78324, 22, 26816, "GU", "NRG", "active");

INSERT INTO studies 
(protocol_number, study_name, treatment_acuityLevel, followup_acuityLevel, IRB_number, site_number, study_phase, coordinator_ID, Investigator_ID, data_manager_ID, disease_team, sponsor, activity_status)
VALUES 
("54-103", "Study of Ipilimumab in Head and Neck Cancer", 4, 3, 57660, 24823, 2, 98437, 23, 34981, "Head and Neck", "SWOG", "pending");

INSERT INTO studies 
(protocol_number, study_name, treatment_acuityLevel, followup_acuityLevel, IRB_number, site_number, study_phase, coordinator_ID, Investigator_ID, data_manager_ID, disease_team, sponsor, activity_status)
VALUES 
("55-104", "Adjuvant Therapy for Heme Malignancies with Durvalumab", 3, 1, 57670, 24824, 3, 12895, 24, 26816, "Heme", "Big-Ten", "active");

INSERT INTO participants (subject_ID, first_name, last_name, disease_team, study_protocol, physician_ID, coordinator_ID, consented, on_treatment)
VALUES 
(1, "John", "Doe", "Lung", "20-025", 20, 58421, 1, 1),
(2, "Jane", "Smith", "Melanoma", "22-046", 22, 22574, 1, 0),
(3, "Michael", "Johnson", "Breast", "23-052", 23, 24376, 1, 1),
(4, "Emily", "Williams", "GU", "25-074", 20, 78324, 1, 0),
(5, "David", "Brown", "GI", "24-063", 24, 49274, 1, 1),
(6, "Sarah", "Miller", "Head and Neck", "26-075", 21, 98437, 1, 1),
(7, "Daniel", "Wilson", "Heme", "27-076", 22, 12895, 1, 0),
(8, "Olivia", "Moore", "Lung", "28-077", 20, 22574, 1, 1),
(9, "James", "Taylor", "Melanoma", "29-078", 23, 24376, 1, 1),
(10, "Sophia", "Anderson", "Breast", "30-079", 24, 49274, 1, 0),
(11, "Benjamin", "Thomas", "GI", "31-080", 20, 58421, 1, 1),
(12, "Ava", "Jackson", "GU", "32-081", 21, 78324, 1, 1),
(13, "Mason", "White", "Head and Neck", "33-082", 22, 98437, 1, 0),
(14, "Amelia", "Harris", "Heme", "34-083", 23, 12895, 1, 1),
(15, "Elijah", "Martin", "Lung", "35-084", 24, 22574, 1, 1),
(16, "Sofia", "Thompson", "Melanoma", "36-085", 20, 24376, 1, 0),
(17, "Lucas", "Garcia", "Breast", "37-086", 21, 49274, 1, 1),
(18, "Layla", "Martinez", "GI", "38-087", 22, 58421, 1, 1),
(19, "Alexander", "Robinson", "GU", "39-088", 23, 78324, 1, 0),
(20, "Mia", "Clark", "Head and Neck", "40-089", 24, 98437, 1, 1),
(21, "Jameson", "Rodriguez", "Heme", "41-090", 20, 12895, 1, 1),
(22, "Scarlett", "Lopez", "Lung", "42-091", 21, 22574, 1, 0),
(23, "Luke", "Perez", "Melanoma", "43-092", 22, 24376, 1, 1),
(24, "Chloe", "Williams", "Breast", "44-093", 23, 49274, 1, 1),
(25, "Hudson", "Sanchez", "GI", "45-094", 24, 58421, 1, 0),
(26, "Zoey", "Ramirez", "GU", "46-095", 20, 78324, 1, 1),
(27, "Penelope", "Walker", "Head and Neck", "47-096", 21, 98437, 1, 1),
(28, "Mateo", "Gonzalez", "Heme", "48-097", 22, 12895, 1, 0),
(29, "Ariana", "Perez", "Lung", "49-098", 23, 22574, 1, 1),
(30, "Leo", "Torres", "Melanoma", "50-099", 24, 24376, 1, 1),
(31, "Claire", "Hill", "Breast", "51-100", 20, 49274, 1, 0),
(32, "Blake", "Moore", "GI", "52-101", 21, 58421, 1, 1),
(33, "Adeline", "King", "GU", "53-102", 22, 78324, 1, 1),
(34, "Elias", "Scott", "Head and Neck", "54-103", 23, 98437, 1, 0),
(35, "Aurora", "Green", "Heme", "55-104", 24, 12895, 1, 1);

INSERT INTO participants (subject_ID, first_name, last_name, disease_team, study_protocol, physician_ID, coordinator_ID, consented, on_treatment)
VALUES (10001, "Emma", "Smith", "Lung", "20-025", 20, 58421, 1, 1);

INSERT INTO participants (subject_ID, first_name, last_name, disease_team, study_protocol, physician_ID, coordinator_ID, consented, on_treatment)
VALUES (10002, "Oliver", "Johnson", "Melanoma", "22-046", 22, 22574, 1, 0);

INSERT INTO participants (subject_ID, first_name, last_name, disease_team, study_protocol, physician_ID, coordinator_ID, consented, on_treatment)
VALUES (10003, "Sophia", "Williams", "Breast", "23-052", 23, 24376, 0, 1);

INSERT INTO participants (subject_ID, first_name, last_name, disease_team, study_protocol, physician_ID, coordinator_ID, consented, on_treatment)
VALUES (10004, "James", "Jones", "GU", "25-074", 20, 78324, 1, 1);

INSERT INTO participants (subject_ID, first_name, last_name, disease_team, study_protocol, physician_ID, coordinator_ID, consented, on_treatment)
VALUES (10005, "Isabella", "Brown", "GI", "24-063", 24, 49274, 1, 0);

INSERT INTO participants (subject_ID, first_name, last_name, disease_team, study_protocol, physician_ID, coordinator_ID, consented, on_treatment)
VALUES (10006, "Mason", "Davis", "Head and Neck", "26-075", 21, 98437, 1, 1);

INSERT INTO participants (subject_ID, first_name, last_name, disease_team, study_protocol, physician_ID, coordinator_ID, consented, on_treatment)
VALUES (10007, "Ava", "Miller", "Heme", "27-076", 22, 12895, 1, 0);

INSERT INTO participants (subject_ID, first_name, last_name, disease_team, study_protocol, physician_ID, coordinator_ID, consented, on_treatment)
VALUES (10008, "William", "Garcia", "Lung", "28-077", 20, 22574, 0, 1);

INSERT INTO participants (subject_ID, first_name, last_name, disease_team, study_protocol, physician_ID, coordinator_ID, consented, on_treatment)
VALUES (10009, "Charlotte", "Martinez", "Melanoma", "29-078", 22, 24376, 1, 1);

INSERT INTO participants (subject_ID, first_name, last_name, disease_team, study_protocol, physician_ID, coordinator_ID, consented, on_treatment)
VALUES (10010, "Michael", "Hernandez", "Breast", "30-079", 23, 49274, 0, 1);

INSERT INTO participants (subject_ID, first_name, last_name, disease_team, study_protocol, physician_ID, coordinator_ID, consented, on_treatment)
VALUES (10011, "Amelia", "Lopez", "GI", "31-080", 24, 58421, 1, 0);

INSERT INTO participants (subject_ID, first_name, last_name, disease_team, study_protocol, physician_ID, coordinator_ID, consented, on_treatment)
VALUES (10012, "Ethan", "Gonzalez", "GU", "32-081", 21, 78324, 1, 1);

INSERT INTO participants (subject_ID, first_name, last_name, disease_team, study_protocol, physician_ID, coordinator_ID, consented, on_treatment)
VALUES (10013, "Evelyn", "Perez", "Head and Neck", "33-082", 22, 98437, 0, 1);

INSERT INTO participants (subject_ID, first_name, last_name, disease_team, study_protocol, physician_ID, coordinator_ID, consented, on_treatment)
VALUES (10014, "Jacob", "Torres", "Heme", "34-083", 23, 12895, 1, 0);

INSERT INTO participants (subject_ID, first_name, last_name, disease_team, study_protocol, physician_ID, coordinator_ID, consented, on_treatment)
VALUES (10015, "Mia", "Flores", "Lung", "35-084", 24, 22574, 1, 1);

INSERT INTO participants (subject_ID, first_name, last_name, disease_team, study_protocol, physician_ID, coordinator_ID, consented, on_treatment)
VALUES (10016, "Alexander", "Reyes", "Melanoma", "36-085", 20, 24376, 0, 1);

INSERT INTO participants (subject_ID, first_name, last_name, disease_team, study_protocol, physician_ID, coordinator_ID, consented, on_treatment)
VALUES (10017, "Abigail", "King", "Breast", "37-086", 21, 49274, 1, 0);

INSERT INTO participants (subject_ID, first_name, last_name, disease_team, study_protocol, physician_ID, coordinator_ID, consented, on_treatment)
VALUES (10018, "Daniel", "Scott", "GI", "38-087", 22, 58421, 1, 1);

INSERT INTO participants (subject_ID, first_name, last_name, disease_team, study_protocol, physician_ID, coordinator_ID, consented, on_treatment)
VALUES (10019, "Sophie", "Green", "GU", "39-088", 23, 78324, 0, 1);

INSERT INTO participants (subject_ID, first_name, last_name, disease_team, study_protocol, physician_ID, coordinator_ID, consented, on_treatment)
VALUES (10020, "Gabriel", "Adams", "Head and Neck", "40-089", 24, 98437, 1, 1);

INSERT INTO participants (subject_ID, first_name, last_name, disease_team, study_protocol, physician_ID, coordinator_ID, consented, on_treatment)
VALUES (10021, "Madison", "Baker", "Heme", "41-090", 20, 12895, 1, 0);

INSERT INTO participants (subject_ID, first_name, last_name, disease_team, study_protocol, physician_ID, coordinator_ID, consented, on_treatment)
VALUES (10022, "Jackson", "Gonzales", "Lung", "42-091", 21, 22574, 0, 1);

INSERT INTO participants (subject_ID, first_name, last_name, disease_team, study_protocol, physician_ID, coordinator_ID, consented, on_treatment)
VALUES (10023, "Avery", "Carter", "Melanoma", "43-092", 22, 24376, 1, 1);

INSERT INTO participants (subject_ID, first_name, last_name, disease_team, study_protocol, physician_ID, coordinator_ID, consented, on_treatment)
VALUES (10024, "Joseph", "Perez", "Breast", "44-093", 23, 49274, 0, 1);

INSERT INTO participants (subject_ID, first_name, last_name, disease_team, study_protocol, physician_ID, coordinator_ID, consented, on_treatment)
VALUES (10025, "Camila", "Evans", "GI", "45-094", 24, 58421, 1, 1);














SELECT * FROM participants;
