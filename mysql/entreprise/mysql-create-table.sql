DROP TABLE IF EXISTS test_trigger;
CREATE TABLE IF NOT EXISTS test_trigger
(
   id INTEGER NOT NULL PRIMARY KEY AUTO_INCREMENT,
   amount INTEGER NOT NULL,
   quantity INTEGER NOT NULL,
   total_amount INTEGER NOT NULL
);

-- Ceci retournera une erreur

create trigger trigger_sum
    BEFORE INSERT ON test_trigger
    FOR EACH ROW SET NEW.total_amount = NEW.quantity * NEW.amount;

INSERT INTO test_trigger(amount, quantity)
VALUES (1200, 4);

