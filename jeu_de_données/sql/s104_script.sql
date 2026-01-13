

-- Création de la base de données
CREATE DATABASE s104_mcd;
USE s104_mcd;

-- Tables de base (Niveau 1)
CREATE TABLE ORGANISME (
    siret INT PRIMARY KEY,
    nomOrganisme VARCHAR(50),
    raisonSociale TEXT
);

CREATE TABLE RANG (
    nomRang VARCHAR(50) PRIMARY KEY
);

CREATE TABLE TITRE (
    nomTitre VARCHAR(50) PRIMARY KEY
);

CREATE TABLE DIGNITE (
    nomDignite VARCHAR(50) PRIMARY KEY
);

CREATE TABLE GRADE (
    nomGrade VARCHAR(50) PRIMARY KEY
);

CREATE TABLE ORGANISATION (
    numOrganisation INT PRIMARY KEY,
    nomOrganisation VARCHAR(50)
);

CREATE TABLE TERRITOIRE (
    idTerritoire INT PRIMARY KEY,
    nomTerritoire VARCHAR(50)
);

CREATE TABLE ALIMENT (
    nomA VARCHAR(50) PRIMARY KEY
);

CREATE TABLE LEGUME (
    nomLegume VARCHAR(50) PRIMARY KEY
);

CREATE TABLE SAUCE (
    nomSauce VARCHAR(50) PRIMARY KEY
);

CREATE TABLE TYPE_ENTRETIEN (
    idTypeEntretien INT PRIMARY KEY,
    description TEXT,
    periodicite TEXT
);

CREATE TABLE MODELE (
    nomModele VARCHAR(50) PRIMARY KEY
);

-- Tables avec dépendances (Niveau 2)
CREATE TABLE GRADE_SUIVANT (
    nomGrade VARCHAR(50),
    nomGradSuiv VARCHAR(50),
    PRIMARY KEY (nomGrade, nomGradSuiv),
    FOREIGN KEY (nomGrade) REFERENCES GRADE(nomGrade)
);

CREATE TABLE ORDRE (
    numOrganisation INT PRIMARY KEY,
    idTerritoire INT NOT NULL,
    FOREIGN KEY (numOrganisation) REFERENCES ORGANISATION(numOrganisation),
    FOREIGN KEY (idTerritoire) REFERENCES TERRITOIRE(idTerritoire)
);

CREATE TABLE TENRAC (
    codeTenrac INT PRIMARY KEY,
    nomTenrac VARCHAR(50),
    courrielT VARCHAR(50),
    telT VARCHAR(50),
    adresseT VARCHAR(50),
    numOrganisation INT NOT NULL,
    nomGrade VARCHAR(50) NOT NULL,
    nomRang VARCHAR(50),
    nomTitre VARCHAR(50),
    nomDignite VARCHAR(50),
    siret INT NOT NULL,
    FOREIGN KEY (numOrganisation) REFERENCES ORGANISATION(numOrganisation),
    FOREIGN KEY (nomGrade) REFERENCES GRADE(nomGrade),
    FOREIGN KEY (nomRang) REFERENCES RANG(nomRang),
    FOREIGN KEY (nomTitre) REFERENCES TITRE(nomTitre),
    FOREIGN KEY (nomDignite) REFERENCES DIGNITE(nomDignite),
    FOREIGN KEY (siret) REFERENCES ORGANISME(siret)
);

CREATE TABLE LIEU (
    idLieu INT PRIMARY KEY,
    adresseLieu VARCHAR(50),
    numOrganisation INT NOT NULL,
    FOREIGN KEY (numOrganisation) REFERENCES ORDRE(numOrganisation)
);

CREATE TABLE PLAT (
    idPlat INT PRIMARY KEY,
    nomLegume VARCHAR(50),
    FOREIGN KEY (nomLegume) REFERENCES LEGUME(nomLegume)
);

CREATE TABLE MACHINE (
    nomMachine VARCHAR(50) PRIMARY KEY,
    nomModele VARCHAR(50) NOT NULL,
    FOREIGN KEY (nomModele) REFERENCES MODELE(nomModele)
);

-- Tables de haut niveau (Niveau 3 & Associations)
CREATE TABLE ENTRETIEN (
    idEntretien VARCHAR(50) PRIMARY KEY,
    date_ DATE,
    idTypeEntretien INT NOT NULL,
    nomMachine VARCHAR(50) NOT NULL,
    numOrganisation INT NOT NULL,
    codeTenrac INT NOT NULL,
    FOREIGN KEY (idTypeEntretien) REFERENCES TYPE_ENTRETIEN(idTypeEntretien),
    FOREIGN KEY (nomMachine) REFERENCES MACHINE(nomMachine),
    FOREIGN KEY (numOrganisation) REFERENCES ORGANISATION(numOrganisation),
    FOREIGN KEY (codeTenrac) REFERENCES TENRAC(codeTenrac)
);

CREATE TABLE CLUB (
    numOrganisation_1 INT PRIMARY KEY,
    numOrganisation INT,
    FOREIGN KEY (numOrganisation_1) REFERENCES ORGANISATION(numOrganisation),
    FOREIGN KEY (numOrganisation) REFERENCES ORDRE(numOrganisation)
);

CREATE TABLE REUNION (
    idReunion INT PRIMARY KEY,
    dateReunion DATE,
    intitule TEXT,
    nomMachine VARCHAR(50) NOT NULL,
    idLieu INT NOT NULL,
    FOREIGN KEY (nomMachine) REFERENCES MACHINE(nomMachine),
    FOREIGN KEY (idLieu) REFERENCES LIEU(idLieu)
);

-- Tables de relations (Many-to-Many)
CREATE TABLE participe (
    codeTenrac INT,
    idReunion INT,
    PRIMARY KEY (codeTenrac, idReunion),
    FOREIGN KEY (codeTenrac) REFERENCES TENRAC(codeTenrac),
    FOREIGN KEY (idReunion) REFERENCES REUNION(idReunion)
);

CREATE TABLE est_composee (
    idReunion INT,
    idPlat INT,
    PRIMARY KEY (idReunion, idPlat),
    FOREIGN KEY (idReunion) REFERENCES REUNION(idReunion),
    FOREIGN KEY (idPlat) REFERENCES PLAT(idPlat)
);

CREATE TABLE constitue (
    idPlat INT,
    nomA VARCHAR(50),
    PRIMARY KEY (idPlat, nomA),
    FOREIGN KEY (idPlat) REFERENCES PLAT(idPlat),
    FOREIGN KEY (nomA) REFERENCES ALIMENT(nomA)
);

CREATE TABLE constitue2 (
    idPlat INT,
    nomSauce VARCHAR(50),
    PRIMARY KEY (idPlat, nomSauce),
    FOREIGN KEY (idPlat) REFERENCES PLAT(idPlat),
    FOREIGN KEY (nomSauce) REFERENCES SAUCE(nomSauce)
);

CREATE TABLE constitue3 (
    nomA VARCHAR(50),
    nomSauce VARCHAR(50),
    PRIMARY KEY (nomA, nomSauce),
    FOREIGN KEY (nomA) REFERENCES ALIMENT(nomA),
    FOREIGN KEY (nomSauce) REFERENCES SAUCE(nomSauce)
);

CREATE TABLE depend (
    idTypeEntretien INT,
    nomModele VARCHAR(50),
    PRIMARY KEY (idTypeEntretien, nomModele),
    FOREIGN KEY (idTypeEntretien) REFERENCES TYPE_ENTRETIEN(idTypeEntretien),
    FOREIGN KEY (nomModele) REFERENCES MODELE(nomModele)
);


-- Insertions des données


-- Insertion de la table ORAGNISME
INSERT INTO ORGANISME (siret, nomOrganisme, raisonSociale) VALUES (111222333, 'TechSolutions', 'TechSolutions SARL');
INSERT INTO ORGANISME (siret, nomOrganisme, raisonSociale) VALUES (222333444, 'BioIndustries', 'BioIndustries SA');
INSERT INTO ORGANISME (siret, nomOrganisme, raisonSociale) VALUES (333444555, 'EcoBuild', 'EcoBuild Group');
INSERT INTO ORGANISME (siret, nomOrganisme, raisonSociale) VALUES (444555666, 'LogiTrans', 'LogiTrans SAS');
INSERT INTO ORGANISME (siret, nomOrganisme, raisonSociale) VALUES (555666777, 'AlimPro', 'AlimPro SAS');
INSERT INTO ORGANISME (siret, nomOrganisme, raisonSociale) VALUES (666777888, 'CyberSec', 'CyberSec Ltd');
INSERT INTO ORGANISME (siret, nomOrganisme, raisonSociale) VALUES (777888999, 'AgriDév', 'AgriDév Coop');
INSERT INTO ORGANISME (siret, nomOrganisme, raisonSociale) VALUES (888999000, 'MedTech', 'MedTech Innovation');
INSERT INTO ORGANISME (siret, nomOrganisme, raisonSociale) VALUES (101010101, 'UrbanMove', 'UrbanMove SA');
INSERT INTO ORGANISME (siret, nomOrganisme, raisonSociale) VALUES (202020202, 'GreenEnergy', 'GreenEnergy SAS');

-- Insertion de la table TENRAC
INSERT INTO TENRAC (codeTenrac, nomTenrac, courrielT, telT, adresseT, numOrganisation, nomGrade, nomRang, nomTitre, nomDignite, siret) VALUES (9001, 'Dupont Jean', 'j.dupont@tech.com', '0101', 'Paris', 1, 'Niveau 1', 'Alpha', 'Directeur', 'Grand Officier', 111222333);
INSERT INTO TENRAC (codeTenrac, nomTenrac, courrielT, telT, adresseT, numOrganisation, nomGrade, nomRang, nomTitre, nomDignite, siret) VALUES (9002, 'Martin Claire', 'c.martin@bio.com', '0102', 'Lyon', 4, 'Niveau 2', 'Beta', 'Chercheur', 'Chevalier', 222333444);
INSERT INTO TENRAC (codeTenrac, nomTenrac, courrielT, telT, adresseT, numOrganisation, nomGrade, nomRang, nomTitre, nomDignite, siret) VALUES (9003, 'Bernard Luc', 'l.bernard@eco.com', '0103', 'Paris', 3, 'Niveau 3', 'Gamma', 'Ingénieur', 'Officier', 333444555);
INSERT INTO TENRAC (codeTenrac, nomTenrac, courrielT, telT, adresseT, numOrganisation, nomGrade, nomRang, nomTitre, nomDignite, siret) VALUES (9004, 'Thomas Marie', 'm.thomas@log.com', '0104', 'Nantes', 5, 'Sénior', 'Delta', 'Manager', 'Commandeur', 444555666);
INSERT INTO TENRAC (codeTenrac, nomTenrac, courrielT, telT, adresseT, numOrganisation, nomGrade, nomRang, nomTitre, nomDignite, siret) VALUES (9005, 'Petit Julie', 'j.petit@alim.com', '0105', 'Bordeaux', 6, 'Grade A', 'Zeta', 'Technicien', 'Associé', 555666777);
INSERT INTO TENRAC (codeTenrac, nomTenrac, courrielT, telT, adresseT, numOrganisation, nomGrade, nomRang, nomTitre, nomDignite, siret) VALUES (9006, 'Robert Paul', 'p.robert@cyber.com', '0106', 'Strasbourg', 9, 'Niveau 5', 'Eta', 'Expert', 'Grand Croix', 666777888);
INSERT INTO TENRAC (codeTenrac, nomTenrac, courrielT, telT, adresseT, numOrganisation, nomGrade, nomRang, nomTitre, nomDignite, siret) VALUES (9007, 'Richard Anne', 'a.richard@agri.com', '0107', 'Marseille', 7, 'Grade B', 'Theta', 'Analyste', 'Doyen', 777888999);
INSERT INTO TENRAC (codeTenrac, nomTenrac, courrielT, telT, adresseT, numOrganisation, nomGrade, nomRang, nomTitre, nomDignite, siret) VALUES (9008, 'Durand Eric', 'e.durand@med.com', '0108', 'Toulouse', 8, 'Expert-Principal', 'Kappa', 'Architecte', 'Partenaire', 888999000);
INSERT INTO TENRAC (codeTenrac, nomTenrac, courrielT, telT, adresseT, numOrganisation, nomGrade, nomRang, nomTitre, nomDignite, siret) VALUES (9009, 'Moreau Sarah', 's.moreau@urban.com', '0109', 'Lille', 10, 'Niveau 4', 'Iota', 'Lead', 'Émérite', 101010101);
INSERT INTO TENRAC (codeTenrac, nomTenrac, courrielT, telT, adresseT, numOrganisation, nomGrade, nomRang, nomTitre, nomDignite, siret) VALUES (9010, 'Simon Pierre', 'p.simon@green.com', '0110', 'Rennes', 2, 'Niveau 2', 'Beta', 'Consultant', 'Chevalier', 202020202);

-- Insertion de la table REUNION
INSERT INTO REUNION (idReunion, dateReunion, intitule, nomMachine, idLieu) VALUES (201, '2026-02-01', 'Sécurité Mensuelle', 'MACH-01', 501);
INSERT INTO REUNION (idReunion, dateReunion, intitule, nomMachine, idLieu) VALUES (202, '2026-02-05', 'Planification Prod', 'MACH-04', 504);
INSERT INTO REUNION (idReunion, dateReunion, intitule, nomMachine, idLieu) VALUES (203, '2026-02-10', 'Revue Qualité', 'MACH-05', 503);
INSERT INTO REUNION (idReunion, dateReunion, intitule, nomMachine, idLieu) VALUES (204, '2026-02-15', 'Briefing Logistique', 'MACH-02', 502);
INSERT INTO REUNION (idReunion, dateReunion, intitule, nomMachine, idLieu) VALUES (205, '2026-02-20', 'Demo Innovation', 'MACH-03', 509);
INSERT INTO REUNION (idReunion, dateReunion, intitule, nomMachine, idLieu) VALUES (206, '2026-02-22', 'Audit Maintenance', 'MACH-06', 505);
INSERT INTO REUNION (idReunion, dateReunion, intitule, nomMachine, idLieu) VALUES (207, '2026-02-25', 'Réunion Commerciale', 'MACH-10', 508);
INSERT INTO REUNION (idReunion, dateReunion, intitule, nomMachine, idLieu) VALUES (208, '2026-03-01', 'Formation Hygiène', 'MACH-07', 504);
INSERT INTO REUNION (idReunion, dateReunion, intitule, nomMachine, idLieu) VALUES (209, '2026-03-05', 'Comité de Pilotage', 'MACH-09', 506);
INSERT INTO REUNION (idReunion, dateReunion, intitule, nomMachine, idLieu) VALUES (210, '2026-03-10', 'Point Technique', 'MACH-08', 507);

-- Insertion de la table GRADE_SUIVANT
INSERT INTO GRADE_SUIVANT (nomGrade, nomGradSuiv) VALUES ('Niveau 1', 'Niveau 2');
INSERT INTO GRADE_SUIVANT (nomGrade, nomGradSuiv) VALUES ('Niveau 2', 'Niveau 3');
INSERT INTO GRADE_SUIVANT (nomGrade, nomGradSuiv) VALUES ('Niveau 3', 'Niveau 4');
INSERT INTO GRADE_SUIVANT (nomGrade, nomGradSuiv) VALUES ('Niveau 4', 'Niveau 5');
INSERT INTO GRADE_SUIVANT (nomGrade, nomGradSuiv) VALUES ('Junior', 'Sénior');
INSERT INTO GRADE_SUIVANT (nomGrade, nomGradSuiv) VALUES ('Grade C', 'Grade B');
INSERT INTO GRADE_SUIVANT (nomGrade, nomGradSuiv) VALUES ('Grade B', 'Grade A');
INSERT INTO GRADE_SUIVANT (nomGrade, nomGradSuiv) VALUES ('Sénior', 'Expert-Principal');
INSERT INTO GRADE_SUIVANT (nomGrade, nomGradSuiv) VALUES ('Niveau 5', 'Expert-Principal');
INSERT INTO GRADE_SUIVANT (nomGrade, nomGradSuiv) VALUES ('Grade A', 'Expert-Principal');

-- Insertion de la table ORDRE
INSERT INTO ORDRE (numOrganisation, idTerritoire) VALUES (1, 75);
INSERT INTO ORDRE (numOrganisation, idTerritoire) VALUES (2, 75);
INSERT INTO ORDRE (numOrganisation, idTerritoire) VALUES (3, 13);
INSERT INTO ORDRE (numOrganisation, idTerritoire) VALUES (4, 31);
INSERT INTO ORDRE (numOrganisation, idTerritoire) VALUES (5, 69);
INSERT INTO ORDRE (numOrganisation, idTerritoire) VALUES (6, 44);
INSERT INTO ORDRE (numOrganisation, idTerritoire) VALUES (7, 33);
INSERT INTO ORDRE (numOrganisation, idTerritoire) VALUES (8, 59);
INSERT INTO ORDRE (numOrganisation, idTerritoire) VALUES (9, 67);
INSERT INTO ORDRE (numOrganisation, idTerritoire) VALUES (10, 34);

-- Insertion de la table LIEU
INSERT INTO LIEU (idLieu, adresseLieu, numOrganisation) VALUES (501, 'Batiment A', 1);
INSERT INTO LIEU (idLieu, adresseLieu, numOrganisation) VALUES (502, 'Entrepôt 4', 3);
INSERT INTO LIEU (idLieu, adresseLieu, numOrganisation) VALUES (503, 'Laboratoire Sud', 4);
INSERT INTO LIEU (idLieu, adresseLieu, numOrganisation) VALUES (504, 'Usine Est', 5);
INSERT INTO LIEU (idLieu, adresseLieu, numOrganisation) VALUES (505, 'Hangar Nord', 6);
INSERT INTO LIEU (idLieu, adresseLieu, numOrganisation) VALUES (506, 'Siège Social', 1);
INSERT INTO LIEU (idLieu, adresseLieu, numOrganisation) VALUES (507, 'Quai 12', 3);
INSERT INTO LIEU (idLieu, adresseLieu, numOrganisation) VALUES (508, 'Zone Franche', 10);
INSERT INTO LIEU (idLieu, adresseLieu, numOrganisation) VALUES (509, 'Centre R&D', 4);
INSERT INTO LIEU (idLieu, adresseLieu, numOrganisation) VALUES (510, 'Tour Green', 2);

-- Insertion de la table CLUB
INSERT INTO CLUB (numOrganisation_1, numOrganisation) VALUES (11, 1);
INSERT INTO CLUB (numOrganisation_1, numOrganisation) VALUES (12, 1);
INSERT INTO CLUB (numOrganisation_1, numOrganisation) VALUES (2, 1);
INSERT INTO CLUB (numOrganisation_1, numOrganisation) VALUES (3, 4);
INSERT INTO CLUB (numOrganisation_1, numOrganisation) VALUES (5, 4);
INSERT INTO CLUB (numOrganisation_1, numOrganisation) VALUES (6, 7);
INSERT INTO CLUB (numOrganisation_1, numOrganisation) VALUES (7, 1);
INSERT INTO CLUB (numOrganisation_1, numOrganisation) VALUES (8, 1);
INSERT INTO CLUB (numOrganisation_1, numOrganisation) VALUES (9, 10);
INSERT INTO CLUB (numOrganisation_1, numOrganisation) VALUES (10, 7);

-- Insertion de la table ENTRETIEN
INSERT INTO ENTRETIEN (idEntretien, date_, idTypeEntretien, nomMachine, numOrganisation, codeTenrac) VALUES ('ENT-001', '2026-01-10', 101, 'MACH-01', 1, 9001);
INSERT INTO ENTRETIEN (idEntretien, date_, idTypeEntretien, nomMachine, numOrganisation, codeTenrac) VALUES ('ENT-002', '2026-01-15', 102, 'MACH-02', 3, 9003);
INSERT INTO ENTRETIEN (idEntretien, date_, idTypeEntretien, nomMachine, numOrganisation, codeTenrac) VALUES ('ENT-003', '2026-01-20', 103, 'MACH-03', 9, 9006);
INSERT INTO ENTRETIEN (idEntretien, date_, idTypeEntretien, nomMachine, numOrganisation, codeTenrac) VALUES ('ENT-004', '2026-01-25', 104, 'MACH-04', 5, 9004);
INSERT INTO ENTRETIEN (idEntretien, date_, idTypeEntretien, nomMachine, numOrganisation, codeTenrac) VALUES ('ENT-005', '2026-02-01', 105, 'MACH-05', 4, 9002);
INSERT INTO ENTRETIEN (idEntretien, date_, idTypeEntretien, nomMachine, numOrganisation, codeTenrac) VALUES ('ENT-006', '2026-02-05', 106, 'MACH-06', 6, 9005);
INSERT INTO ENTRETIEN (idEntretien, date_, idTypeEntretien, nomMachine, numOrganisation, codeTenrac) VALUES ('ENT-007', '2026-02-10', 107, 'MACH-07', 7, 9007);
INSERT INTO ENTRETIEN (idEntretien, date_, idTypeEntretien, nomMachine, numOrganisation, codeTenrac) VALUES ('ENT-008', '2026-02-15', 108, 'MACH-08', 8, 9008);
INSERT INTO ENTRETIEN (idEntretien, date_, idTypeEntretien, nomMachine, numOrganisation, codeTenrac) VALUES ('ENT-009', '2026-02-20', 109, 'MACH-09', 10, 9009);
INSERT INTO ENTRETIEN (idEntretien, date_, idTypeEntretien, nomMachine, numOrganisation, codeTenrac) VALUES ('ENT-010', '2026-02-25', 110, 'MACH-10', 2, 9010);

-- Insertion de la table MACHINE
INSERT INTO MACHINE (nomMachine, nomModele) VALUES ('MACH-01', 'RX-500');
INSERT INTO MACHINE (nomMachine, nomModele) VALUES ('MACH-02', 'V-Torq 2000');
INSERT INTO MACHINE (nomMachine, nomModele) VALUES ('MACH-03', 'Cyber-X1');
INSERT INTO MACHINE (nomMachine, nomModele) VALUES ('MACH-04', 'Alpha-Jet');
INSERT INTO MACHINE (nomMachine, nomModele) VALUES ('MACH-05', 'Titan-9');
INSERT INTO MACHINE (nomMachine, nomModele) VALUES ('MACH-06', 'Eco-Flow');
INSERT INTO MACHINE (nomMachine, nomModele) VALUES ('MACH-07', 'Z-Series');
INSERT INTO MACHINE (nomMachine, nomModele) VALUES ('MACH-08', 'Meca-V1');
INSERT INTO MACHINE (nomMachine, nomModele) VALUES ('MACH-09', 'Neo-Tech');
INSERT INTO MACHINE (nomMachine, nomModele) VALUES ('MACH-10', 'Xpress-10');

-- Insertion de la table PARTICIPE
INSERT INTO participe (codeTenrac, idReunion) VALUES (9001, 201);
INSERT INTO participe (codeTenrac, idReunion) VALUES (9002, 203);
INSERT INTO participe (codeTenrac, idReunion) VALUES (9003, 204);
INSERT INTO participe (codeTenrac, idReunion) VALUES (9004, 202);
INSERT INTO participe (codeTenrac, idReunion) VALUES (9005, 206);
INSERT INTO participe (codeTenrac, idReunion) VALUES (9006, 205);
INSERT INTO participe (codeTenrac, idReunion) VALUES (9007, 208);
INSERT INTO participe (codeTenrac, idReunion) VALUES (9008, 203);
INSERT INTO participe (codeTenrac, idReunion) VALUES (9009, 207);
INSERT INTO participe (codeTenrac, idReunion) VALUES (9010, 209);
INSERT INTO participe (codeTenrac, idReunion) VALUES (9001, 210);
INSERT INTO participe (codeTenrac, idReunion) VALUES (9002, 201);

-- Insertion de la table EST_COMPOSEE
INSERT INTO est_composee (idReunion, idPlat) VALUES (201, 1);
INSERT INTO est_composee (idReunion, idPlat) VALUES (202, 2);
INSERT INTO est_composee (idReunion, idPlat) VALUES (203, 3);
INSERT INTO est_composee (idReunion, idPlat) VALUES (204, 4);
INSERT INTO est_composee (idReunion, idPlat) VALUES (205, 5);
INSERT INTO est_composee (idReunion, idPlat) VALUES (206, 6);
INSERT INTO est_composee (idReunion, idPlat) VALUES (207, 7);
INSERT INTO est_composee (idReunion, idPlat) VALUES (208, 8);
INSERT INTO est_composee (idReunion, idPlat) VALUES (209, 9);
INSERT INTO est_composee (idReunion, idPlat) VALUES (210, 10);
INSERT INTO est_composee (idReunion, idPlat) VALUES (201, 5);
INSERT INTO est_composee (idReunion, idPlat) VALUES (205, 1);

-- Insertion de la table CONSTITUE
INSERT INTO constitue (idPlat, nomA) VALUES (1, 'Carotte');
INSERT INTO constitue (idPlat, nomA) VALUES (1, 'Riz');
INSERT INTO constitue (idPlat, nomA) VALUES (2, 'Poulet');
INSERT INTO constitue (idPlat, nomA) VALUES (3, 'Tomate');
INSERT INTO constitue (idPlat, nomA) VALUES (4, 'Boeuf');
INSERT INTO constitue (idPlat, nomA) VALUES (5, 'Lentilles');
INSERT INTO constitue (idPlat, nomA) VALUES (6, 'Poisson');
INSERT INTO constitue (idPlat, nomA) VALUES (7, 'Pâtes');
INSERT INTO constitue (idPlat, nomA) VALUES (8, 'Oignon');
INSERT INTO constitue (idPlat, nomA) VALUES (9, 'Blé');
INSERT INTO constitue (idPlat, nomA) VALUES (10, 'Pomme de terre');
INSERT INTO constitue (idPlat, nomA) VALUES (2, 'Salade');

-- Insertion de la table CONSTITUE2
INSERT INTO constitue2 (idPlat, nomSauce) VALUES (1, 'Curry');
INSERT INTO constitue2 (idPlat, nomSauce) VALUES (2, 'Béchamel');
INSERT INTO constitue2 (idPlat, nomSauce) VALUES (3, 'Pesto');
INSERT INTO constitue2 (idPlat, nomSauce) VALUES (4, 'Poivre');
INSERT INTO constitue2 (idPlat, nomSauce) VALUES (5, 'Hollandaise');
INSERT INTO constitue2 (idPlat, nomSauce) VALUES (6, 'Tartare');
INSERT INTO constitue2 (idPlat, nomSauce) VALUES (7, 'Tomate');
INSERT INTO constitue2 (idPlat, nomSauce) VALUES (8, 'Aigre-douce');
INSERT INTO constitue2 (idPlat, nomSauce) VALUES (9, 'Soja');
INSERT INTO constitue2 (idPlat, nomSauce) VALUES (10, 'Béarnaise');

-- Insertion de la table DEPEND
INSERT INTO depend (idTypeEntretien, nomModele) VALUES (101, 'RX-500');
INSERT INTO depend (idTypeEntretien, nomModele) VALUES (102, 'V-Torq 2000');
INSERT INTO depend (idTypeEntretien, nomModele) VALUES (103, 'Cyber-X1');
INSERT INTO depend (idTypeEntretien, nomModele) VALUES (104, 'Alpha-Jet');
INSERT INTO depend (idTypeEntretien, nomModele) VALUES (105, 'Titan-9');
INSERT INTO depend (idTypeEntretien, nomModele) VALUES (106, 'Eco-Flow');
INSERT INTO depend (idTypeEntretien, nomModele) VALUES (107, 'Z-Series');
INSERT INTO depend (idTypeEntretien, nomModele) VALUES (108, 'Meca-V1');
INSERT INTO depend (idTypeEntretien, nomModele) VALUES (109, 'Neo-Tech');
INSERT INTO depend (idTypeEntretien, nomModele) VALUES (110, 'Xpress-10');