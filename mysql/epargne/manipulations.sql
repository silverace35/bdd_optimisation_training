/* =====================================================================
   VUE 1 : vue_obligation_etat
   - État de chaque obligation (bilatéral payeur -> bénéficiaire).
   - Affiche : dû, payé, reste, échéance, retard courant/ancien,
               noms lisibles des payeur/bénéficiaire, tour, séance.
   - Calcul du "retard" : à la demande (date_echeance vs CURDATE()).
   ===================================================================== */
CREATE OR REPLACE VIEW vue_obligation_etat AS
SELECT o.obligation_id,
       s.tour_id,
       o.seance_id,
       s.numero                                                                         AS numero_seance,
       s.date_prevue                                                                    AS date_seance,

       o.payeur_inscription_id,
       p_pay.participant_id                                                             AS payeur_participant_id,
       CONCAT(ppay.prenom, ' ', ppay.nom)                                               AS payeur_nom,

       o.beneficiaire_inscription_id,
       p_ben.participant_id                                                             AS beneficiaire_participant_id,
       CONCAT(pben.prenom, ' ', pben.nom)                                               AS beneficiaire_nom,

       o.montant                                                                        AS montant_du,
       COALESCE(ap.montant_paye, 0)                                                     AS montant_paye,
       (o.montant - COALESCE(ap.montant_paye, 0))                                       AS reste,

       o.date_echeance,
       (o.date_echeance < CURDATE() AND (o.montant - COALESCE(ap.montant_paye, 0)) > 0) AS est_en_retard,
       (o.cloturee_le IS NOT NULL AND o.cloturee_le > o.date_echeance)                  AS a_ete_en_retard,

       o.statut,
       o.cloturee_le
FROM obligation o
         JOIN seance s ON s.seance_id = o.seance_id
         JOIN inscription_tour p_pay ON p_pay.inscription_tour_id = o.payeur_inscription_id
         JOIN participant ppay ON ppay.participant_id = p_pay.participant_id
         JOIN inscription_tour p_ben ON p_ben.inscription_tour_id = o.beneficiaire_inscription_id
         JOIN participant pben ON pben.participant_id = p_ben.participant_id
         LEFT JOIN (SELECT obligation_id, SUM(montant_affecte) AS montant_paye
                    FROM allocation_paiement
                    GROUP BY obligation_id) ap ON ap.obligation_id = o.obligation_id;

/* =====================================================================
   VUE 2 : vue_reception_beneficiaires
   - Par séance et par bénéficiaire :
     * devait recevoir (théorique) = somme des obligations où il est bénéficiaire
     * reçu effectif = somme allouée aux obligations où il est bénéficiaire
     * manque à gagner = différence
   ===================================================================== */
CREATE OR REPLACE VIEW vue_reception_beneficiaires AS
SELECT s.seance_id,
       s.tour_id,
       s.numero                                              AS numero_seance,
       s.date_prevue                                         AS date_seance,
       o.beneficiaire_inscription_id,
       b.participant_id                                      AS beneficiaire_participant_id,
       CONCAT(pb.prenom, ' ', pb.nom)                        AS beneficiaire_nom,
       SUM(o.montant)                                        AS devait_recevoir,
       COALESCE(SUM(ap.montant_affecte), 0)                  AS recu_effectif,
       SUM(o.montant) - COALESCE(SUM(ap.montant_affecte), 0) AS manque_a_gagner
FROM obligation o
         JOIN seance s ON s.seance_id = o.seance_id
         JOIN inscription_tour b ON b.inscription_tour_id = o.beneficiaire_inscription_id
         JOIN participant pb ON pb.participant_id = b.participant_id
         LEFT JOIN allocation_paiement ap ON ap.obligation_id = o.obligation_id
GROUP BY s.seance_id, s.tour_id, s.numero, s.date_prevue,
         o.beneficiaire_inscription_id, b.participant_id, beneficiaire_nom;

/* =====================================================================
   VUE 3 : vue_soldes_paires
   - Soldes agrégés par paire payeur -> bénéficiaire (par tour).
   - Filtre les auto-obligations (payeur != bénéficiaire) pour lire
     "qui doit à qui" entre personnes.
   ===================================================================== */
CREATE OR REPLACE VIEW vue_soldes_paires AS
SELECT s.tour_id,
       o.payeur_inscription_id,
       ip.participant_id                                     AS payeur_participant_id,
       CONCAT(pp.prenom, ' ', pp.nom)                        AS payeur_nom,

       o.beneficiaire_inscription_id,
       ib.participant_id                                     AS beneficiaire_participant_id,
       CONCAT(pb.prenom, ' ', pb.nom)                        AS beneficiaire_nom,

       SUM(o.montant)                                        AS du_total,
       COALESCE(SUM(ap.montant_affecte), 0)                  AS paye_total,
       SUM(o.montant) - COALESCE(SUM(ap.montant_affecte), 0) AS reste_total
FROM obligation o
         JOIN seance s ON s.seance_id = o.seance_id
         JOIN inscription_tour ip ON ip.inscription_tour_id = o.payeur_inscription_id
         JOIN participant pp ON pp.participant_id = ip.participant_id
         JOIN inscription_tour ib ON ib.inscription_tour_id = o.beneficiaire_inscription_id
         JOIN participant pb ON pb.participant_id = ib.participant_id
         LEFT JOIN allocation_paiement ap ON ap.obligation_id = o.obligation_id
WHERE o.payeur_inscription_id <> o.beneficiaire_inscription_id
GROUP BY s.tour_id,
         o.payeur_inscription_id, ip.participant_id, payeur_nom,
         o.beneficiaire_inscription_id, ib.participant_id, beneficiaire_nom;

-- Test des vues
select * from vue_obligation_etat;
select * from vue_reception_beneficiaires;
select * from vue_soldes_paires;