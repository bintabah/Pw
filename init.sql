CREATE DATABASE IF NOT EXISTS club;
USE club;

-- --------------------------------------------------------
-- SCHEMA
-- --------------------------------------------------------

CREATE TABLE IF NOT EXISTS categories (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nom VARCHAR(100) NOT NULL,
    code_raccourci VARCHAR(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS contacts (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nom VARCHAR(100) NOT NULL,
    prenom VARCHAR(100) NOT NULL,
    email VARCHAR(150) NOT NULL,
    numero_tel VARCHAR(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS licencies (
    id INT AUTO_INCREMENT PRIMARY KEY,
    numero_licence VARCHAR(20) NOT NULL UNIQUE,
    nom VARCHAR(100) NOT NULL,
    prenom VARCHAR(100) NOT NULL,
    contact_id INT NOT NULL,
    categorie_id INT NOT NULL,
    FOREIGN KEY (contact_id) REFERENCES contacts(id),
    FOREIGN KEY (categorie_id) REFERENCES categories(id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS educateurs (
    id INT AUTO_INCREMENT PRIMARY KEY,
    email VARCHAR(150) NOT NULL UNIQUE,
    mot_de_passe VARCHAR(255) NOT NULL,
    est_administrateur TINYINT(1) NOT NULL DEFAULT 0,
    licencie_id INT NOT NULL,
    FOREIGN KEY (licencie_id) REFERENCES licencies(id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS mail_contact (
    id INT AUTO_INCREMENT PRIMARY KEY,
    date_envoie DATETIME DEFAULT NULL,
    objet VARCHAR(255) DEFAULT NULL,
    message VARCHAR(300) DEFAULT NULL,
    expediteur_id INT DEFAULT NULL,
    FOREIGN KEY (expediteur_id) REFERENCES educateurs(id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS mail_contact_edu (
    mail_contact_id INT NOT NULL,
    contacts_id INT NOT NULL,
    PRIMARY KEY (mail_contact_id, contacts_id),
    FOREIGN KEY (mail_contact_id) REFERENCES mail_contact(id) ON DELETE CASCADE,
    FOREIGN KEY (contacts_id) REFERENCES contacts(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS mail_edu (
    id INT AUTO_INCREMENT PRIMARY KEY,
    date_envoie DATETIME DEFAULT NULL,
    objet VARCHAR(255) DEFAULT NULL,
    message VARCHAR(300) DEFAULT NULL,
    expediteur_id INT DEFAULT NULL,
    FOREIGN KEY (expediteur_id) REFERENCES educateurs(id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS mail_edu_educateur (
    mail_edu_id INT NOT NULL,
    educateurs_id INT NOT NULL,
    PRIMARY KEY (mail_edu_id, educateurs_id),
    FOREIGN KEY (mail_edu_id) REFERENCES mail_edu(id) ON DELETE CASCADE,
    FOREIGN KEY (educateurs_id) REFERENCES educateurs(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Table de suivi des migrations Doctrine (pour Symfony)
CREATE TABLE IF NOT EXISTS doctrine_migration_versions (
    version VARCHAR(191) NOT NULL,
    executed_at DATETIME DEFAULT NULL,
    execution_time INT DEFAULT NULL,
    PRIMARY KEY (version)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------
-- DONNEES DE TEST
-- --------------------------------------------------------

-- Categories
INSERT INTO categories (nom, code_raccourci) VALUES
('Moins de 12 ans', 'M12'),
('Moins de 15 ans', 'M15'),
('Moins de 18 ans', 'M18'),
('Seniors', 'SEN');

-- Contacts (un par licencié)
INSERT INTO contacts (nom, prenom, email, numero_tel) VALUES
('Dupont',   'Marie',    'marie.dupont@email.fr',     '0611111111'),
('Martin',   'Jean',     'jean.martin@email.fr',      '0622222222'),
('Bernard',  'Claire',   'claire.bernard@email.fr',   '0633333333'),
('Petit',    'Paul',     'paul.petit@email.fr',       '0644444444'),
('Robert',   'Alice',    'alice.robert@email.fr',     '0655555555'),
('Simon',    'Marc',     'marc.simon@email.fr',       '0666666666'),
('Laurent',  'Julie',    'julie.laurent@email.fr',    '0677777777'),
('Michel',   'Pierre',   'pierre.michel@email.fr',    '0688888888'),
('Leroy',    'Sophie',   'sophie.leroy@email.fr',     '0699999999'),
('Moreau',   'Isabelle', 'isabelle.moreau@email.fr',  '0610101010'),
('Girard',   'Thomas',   'thomas.girard@email.fr',    '0621212121'),
('Lefevre',  'Nathalie', 'nathalie.lefevre@email.fr', '0632323232'),
('Blanc',    'Henri',    'henri.blanc@email.fr',      '0643434343');

-- Licenciés (9 réguliers + 4 éducateurs)
INSERT INTO licencies (numero_licence, nom, prenom, contact_id, categorie_id) VALUES
('L001', 'Dupont',  'Thomas',  1,  1),
('L002', 'Martin',  'Lucas',   2,  1),
('L003', 'Bernard', 'Emma',    3,  2),
('L004', 'Petit',   'Léa',     4,  2),
('L005', 'Robert',  'Hugo',    5,  3),
('L006', 'Simon',   'Chloé',   6,  3),
('L007', 'Laurent', 'Nathan',  7,  4),
('L008', 'Michel',  'Camille', 8,  4),
('L009', 'Leroy',   'Maxime',  9,  1),
('L010', 'Moreau',  'Pierre',  10, 4),
('L011', 'Girard',  'Sophie',  11, 4),
('L012', 'Lefevre', 'Antoine', 12, 3),
('L013', 'Blanc',   'Julie',   13, 4);

-- Éducateurs (mot de passe : admin123 pour le 1er, password pour les autres)
-- admin123 → $2y$10$NiOPLuc57gNRuzDanOPbNuabY1Jj/OsUYirXR7VLHgu1wamwtNqWK
-- password → $2y$10$Q.VIgVPv7LB8mHPRBY7VYeBwP0L2/ZNP3eRmrC0I/6MROvazZuiJe
INSERT INTO educateurs (email, mot_de_passe, est_administrateur, licencie_id) VALUES
('pierre.moreau@club.fr',   '$2y$10$NiOPLuc57gNRuzDanOPbNuabY1Jj/OsUYirXR7VLHgu1wamwtNqWK', 1, 10),
('sophie.girard@club.fr',   '$2y$10$Q.VIgVPv7LB8mHPRBY7VYeBwP0L2/ZNP3eRmrC0I/6MROvazZuiJe', 0, 11),
('antoine.lefevre@club.fr', '$2y$10$Q.VIgVPv7LB8mHPRBY7VYeBwP0L2/ZNP3eRmrC0I/6MROvazZuiJe', 0, 12),
('julie.blanc@club.fr',     '$2y$10$Q.VIgVPv7LB8mHPRBY7VYeBwP0L2/ZNP3eRmrC0I/6MROvazZuiJe', 0, 13);

-- Mails entre éducateurs
INSERT INTO mail_edu (date_envoie, objet, message, expediteur_id) VALUES
('2024-01-15 10:00:00', 'Réunion équipe', 'Bonjour à tous, réunion vendredi 19 janvier à 18h en salle A. Merci de confirmer votre présence.', 1),
('2024-01-22 14:30:00', 'Planning matchs février', 'Voici le planning des matchs pour le mois de février. Merci de vous organiser en conséquence.', 2);

-- Destinataires des mails éducateurs
INSERT INTO mail_edu_educateur (mail_edu_id, educateurs_id) VALUES
(1, 2), (1, 3), (1, 4),
(2, 1), (2, 4);

-- Mails vers les contacts des licenciés
INSERT INTO mail_contact (date_envoie, objet, message, expediteur_id) VALUES
('2024-01-10 09:00:00', 'Tournoi M12 - 20 janvier', 'Bonjour, nous organisons un tournoi pour les M12 le samedi 20 janvier. Inscription avant le 15 janvier.', 1),
('2024-01-18 11:00:00', 'Stage vacances M15', 'Un stage est prévu du 5 au 9 février pour les M15. Tarif : 50€. Répondez à ce mail pour inscrire votre enfant.', 2);

-- Destinataires des mails contacts (contacts des M12 pour le premier mail)
INSERT INTO mail_contact_edu (mail_contact_id, contacts_id) VALUES
(1, 1), (1, 2), (1, 9),
(2, 3), (2, 4);

-- Marquer les migrations Doctrine comme déjà exécutées
INSERT INTO doctrine_migration_versions (version, executed_at, execution_time) VALUES
('DoctrineMigrations\\Version20240108125537', NOW(), 50),
('DoctrineMigrations\\Version20240108125538', NOW(), 45);
