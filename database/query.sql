CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    email VARCHAR(255) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    created TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    modified TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);


CREATE TABLE products (
    id SERIAL PRIMARY KEY,
    product_name VARCHAR(255) NOT NULL,
    price DECIMAL(10, 2) NOT NULL,
    amount_in_stock INT NOT NULL,
    description TEXT,
    image_url VARCHAR(255)
);


INSERT INTO products (product_name, price, amount_in_stock, description, image_url) VALUES
('Krzesło', 149.99, 30, 'Krzesło do biura z regulowaną wysokością.', 'images/img-1.jpg'),
('Kanapa', 1299.99, 12, 'Kanapa z funkcją rozkładania, idealna do salonu.', 'images/img-2.jpg'),
('Fotel', 699.99, 4, 'Wygodny fotel z miękkim siedziskiem, idealny do odpoczynku.', 'images/img-3.jpg'),
('Stolik kawowy', 299.99, 14, 'Elegancki stolik kawowy z drewnianym blatem i metalowymi nogami.', 'images/img-4.jpg'),
('Puf', 199.99, 21, 'Miękki puf, który można wykorzystać jako dodatkowe siedzisko lub podnóżek.', 'images/img-5.jpg');

