INSERT INTO `CONCESSIONNAIRE` (`NOM`) VALUES
                                          ('Croix Rousse'),
                                          ('Gerland'),
                                          ('Mermoz'),
                                          ('Bron');

--
-- Dumping data for table `MODEL`
--

INSERT INTO `MODEL` (`DESIGNATION`) VALUES
                                        ('Clio'),
                                        ('Twingo'),
                                        ('Espace');

--
-- Dumping data for table `TEMPS`
--

INSERT INTO `TEMPS` (`ANNEE`) VALUES
                                  (2000),
                                  (2001),
                                  (2002);

--
-- Dumping data for table `FAIT_VENTE`
--

INSERT INTO `FAIT_VENTE` (`ID_CONCESSIONNAIRE`, `ID_MODELE`, `ID_TEMPS`, `NOMBRE_DE_VENTE`) VALUES(
                                                                                                      (select ID_CONCESSIONNAIRE FROM  CONCESSIONNAIRE WHERE NOM='Croix Rousse'),
                                                                                                      (select ID_MODELE FROM  MODEL WHERE DESIGNATION='Clio'),
                                                                                                      (select ID_TEMPS FROM  TEMPS WHERE ANNEE=2000), 1000);

INSERT INTO `FAIT_VENTE` (`ID_CONCESSIONNAIRE`, `ID_MODELE`, `ID_TEMPS`, `NOMBRE_DE_VENTE`) VALUES(
                                                                                                      (select ID_CONCESSIONNAIRE FROM  CONCESSIONNAIRE WHERE NOM='Croix Rousse'),
                                                                                                      (select ID_MODELE FROM  MODEL WHERE DESIGNATION='Clio'),
                                                                                                      (select ID_TEMPS FROM  TEMPS WHERE ANNEE=2001), 1500);

INSERT INTO `FAIT_VENTE` (`ID_CONCESSIONNAIRE`, `ID_MODELE`, `ID_TEMPS`, `NOMBRE_DE_VENTE`) VALUES(
                                                                                                      (select ID_CONCESSIONNAIRE FROM  CONCESSIONNAIRE WHERE NOM='Croix Rousse'),
                                                                                                      (select ID_MODELE FROM  MODEL WHERE DESIGNATION='Twingo'),
                                                                                                      (select ID_TEMPS FROM  TEMPS WHERE ANNEE=2000), 1000);

INSERT INTO `FAIT_VENTE` (`ID_CONCESSIONNAIRE`, `ID_MODELE`, `ID_TEMPS`, `NOMBRE_DE_VENTE`) VALUES(
                                                                                                      (select ID_CONCESSIONNAIRE FROM  CONCESSIONNAIRE WHERE NOM='Croix Rousse'),
                                                                                                      (select ID_MODELE FROM  MODEL WHERE DESIGNATION='Twingo'),
                                                                                                      (select ID_TEMPS FROM  TEMPS WHERE ANNEE=2001), 5000);

INSERT INTO `FAIT_VENTE` (`ID_CONCESSIONNAIRE`, `ID_MODELE`, `ID_TEMPS`, `NOMBRE_DE_VENTE`) VALUES(
                                                                                                      (select ID_CONCESSIONNAIRE FROM  CONCESSIONNAIRE WHERE NOM='Croix Rousse'),
                                                                                                      (select ID_MODELE FROM  MODEL WHERE DESIGNATION='Espace'),
                                                                                                      (select ID_TEMPS FROM  TEMPS WHERE ANNEE=2002), 1000);

INSERT INTO `FAIT_VENTE` (`ID_CONCESSIONNAIRE`, `ID_MODELE`, `ID_TEMPS`, `NOMBRE_DE_VENTE`) VALUES(
                                                                                                      (select ID_CONCESSIONNAIRE FROM  CONCESSIONNAIRE WHERE NOM='Gerland'),
                                                                                                      (select ID_MODELE FROM  MODEL WHERE DESIGNATION='Clio'),
                                                                                                      (select ID_TEMPS FROM  TEMPS WHERE ANNEE=2001), 1200);

INSERT INTO `FAIT_VENTE` (`ID_CONCESSIONNAIRE`, `ID_MODELE`, `ID_TEMPS`, `NOMBRE_DE_VENTE`) VALUES(
                                                                                                      (select ID_CONCESSIONNAIRE FROM  CONCESSIONNAIRE WHERE NOM='Gerland'),
                                                                                                      (select ID_MODELE FROM  MODEL WHERE DESIGNATION='Twingo'),
                                                                                                      (select ID_TEMPS FROM  TEMPS WHERE ANNEE=2002), 500);

INSERT INTO `FAIT_VENTE` (`ID_CONCESSIONNAIRE`, `ID_MODELE`, `ID_TEMPS`, `NOMBRE_DE_VENTE`) VALUES(
                                                                                                      (select ID_CONCESSIONNAIRE FROM  CONCESSIONNAIRE WHERE NOM='Mermoz'),
                                                                                                      (select ID_MODELE FROM  MODEL WHERE DESIGNATION='Twingo'),
                                                                                                      (select ID_TEMPS FROM  TEMPS WHERE ANNEE=2000), 1500);

INSERT INTO `FAIT_VENTE` (`ID_CONCESSIONNAIRE`, `ID_MODELE`, `ID_TEMPS`, `NOMBRE_DE_VENTE`) VALUES(
                                                                                                      (select ID_CONCESSIONNAIRE FROM  CONCESSIONNAIRE WHERE NOM='Mermoz'),
                                                                                                      (select ID_MODELE FROM  MODEL WHERE DESIGNATION='Espace'),
                                                                                                      (select ID_TEMPS FROM  TEMPS WHERE ANNEE=2001), 500);

INSERT INTO `FAIT_VENTE` (`ID_CONCESSIONNAIRE`, `ID_MODELE`, `ID_TEMPS`, `NOMBRE_DE_VENTE`) VALUES(
                                                                                                      (select ID_CONCESSIONNAIRE FROM  CONCESSIONNAIRE WHERE NOM='Bron'),
                                                                                                      (select ID_MODELE FROM  MODEL WHERE DESIGNATION='Clio'),
                                                                                                      (select ID_TEMPS FROM  TEMPS WHERE ANNEE=2001), 1000);

INSERT INTO `FAIT_VENTE` (`ID_CONCESSIONNAIRE`, `ID_MODELE`, `ID_TEMPS`, `NOMBRE_DE_VENTE`) VALUES(
                                                                                                      (select ID_CONCESSIONNAIRE FROM  CONCESSIONNAIRE WHERE NOM='Bron'),
                                                                                                      (select ID_MODELE FROM  MODEL WHERE DESIGNATION='Clio'),
                                                                                                      (select ID_TEMPS FROM  TEMPS WHERE ANNEE=2002), 500);

INSERT INTO `FAIT_VENTE` (`ID_CONCESSIONNAIRE`, `ID_MODELE`, `ID_TEMPS`, `NOMBRE_DE_VENTE`) VALUES(
                                                                                                      (select ID_CONCESSIONNAIRE FROM  CONCESSIONNAIRE WHERE NOM='Bron'),
                                                                                                      (select ID_MODELE FROM  MODEL WHERE DESIGNATION='Twingo'),
                                                                                                      (select ID_TEMPS FROM  TEMPS WHERE ANNEE=2001), 700);

INSERT INTO `FAIT_VENTE` (`ID_CONCESSIONNAIRE`, `ID_MODELE`, `ID_TEMPS`, `NOMBRE_DE_VENTE`) VALUES(
                                                                                                      (select ID_CONCESSIONNAIRE FROM  CONCESSIONNAIRE WHERE NOM='Bron'),
                                                                                                      (select ID_MODELE FROM  MODEL WHERE DESIGNATION='Twingo'),
                                                                                                      (select ID_TEMPS FROM  TEMPS WHERE ANNEE=2002), 1000);

INSERT INTO `FAIT_VENTE` (`ID_CONCESSIONNAIRE`, `ID_MODELE`, `ID_TEMPS`, `NOMBRE_DE_VENTE`) VALUES(
                                                                                                      (select ID_CONCESSIONNAIRE FROM  CONCESSIONNAIRE WHERE NOM='Bron'),
                                                                                                      (select ID_MODELE FROM  MODEL WHERE DESIGNATION='Espace'),
                                                                                                      (select ID_TEMPS FROM  TEMPS WHERE ANNEE=2002), 500);