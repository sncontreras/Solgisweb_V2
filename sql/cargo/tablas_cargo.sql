USE [TestSolmar]

CREATE TABLE Appsolgis_FotoVehiculo
(

    codigo NUMERIC(18,0) IDENTITY(1,1) PRIMARY KEY, -- primary key column
    nombre VARCHAR(MAX)  NULL,
    extension CHAR(6) NULL,
    tamanio DECIMAL(10,2) NULL,
    path  varchar(MAX) NULL,
    codigo_vehiculo NUMERIC(18,0) NOT NULL,
    codigo_TipoFoto NUMERIC(18,0) NOT NULL,
    fecha_creacion DATE NOT NULL,
    creado_por VARCHAR(100)  NULL,
    modificado_por VARCHAR(100) NULL,
    fecha_modificacion DATETIME NOT NULL,

);

-- ALTER TABLE [TestSolmar].[dbo].[Appsolgis_TipoFotoVehiculo] ALTER COLUMN fecha_creacion DATETIME;  

-- INSERT INTO [TestSolmar].[dbo].[Appsolgis_TipoFotoVehiculo] (nombre, fecha_creacion, creado_por, habilitado)
-- VALUES ('Tarjeta de Propiedad', GETDATE(), 'jchunga', 1);

-- INSERT INTO [TestSolmar].[dbo].[Appsolgis_TipoFotoVehiculo] (nombre, fecha_creacion, creado_por, habilitado)
-- VALUES ('Soat', GETDATE(), 'jchunga', 1);

-- INSERT INTO [TestSolmar].[dbo].[Appsolgis_TipoFotoVehiculo] (nombre, fecha_creacion, creado_por, habilitado)
-- VALUES ('Revision Tecnica', GETDATE(), 'jchunga', 1);

-- dbcc checkident([Appsolgis_CargoTipoFormulario], reseed, 0 )

CREATE TABLE Appsolgis_CargoTipoFormulario
(

    codigo NUMERIC(18,0) IDENTITY(1,1) PRIMARY KEY,
    nombre VARCHAR(MAX)  NULL,
    habilitado bit not null,
    fecha_creacion DATETIME NOT NULL,
    creado_por VARCHAR(100) NOT NULL,
    modificado_por VARCHAR(100) NULL,
    fecha_modificacion DATETIME NULL,

);



-- INSERT INTO [TestSolmar].[dbo].[Appsolgis_CargoTipoFormulario] (nombre, habilitado, fecha_creacion, creado_por)
-- VALUES ('Caja de Texto', 1, GETDATE(), 'jchunga');

-- INSERT INTO [TestSolmar].[dbo].[Appsolgis_CargoTipoFormulario] (nombre, habilitado, fecha_creacion, creado_por)
-- VALUES ('ComboBox', 1, GETDATE(), 'jchunga');


-- INSERT INTO [TestSolmar].[dbo].[Appsolgis_CargoTipoFormulario] (nombre, habilitado, fecha_creacion, creado_por)
-- VALUES ('RadioButton', 1, GETDATE(), 'jchunga');


-- INSERT INTO [TestSolmar].[dbo].[Appsolgis_CargoTipoFormulario] (nombre, habilitado, fecha_creacion, creado_por)
-- VALUES ('Text', 1, GETDATE(), 'jchunga');


CREATE TABLE Appsolgis_CargoTipoDatoFormulario
(

    codigo NUMERIC(18,0) IDENTITY(1,1) PRIMARY KEY,
    nombre VARCHAR(MAX)  NULL,
    habilitado bit not null,
    fecha_creacion DATETIME NOT NULL,
    creado_por VARCHAR(100) NOT NULL,
    modificado_por VARCHAR(100) NULL,
    fecha_modificacion DATETIME NULL,

);


-- INSERT INTO [TestSolmar].[dbo].[Appsolgis_CargoTipoDatoFormulario] (nombre, habilitado, fecha_creacion, creado_por)
-- VALUES ('Texto', 1, GETDATE(), 'jchunga');

-- INSERT INTO [TestSolmar].[dbo].[Appsolgis_CargoTipoDatoFormulario] (nombre, habilitado, fecha_creacion, creado_por)
-- VALUES ('Numerico', 1, GETDATE(), 'jchunga');


-- INSERT INTO [TestSolmar].[dbo].[Appsolgis_CargoTipoDatoFormulario] (nombre, habilitado, fecha_creacion, creado_por)
-- VALUES ('Alfanumerico', 1, GETDATE(), 'jchunga');


-- INSERT INTO [TestSolmar].[dbo].[Appsolgis_CargoTipoFormulario] (nombre, habilitado, fecha_creacion, creado_por)
-- VALUES ('Text', 1, GETDATE(), 'jchunga');


USE [TestSolmar]

CREATE TABLE Appsolgis_CargoFormulario
(
    codigo NUMERIC(18,0) IDENTITY(1,1) PRIMARY KEY,
    etiqueta VARCHAR(MAX) NOT NULL,
    orden  INT NOT NULL,
    requerido  BIT NOT NULL,
    cod_tipoDatoFormulario NUMERIC(18,0) NOT NULL,
    tamanioCampo INT NULL,
    habilitado bit not null,
    cod_cliente VARCHAR(5) NOT NULL,
    fecha_creacion DATETIME NOT NULL,
    creado_por VARCHAR(50) NOT NULL,
    hasFoto BIT NOT NULL,
    modificado_por VARCHAR(50) NULL,
    fecha_modificacion DATETIME NULL,
    cod_CargoTipoFormulario NUMERIC(18,0) NOT NULL
);

-- SELECT * FROM  [TestSolmar].[dbo].[Appsolgis_CargoTipoDatoFormulario] 
-- SELECT * FROM  [TestSolmar].[dbo].[Appsolgis_CargoTipoFormulario]
-- SELECT * FROM  [TestSolmar].[dbo].[Appsolgis_CargoFormulario]
-- SELECT * FROM  [TestSolmar].[dbo].[Appsolgis_CargoOpcionRadioFormulario]
-- DELETE FROM [TestSolmar].[dbo].[Appsolgis_CargoFormulario] where codigo = 4

INSERT INTO [TestSolmar].[dbo].[Appsolgis_CargoFormulario](etiqueta, orden, requerido, cod_tipoDatoFormulario, tamanioCampo, habilitado, cod_cliente, fecha_creacion, creado_por, hasFoto, cod_CargoTipoFormulario)
VALUES('Cant. Guia', 4, 1, 2, 50, 1, '25866', GETDATE(), 'jchunga', 1, 1)


INSERT INTO [TestSolmar].[dbo].[Appsolgis_CargoFormulario](etiqueta, orden, requerido, cod_tipoDatoFormulario, tamanioCampo, habilitado, cod_cliente, fecha_creacion, creado_por, hasFoto, cod_CargoTipoFormulario)
VALUES('Guía', 5, 1, 1, 50, 1, '25866', GETDATE(), 'jchunga', 1, 1)


INSERT INTO [TestSolmar].[dbo].[Appsolgis_CargoFormulario](etiqueta, orden, requerido, cod_tipoDatoFormulario, tamanioCampo, habilitado, cod_cliente, fecha_creacion, creado_por, hasFoto, cod_CargoTipoFormulario)
VALUES('Contenedor', 6, 1, 1, 50, 1, '25866', GETDATE(), 'jchunga', 1, 1)


INSERT INTO [TestSolmar].[dbo].[Appsolgis_CargoFormulario](etiqueta, orden, requerido, cod_tipoDatoFormulario, tamanioCampo, habilitado, cod_cliente, fecha_creacion, creado_por, hasFoto, cod_CargoTipoFormulario)
VALUES('T. Contenedor', 7, 1, 2, 10, 1, '25866', GETDATE(), 'jchunga', 0, 3)

USE [TestSolmar]
CREATE TABLE Appsolgis_CargoOpcionRadioFormulario
(
    codigo NUMERIC(18,0) IDENTITY(1,1) PRIMARY KEY,
    etiqueta VARCHAR(MAX) NOT NULL,
    habilitado  BIT NOT NULL,
    seleccionado  BIT NOT NULL,
    fecha_creacion DATETIME NOT NULL,
    creado_por  VARCHAR(100) NOT NULL,
    fecha_modificacion DATETIME  NULL,
    modificado_por  VARCHAR(100)  NULL,
    cod_cliente     VARCHAR(5) NOT NULL,
    codigo_cargo_formulario NUMERIC(18,0) NOT NULL,
);



INSERT INTO [TestSolmar].[dbo].[Appsolgis_CargoOpcionRadioFormulario](etiqueta, habilitado, seleccionado, fecha_creacion, creado_por, cod_cliente, codigo_cargo_formulario)
VALUES('Lleno', 1, 0, GETDATE(), 'jchunga','25866', 2)


INSERT INTO [TestSolmar].[dbo].[Appsolgis_CargoOpcionRadioFormulario](etiqueta, habilitado, seleccionado, fecha_creacion, creado_por, cod_cliente, codigo_cargo_formulario)
VALUES('20', 1, 1, GETDATE(), 'jchunga','25866', 8)


INSERT INTO [TestSolmar].[dbo].[Appsolgis_CargoOpcionRadioFormulario](etiqueta, habilitado, seleccionado, fecha_creacion, creado_por, cod_cliente, codigo_cargo_formulario)
VALUES('40', 1, 1, GETDATE(), 'jchunga','25866', 8)
