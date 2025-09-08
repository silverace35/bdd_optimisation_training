# -----------------------------------------------------------------------------
#       TABLE : TEMPS
# -----------------------------------------------------------------------------

CREATE TABLE IF NOT EXISTS TEMPS
(
    ID_TEMPS BIGINT(4) PRIMARY KEY AUTO_INCREMENT ,
    ANNEE BIGINT(4) UNIQUE NOT NULL
)
    COMMENT = "";

# -----------------------------------------------------------------------------
#       TABLE : CONCESSIONNAIRE
# -----------------------------------------------------------------------------

CREATE TABLE IF NOT EXISTS CONCESSIONNAIRE
(
    ID_CONCESSIONNAIRE BIGINT(4) PRIMARY KEY AUTO_INCREMENT,
    NOM VARCHAR(128) NULL
)
    COMMENT = "";

# -----------------------------------------------------------------------------
#       TABLE : MODEL
# -----------------------------------------------------------------------------

CREATE TABLE IF NOT EXISTS MODEL
(
    ID_MODELE BIGINT(4) PRIMARY KEY AUTO_INCREMENT ,
    DESIGNATION VARCHAR(128) NULL
)
    COMMENT = "";

# -----------------------------------------------------------------------------
#       TABLE : FAIT_VENTE
# -----------------------------------------------------------------------------

CREATE TABLE IF NOT EXISTS FAIT_VENTE
(
    ID_CONCESSIONNAIRE BIGINT(4) NOT NULL,
    ID_MODELE BIGINT(4) NOT NULL,
    ID_TEMPS BIGINT(4) NOT NULL,
    NOMBRE_DE_VENTE BIGINT(4) NULL,
    PRIMARY KEY (ID_MODELE,ID_TEMPS,ID_CONCESSIONNAIRE)
)
    COMMENT = "";


# -----------------------------------------------------------------------------
#       CREATION DES REFERENCES DE TABLE
# -----------------------------------------------------------------------------


ALTER TABLE FAIT_VENTE
    ADD FOREIGN KEY FK_FAIT_VENTE_CONCESSIONNAIRE (ID_CONCESSIONNAIRE)
        REFERENCES CONCESSIONNAIRE (ID_CONCESSIONNAIRE) ;


ALTER TABLE FAIT_VENTE
    ADD FOREIGN KEY FK_FAIT_VENTE_MODEL (ID_MODELE)
        REFERENCES MODEL (ID_MODELE) ;


ALTER TABLE FAIT_VENTE
    ADD FOREIGN KEY FK_FAIT_VENTE_TEMPS (ID_TEMPS)
        REFERENCES TEMPS (ID_TEMPS) ;