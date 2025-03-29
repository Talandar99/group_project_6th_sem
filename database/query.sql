CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    email VARCHAR(255) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    created TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    modified TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);


INSERT INTO users (email, password) VALUES
('amadeusz@sklep.pl', 'password'),
('grzegorz@sklep.pl', 'password'),
('mikolaj@sklep.pl', 'password'),
('katarzyna@sklep.pl', 'password'),
('aleksandra@sklep.pl', 'password'),
('dawid@sklep.pl', 'password'),
('klaudia@sklep.pl', 'password');




CREATE TABLE products (
    id SERIAL PRIMARY KEY,
    product_name VARCHAR(255) NOT NULL,
    price DECIMAL(10, 2) NOT NULL,
    amount_in_stock INT NOT NULL,
    description TEXT
);


INSERT INTO products (product_name, price, amount_in_stock, description) VALUES
('Krzesło', 149.99, 30, 'Krzesło do biura z regulowaną wysokością.'),
('Kanapa', 1299.99, 12, 'Kanapa z funkcją rozkładania, idealna do salonu.'),
('Fotel', 699.99, 4, 'Wygodny fotel z miękkim siedziskiem, idealny do odpoczynku.'),
('Stolik kawowy', 299.99, 14, 'Elegancki stolik kawowy z drewnianym blatem i metalowymi nogami.'),
('Puf', 199.99, 21, 'Miękki puf, który można wykorzystać jako dodatkowe siedzisko lub podnóżek.');