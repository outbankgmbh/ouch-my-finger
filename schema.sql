CREATE TABLE table_that_should_be_hidden (
    foreign_id SERIAL PRIMARY KEY,
    data VARCHAR(100) NOT NULL
);
COMMENT ON TABLE table_that_should_be_hidden IS E'@omit all\n';

CREATE TABLE table_that_is_hidden(
    foreign_id SERIAL PRIMARY KEY,
    data VARCHAR(100) NOT NULL
);
COMMENT ON TABLE table_that_is_hidden IS E'@behavior -*\n';

