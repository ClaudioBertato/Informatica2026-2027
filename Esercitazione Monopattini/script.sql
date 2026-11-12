sqlite3 GestioneMonopattiniComune.db;
create table Utente (CF text primary key not null, Nome text not null, Cognome text not null, Email text not null, Telefono integer not null);
INSERT INTO Utente (CF, Nome, Cognome, Email, Telefono) VALUES     
('RSSMRA80A01H501U', 'Mario', 'Rossi', 'mario.rossi@email.it', '0212345678'),
('BRNLRA85M42H501Z', 'Laura', 'Bianchi', 'laura.bianchi@email.com', '3339876543'),
('VRDGLN90T15F205W', 'Giulio', 'Verdi', 'giulio.verdi@outlook.it', '0654321098'),
('NNCFRN95A50L219X', 'Francesca', 'Neri', 'francesca.neri@gmail.com', '3471122334'),
('RZZLNZ88E20F205D', 'Lorenzo', 'Rizzo', 'lorenzo.rizzo@email.com', '3205566778');

create table Monopattino (ID integer primary key not null, Targa text check (Targa GLOB '[A-Z][A-Z][A-Z][0-9][0-9][0-9]'), Disponibile BIT not null);
INSERT INTO Monopattino (ID, targa) VALUES 
(1, 'XYZ543', true),
(2, 'LMN982', false),
(3, 'RST107', false),
(4, 'BJK465', true),
(5, 'WCV839', true);

create table Noleggi (CF_Persona text not null, ID_Monopattino integer not null, ID_Noleggio integer not null, Data text not null, Ora text not null, PRIMARY KEY(CF_Persona, ID_Monopattino, ID_Noleggio));  
INSERT INTO Noleggi (CF_Persona, ID_Monopattino, ID_Noleggio, Data, Ora) VALUES 
('RSSMRA80A01H501U', 1, 101, '2026-10-20', '08:30:00'),
('BRNLRA85M42H501Z', 2, 102, '2026-10-20', '09:15:00'),
('VRDGLN90T15F205W', 3, 103, '2026-10-20', '12:00:00'),
('NNCFRN95A50L219X', 4, 104, '2026-10-21', '14:45:00'),
('RZZLNZ88E20F205D', 5, 105, '2026-10-21', '17:30:00'),
('RSSMRA80A01H501U', 3, 106, '2026-10-21', '18:10:00'),
('BRNLRA85M42H501Z', 5, 107, '2026-10-22', '08:00:00'),
('VRDGLN90T15F205W', 1, 108, '2026-10-22', '10:30:00'),
('NNCFRN95A50L219X', 2, 109, '2026-10-22', '13:15:00'),
('RZZLNZ88E20F205D', 4, 110, '2026-10-22', '16:00:00');


--MODIFICA DATI--
UPDATE Utente SET Telefono = '3339998877' WHERE CF = 'RSSMRA80A01H501U'; --1
UPDATE Monopattino SET Disponibile = 0 WHERE ID = 1; --2

ALTER TABLE Monopattino ADD Costo integer; --5
UPDATE Monopattino SET Costo = 1 WHERE ID = 1;--3

DELETE FROM Noleggi WHERE ID_Noleggio = 101; --4

--QUERY--
SELECT * FROM Utente; --1
SELECT * FROM Monopattino WHERE Disponibile = 1; --2
SELECT * FROM Noleggi WHERE CF_Persona = 'RSSMRA80A01H501U'; --3

SELECT COUNT(*) FROM Noleggi;
SELECT AVG(Costo) AS CostoMedio FROM Monopattino;


--Approfondimento manutenzione--
--Creazione tabella--
CREATE TABLE Manutenzione (
    ID_Manutenzione INTEGER NOT NULL,
    ID_Monopattino INTEGER NOT NULL,
    Data_Intervento DATE NOT NULL,
    Descrizione TEXT NOT NULL,
    Costo INTEGER NOT NULL,

    -- Chiave primaria composta (ID Manutenzione + ID Monopattino)
    PRIMARY KEY (ID_Manutenzione, ID_Monopattino),

    -- Chiave esterna per il monopattino interessato
    FOREIGN KEY (ID_Monopattino)
        REFERENCES Monopattino (ID)
);


--Popolamento tabella--
INSERT INTO Manutenzione (ID_Manutenzione, ID_Monopattino, Data_Intervento, Descrizione, Costo) VALUES
(1, 1, '2026-10-01', 'Sostituzione pastiglie freno posteriore', 25),
(1, 2, '2026-10-02', 'Riparazione pneumatico forato e camera d aria', 30),
(2, 3, '2026-10-05', 'Sostituzione leva dell acceleratore danneggiata', 45),
(3, 4, '2026-10-10', 'Aggiornamento firmware e calibrazione batteria', 15),
(4, 5, '2026-10-12', 'Riparazione cavo del freno e test di sicurezza', 20),
(5, 1, '2026-10-15', 'Sostituzione totale del pacco batteria esausto', 120),
(2, 2, '2026-10-18', 'Sostituzione parafango posteriore e luce LED', 35),
(6, 3, '2026-10-20', 'Serraggio piantone dello sterzo e accoppiamenti', 10),
(7, 4, '2026-10-22', 'Sostituzione cuscinetti della ruota anteriore', 40),
(8, 5, '2026-10-25', 'Ripristino graffi telaio e sostituzione manopole', 25);

