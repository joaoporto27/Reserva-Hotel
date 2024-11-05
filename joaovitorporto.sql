    CREATE DATABASE reservahotel;

    \c reservahotel;

    CREATE TABLE hospedes (
        id_hospede SERIAL PRIMARY KEY,
        nome VARCHAR(100) NOT NULL,
        email VARCHAR(200) UNIQUE NOT NULL
    );

    CREATE TABLE quartos (
        id_quarto SERIAL PRIMARY KEY,
        numero_quarto INT UNIQUE NOT NULL,
        servico_quarto BOOLEAN
    );

    CREATE TABLE reservas (
        id_reserva SERIAL PRIMARY KEY,
        data_check_in DATE NOT NULL DEFAULT CURRENT_DATE,
        data_check_out DATE,
        id_hospede INT NOT NULL,
        id_quarto INT NOT NULL,
        CONSTRAINT fk_hospede FOREIGN KEY (id_hospede) REFERENCES hospedes(id_hospede),
        CONSTRAINT fk_quarto FOREIGN KEY (id_quarto) REFERENCES quartos(id_quarto)
    );

    INSERT INTO hospedes (nome, email)
    VALUES
    ('Luiz Gabriel', 'luizgabriel@yahoo.com'),
    ('Lucas Zani', 'lucasluz@hotmail.com'),
    ('Leonardo Pedro', 'leonardopedro@gmail.com'),
    ('Caio Gabriel', 'caiofpslacerda@gmail.com'),
    ('André Lucca', 'andrelucca@gmail.com'),
    ('Kevin Ezequiel', 'kevinnino@gmail.com');

    INSERT INTO quartos (numero_quarto, servico_quarto)
    VALUES
    ('12', FALSE),
    ('27', TRUE),
    ('04', TRUE),
    ('41', FALSE),
    ('10', TRUE),
    ('17', FALSE);

    INSERT INTO reservas (id_hospede, id_quarto, data_check_out)
    VALUES
    (1,3, '2024/11/02'),
    (2,4, NULL),
    (3,2, NULL ),
    (4,1, '2024/11/01');

/*Todos os hospedes com ou sem a reserva*/
    SELECT 
        r.id_reserva,
        r.data_check_in,
        r.data_check_out,
        q.numero_quarto,
        q.servico_quarto,
        h.nome AS hospede,
        h.email
    FROM 
        reservas r
    RIGHT JOIN 
        hospedes h ON r.id_hospede = h.id_hospede
    LEFT JOIN 
        quartos q ON r.id_quarto = q.id_quarto;

/*Todos que já fizeram checkout*/
    SELECT 
        r.id_reserva,
        r.data_check_in,
        r.data_check_out,
        q.numero_quarto,
        q.servico_quarto,
        h.nome AS hospede,
        h.email
    FROM 
        reservas r
    JOIN 
        hospedes h ON r.id_hospede = h.id_hospede
    JOIN 
        quartos q ON r.id_quarto = q.id_quarto
    WHERE
        r.data_check_out IS NOT NULL;

/*Todos quartos vazios*/
    SELECT
        r.id_reserva,
        r.data_check_in,
        r.data_check_out,
        q.numero_quarto,
        q.servico_quarto,
        h.nome AS hospede,
        h.email
    FROM
        hospedes h
    RIGHT JOIN
        reservas r ON h.id_hospede = r.id_hospede
    RIGHT JOIN
        quartos q ON r.id_quarto = q.id_quarto
    WHERE 
        r.data_check_in IS NULL;
    
    