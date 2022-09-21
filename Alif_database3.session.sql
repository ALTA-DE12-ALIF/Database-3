use toko2;

-- DROP --
DROP TABLE merek; 
DROP TABLE product_types; 
DROP TABLE products; 
DROP TABLE product_descriptions; 
DROP TABLE payment_methods; 
DROP TABLE users; 
DROP TABLE transactions;
DROP TABLE transaction_details;


-- CREATE TABLE --

CREATE TABLE products(
    id_product int(11) primary key,
    id_product_type int(11),
    id_merek int(11),
    code VARCHAR(50) not null,
    name VARCHAR(100) not null,
    status smallint,
    created_at timestamp default current_timestamp(),
    updated_at timestamp default current_timestamp(),
    constraint FK_User_product foreign key (id_product_type) references product_types(id_product_type),
    constraint FK_User_merek foreign key (id_merek) references merek(id_merek)
);

CREATE TABLE product_descriptions(
    id_description int(11) primary key,
    description text,
    created_at timestamp default current_timestamp(),
    updated_at timestamp default current_timestamp()
);

CREATE TABLE payment_methods(
    id_payment int(11) primary key,
    name VARCHAR(255) not null,
    status smallint,
    created_at timestamp default current_timestamp(),
    updated_at timestamp default current_timestamp()
);

CREATE TABLE users(
    id_user int(11) primary key,
    name VARCHAR(255) not null,
    status smallint,
    dob DATE,
    gender CHAR(1),
    created_at timestamp default current_timestamp(),
    updated_at timestamp default current_timestamp()
);

CREATE TABLE product_types(
    id_product_type int(11) primary key,
    name VARCHAR(255) not null,
    created_at timestamp default current_timestamp(),
    updated_at timestamp default current_timestamp()
);

CREATE TABLE merek(
    id_merek int(11) primary key,
    name VARCHAR(255) not null,
    created_at timestamp default current_timestamp(),
    updated_at timestamp default current_timestamp()
);

CREATE TABLE transactions(
    id_transaction int(11) primary key,
    id_user int(11),
    id_payment int(11),
    status VARCHAR(10),
    total_qty int(11),
    total_price int(25),
    created_at timestamp default current_timestamp(),
    updated_at timestamp default current_timestamp(),
    constraint FK_User_usr foreign key (id_user) references users(id_user),
    constraint FK_User_pay foreign key (id_payment) references payment_methods(id_payment)
);


CREATE TABLE transaction_details(
    id_transaction int(11) references transactions(id_transaction),
    id_product int(11) references products(id_product),
    status VARCHAR(10),
    qty int(10),
    price int(25),
    created_at timestamp default current_timestamp(),
    updated_at timestamp default current_timestamp(),
    constraint FK_User_trpro primary key (id_transaction, id_product)
);



-- INSERT --
-- A --
INSERT INTO merek (id_merek, name) values
(1, 'indofood' ), 
(2, 'wings'), 
(3, 'sedaap'), 
(4, 'abc'), 
(5, 'white coffe');
-- B --
INSERT INTO product_types (id_product_type, name) values
(1, 'pasta gigi' ),
(2, 'minuman'), 
(3, 'mie goreng');
-- C --
INSERT INTO products (id_product, id_product_type, id_merek, code, name, status ) values
('1', '1', '3', '344', 'kare ayam', '100'),
('2', '1', '3', '344', 'bakso', '100');
-- D --
INSERT INTO products (id_product, id_product_type, id_merek, code, name, status ) values
('3', '2', '1', '343', 'soto', '100'),
('4', '2', '1', '343', 'rawon', '100'),
('5', '2', '1', '343', 'ayam goreng', '100');
-- E --
INSERT INTO products (id_product, id_product_type, id_merek, code, name, status ) values
('6', '3', '4', '345', 'redang', '100'),
('7', '3', '4', '345', 'lawar', '100'),
('8', '3', '4', '345', 'sate lilit', '100');
-- F --
INSERT INTO  product_descriptions (id_description, description) values
(1, 'menyejukan'),
(2, 'manis'),
(3, 'lembut'), 
(4, 'mudah diperbaiki');
-- G --
INSERT INTO payment_methods (id_payment, name, status) values
(1, 'BRI', '123'), (2, 'BCA', '133'), (3, 'MANDIRI', '272');
-- H --
INSERT INTO users (id_user, name, status, dob, gender) values
(1, 'Lukman', 1, '1999-12-12', 'L'),
(2, 'Alif', 2, '1996-12-08', 'L'),
(3, 'Moh', 1, '1997-12-09', 'L'),
(4, 'ALi', 1, '1998-12-12', 'L'),
(5, 'Erni', 2, '1998-12-11', 'P');
-- I --
INSERT INTO transactions (id_transaction, id_user, id_payment, status, total_qty, total_price) values
(1, 1, 1, 'sukses', 12, '100000'),
(2, 2, 2, 'sukses', 10, '50000'),
(3, 3, 3, 'sukses', 2, '60000');
-- J --
INSERT INTO transaction_details(id_transaction, id_product, status, qty, price) values
(1, 3, 'sukses', 2, '200000'),
(2, 2, 'sukses', 3, '100000'),
(3, 6, 'sukses', 4, '120000');

-- SELECT --
-- A --
SELECT *
FROM users
WHERE gender = 'L';
-- B --
SELECT *
FROM products
WHERE id_product = 3;
-- C --
SELECT *
FROM users
WHERE created_at >= DATE(NOW() - INTERVAL 7 DAY) AND name like '%a%';
-- D --
SELECT count(gender)
FROM users
WHERE gender = 'P';
-- E --
SELECT *
FROM users
ORDER BY name;
-- F --
SELECT *
FROM transaction_details
WHERE id_product  = 3
LIMIT 5;

-- UPDATE --
-- A --
UPDATE products
set name = 'product dummy'
WHERE id_product = 1;
-- B --
UPDATE transaction_details
set qty = 3
WHERE id_product = 1;

-- DELETE --
-- A --
DELETE
FROM products
WHERE id_product = 1;
-- B --
DELETE
FROM products
WHERE id_product_type = 1;
