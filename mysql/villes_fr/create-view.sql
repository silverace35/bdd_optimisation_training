DROP VIEW departement_stats IF EXISTS;
CREATE VIEW departement_stats AS
SELECT departement_id, COUNT(*) AS nbr_items,
       SUM(v.ville_surface) AS dpt_surface,
       SUM(v.ville_population_2012) AS dpt_population_2012
FROM departement d
         INNER JOIN villes_france_free v ON d.departement_code = v.ville_departement
GROUP BY departement_id;

select dv.dpt_surface, d.departement_nom, d.departement_code, d.departement_id
from departement_stats dv
JOIN departement d ON d.departement_id = dv.departement_id
order by dpt_surface desc
limit 5;

DROP TABLE IF EXISTS test_json;
CREATE TABLE IF NOT EXISTS test_json
(
    id INTEGER NOT NULL PRIMARY KEY AUTO_INCREMENT,
    options JSON NOT NULL
);

INSERT INTO test_json(options)
VALUES (JSON_ARRAY('Valeur1', 'Valeur2', 'Valeur3', 'Valeur4'));
SELECT JSON_TYPE(options) FROM test_json;

UPDATE test_json SET options = JSON_ARRAY_APPEND(options, '$', 'Valeur05');

UPDATE test_json SET options = JSON_ARRAY_INSERT(options, '$[0]', 'Valeur01');

INSERT INTO test_json(options) VALUES('{"key1": "Value1", "key2": "Value2"}');

UPDATE test_json SET options = JSON_ARRAY_APPEND(options, '$', 'Valeur05');

UPDATE test_json SET options = JSON_ARRAY_INSERT(options, '$[0]', 'Valeur01');

INSERT INTO test_json(options) VALUES(JSON_OBJECT('key3', 'Value3', 'key4', 'Value4'));

SELECT JSON_EXTRACT(options, '$[3]') FROM test_json;
SELECT JSON_UNQUOTE(JSON_EXTRACT(options, '$[3]')) FROM test_json;

INSERT INTO test_json(options) VALUES('{"key1": "Value1", "key2": "Value2"}');
INSERT INTO test_json(options) VALUES('{"key3": "Value3", "key4": "Value4"}');
-- Get by key
SELECT JSON_EXTRACT(options, '$.key1') FROM test_json;
SELECT JSON_UNQUOTE(JSON_EXTRACT(options, '$.key3')) FROM test_json;