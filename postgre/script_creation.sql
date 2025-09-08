DROP TABLE IF EXISTS Bureau CASCADE;
DROP TABLE IF EXISTS Contact CASCADE;
DROP TABLE IF EXISTS Adresse CASCADE;
DROP TABLE IF EXISTS Entreprise CASCADE;

CREATE TABLE Entreprise (
  id UUID NOT NULL,
  nom VARCHAR(50) NOT NULL,
  ca NUMERIC(10,2),
  CONSTRAINT Entreprise_PK PRIMARY KEY (id)
);

CREATE TABLE Adresse (
  id UUID NOT NULL,
  ville VARCHAR(50) NOT NULL,
  rue VARCHAR(255) NOT NULL,
  code_postal INT NOT NULL,
  CONSTRAINT Adresse_PK PRIMARY KEY (id),
  CONSTRAINT adr_uni_rue_ville_codepost UNIQUE (ville, rue, code_postal)
);

CREATE TABLE Contact (
  id UUID NOT NULL,
  nom VARCHAR(50) NOT NULL,
  prenom VARCHAR(50) NOT NULL,
  mail VARCHAR(50) NOT NULL,
  numero VARCHAR(50) NOT NULL,
  id_Entreprise UUID NOT NULL,
  CONSTRAINT Contact_PK PRIMARY KEY (id),
  CONSTRAINT Contact_id_Entreprise_FK
      FOREIGN KEY (id_Entreprise) REFERENCES Entreprise (id) ON DELETE CASCADE
);

CREATE TABLE Bureau (
  id UUID NOT NULL,
  nom VARCHAR(50) NOT NULL,
  surface SMALLINT,
  id_Entreprise UUID NOT NULL,
  id_Adresse UUID,
  CONSTRAINT Bureau_PK PRIMARY KEY (id),
  CONSTRAINT Bureau_id_Entreprise_FK
      FOREIGN KEY (id_Entreprise) REFERENCES Entreprise (id) ON DELETE CASCADE,
  CONSTRAINT Bureau_id_Adresse_FK
      FOREIGN KEY (id_Adresse) REFERENCES Adresse (id) ON DELETE SET NULL
);
