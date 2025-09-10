INSERT INTO participant (participant_id, nom, prenom, email, telephone)
VALUES (1, 'Martin', 'Alice', 'alice@example.com', '0600000001'),
       (2, 'Dupont', 'Bob', 'bob@example.com', '0600000002'),
       (3, 'Bernard', 'Chloé', 'chloe@example.com', '0600000003'),
       (4, 'Nguessan', 'David', 'david@example.com', '0600000004');

INSERT INTO tour_epargne (tour_id, nom, mise_unitaire, nb_seances, date_debut, devise)
VALUES (1, 'Tour démo - obligations T0', 100.00, 3, '2025-01-15', 'EUR');

INSERT INTO inscription_tour (inscription_tour_id, tour_id, participant_id, multiplicateur)
VALUES (1, 1, 1, 2), -- Alice ×2
       (2, 1, 2, 1), -- Bob   ×1
       (3, 1, 3, 1), -- Chloé ×1
       (4, 1, 4, 1); -- David ×1

INSERT INTO seance (seance_id, tour_id, numero, date_prevue)
VALUES (1, 1, 1, '2025-01-15'),
       (2, 1, 2, '2025-02-15'),
       (3, 1, 3, '2025-03-15');

-- Répartition des bénéficiaires (somme(part)=1 par séance)
INSERT INTO seance_beneficiaire (seance_beneficiaire_id, seance_id, inscription_tour_id, part)
VALUES (1, 1, 1, 0.500000), -- S1 : Alice 50%
       (2, 1, 2, 0.500000), -- S1 : Bob   50%
       (3, 2, 1, 0.500000), -- S2 : Alice 50%
       (4, 2, 3, 0.500000), -- S2 : Chloé 50%
       (5, 3, 4, 1.000000);
-- S3 : David 100%

-- =====================================================================
-- OBLIGATIONS (DETTE BILATÉRALE) GÉNÉRÉES À T0
--  date_echeance = date de la séance
-- =====================================================================
-- S1 — parts : Alice 50% / Bob 50%
INSERT INTO obligation (obligation_id, seance_id, payeur_inscription_id, beneficiaire_inscription_id, montant,
                        date_echeance, statut)
VALUES (1, 1, 1, 1, 100.00, '2025-01-15', 'ouverte'), -- Alice -> Alice
       (2, 1, 1, 2, 100.00, '2025-01-15', 'ouverte'), -- Alice -> Bob
       (3, 1, 2, 1, 50.00, '2025-01-15', 'ouverte'),  -- Bob   -> Alice
       (4, 1, 2, 2, 50.00, '2025-01-15', 'ouverte'),  -- Bob   -> Bob
       (5, 1, 3, 1, 50.00, '2025-01-15', 'ouverte'),  -- Chloé -> Alice
       (6, 1, 3, 2, 50.00, '2025-01-15', 'ouverte'),  -- Chloé -> Bob
       (7, 1, 4, 1, 50.00, '2025-01-15', 'ouverte'),  -- David -> Alice
       (8, 1, 4, 2, 50.00, '2025-01-15', 'ouverte');
-- David -> Bob

-- S2 — parts : Alice 50% / Chloé 50%
INSERT INTO obligation (obligation_id, seance_id, payeur_inscription_id, beneficiaire_inscription_id, montant,
                        date_echeance, statut)
VALUES (9, 2, 1, 1, 100.00, '2025-02-15', 'ouverte'),  -- Alice -> Alice
       (10, 2, 1, 3, 100.00, '2025-02-15', 'ouverte'), -- Alice -> Chloé
       (11, 2, 2, 1, 50.00, '2025-02-15', 'ouverte'),  -- Bob   -> Alice
       (12, 2, 2, 3, 50.00, '2025-02-15', 'ouverte'),  -- Bob   -> Chloé
       (13, 2, 3, 1, 50.00, '2025-02-15', 'ouverte'),  -- Chloé -> Alice
       (14, 2, 3, 3, 50.00, '2025-02-15', 'ouverte'),  -- Chloé -> Chloé
       (15, 2, 4, 1, 50.00, '2025-02-15', 'ouverte'),  -- David -> Alice
       (16, 2, 4, 3, 50.00, '2025-02-15', 'ouverte');
-- David -> Chloé

-- S3 — parts : David 100%
INSERT INTO obligation (obligation_id, seance_id, payeur_inscription_id, beneficiaire_inscription_id, montant,
                        date_echeance, statut)
VALUES (17, 3, 1, 4, 200.00, '2025-03-15', 'ouverte'), -- Alice -> David
       (18, 3, 2, 4, 100.00, '2025-03-15', 'ouverte'), -- Bob   -> David
       (19, 3, 3, 4, 100.00, '2025-03-15', 'ouverte'), -- Chloé -> David
       (20, 3, 4, 4, 100.00, '2025-03-15', 'ouverte');
-- David -> David

-- =====================================================================
-- PAIEMENTS (flux réels) + ALLOCATIONS (réconciliation vers obligations)
-- S1 : tout le monde paye intégralement (pot réel = 500)
-- S2 : imprévus -> Bob partiel 60€, Chloé 0€ (pas de ligne); Alice et David OK
-- S3 : rattrapages + paiement de la séance
-- =====================================================================

-- SÉANCE 1 — paiements “normaux”, ventilés sur obligations de S1
INSERT INTO paiement (paiement_id, payeur_inscription_id, seance_id, date_paiement, montant, note)
VALUES (1, 1, 1, '2025-01-15 10:01:00', 200.00, 'S1 Alice OK'),
       (2, 2, 1, '2025-01-15 10:02:00', 100.00, 'S1 Bob OK'),
       (3, 3, 1, '2025-01-15 10:03:00', 100.00, 'S1 Chloé OK'),
       (4, 4, 1, '2025-01-15 10:04:00', 100.00, 'S1 David OK');

INSERT INTO allocation_paiement (allocation_id, paiement_id, obligation_id, montant_affecte)
VALUES
    -- Paiement 1 (Alice)
    (1, 1, 1, 100.00), -- -> Obl Alice->Alice (S1)
    (2, 1, 2, 100.00), -- -> Obl Alice->Bob   (S1)
    -- Paiement 2 (Bob)
    (3, 2, 3, 50.00),  -- -> Bob->Alice (S1)
    (4, 2, 4, 50.00),  -- -> Bob->Bob   (S1)
    -- Paiement 3 (Chloé)
    (5, 3, 5, 50.00),  -- -> Chloé->Alice (S1)
    (6, 3, 6, 50.00),  -- -> Chloé->Bob   (S1)
    -- Paiement 4 (David)
    (7, 4, 7, 50.00),  -- -> David->Alice (S1)
    (8, 4, 8, 50.00);
-- -> David->Bob   (S1)

-- SÉANCE 2 — imprévus : Bob partiel 60€, Chloé ne paye pas ; Alice & David OK
INSERT INTO paiement (paiement_id, payeur_inscription_id, seance_id, date_paiement, montant, note)
VALUES (5, 1, 2, '2025-02-15 09:30:00', 200.00, 'S2 Alice OK'),
       (6, 2, 2, '2025-02-16 14:00:00', 60.00, 'S2 Bob partiel — difficulté financière pour Bob'),
       -- (pas de paiement pour Chloé à S2)
       (7, 4, 2, '2025-02-15 09:45:00', 100.00, 'S2 David OK');

INSERT INTO allocation_paiement (allocation_id, paiement_id, obligation_id, montant_affecte)
VALUES
    -- Paiement 5 (Alice) -> obligations S2 d'Alice
    (9, 5, 9, 100.00),   -- Alice->Alice (S2)
    (10, 5, 10, 100.00), -- Alice->Chloé (S2)
    -- Paiement 6 (Bob partiel 60€) -> réparti 30/30 sur ses 2 obligations S2
    (11, 6, 11, 30.00),  -- Bob->Alice (S2)  (reste 20)
    (12, 6, 12, 30.00),  -- Bob->Chloé (S2)  (reste 20)
    -- Paiement 7 (David) -> obligations S2 de David
    (13, 7, 15, 50.00),  -- David->Alice (S2)
    (14, 7, 16, 50.00);
-- David->Chloé (S2)

-- SÉANCE 3 — rattrapages S2 + paiements S3
-- Bob rattrape S2 (40€) et paye S3 (100€) dans le même paiement (140€)
-- Chloé rattrape S2 (100€) et paye S3 (100€) (200€)
-- Alice paye S3 (200€) ; David paye S3 (100€)
INSERT INTO paiement (paiement_id, payeur_inscription_id, seance_id, date_paiement, montant, note)
VALUES (8, 2, 3, '2025-03-15 11:00:00', 140.00, 'S3 Bob : rattrapage S2 (40) + S3 (100)'),
       (9, 3, 3, '2025-03-15 11:05:00', 200.00, 'S3 Chloé : rattrapage S2 (100) + S3 (100)'),
       (10, 1, 3, '2025-03-15 11:10:00', 200.00, 'S3 Alice OK'),
       (11, 4, 3, '2025-03-15 11:15:00', 100.00, 'S3 David OK');

INSERT INTO allocation_paiement (allocation_id, paiement_id, obligation_id, montant_affecte)
VALUES
    -- Paiement 8 (Bob 140€) : 20+20 sur S2, 100 sur S3
    (15, 8, 11, 20.00),   -- Bob->Alice (S2)  solde
    (16, 8, 12, 20.00),   -- Bob->Chloé (S2)  solde
    (17, 8, 18, 100.00),  -- Bob->David (S3)
    -- Paiement 9 (Chloé 200€) : 50+50 sur S2, 100 sur S3
    (18, 9, 13, 50.00),   -- Chloé->Alice (S2) solde
    (19, 9, 14, 50.00),   -- Chloé->Chloé (S2) solde
    (20, 9, 19, 100.00),  -- Chloé->David (S3)
    -- Paiement 10 (Alice 200€) : S3
    (21, 10, 17, 200.00), -- Alice->David (S3)
    -- Paiement 11 (David 100€) : S3
    (22, 11, 20, 100.00); -- David->David (S3)
