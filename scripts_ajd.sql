CREATE SCHEMA libajdbd2561203;



CREATE TABLE clientes(
id_cliente INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
identificacion VARCHAR (11) NOT NULL,
nombres VARCHAR(25) NOT NULL,
apellidos VARCHAR(25) NOT NULL,
telefono VARCHAR (12) NOT NULL,
direccion VARCHAR (100) NOT NULL,
correo_electronico VARCHAR (100) NOT NULL
);

CREATE TABLE categorias(
id_categoria INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
categoria VARCHAR(40) NOT NULL
);

CREATE TABLE pedido_cliente(
id_pedido INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
nro_pedido INT NOT NULL,
id_cliente INT NOT NULL,
isbn INT NOT NULL,
fecha_pedido DATETIME NOT NULL,
cantidad INT NOT NULL DEFAULT 1,
subtotal INT NOT NULL,
FOREIGN KEY (id_cliente) REFERENCES clientes (id_cliente),
FOREIGN KEY (isbn) REFERENCES libros (isbn)
);

CREATE TABLE libros(
isbn INT NOT NULL PRIMARY KEY,
titulo VARCHAR(125) NOT NULL,
fehca_pub DATE NOT NULL,
categoria INT NOT NULL,
precio INT NOT NULL,
portada VARCHAR (30),
cantidad_stock INT NOT NULL CHECK (cantidad_stock >= 0),
FOREIGN KEY (categoria) REFERENCES categorias(id_categoria)
);

CREATE TABLE autores(
id_autor INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
nombres VARCHAR(25) NOT NULL,
apellidos VARCHAR(25) NOT NULL
);

CREATE TABLE libros_por_autor(
isbn INT NOT NULL,
id_autor INT NOT NULL,
PRIMARY KEY(isbn, id_autor),
FOREIGN KEY (id_autor) REFERENCES autores(id_autor),
FOREIGN KEY (isbn) REFERENCES libros(isbn)
);

CREATE TABLE usuarios_ajd(
id_usuario INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
usuario VARCHAR(25) NOT NULL,
clave VARCHAR(20) NOT NULL,
correo VARCHAR(35) NOT NULL
);

INSERT INTO clientes(identificacion, nombres, apellidos, telefono, direccion, correo_electronico)
VALUES
('1001389935','Alejandro','Jiménez Daza','303328129','carrera 59','ajimenez539@misena.edu.co'),('100178976','Maroel','Estrada Zuleta','3058764513','carrera 67','maroel@gmail.com'),
('600956712','Ximena','Zapata Cadavid','3114756890','carrera 12','ximenacada17@gmail.com'),('700734567','Santiago','Zuleta Builes','678128976','carrera 72','santiagozb454@hotmail.com'),
('100138','Luis Miguel','Posada Jaramillo','304897','carrera 51','luism564@yahoo.com'),('7763471','Carolina','Montana Suarez','78465476','carrera 31','caroms45@outlook.com');

INSERT INTO categorias(categoria)
VALUES('Accion y aventuras'),('Terror'),('Ficcion moderna'),('Suspenso'),('Romance'),('Narrativa'),('Novela');

SELECT * FROM categorias;

INSERT INTO libros(isbn, titulo, fecha_pub, categoria, precio, portada, cantidad_stock)
VALUES
(372, 'Operation Hell Gate', '2005-09-27', 1, 48000, 'Operacion H.G.', 25), (328, 'Miguel Strogoff', '2005-09-27', 1, 25000, 'M. Strogoff', 30),
(468, 'El gato negro', '1997-10-12', 2, 44000, 'Gato Negro', 17), (498, 'Frankenstein', '1990-03-01', 2, 55500, 'Frankenstein', 10),
(385, 'Sexo en la Luna', '2011-06-01', 3, 29500, 'La luna', 11), (415, 'Drácula', '1999-04-10', 2, 46800, 'Dracula', 30),
(428, 'Realidad aumentada', '2001-03-13', 4, 35200, 'R. Aumentada', 40), (442, 'Juicio Final, Sangre en el cielo', '2009-05-30', 4, 40000, 'Juicio Final', 55),
(466, 'El Enigma de los Vencidos', '2000-11-25', 4, 38500, 'Enigma Vencidos', 43), (578, 'Orgullo y Prejuicio', '2003-09-25', 5, 36100, 'El orgullo', 5),
(603, 'Cumbres Borrascosas', '1998-11-25', 5, 60800, 'Cumbres', 24), (618, 'La Dama de las Camelias', '1995-07-28', 5, 57600, 'Dama Camelia', 57),
(729, '100 años de soledad', '1990-04-27', 6, 39500, '100 Años', 3), (128, 'Zorba, el griego', '2010-11-25', 6, 38500, 'Zorba G.', 80),
(28, 'Cathedral', '2004-08-15', 6, 25700, 'Cathed', 33), (8807, 'El Nombre de la Rosa', '2011-05-24', 7, 68000, 'Rosa', 100),
(2437, 'Crónica de una Muerte Anunciada', '2016-07-15', 6, 48000, 'Muerte anunciada', 92);

UPDATE libros
SET fecha_pub = "2001-12-10"
WHERE isbn = 328;

SELECT libros.isbn, libros.titulo, libros.fecha_pub, libros.categoria, libros.precio, libros.cantidad_stock, categorias.categoria
FROM libros, categorias
WHERE libros.categoria = categorias.id_categoria;

/*INNER JOIN*/
SELECT *
FROM libros
INNER JOIN categorias
ON libros.categoria = categorias.id_categoria;

/*INNER JOIN*/
SELECT a.titulo, a.categoria, a.fecha_pub, b.id_categoria, b.categoria
FROM libros a
INNER JOIN categorias b
ON a.categoria  = b.id_categoria;

SELECT * FROM libros;

INSERT INTO autores(nombres, apellidos)
VALUES
('Marc', 'Cerasini'),('Julio', 'Verne'),('Edgar Allan', 'Poe'),('Mary Wollstonecraft', 'Shelley'),
('Ben', 'Mezrich'),('Bram', 'Stoker'),('Bruno', 'Nievas'),('César García', 'Muñoz'),
('Armando', 'Rodera'),('Jane', 'Austen'),('Emily', 'Bronte'),('Alejandro', 'Dumas'),
('Gabriel García', 'Márquez'),('Nikos', 'Kazantzakis'),('Raymond', 'Carver'),('Umberto', 'Eco'),
('Gabriel García', 'Márquez');

INSERT INTO usuarios_ajd(usuario, clave, correo)
VALUES
('alejo16', 'holamundo', 'alejodaza061@gmail.com');


SELECT user, host FROM mysql.user;

GRANT ALL PRIVILEGES ON libajdbd2561203.* TO 'alejo16'@'localhost';
FLUSH PRIVILEGES;

CREATE USER 'alejo16'@'localhost' IDENTIFIED BY 'holamundo';


USE libajdbd2561203;

SELECT * FROM autores;
SELECT * FROM categorias;
SELECT * FROM clientes;
SELECT * FROM libros;
SELECT * FROM libros_por_autor;
SELECT * FROM pedido_cliente;
SELECT * FROM usuarios_ajd;

