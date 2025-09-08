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


select * from CONCESSIONNAIRE c;

select fv.ID_MODELE, fv.NOMBRE_DE_VENTE from FAIT_VENTE fv;

update CONCESSIONNAIRE c set NOM='CROIX-ROUSSE';

update FAIT_VENTE fv set
                                NOMBRE_DE_VENTE=2500,
                                ID_TEMPS=(select fv.ID_TEMPS from TEMPS t where t.ANNEE="2001")
where fv.ID_CONCESSIONNAIRE = (select c.ID_CONCESSIONNAIRE from CONCESSIONNAIRE c where c.NOM='Bron') and
    fv.ID_MODELE = (select m.ID_MODELE from MODEL m where m.DESIGNATION ='Espace') and
    fv.ID_TEMPS = (select t.ID_TEMPS from TEMPS t where t.ANNEE=2002);

SELECT
    c.NOM,
    m.DESIGNATION as 'Modèle',
    t.ANNEE AS 'Année',
    SUM(fv.NOMBRE_DE_VENTE) AS 'nombre de ventes',
    COUNT(*) AS nb_lignes
FROM FAIT_VENTE fv
         JOIN CONCESSIONNAIRE c ON c.ID_CONCESSIONNAIRE = fv.ID_CONCESSIONNAIRE
         JOIN MODEL m ON m.ID_MODELE = fv.ID_MODELE
         JOIN TEMPS t ON t.ID_TEMPS = fv.ID_TEMPS
GROUP BY c.NOM, m.DESIGNATION, t.ANNEE, fv.NOMBRE_DE_VENTE;
