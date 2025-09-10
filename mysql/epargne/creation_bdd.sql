-- =====================================================================
-- PARTICIPANT : référentiel des personnes du groupe
-- Choix : séparé du tour pour pouvoir réutiliser un même participant
--         dans plusieurs tours.
-- =====================================================================
CREATE TABLE participant
(
    participant_id BIGINT AUTO_INCREMENT PRIMARY KEY,
    nom            VARCHAR(120) NOT NULL,
    prenom         VARCHAR(120) NULL,
    email          VARCHAR(255) NULL,
    telephone      VARCHAR(40)  NULL,
    UNIQUE (email),
    cree_le        DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP,
    maj_le         DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE = InnoDB COMMENT ='Membres du groupe d’épargne';

-- =====================================================================
-- TOUR_EPARGNE : cadre de l’epargne rotative (mise, nb de séances, devise…)
-- Choix : la mise unitaire appartient au tour (constante pour tout le tour).
-- =====================================================================
CREATE TABLE tour_epargne
(
    tour_id       BIGINT AUTO_INCREMENT PRIMARY KEY,
    nom           VARCHAR(140)   NOT NULL,
    mise_unitaire DECIMAL(18, 2) NOT NULL CHECK (mise_unitaire > 0),
    nb_seances    INT            NOT NULL CHECK (nb_seances >= 1),
    date_debut    DATE           NOT NULL,
    devise        CHAR(3)        NOT NULL DEFAULT 'EUR',
    cree_le       DATETIME       NOT NULL DEFAULT CURRENT_TIMESTAMP,
    maj_le        DATETIME       NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE = InnoDB COMMENT ='Paramètres généraux du tour (montant de mise, calendrier global)';

-- =====================================================================
-- INSCRIPTION_TOUR : qui participe au tour + multiplicateur
-- Choix : le multiplicateur est porté par l’inscription
-- =====================================================================
CREATE TABLE inscription_tour
(
    inscription_tour_id BIGINT AUTO_INCREMENT PRIMARY KEY,
    tour_id             BIGINT   NOT NULL,
    participant_id      BIGINT   NOT NULL,
    multiplicateur      INT      NOT NULL CHECK (multiplicateur >= 1),
    UNIQUE (tour_id, participant_id),
    FOREIGN KEY (tour_id) REFERENCES tour_epargne (tour_id) ON DELETE RESTRICT ON UPDATE CASCADE,
    FOREIGN KEY (participant_id) REFERENCES participant (participant_id) ON DELETE RESTRICT ON UPDATE CASCADE,
    cree_le             DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    maj_le              DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE = InnoDB COMMENT ='Engagement d’un participant dans un tour (multiplicateur de mise)';

-- =====================================================================
-- SEANCE : chaque échéance du tour
-- =====================================================================
CREATE TABLE seance
(
    seance_id   BIGINT AUTO_INCREMENT PRIMARY KEY,
    tour_id     BIGINT   NOT NULL,
    numero      INT      NOT NULL CHECK (numero >= 1),
    date_prevue DATE     NOT NULL,
    UNIQUE (tour_id, numero),
    FOREIGN KEY (tour_id) REFERENCES tour_epargne (tour_id) ON DELETE RESTRICT ON UPDATE CASCADE,
    cree_le     DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    maj_le      DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE = InnoDB COMMENT ='Calendrier des séances d’un tour';

-- =====================================================================
-- SEANCE_BENEFICIAIRE : répartition du pot par séance
-- Choix : parts par bénéficiaire à la séance (50/50, 20/80, etc.).
--         La SOMME(part) = 1 par séance est contrôlée côté application.
-- =====================================================================
CREATE TABLE seance_beneficiaire
(
    seance_beneficiaire_id BIGINT AUTO_INCREMENT PRIMARY KEY,
    seance_id              BIGINT        NOT NULL,
    inscription_tour_id    BIGINT        NOT NULL,
    part                   DECIMAL(9, 6) NOT NULL CHECK (part > 0 AND part <= 1),
    UNIQUE (seance_id, inscription_tour_id),
    FOREIGN KEY (seance_id) REFERENCES seance (seance_id) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (inscription_tour_id) REFERENCES inscription_tour (inscription_tour_id) ON DELETE RESTRICT ON UPDATE CASCADE,
    cree_le                DATETIME      NOT NULL DEFAULT CURRENT_TIMESTAMP,
    maj_le                 DATETIME      NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE = InnoDB COMMENT ='Qui reçoit le pot à la séance et à quelle part (somme des parts = 1)';

-- =====================================================================
-- OBLIGATION : DETTE BILATERALE payeur -> bénéficiaire générée à T0
-- Choix :
--  - On génère TOUTES les obligations au début du tour (T0), une par
--    (séance × payeur × bénéficiaire de la séance).
--  - Montant = mise_unitaire(tour) × multiplicateur(payeur) × part(beneficiaire, séance).
--  - On CONSERVE AUSSI les obligations "vers soi-même" (payeur = bénéficiaire) :
--      * cela garantit que le pot théorique (somme des obligations) égale la
--        somme des cotisations.
--      * pour afficher les DETTES entre personnes, on filtrera simplement
--        payeur <> bénéficiaire.
--  - Pas de stockage dédié du “retard” : on le calcule à la demande à partir
--    de date_echeance + reste (= montant - paiements alloués).
-- =====================================================================
CREATE TABLE obligation
(
    obligation_id               BIGINT AUTO_INCREMENT PRIMARY KEY,
    seance_id                   BIGINT                      NOT NULL,
    payeur_inscription_id       BIGINT                      NOT NULL,
    beneficiaire_inscription_id BIGINT                      NOT NULL,
    montant                     DECIMAL(18, 2)              NOT NULL CHECK (montant >= 0),
    date_echeance               DATE                        NOT NULL,
    statut                      ENUM ('ouverte','cloturee') NOT NULL DEFAULT 'ouverte',
    cloturee_le                 DATETIME                    NULL,
    note                        VARCHAR(255)                NULL,
    UNIQUE (seance_id, payeur_inscription_id, beneficiaire_inscription_id),
    FOREIGN KEY (seance_id) REFERENCES seance (seance_id) ON DELETE RESTRICT ON UPDATE CASCADE,
    FOREIGN KEY (payeur_inscription_id) REFERENCES inscription_tour (inscription_tour_id) ON DELETE RESTRICT ON UPDATE CASCADE,
    FOREIGN KEY (beneficiaire_inscription_id) REFERENCES inscription_tour (inscription_tour_id) ON DELETE RESTRICT ON UPDATE CASCADE,
    cree_le                     DATETIME                    NOT NULL DEFAULT CURRENT_TIMESTAMP,
    maj_le                      DATETIME                    NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE = InnoDB COMMENT ='Dette bilatérale créée à T0, soldée progressivement par des paiements alloués';

-- =====================================================================
-- PAIEMENT : argent réellement versé par un payeur (à n’importe quel moment)
-- Choix :
--  - Un paiement peut couvrir plusieurs obligations (via allocations).
--  - seance_id est OPTIONNEL : utile pour tracer “payé le jour de la séance X”,
--    mais pas obligatoire (un paiement peut arriver hors séance).
--  - La note permet d’indiquer “difficulté financière”, etc.
-- =====================================================================
CREATE TABLE paiement
(
    paiement_id           BIGINT AUTO_INCREMENT PRIMARY KEY,
    payeur_inscription_id BIGINT         NOT NULL,
    seance_id             BIGINT         NULL,
    date_paiement         DATETIME       NOT NULL DEFAULT CURRENT_TIMESTAMP,
    montant               DECIMAL(18, 2) NOT NULL CHECK (montant > 0),
    note                  VARCHAR(255)   NULL,
    FOREIGN KEY (payeur_inscription_id) REFERENCES inscription_tour (inscription_tour_id) ON DELETE RESTRICT ON UPDATE CASCADE,
    FOREIGN KEY (seance_id) REFERENCES seance (seance_id) ON DELETE SET NULL ON UPDATE CASCADE,
    cree_le               DATETIME       NOT NULL DEFAULT CURRENT_TIMESTAMP,
    maj_le                DATETIME       NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE = InnoDB COMMENT ='Flux réel versé par un payeur (à la séance ou hors séance)';

-- =====================================================================
-- ALLOCATION_PAIEMENT : réconciliation "paiement -> obligation"
-- Choix :
--  - Un paiement peut être ventilé sur plusieurs obligations (même ou
--    différentes séances) ; une obligation peut recevoir plusieurs paiements.
-- =====================================================================
CREATE TABLE allocation_paiement
(
    allocation_id   BIGINT AUTO_INCREMENT PRIMARY KEY,
    paiement_id     BIGINT         NOT NULL,
    obligation_id   BIGINT         NOT NULL,
    montant_affecte DECIMAL(18, 2) NOT NULL CHECK (montant_affecte > 0),
    UNIQUE (paiement_id, obligation_id),
    FOREIGN KEY (paiement_id) REFERENCES paiement (paiement_id) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (obligation_id) REFERENCES obligation (obligation_id) ON DELETE CASCADE ON UPDATE CASCADE,
    cree_le         DATETIME       NOT NULL DEFAULT CURRENT_TIMESTAMP,
    maj_le          DATETIME       NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE = InnoDB COMMENT ='Affectation (totale/partielle) d’un paiement à une obligation';