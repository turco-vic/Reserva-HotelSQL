CREATE DATABASE hotel_reserva;

\c hotel_reserva;

CREATE TABLE quartos (
    id_quarto SERIAL PRIMARY KEY,
    numero_quarto INT NOT NULL,
    tipo VARCHAR(10) NOT NULL,
    preco_diaria DECIMAL(10,3)
    );

CREATE TABLE hospedes (
    id_hospede SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(100)
    );

CREATE TABLE reservas (
    id_reserva SERIAL PRIMARY KEY,
    id_quarto INT NOT NULL,
    id_hospede INT NOT NULL,
    data_inicio DATE NOT NULL,
    data_fim DATE,
    CONSTRAINT fk_hospede FOREIGN KEY (id_hospede) REFERENCES hospedes(id_hospede),
    CONSTRAINT fk_quarto FOREIGN KEY (id_quarto) REFERENCES quartos(id_quarto)
    );

INSERT INTO quartos (numero_quarto, tipo, preco_diaria) VALUES 
    (1, 'Simples', 1000),
    (2, 'Luxurioso', 2000),
    (3, 'Especial', 3000);

INSERT INTO hospedes (nome, email) VALUES 
    ('Enzo Turcovic', 'enzoturcovic@gmail.com'),
    ('Maria Turcovic', 'maria@gmail.com'),
    ('Pedro Turcovic', 'pedro@gmail.com');

INSERT INTO reservas (id_quarto, id_hospede, data_inicio, data_fim) VALUES
    (1, 1, '2020-01-01', '2020-01-10'),
    (1, 2, '2020-01-11', '2020-01-15'),
    (2, 1, '2020-01-16', '2020-01-20'),
    (2, 2, '2020-01-21', '2020-01-25'),
    (3, 1, '2020-01-26', '2020-01-30'),
    (3, 2, '2020-01-31', '2020-02-05');

SELECT * FROM quartos;
SELECT * FROM hospedes;
SELECT * FROM reservas;

SELECT 
    h.nome AS nome_hospede,
    q.numero_quarto,
    r.data_inicio,
    r.data_fim

FROM 
    reservas r

JOIN
    hospedes h ON r.id_hospede = h.id_hospede

JOIN
    quartos q ON r.id_quarto = q.id_quarto

WHERE
    r.data_fim IS NOT NULL;

SELECT
    h.nome AS nome_hospede,
    q.numero_quarto,
    r.data_inicio,
    r.data_fim

FROM 
    reservas r

RIGHT JOIN
    hospedes h ON r.id_hospede = h.id_hospede

LEFT JOIN
    quartos q ON r.id_quarto = q.id_quarto
    
SELECT
    r.id_reserva,
    h.nome,
    h.email,
    q.numero_quarto,
    r.data_inicio,
    r.data_fim

FROM 
    quartos q

LEFT JOIN
    reservas r ON q.id_quarto = r.id_quarto

LEFT JOIN
    hospedes h ON r.id_hospede = h.id_hospede

WHERE
    r.id_reserva IS NULL;
