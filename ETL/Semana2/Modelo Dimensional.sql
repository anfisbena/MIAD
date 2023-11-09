USE Estudiante_8_202315;
--------------------- Modelo de hecho movimiento
/*Esta tabla no tiene ningun argumento, se sugiere borrar y se mantiene por fines academicos
CREATE TABLE Fecha (
ID_Fecha INT NOT NULL auto_increment,
Fecha DATE, 
Dia TINYINT, 
Mes VARCHAR(20), 
Anio SMALLINT,
Numero_semana_ISO TINYINT,
PRIMARY KEY(ID_Fecha));
*/

CREATE TABLE IF NOT EXISTS Producto (
ID_Producto_DWH INT NOT NULL auto_increment, /*Se sugiere hacerlo INT porque pueden tener mas de 32k productos*/
/*ID_Producto_T SMALLINT NOT NULL auto_increment, Esta llave no tiene ningun argumento, se sugiere borrar*/
Nombre VARCHAR(100),
Marca VARCHAR(30), 
Paquete_de_compra VARCHAR(20), 
Color VARCHAR(10), 
Necesita_refrigeracion BOOLEAN, 
Dias_tiempo_entrega SMALLINT, 
cantidad_por_salida INT, 
Precio_minorista_recomendado FLOAT, 
Paquete_de_venta VARCHAR(20), 
Precio_unitario FLOAT,
PRIMARY KEY(ID_Producto_DWH));

CREATE TABLE IF NOT EXISTS Proveedor(
ID_proveedor_DWH INT PRIMARY KEY NOT NULL auto_increment,
/*ID_proveedor_T INT NOT NULL auto_increment, Esta llave no tiene ningun argumento, se sugiere borrar*/
Nombre VARCHAR(20),
Categoria VARCHAR(20),
Contacto_principal VARCHAR(30),/*Se sugiere añadir campos Nombre_contacto,Numero_contacto,Cargo_contacto,Email_contacto, que reemplace este*/
Referencia VARCHAR(30),
Dias_pago INT, 
Codigo_postal INT
);

CREATE TABLE IF NOT EXISTS TipoTransaccion(
ID_Tipo_transaccion_DWH TINYINT PRIMARY KEY NOT NULL auto_increment,
/*ID_Tipo_transaccion_T TINYINT NOT NULL auto_increment,  Esta llave no tiene ningun argumento, se sugiere borrar*/
Tipo VARCHAR(20)
);

CREATE TABLE IF NOT EXISTS Cliente(
ID_Cliente_DWH INT PRIMARY KEY NOT NULL auto_increment,
/*ID_Cliente_T int NOT NULL auto_increment, Esta llave no tiene ningun argumento, se sugiere borrar*/
Nombre VARCHAR(50),
ClienteFactura VARCHAR(50),
ID_CiudadEntrega_DWH INT, /*Se crea tabla para fines funcionales*/
LimiteCredito float,
FechaAperturaCuenta date,
DiasPago int,
NombreGrupoCompra varchar(50),/*Asumo datos*/
NombreCategoria Varchar(50)/*Asumo datos*/
);

CREATE TABLE IF NOT EXISTS Ciudades(
ID_Ciudad INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
Ciudad VARCHAR(30),
Departamento VARCHAR(30),
Pais VARCHAR(30)
);

CREATE TABLE IF NOT EXISTS CiudadEntrega(
ID_CiudadEntrega_DWH INT PRIMARY KEY NOT NULL auto_increment,
ID_Ciudad INT,
Direccion VARCHAR(50),
FOREIGN KEY (ID_Ciudad) REFERENCES Ciudades(ID_Ciudad)
);


CREATE TABLE IF NOT EXISTS Hecho_Movimiento(
ID_Movimiento INT PRIMARY KEY NOT NULL auto_increment,
ID_Producto_DWH INT,/*Se sugiere hacerlo INT porque pueden tener mas de 32k productos*/
ID_Proveedor_DWH INT,
ID_Cliente_DWH INT,
ID_Tipo_Transaccion_DWH TINYINT,
/*ID_Fecha INT,Tabla obsoleta, se añade por fines academincos y de calificacion sin embargo se sugiere eliminar y usar campo Fecha_Transaccion*/
Fecha_Transaccion datetime, /*Tabla fecha sobra si solo se usa para definir una fecha, se recomienda mejor usar un datetime de paso ahorra espacio en memoria*/
Cantidad INT,
foreign key(ID_Producto_DWH) references Producto(ID_Producto_DWH),
foreign key(ID_Proveedor_DWH) references Proveedor(ID_proveedor_DWH),
foreign key(ID_Cliente_DWH) references Cliente(ID_Cliente_DWH),
foreign key(ID_Tipo_Transaccion_DWH) references TipoTransaccion(ID_Tipo_transaccion_DWH)
/*foreign key(ID_Fecha) references Fecha(ID_Fecha)Tabla obsoleta, se añade por fines academincos y de calificacion sin embargo se sugiere eliminar y usar campo Fecha_Transaccion*/
);


INSERT INTO Producto (Nombre, Marca, Paquete_de_compra, Color, Necesita_refrigeracion, Dias_tiempo_entrega, cantidad_por_salida, Precio_minorista_recomendado, Paquete_de_venta, Precio_unitario)
VALUES
("Aguacate", "Hass", "Caja de 5 kg", "Verde", TRUE, 3, 10, 20000, "Bolsa de 250g", 8000),
("Manzana", "Golden", "Bolsa de 1 kg", "Rojo", FALSE, 2, 20, 15000, "Manojo de 3", 5000),
("Leche", "Entera", "Paquete de 1 litro", "Blanco", FALSE, 1, 6, 3000, "Botella", 5000),
("Arroz", "Integral", "Bolsa de 5 kg", "Marron", FALSE, 3, 10, 10000, "Bolsa", 1000),
("Chocolate", "Nestlé", "Tableta de 100g", "Marrón", FALSE, 1, 20, 5000, "Tableta", 2500);

insert Into Proveedor(Nombre,Categoria,Contacto_principal,Referencia,Dias_pago,Codigo_postal)
Values ('P1','Juguetes','p1@p1,com','1111',30,1330),
('P2','Cosmeticos','p2@p2.com','1112',15,1331),
('P3','Textil','p3@p3.com','1113',30,1332),
('P4','Juguetes','p4@p4.com','1114',30,1333),
('P5','Cosmetico','p5@p4.com','1115',30,1334);

INSERT INTO TipoTransaccion (Tipo)
VALUES
('Venta'),
('Devolucion'),
('Cambio'),
('Reembolso'),
('Otro');

INSERT INTO Cliente (Nombre, ClienteFactura, ID_CiudadEntrega_DWH, LimiteCredito, FechaAperturaCuenta, DiasPago, NombreGrupoCompra, NombreCategoria)
VALUES
('Juan Pérez', '850', 1, 1000000, '20230101', 30, 'Clientes VIP', 'Persona'),
('Pedro López', '851', 2, 500000, '20230201', 30, 'Clientes frecuentes', 'Persona'),
('María García', '852', 3, 250000, '20230301', 30, 'Clientes frecuentes', 'Persona'),
('Jorge Hernández', '853', 4, 100000, '20230401', 30, 'Clientes frecuentes', 'Empresa'),
('Ana Sánchez', '12', 5, 50000, '20230501', 0, 'Clientes VIP', 'Persona');

INSERT INTO Ciudades (ID_Ciudad, Ciudad, Departamento, Pais)
VALUES
    (1, 'Bogotá', 'Cundinamarca', 'Colombia'),
    (2, 'Medellín', 'Antioquia', 'Colombia'),
    (3, 'Cali', 'Valle del Cauca', 'Colombia'),
    (4, 'Barranquilla', 'Atlántico', 'Colombia'),
    (5, 'Cartagena', 'Bolívar', 'Colombia');
    
INSERT INTO CiudadEntrega (ID_Ciudad, Direccion)
VALUES
    (1, 'Calle 1 #4, Bogotá'),
    (2, 'Carrera 2 #20, Medellín'),
    (3, 'Avenida 3 #69, Cali'),
    (4, 'Calle 4 #66, Barranquilla'),
    (5, 'Carrera 5 #6, Cartagena');
    
INSERT INTO Hecho_Movimiento (ID_Producto_DWH, ID_Proveedor_DWH, ID_Cliente_DWH, ID_Tipo_Transaccion_DWH, Fecha_Transaccion, Cantidad)
VALUES
    (1, 1, null, 1, '2023-10-31 08:00:00', 10),
    (2, null, 2, 2, '2023-11-01 09:30:00', 20),
    (3, null, 3, 3, '2023-11-02 11:15:00', 30),
    (4, 4, null, 4, '2023-11-03 13:45:00', 40),
    (5, null, 5, 5, '2023-11-04 15:20:00', 50);
    
    
    
    SELECT PV.Nombre,PD.Nombre,sum(HM.Cantidad), TT.Tipo
    FROM Hecho_Movimiento HM 
    LEFT JOIN Proveedor PV ON HM.ID_Proveedor_DWH=PV.ID_Proveedor_DWH
    LEFT JOIN Producto PD ON HM.ID_Producto_DWH=PD.ID_Producto_DWH
    LEFT JOIN TipoTransaccion TT ON HM.ID_Tipo_Transaccion_DWH=TT.ID_Tipo_Transaccion_DWH
    WHERE Fecha_Transaccion BETWEEN '20231031' AND '20231105'
    GROUP BY PV.Nombre, PD.Nombre, TT.Tipo;

    SELECT C.Nombre,PD.Nombre,sum(HM.Cantidad), TT.Tipo
    FROM Hecho_Movimiento HM 
    INNER JOIN Cliente C ON HM.ID_Cliente_DWH=C.ID_Cliente_DWH
    INNER JOIN Producto PD ON HM.ID_Producto_DWH=PD.ID_Producto_DWH
    INNER JOIN TipoTransaccion TT ON HM.ID_Tipo_Transaccion_DWH=TT.ID_Tipo_Transaccion_DWH
    WHERE Fecha_Transaccion BETWEEN '20231031' AND '20231105'
	GROUP BY C.Nombre, PD.Nombre, TT.Tipo;