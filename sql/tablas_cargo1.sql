-- Create the table 
CREATE TABLE AppSolgis_campo_form
(
    codigo_campo_form INT IDENTITY(1,1) NOT NULL, 
    etiqueta VARCHAR(200) NULL,
    habilitado BIT NULL,
    fecha_creacion DATETIME NULL,
    creado_por VARCHAR(200) NULL,
    fecha_modificacion DATETIME NULL,
    modificado_por VARCHAR(200) NULL
);

CREATE TABLE AppSolgis_RelacionCampoCargoCliente
(
    codigo_relacion INT IDENTITY(1,1) NOT NULL, 
    codigo_campo_form INT NULL,
    habilitado BIT NULL,
    codigo_cliente CHAR(5) NULL,
    hasFoto BIT NULL,
    fecha_creacion DATETIME NULL,
    creado_por VARCHAR(200) NULL,
    fecha_modificacion DATETIME NULL,
    modificado_por VARCHAR(200) NULL,
);

CREATE TABLE AppSolgis_RadioOpcion
(
    codigo_opcion INT IDENTITY(1,1) NOT NULL, 
    valor VARCHAR(200) NULL,
    es_numerico BIT NULL,
    habilitado BIT NULL,
    seleccionado BIT NULL,
    codigo_cliente CHAR(5) NULL,
    codigo_campo_form INT NOT NULL,
    fecha_creacion DATETIME NULL,
    creado_por VARCHAR(200) NULL,
    fecha_modificacion DATETIME NULL,
    modificado_por VARCHAR(200) NULL,
);

CREATE TABLE AppSolgis_Epp
(
    codigo_epp INT IDENTITY(1,1) NOT NULL, 
    nombre VARCHAR(200) NULL,
    es_numerico BIT NULL,
    habilitado BIT NULL,
    fecha_creacion DATETIME NULL,
    creado_por VARCHAR(200) NULL,
    fecha_modificacion DATETIME NULL,
    modificado_por VARCHAR(200) NULL,
);

CREATE TABLE AppSolgis_RelacionEppsCliente
(
    codigo_relacion INT IDENTITY(1,1) NOT NULL,
    codigo_epp INT NULL, 
    codigo_cliente CHAR(5) NULL,
    habilitado BIT NULL, 
    fecha_creacion DATETIME NULL,
    creado_por VARCHAR(200) NULL,
    fecha_modificacion DATETIME NULL,
    modificado_por VARCHAR(200) NULL,
);

CREATE TABLE AppSolgis_RelacionEppsCargo
(
    codigo_relacion INT IDENTITY(1,1) NOT NULL,
    codigo_epp INT NULL, 
    codigo_cargo INT NULL,
    codigo_cliente CHAR(5) NULL,
    fecha_creacion DATETIME NULL,
    creado_por VARCHAR(200) NULL,
);

CREATE TABLE AppSolgis_TipoFotoCargoForm
(
    codigo_tipo_foto INT IDENTITY(1,1) NOT NULL,
    descripcion      NVARCHAR(250) NULL,
    fecha_creacion      DATETIME NULL,
    creado_por         VARCHAR(200) NULL,
    fecha_modificacion DATETIME NULL,
    modificado_por VARCHAR(200) NULL,
);

CREATE TABLE AppSolgis_FotoCargoForm
(
    codigo_foto INT IDENTITY(1,1) NOT NULL,
    nombre      NVARCHAR(250) NULL,
    extension   VARCHAR(100) NULL,
    tamanio     DECIMAL(18,2) NULL,
    path        NVARCHAR(250) NULL,
    fecha_creacion DATETIME NULL,
    creado_por VARCHAR(200) NULL,
);

CREATE TABLE AppSolgis_RelacionFotoCargo
(
    codigo_relacion INT IDENTITY(1,1) NOT NULL,
    codigo_cargo    INT NULL,
    codigo_tipo_foto INT NULL,
    codigo_foto     INT NULL,
    fecha_creacion      DATETIME NULL,
    creado_por         VARCHAR(200) NULL,
);

CREATE TABLE AppSolgis_RelacionCampoMultiples
(
    codigo_relacion INT IDENTITY(1,1) NOT NULL,
    codigo_cargo    INT NULL,
    descripcion     VARCHAR(250) NOT NULL, 
    codigo_campo_form INT NULL,
    fecha_creacion DATETIME NULL,
    creado_por VARCHAR(200) NULL,
);

CREATE TABLE AppSolgis_Cargo
(
    codigo_cargo INT IDENTITY(1,1) NOT NULL,
    codigo_tipo_carga INT NULL,
    alcoholimetro BIT NULL,
    codigo_cliente CHAR(5) NULL,
    codigo_servicio NUMERIC(18,0) NULL,
    cod_mov_peatonal NUMERIC(18,0) NULL,
    cod_mov_vehicular NUMERIC(18,0) NULL,
    carreta INT NULL,
    carga   BIT NULL,
    origen INT NULL,
    contenedor VARCHAR(250) NULL,
    cod_tam_contenedor INT NULL,
    booking VARCHAR(250) NULL,
    contrato VARCHAR(250) NULL,
    fecha_creacion DATETIME NULL,
    creado_por VARCHAR(200) NULL,
    fecha_modificacion DATETIME NULL,
    modificado_por VARCHAR(200) NULL,
);

CREATE TABLE AppSolgis_foto_licencia
(
    codigo_foto_licencia INT IDENTITY(1,1 ) NOT NULL,
    nombre      NVARCHAR(250) NULL,
    codigo_personal NUMERIC(18,0) NULL,
    extension   VARCHAR(100) NULL,
    tamanio     DECIMAL(18,2) NULL,
    path        NVARCHAR(250) NULL,
    fecha_creacion DATETIME NULL,
    creado_por VARCHAR(200) NULL,
);


CREATE TABLE AppSolgis_FotoVehiculo
(
    codigo_foto INT IDENTITY(1,1 ) NOT NULL,
    nombre      NVARCHAR(250) NULL,
    extension   VARCHAR(100) NULL,
    tamanio     DECIMAL(18,2) NULL,
    path        NVARCHAR(250) NULL,
    fecha_creacion DATETIME NULL,
    creado_por VARCHAR(200) NULL,
);



CREATE TABLE AppSolgis_RelacionFotoVehiculo
(
    codigo_relacion INT IDENTITY(1,1 ) NOT NULL,
    codigo_vehiculo NUMERIC(18,0) NULL,
    codigo_foto_vehiculo INT NULL,
    codigo_tipo_fotoVehiculo INT NULL,
    fecha_creacion DATETIME NULL,
    creado_por VARCHAR(200) NULL,
);

