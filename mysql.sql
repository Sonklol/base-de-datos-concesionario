DROP DATABASE IF EXISTS Concesionario;
CREATE DATABASE Concesionario;
USE Concesionario;

CREATE TABLE Personas (
    idPersona INT PRIMARY KEY,
    telefono VARCHAR(9) NOT NULL,
    NIF VARCHAR(9) UNIQUE NOT NULL,
    nombre VARCHAR(15) NOT NULL,
    priApe VARCHAR(15) NOT NULL,
    segApe VARCHAR(15)
);

INSERT INTO Personas (idPersona, telefono, NIF, nombre, priApe, segApe) VALUES (1, '657344523', 'A08001851', 'Paquito', 'Scaletta', 'Garcia');
INSERT INTO Personas (idPersona, telefono, NIF, nombre, priApe, segApe) VALUES (2, '656364623', 'A09005451', 'Alfonso', 'ElCrack', 'Maradona');

CREATE TABLE Empleados (
    idPersonaEmp INT PRIMARY KEY,
    FOREIGN KEY (idPersonaEmp) REFERENCES Personas(idPersona)
);

INSERT INTO Empleados (idPersonaEmp) VALUES (1);
INSERT INTO Empleados (idPersonaEmp) VALUES (2);

CREATE TABLE Tecnicos (
    idTecnico INT PRIMARY KEY,
    idPersonaEmp INT NOT NULL UNIQUE,
    FOREIGN KEY (idPersonaEmp) REFERENCES Empleados(idPersonaEmp)
);

INSERT INTO Tecnicos (idTecnico, idPersonaEmp) VALUES (1, 1);
INSERT INTO Tecnicos (idTecnico, idPersonaEmp) VALUES (2, 2);

CREATE TABLE Comerciales (
    idComercial INT PRIMARY KEY,
    idPersonaEmp INT NOT NULL UNIQUE,
    FOREIGN KEY (idPersonaEmp) REFERENCES Empleados(idPersonaEmp)
);

INSERT INTO Comerciales (idComercial, idPersonaEmp) VALUES (1, 1);
INSERT INTO Comerciales (idComercial, idPersonaEmp) VALUES (2, 2);

CREATE TABLE Ciudades (
    idCiudad INT PRIMARY KEY,
    Nombre VARCHAR(15) NOT NULL UNIQUE
);

INSERT INTO Ciudades (idCiudad, Nombre) VALUES (1, 'Ávila');
INSERT INTO Ciudades (idCiudad, Nombre) VALUES (2, 'Madrid');

CREATE TABLE Direcciones (
    idDireccion INT PRIMARY KEY,
    portal VARCHAR(2),
    calle VARCHAR(30) NOT NULL,
    numCalle NUMERIC(2) NOT NULL,
    idCiudad INT NOT NULL,
    FOREIGN KEY (idCiudad) REFERENCES Ciudades(idCiudad)
);

INSERT INTO Direcciones (idDireccion, portal, calle, numCalle, idCiudad) VALUES (1, 'A', 'Hernan Cortes', 16, 1);
INSERT INTO Direcciones (idDireccion, portal, calle, numCalle, idCiudad) VALUES (2, 'A', 'Hernan Cortes', 16, 1);
INSERT INTO Direcciones (idDireccion, portal, calle, numCalle, idCiudad) VALUES (3, 'B', 'Hola Buenas Tardes', 5, 2);

CREATE TABLE Clientes (
    idCliente INT PRIMARY KEY,
    idPersona INT NOT NULL UNIQUE,
    idDireccion INT NOT NULL,
    idCiudad INT,
    FOREIGN KEY (idPersona) REFERENCES Personas(idPersona),
    FOREIGN KEY (idDireccion) REFERENCES Direcciones(idDireccion),
    FOREIGN KEY (idCiudad) REFERENCES Ciudades(idCiudad)
);

INSERT INTO Clientes (idCliente, idPersona, idDireccion, idCiudad) VALUES (1, 1, 1, 1);
INSERT INTO Clientes (idCliente, idPersona, idDireccion, idCiudad) VALUES (2, 2, 2, 2);

CREATE TABLE Ventas (
    idVenta INT PRIMARY KEY,
    fechaVenta date NOT NULL,
    idComercial INT NOT NULL,
    idCliente INT NOT NULL,
    FOREIGN KEY (idComercial) REFERENCES Comerciales(idComercial),
    FOREIGN KEY (idCliente) REFERENCES Clientes(idCliente)
);

INSERT INTO Ventas (idVenta, fechaVenta, idComercial, idCliente) VALUES (1, '2019-09-02', 1, 1);
INSERT INTO Ventas (idVenta, fechaVenta, idComercial, idCliente) VALUES (2, '2020-01-01', 2, 2);

CREATE TABLE Colores (
    idColor INT PRIMARY KEY,
    nombre VARCHAR(15) NOT NULL UNIQUE
);

INSERT INTO Colores (idColor, nombre) VALUES (1, 'Rojo');
INSERT INTO Colores (idColor, nombre) VALUES (2, 'Azul');
INSERT INTO Colores (idColor, nombre) VALUES (3, 'Negro');


CREATE TABLE Marcas (
    idMarca INT PRIMARY KEY,
    nombre VARCHAR(15) NOT NULL UNIQUE
);

INSERT INTO Marcas (idMarca, nombre) VALUES (1, 'BMW');
INSERT INTO Marcas (idMarca, nombre) VALUES (2, 'Mercedes');
INSERT INTO Marcas (idMarca, nombre) VALUES (3, 'Audi');
INSERT INTO Marcas (idMarca, nombre) VALUES (4, 'Nissan');


CREATE TABLE Modelos (
    idModelo INT PRIMARY KEY,
    nombre VARCHAR(15) NOT NULL UNIQUE
);

INSERT INTO Modelos (idModelo, nombre) VALUES (1, 'E46 M3');
INSERT INTO Modelos (idModelo, nombre) VALUES (2, 'CLS');
INSERT INTO Modelos (idModelo, nombre) VALUES (3, 'A5');
INSERT INTO Modelos (idModelo, nombre) VALUES (4, '370z');

CREATE TABLE Coches (
    idCoche INT PRIMARY KEY,
    matricula VARCHAR(8) UNIQUE,
    PrecioVenta NUMERIC (9, 2) CHECK(PrecioVenta>0),
    idVenta INT,
    idColor INT NOT NULL,
    idMarca INT NOT NULL,
    idModelo INT NOT NULL,
    FOREIGN KEY (idVenta) REFERENCES Ventas(idVenta),
    FOREIGN KEY (idColor) REFERENCES Colores(idColor),
    FOREIGN KEY (idMarca) REFERENCES Marcas(idMarca),
    FOREIGN KEY (idModelo) REFERENCES Modelos(idModelo)
);

INSERT INTO Coches (idCoche, matricula, PrecioVenta, idVenta, idColor, idMarca, idModelo) VALUES (1, '7587-KUJ', 150000, 1, 1, 1, 1);
INSERT INTO Coches (idCoche, matricula, PrecioVenta, idVenta, idColor, idMarca, idModelo) VALUES (2, '7565-VGA', 50000, 1, 1, 2, 2);
INSERT INTO Coches (idCoche, matricula, PrecioVenta, idVenta, idColor, idMarca, idModelo) VALUES (3, '7534-LVM', 49000, 2, 2, 2, 2);
INSERT INTO Coches (idCoche, matricula, PrecioVenta, idVenta, idColor, idMarca, idModelo) VALUES (4, '4345-FGF', 70000, 2, 2, 4, 4);

CREATE TABLE Revisiones (
    idRevision INT PRIMARY KEY,
    cambiofiltro NUMERIC(1) check(cambiofiltro IN(0, 1)),
    cambioaceite NUMERIC(1) check(cambioaceite IN(0, 1)),
    cambiofrenos NUMERIC(1) check(cambiofrenos IN(0, 1)),
    idCoche INT NOT NULL,
    idTecnico INT NOT NULL,
    FOREIGN KEY (idTecnico) REFERENCES Tecnicos(idTecnico)
    FOREIGN KEY (idCoche) REFERENCES Coches(idCoche)
);

INSERT INTO Revisiones (idRevision, cambiofiltro, cambioaceite, cambiofrenos, idCoche, idTecnico) VALUES (1, 1, 1, 1, 1, 1);
INSERT INTO Revisiones (idRevision, cambiofiltro, cambioaceite, cambiofrenos, idCoche, idTecnico) VALUES (2, 0, 0, 0, 1, 1);

CREATE TABLE Marcas_Modelos (
    idMarca INT,
    idModelo INT,
    PRIMARY KEY (idMarca, idModelo),
    FOREIGN KEY (idMarca) REFERENCES Marcas(idMarca),
    FOREIGN KEY (idModelo) REFERENCES Modelos(idModelo)
);

INSERT INTO Marcas_Modelos (idMarca, idmodelo) VALUES (1, 1);
INSERT INTO Marcas_Modelos (idMarca, idmodelo) VALUES (2, 2);
INSERT INTO Marcas_Modelos (idMarca, idmodelo) VALUES (3, 3);
INSERT INTO Marcas_Modelos (idMarca, idmodelo) VALUES (4, 4);
