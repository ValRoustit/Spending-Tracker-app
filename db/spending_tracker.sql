DROP TABLE transactions;
DROP TABLE merchants;
DROP TABLE tags;
DROP TABLE budgets;

CREATE TABLE  merchants(
  id SERIAL primary key,
  name VARCHAR(255)
);

CREATE TABLE  tags(
  id SERIAL primary key,
  name VARCHAR(255)
);

CREATE TABLE  budgets(
  id SERIAL primary key,
  name VARCHAR(255),
  amount FLOAT,
  alert_limit INT
);

CREATE TABLE transactions (
  id SERIAL primary key,
  name VARCHAR(255),
  amount FLOAT,
  merchant_id INT REFERENCES merchants(id) ON DELETE SET DEFAULT,
  tag_id INT REFERENCES tags(id) ON DELETE SET DEFAULT,
  budget_id INT REFERENCES budgets(id) ON DELETE SET DEFAULT,
  date DATE NOT NULL DEFAULT CURRENT_DATE
);