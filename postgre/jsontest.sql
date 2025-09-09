DROP TABLE IF EXISTS test_json;
CREATE TABLE IF NOT EXISTS test_json
(
    id SERIAL PRIMARY KEY,
    options jsonb NOT NULL
);

-- Insérer des valeurs

INSERT INTO test_json(options)
VALUES (jsonb_object(string_to_array('key1,Value1,key2,Value2', ',')));

INSERT INTO test_json(options)
VALUES (jsonb_object(string_to_array('key3,Value3,key4,Value4', ',')));

SELECT jsonb_path_query(options, '$.key1') FROM test_json;

INSERT INTO test_json(options) VALUES
    (json_build_object('key5', 'Value5', 'key6', json_build_array('foo', 'bar', 'baz')));

INSERT INTO test_json(options) VALUES (json_build_array(1, 2, '3', 4, 5));

SELECT jsonb_path_query(options, '$[0]') FROM test_json;
