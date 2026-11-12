sqlite3 CompagniaAerea.db;
create table Passeggero (CF text primary key not null, Nome text not null, Cognome text not null, Telefono integer not null);
INSERT INTO Passeggero (CF, Nome, Cognome, Telefono) VALUES     
('RSSMRA80A01H501U', 'Mario', 'Rossi', '0212345678'),
('BRNLRA85M42H501Z', 'Laura', 'Bianchi', '3339876543'),
('VRDGLN90T15F205W', 'Giulio', 'Verdi', '0654321098'),
('NNCFRN95A50L219X', 'Francesca', 'Neri', '3471122334'),
('RZZLNZ88E20F205D', 'Lorenzo', 'Rizzo', '3205566778'),
('CRSMRC92P12F205K', 'Marco', 'Conti', '3498877665');


create table Biglietto (ID integer primary key not null, NPosto text check (NPosto GLOB '[0-3][0-9][A-F]'), Prezzo integer not null);
INSERT INTO Biglietto (ID, NPosto, Prezzo) VALUES 
(1, '01A', 50),
(2, '03B', 50),
(3, '05C', 50),
(4, '07D', 50),
(5, '09E', 50),
(6, '12A', 45),
(7, '14B', 45),
(8, '16C', 45),
(9, '18D', 45),
(10, '21A', 40),
(11, '25B', 40),
(12, '30C', 40);

create table Volo (ID text primary key not null, Partenza text not null, Arrivo integer not null, Data text not null, OraPartenza text not null, OraArrivoPrevista text not null);  
INSERT INTO Volo (ID, Partenza, Arrivo, Data, OraPartenza, OraArrivoPrevista) VALUES
('AZ123', 'Venezia', 'Roma', '2026-11-15', '08:30', '09:45'),
('IT456', 'Milano', 'Napoli', '2026-11-15', '10:00', '11:15'),
('FR789', 'Bologna', 'Catania', '2026-11-16', '14:20', '16:00'),
('AZ321', 'Torino', 'Roma', '2026-11-16', '18:40', '19:55'),
('VO654', 'Verona', 'Palermo', '2026-11-17', '07:15', '09:00');


--MODIFICA DATI--
UPDATE Passeggero SET Telefono = '3339998877' WHERE CF = 'RSSMRA80A01H501U'; --1
UPDATE Biglietto SET Prezzo = 55 WHERE ID = 2; --2

ALTER TABLE Passeggero ADD Email text; --5
UPDATE Biglietto SET NPosto = 02A WHERE ID = 1;--3

DELETE FROM Biglietto WHERE ID = 1; --4

--QUERY--
SELECT * FROM Passeggero; --1
SELECT * FROM Volo WHERE Data = '2026-11-15'; --2 Voli in quel giorno
SELECT * FROM Biglietto; --3

SELECT COUNT(*) FROM Passeggero;
SELECT AVG(prezzo) AS CostoMedio FROM Biglietto;

DROP TABLE Volo --Rifaccio la tabella da capo per aggiungere le colonne IDPartenza e IDArrivo per gli aereoporti (foreignkey)

CREATE TABLE Volo (
    ID TEXT PRIMARY KEY NOT NULL,
    Partenza TEXT NOT NULL,
    Arrivo TEXT NOT NULL,
    Data TEXT NOT NULL,
    OraPartenza TEXT NOT NULL,
    OraArrivoPrevista TEXT NOT NULL,
    IDPartenza TEXT NOT NULL,
    IDArrivo TEXT NOT NULL,
    FOREIGN KEY (IDPartenza) REFERENCES Aereoporto(ID),
    FOREIGN KEY (IDArrivo) REFERENCES Aereoporto(ID)
);

INSERT INTO Volo (ID, Partenza, Arrivo, Data, OraPartenza, OraArrivoPrevista, IDPartenza, IDArrivo) VALUES
('AZ123', 'Venezia', 'Roma', '2026-11-15', '08:30', '09:45', 'VCE', 'FCO'),
('IT456', 'Milano', 'Napoli', '2026-11-15', '10:00', '11:15', 'MXP', 'NAP'),
('FR789', 'Bologna', 'Catania', '2026-11-16', '14:20', '16:00', 'BLQ', 'CTA'),
('AZ321', 'Torino', 'Roma', '2026-11-16', '18:40', '19:55', 'TRN', 'FCO'),
('VO654', 'Verona', 'Palermo', '2026-11-17', '07:15', '09:00', 'VRN', 'PMO');

--Approfondimento Aereoporto--
--Creazione tabella--
CREATE TABLE Aereoporto (
    ID TEXT NOT NULL primary key,
    NomeAereoporto TEXT NOT NULL,
    Citta text NOT NULL,
    Regione TEXT NOT NULL
);


--Popolamento tabella--
INSERT INTO Aereoporto (ID, NomeAereoporto, Citta, Regione) VALUES 
('VCE', 'Aeroporto Marco Polo', 'Venezia', 'Veneto'),
('FCO', 'Aeroporto di Roma-Fiumicino', 'Roma', 'Lazio'),
('MXP', 'Aeroporto di Milano-Malpensa', 'Milano', 'Lombardia'),
('NAP', 'Aeroporto di Napoli-Capodichino', 'Napoli', 'Campania'),
('BLQ', 'Aeroporto di Bologna-Borgo Panigale', 'Bologna', 'Emilia-Romagna'),
('CTA', 'Aeroporto di Catania-Fontanarossa', 'Catania', 'Sicilia'),
('TRN', 'Aeroporto di Torino-Caselle', 'Torino', 'Piemonte'),
('PMO', 'Aeroporto di Palermo-Punta Raisi', 'Palermo', 'Sicilia');

