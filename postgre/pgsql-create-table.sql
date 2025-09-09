DROP TABLE IF EXISTS test_trigger;
CREATE TABLE IF NOT EXISTS test_trigger
(
   id SERIAL PRIMARY KEY,
   amount INTEGER NOT NULL,
   quantity INTEGER NOT NULL,
   total_amount INTEGER NOT NULL
);

-- Ceci retournera une erreur

INSERT INTO test_trigger(amount, quantity)
    VALUES (1200, 4);
