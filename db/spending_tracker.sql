DROP TABLE transactions;
DROP TABLE merchants;
DROP TABLE tags;

CREATE TABLE  merchants(
  id SERIAL primary key,
  name VARCHAR(255)
);

CREATE TABLE  tags(
  id SERIAL primary key,
  name VARCHAR(255)
);

CREATE TABLE transactions (
  id SERIAL primary key,
  name VARCHAR(255),
  amount FLOAT,
  merchant_id INT REFERENCES merchants(id),
  tag_id INT REFERENCES tags(id)
);
