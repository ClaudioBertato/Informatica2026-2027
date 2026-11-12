CREATE TABLE Topic (
    ID INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, 
    Argomento varchar(20) NOT NULL CHECK (Argomento IN ('Economia', 'Politica', 'Medicina', 'Salute e Cultura', 'Cronaca', 'Scienza e Tecnologia', 'Sport'))
);

CREATE TABLE Result (
    ID INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, 
    Validata INTEGER NOT NULL, 
    Tipologia varchar(6) NOT NULL CHECK (Tipologia IN ('Fake', 'Vera', 'Dubbia')), 
    Nota varchar(50) NOT NULL, 
    Motivazione varchar(50) NOT NULL
);

CREATE TABLE ContenutoMultimediale (
    ID INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
    Tipo varchar(10) NOT NULL
);

CREATE TABLE Commento (
    ID INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
    Testo varchar(50) NOT NULL
);

CREATE TABLE News (
    Titolo varchar(20) NOT NULL, 
    Autore TEXT varcar(20) NULL, 
    IdTopic INTEGER NOT NULL, 
    IdContenuto INTEGER NOT NULL,
    IdCommento INTEGER NOT NULL,
    IdResult INTEGER NOT NULL,
    Tipologia varchar(20) NOT NULL CHECK (Tipologia IN ('blog', 'social media', 'giornale online', 'piattaforma di streaming')),
    Nome_Fonte varchar(20) NOT NULL,
    Url TEXT varchar(30) NULL,
    Data varchar(10) NOT NULL, 
    ContenutoTestuale varchar(200) NOT NULL,
    PRIMARY KEY (Titolo, Autore),
    FOREIGN KEY (IdTopic) REFERENCES Topic(ID),
    FOREIGN KEY (IdContenuto) REFERENCES ContenutoMultimediale(ID),
    FOREIGN KEY (IdCommento) REFERENCES Commento(ID),
    FOREIGN KEY (IdResult) REFERENCES Result(ID)
);

CREATE TABLE Esperto (
    CF varchar(16) PRIMARY KEY NOT NULL CHECK (LENGTH(CF) = 16),
    Nome varchar(20) NOT NULL,
    Cognome varchar(20) NOT NULL,
    Esperto INTEGER NOT NULL
);