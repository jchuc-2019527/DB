# OPTIONS:
#   sourcefilename=C:/Users/Usuario/Downloads/Contabilidad.mdb
#   sourceusername=
#   sourcepassword=
#   sourcesystemdatabase=
#   destinationdatabase=movedb
#   storageengine=MyISAM
#   dropdatabase=0
#   createtables=1
#   unicode=1
#   autocommit=1
#   transferdefaultvalues=1
#   transferindexes=1
#   transferautonumbers=1
#   transferrecords=1
#   columnlist=1
#   tableprefix=
#   negativeboolean=0
#   ignorelargeblobs=0
#   memotype=LONGTEXT
#   datetimetype=DATETIME
#

CREATE DATABASE IF NOT EXISTS movedb;
USE movedb;

DROP TABLE IF EXISTS ActivoFijo;

CREATE TABLE ActivoFijo (
  Codigo_Empresa INTEGER NOT NULL, 
  Codigo_ActivoFijo INTEGER NOT NULL, 
  Fecha_Adquisicion DATETIME, 
  Numero_Documento VARCHAR(255), 
  NIT_Entidad VARCHAR(12), 
  Codigo_Tipo INTEGER, 
  Descripcion_ActivoFijo VARCHAR(255), 
  Cantidad_ActivoFijo INTEGER, 
  Valor_Unitario FLOAT NULL, 
  Valor_Total FLOAT NULL, 
  Valor_Actual FLOAT NULL, 
  Depreciacion_Acumulada FLOAT NULL, 
  Depreciacion_Actual FLOAT NULL, 
  Caracteristicas_ActivoFijo LONGTEXT, 
  PRIMARY KEY (Codigo_Empresa, Codigo_ActivoFijo)
);

DROP TABLE IF EXISTS AuxiliarDetalle;

CREATE TABLE AuxiliarDetalle (
  Codigo_Empresa INTEGER NOT NULL, 
  Codigo_PlantillaAuxiliar INTEGER NOT NULL, 
  Numero_Auxiliar INTEGER NOT NULL, 
  Correlativo_Auxiliar INTEGER NOT NULL, 
  Fecha_Detalle DATETIME, 
  Descripcion_Detalle VARCHAR(255), 
  Monto_Detalle INTEGER, 
  PRIMARY KEY (Codigo_Empresa, Codigo_PlantillaAuxiliar, Numero_Auxiliar, Correlativo_Auxiliar)
);

DROP TABLE IF EXISTS AuxiliarMaestro;

CREATE TABLE AuxiliarMaestro (
  Codigo_Empresa INTEGER NOT NULL, 
  Codigo_PlantillaAuxiliar INTEGER NOT NULL, 
  Numero_Auxiliar INTEGER NOT NULL, 
  Fecha_Inicial DATETIME, 
  Fecha_Final DATETIME, 
  Estado_Auxiliar INTEGER, 
  PRIMARY KEY (Codigo_Empresa, Codigo_PlantillaAuxiliar, Numero_Auxiliar)
);

DROP TABLE IF EXISTS AuxiliarPlantilla;

CREATE TABLE AuxiliarPlantilla (
  Codigo_Empresa INTEGER NOT NULL, 
  Codigo_PlantillaAuxiliar INTEGER NOT NULL, 
  Descripcion_PlantillaAuxiliar VARCHAR(255), 
  Codigo_PlantillaContable INTEGER, 
  PRIMARY KEY (Codigo_Empresa, Codigo_PlantillaAuxiliar)
);

DROP TABLE IF EXISTS CuentaContable;

CREATE TABLE CuentaContable (
  Codigo_Empresa INTEGER NOT NULL, 
  Codigo_CuentaContable VARCHAR(20) NOT NULL, 
  Nombre_CuentaContable VARCHAR(50), 
  Tipo_CuentaContable INTEGER DEFAULT 0, 
  Padre_CuentaContable VARCHAR(20), 
  Nivel_CuentaContable INTEGER DEFAULT 0, 
  RecibePartidas_CuentaContable INTEGER, 
  PRIMARY KEY (Codigo_Empresa, Codigo_CuentaContable)
);

DROP TABLE IF EXISTS EmpresaMaestro;

CREATE TABLE EmpresaMaestro (
  Codigo_Empresa INTEGER NOT NULL, 
  Nombre_Empresa VARCHAR(255), 
  Nombre_Comercial VARCHAR(255), 
  Direccion_Empresa VARCHAR(255), 
  NIT_Empresa VARCHAR(255), 
  Porcentaje_IVA FLOAT NULL, 
  PRIMARY KEY (Codigo_Empresa)
);

DROP TABLE IF EXISTS Entidad;

CREATE TABLE Entidad (
  NIT_Entidad VARCHAR(12) NOT NULL, 
  Nombre_Entidad VARCHAR(255), 
  PRIMARY KEY (NIT_Entidad)
);

DROP TABLE IF EXISTS ImpuestoAdicional;

CREATE TABLE ImpuestoAdicional (
  Codigo_Impuesto INTEGER NOT NULL, 
  Descripcion_Impuesto VARCHAR(255), 
  Valor_Impuesto FLOAT NULL, 
  PRIMARY KEY (Codigo_Impuesto)
);

DROP TABLE IF EXISTS LibroComprasVentasDetalle;

CREATE TABLE LibroComprasVentasDetalle (
  Codigo_Empresa INTEGER NOT NULL, 
  Numero_Libro INTEGER NOT NULL, 
   Correlativo_Libro INTEGER NOT NULL, 
  Fecha_Movimiento DATETIME, 
  `NIT_Entidad` VARCHAR(255), 
  Valor_Movimiento FLOAT NULL, 
  Codigo_Movimiento INTEGER, 
  Numero_Documento VARCHAR(255), 
  Unidades_Impuesto FLOAT NULL, 
  Valor_Impuesto FLOAT NULL, 
  PRIMARY KEY (Codigo_Empresa, Numero_Libro, Correlativo_Libro)
);

DROP TABLE IF EXISTS LibroComprasVentasMaestro;

CREATE TABLE LibroComprasVentasMaestro (
  Codigo_Empresa INTEGER NOT NULL, 
  Numero_Libro INTEGER NOT NULL, 
  Fecha_Inicial DATETIME, 
  Fecha_Final DATETIME, 
  Estado_Libro INTEGER, 
  Tipo_Libro INTEGER, 
  Codigo_PlantillaContable INTEGER, 
  Fecha_Minima DATETIME, 
  Fecha_Maxima DATETIME, 
  PRIMARY KEY (Codigo_Empresa, Numero_Libro)
);

DROP TABLE IF EXISTS PartidaContableDetalle;

CREATE TABLE PartidaContableDetalle (
  Codigo_Empresa INTEGER NOT NULL, 
  Numero_PartidaContable INTEGER NOT NULL DEFAULT 0, 
  Correlativo_PartidaContable INTEGER NOT NULL DEFAULT 0, 
  Codigo_CuentaContable VARCHAR(50), 
  TipoMovimiento_PartidaContable INTEGER DEFAULT 0, 
  Monto_CuentaContable FLOAT NULL DEFAULT 0, 
  INDEX (Codigo_Empresa), 
  INDEX (Numero_PartidaContable), 
  PRIMARY KEY (Codigo_Empresa, Numero_PartidaContable, Correlativo_PartidaContable)
);

DROP TABLE IF EXISTS PartidaContableMaestro;

CREATE TABLE PartidaContableMaestro (
  Codigo_Empresa INTEGER NOT NULL, 
  Numero_PartidaContable INTEGER NOT NULL DEFAULT 0, 
  Fecha_PartidaContable DATETIME, 
  MontoDebe_PartidaContable FLOAT NULL DEFAULT 0, 
  MontoHaber_PartidaContable FLOAT NULL DEFAULT 0, 
  Caracteristicas_PartidaContable LONGTEXT, 
  PRIMARY KEY (Codigo_Empresa, Numero_PartidaContable)
);

DROP TABLE IF EXISTS Periodo;

CREATE TABLE Periodo (
  Codigo_Empresa INTEGER NOT NULL, 
  Codigo_Periodo INTEGER NOT NULL, 
  Estado_Periodo INTEGER, 
  Fecha_Inicial DATETIME, 
  Fecha_Final DATETIME, 
  INDEX (Codigo_Empresa), 
  INDEX (Codigo_Periodo), 
  PRIMARY KEY (Codigo_Empresa, Codigo_Periodo)
);

DROP TABLE IF EXISTS PlantillaContableDetalle;

CREATE TABLE PlantillaContableDetalle (
  Codigo_Empresa INTEGER NOT NULL, 
  Codigo_PlantillaContable INTEGER NOT NULL DEFAULT 0, 
  Correlativo_PlantillaContable INTEGER NOT NULL DEFAULT 0, 
  Codigo_CuentaContable VARCHAR(50), 
  TipoMovimiento_PlantillaContable INTEGER DEFAULT 0, 
  Porcentaje_CuentaContable FLOAT NULL DEFAULT 0, 
  INDEX (Codigo_Empresa), 
  INDEX (Codigo_PlantillaContable), 
  PRIMARY KEY (Codigo_Empresa, Codigo_PlantillaContable, Correlativo_PlantillaContable)
);

DROP TABLE IF EXISTS PlantillaContableMaestro;

CREATE TABLE PlantillaContableMaestro (
  Codigo_Empresa INTEGER NOT NULL, 
  Codigo_PlantillaContable INTEGER NOT NULL DEFAULT 0, 
  Descripcion_PlantillaContable VARCHAR(255), 
  Caracteristicas_PlantillaContable LONGTEXT, 
  Tipo_Plantilla INTEGER DEFAULT 0, 
  INDEX (Codigo_Empresa), 
  PRIMARY KEY (Codigo_Empresa, Codigo_PlantillaContable)
);

DROP TABLE IF EXISTS ReporteDetalle;

CREATE TABLE ReporteDetalle (
  Codigo_Reporte INTEGER NOT NULL DEFAULT 0, 
  Correlativo_Reporte INTEGER NOT NULL DEFAULT 0, 
  Orden_Reporte INTEGER DEFAULT 0, 
  Numero_Columna INTEGER DEFAULT 0, 
  Tipo_Detalle INTEGER DEFAULT 0, 
  Tipo_Valor INTEGER DEFAULT 0, 
  Codigo_CuentaContableI VARCHAR(50), 
  Codigo_CuentaContableF VARCHAR(50), 
  Tipo_Operacion INTEGER DEFAULT 0, 
  CorrelativoAnterior_Reporte INTEGER DEFAULT 0, 
  Linea_Arriba INTEGER DEFAULT 0, 
  Linea_Abajo INTEGER DEFAULT 0, 
  PRIMARY KEY (Codigo_Reporte, Correlativo_Reporte)
);

DROP TABLE IF EXISTS ReporteEjecutado;

CREATE TABLE ReporteEjecutado (
  Codigo_Reporte INTEGER NOT NULL DEFAULT 0, 
  Correlativo_Reporte INTEGER NOT NULL DEFAULT 0, 
  Fecha_Reporte DATETIME NOT NULL, 
  Codigo_CuentaContable VARCHAR(20), 
  Valor_Columna1 FLOAT NULL DEFAULT 0, 
  Valor_Columna2 FLOAT NULL DEFAULT 0, 
  Valor_Columna3 FLOAT NULL DEFAULT 0, 
  Valor_Columna4 FLOAT NULL DEFAULT 0, 
  UNIQUE (Codigo_CuentaContable), 
  INDEX (Codigo_Reporte), 
  INDEX (Correlativo_Reporte), 
  INDEX (Fecha_Reporte), 
  PRIMARY KEY (Codigo_Reporte, Correlativo_Reporte, Fecha_Reporte)
);


DROP TABLE IF EXISTS ReporteMaestro;

CREATE TABLE ReporteMaestro (
  Codigo_Reporte INTEGER NOT NULL DEFAULT 0, 
  Nombre_Reporte VARCHAR(50), 
  PRIMARY KEY (Codigo_Reporte)
);


DROP TABLE IF EXISTS SaldoContable;

CREATE TABLE SaldoContable (
  Codigo_Empresa INTEGER NOT NULL, 
  Codigo_CuentaContable VARCHAR(20) NOT NULL, 
  Codigo_Periodo INTEGER NOT NULL, 
  SaldoInicialD_CuentaContable FLOAT NULL, 
  SaldoInicialH_CuentaContable FLOAT NULL, 
  MontoDebe_CuentaContable FLOAT NULL DEFAULT 0, 
  MontoHaber_CuentaContable FLOAT NULL DEFAULT 0, 
  SaldoFinalD_CuentaContable FLOAT NULL DEFAULT 0, 
  SaldoFinalH_CuentaContable FLOAT NULL, 
  INDEX (Codigo_Empresa), 
  PRIMARY KEY (Codigo_Empresa, Codigo_Periodo, Codigo_CuentaContable)
);

DROP TABLE IF EXISTS TipoActivoFijo;

CREATE TABLE TipoActivoFijo (
  Codigo_Tipo INTEGER NOT NULL, 
  Descripcion_Tipo VARCHAR(255), 
  Porcentaje_Depreciacion FLOAT NULL, 
  PRIMARY KEY (Codigo_Tipo)
);


DROP TABLE IF EXISTS TipoMovimientoLibroComprasVentas;

CREATE TABLE TipoMovimientoLibroComprasVentas (
  Codigo_Movimiento INTEGER NOT NULL, 
  Descripcion_Movimiento VARCHAR(255), 
  Tipo_Libro INTEGER, 
  Tipo_Movimiento INTEGER, 
  PRIMARY KEY (Codigo_Movimiento)
);

DROP TABLE IF EXISTS Usuario;

CREATE TABLE Usuario (
  Codigo_Usuario VARCHAR(12) NOT NULL, 
  Nombre_Usuario VARCHAR(255), 
  Clave_Usuario VARCHAR(255), 
  INDEX (Clave_Usuario), 
  PRIMARY KEY (Codigo_Usuario)
);


-- 					PROCEDIMIENTOS ALMACENADOS				--

/*-- -----------------Activo fijo------------------------------
-----------------------------------------------------------*/

-- ------------------------ Listar ---------------------------
Drop procedure if exists sp_ListarActivoFijo;
Delimiter $$
	create procedure sp_ListarActivoFijo()
		Begin
			Select 
				A.codigo_Empresa,
                A.Codigo_ActivoFijo,
                A.Fecha_Adquisicion,
                A.Numero_Documento,
                A.Nit_Entidad,
                A.Codigo_Tipo,
                A.Descripcion_ActivoFijo,
                A.Cantidad_ActivoFijo,
                A.Valor_Unitario,
                A.Valor_Total,
                A.Valor_Actual,
                A.Depreciacion_Acumulada,
                A.Depreciacion_Actual,
                A.Caracteristicas_ActivoFijo
                from ActivoFijo A;
		End$$
Delimiter ;

call sp_ListarActivoFijo();
-- ---------------------- Agregar ------------------------

Drop procedure if exists sp_AgregarActivoFijo;
Delimiter $$
	Create procedure sp_AgregarActivoFijo(in Codigo_Empresa INTEGER, IN Codigo_ActivoFijo INTEGER, in Fecha_Adquisicion DATETIME, in Numero_Documento VARCHAR(255), in NIT_Entidad VARCHAR(12), IN Codigo_Tipo INTEGER, IN Descripcion_ActivoFijo VARCHAR(255), in Cantidad_ActivoFijo INTEGER, in Valor_Unitario FLOAT, in Valor_Total FLOAT, in Valor_Actual FLOAT, in Depreciacion_Acumulada FLOAT, in Depreciacion_Actual FLOAT, in Caracteristicas_ActivoFijo LONGTEXT )
    Begin
        Insert into ActivoFijo (Codigo_Empresa, Codigo_ActivoFijo, Fecha_Adquisicion, Numero_Documento, NIT_Entidad, Codigo_Tipo, Descripcion_ActivoFijo, Cantidad_ActivoFijo, Valor_Unitario, Valor_Total, Valor_Actual, Depreciacion_Acumulada, Depreciacion_Actual, Caracteristicas_ActivoFijo)
          Values  (Codigo_Empresa, Codigo_ActivoFijo, Fecha_Adquisicion, Numero_Documento, NIT_Entidad, Codigo_Tipo, Descripcion_ActivoFijo, Cantidad_ActivoFijo, Valor_Unitario, Valor_Total, Valor_Actual, Depreciacion_Acumulada, Depreciacion_Actual, Caracteristicas_ActivoFijo);
    End$$
Delimiter ;
call sp_AgregarActivoFijo(1, 5, '2022-02-08', 8, '6411372-8', 3, 'Es un activo fijo de una empresa', 2000, 10, 1000, 10000, 1000, 2000, 'Tuvimos una depreciacion de esta misma empresa');

--- -------------------- Eliminar --------------------------
Drop procedure if exists sp_DeleteActivoFijo;
Delimiter $$
  Create Procedure sp_DeleteActivoFijo(in codActivoFijo INTEGER)
    Begin
      Delete from ActivoFijo where Codigo_Empresa = codActivoFijo;
    End$$
Delimiter ;

call sp_DeleteActivoFijo(1);
select * from ActivoFijo;

-- ---------------------- Actualizar ------------------
Drop procedure if exists sp_UpdateActivoFijo;
Delimiter $$
  Create procedure sp_UpdateActivoFijo(in codEmpre integer, in codActivo integer, in fechaAdqui DATETIME, in numDoc VARCHAR(255), in NIT VARCHAR(12), IN codTipo integer, in desActivo VARCHAR(255), IN canActivo integer, in valorUni FLOAT, in valorTotal FLOAT, in valorActual FLOAT, in depreciacionAcu FLOAT,in depreAtual FLOAT ,in caractersticasFijo LONGTEXT)
    Begin
      Update ActivoFijo 
      set 
      Codigo_Empresa = codEmpre, 
      Codigo_ActivoFijo = codActivo, 
      Fecha_Adquisicion = fechaAdqui, 
      Numero_Documento = numDoc, 
      NIT_Entidad = NIT, 
      Codigo_Tipo = codTipo, 
      Descripcion_ActivoFijo = desActivo, 
      Cantidad_ActivoFijo = canActivo, 
      Valor_Unitario = valorUni, 
      Valor_Total = valorTotal, 
      Valor_Actual = valorActual, 
      Depreciacion_Acumulada = depreciacionAcu, 
      Depreciacion_Actual = depreAtual, 
      Caracteristicas_ActivoFijo = caractersticasFijo 
      where Codigo_Empresa = codEmpre;
    End$$
Delimiter ;
call sp_UpdateActivoFijo(1, 1, '2022-02-08', 8, '6411372-8', 3, 'Es un activo fijo', 2000, 10, 1000, 10000, 1000, 2000, 'Tuvimos una depreciacion updated');
call sp_ListarActivoFijo();

-- ---------------------Buscar -------------------

Drop procedure if exists sp_BuscarActivoFijo;
Delimiter $$
  Create procedure sp_BuscarActivoFijo(in codEmpre integer)
    Begin
		Select 
			A.codigo_Empresa,
			A.Codigo_ActivoFijo,
			A.Fecha_Adquisicion,
			A.Numero_Documento,
			A.Nit_Entidad,
			A.Codigo_Tipo,
			A.Descripcion_ActivoFijo,
			A.Cantidad_ActivoFijo,
			A.Valor_Unitario,
			A.Valor_Total,
			A.Valor_Actual,
			A.Depreciacion_Acumulada,
			A.Depreciacion_Actual,
			A.Caracteristicas_ActivoFijo
			from ActivoFijo A where Codigo_Empresa = codEmpre ;
    End$$
Delimiter ;
call sp_BuscarActivoFijo(2);
select * from ActivoFijo;


/*-- -----------------Auxiliar Detalle------------------------------
-----------------------------------------------------------*/

-- --------------------------- Agregar-------------------------------
Drop procedure if exists sp_AgregarAuxiliarDetalle;
Delimiter $$
	Create procedure sp_AgregarAuxiliarDetalle(in codigo_Empresa INTEGER, IN Codigo_PlantillaAuxiliar integer, in Numero_Auxiliar integer, in Correlativo_Auxiliar Integer, in Fecha_Detalle DATETIME, in Descripcion_Detalle Varchar(255), in Monto_Detalle INTEGER)
    Begin
      Insert into AuxiliarDetalle(codigo_Empresa, Codigo_PlantillaAuxiliar, Numero_Auxiliar, Correlativo_Auxiliar, Fecha_Detalle, Descripcion_Detalle,  Monto_Detalle)
      values (codigo_Empresa, Codigo_PlantillaAuxiliar, Numero_Auxiliar, Correlativo_Auxiliar, Fecha_Detalle, Descripcion_Detalle,  Monto_Detalle);
    End$$
Delimiter ;
call sp_AgregarAuxiliarDetalle(9, 2, 4, 121211, '2022-03-08', 'Es el detalle de un auxiliar', 2000);
select * from AuxiliarDetalle;

-- -------------------Listar ------------------- ----
Drop procedure if exists sp_ListarAuxiliarDetalle;
Delimiter $$
  Create procedure sp_ListarAuxiliarDetalle ()
    Begin
      Select 
      AU.codigo_Empresa,
      Au.Codigo_PlantillaAuxiliar,
      AU.Numero_Auxiliar,
      Au.Correlativo_Auxiliar,
      AU.Fecha_Detalle,
      AU.Descripcion_Detalle,
      AU.Monto_Detalle
      from AuxiliarDetalle AU;
    End$$
Delimiter ;
call sp_ListarAuxiliarDetalle();

-- ----------------------------Actualizar ------------ --
Drop procedure if exists sp_UpdateAuxiliarDetalle;
Delimiter $$
  Create procedure sp_UpdateAuxiliarDetalle (in codEmpre integer, 
  in codPlantAux integer, in numAux integer, in correlativoAux integer, 
  in fechaDe DATETIME, in descriptionDet varchar(255), in montoDet integer)
    Begin
      Update AuxiliarDetalle
        set Codigo_Empresa = codEmpre,
          Codigo_PlantillaAuxiliar = codPlantAux,
          Numero_Auxiliar = numAux,
          Correlativo_Auxiliar = correlativoAux,
          Fecha_Detalle = fechaDe,
          Descripcion_Detalle = descriptionDet,
          Monto_Detalle = montoDet
        where Codigo_Empresa = codEmpre;
    End$$
Delimiter ;
call sp_UpdateAuxiliarDetalle(1, 9, 4, 887878, '2022-02-06', 'Es el detalle de un auxiliar edited', 2000);
select * from AuxiliarDetalle;

-- ------------------------- Eliminar ---------------- --
Drop procedure if exists sp_DeleteAuxiliarDetalle;
Delimiter $$
  Create procedure sp_DeleteAuxiliarDetalle (in codEmpre integer)
    Begin
      Delete from AuxiliarDetalle where Codigo_Empresa = codEmpre; 
    End$$
Delimiter ;

call sp_DeleteAuxiliarDetalle(1);
select * from AuxiliarDetalle;

-- ---------------------- Buscar ----------------------- --
Drop procedure if exists sp_BuscarAuxiliarDetalle;
Delimiter $$
  Create procedure sp_BuscarAuxiliarDetalle(in codEmpre integer)
    Begin
      Select 
        AU.codigo_Empresa,
        Au.Codigo_PlantillaAuxiliar,
        AU.Numero_Auxiliar,
        Au.Correlativo_Auxiliar,
        AU.Fecha_Detalle,
        AU.Descripcion_Detalle,
        AU.Monto_Detalle
      from AuxiliarDetalle AU where Codigo_Empresa = codEmpre;
    End$$
Delimiter ;

call sp_BuscarAuxiliarDetalle(9);


/*-- -----------------Auxiliar Maestro------------------------------
-----------------------------------------------------------*/

-- --------------------------- Agregar-------------------------------
Drop procedure if exists sp_AgregarAuxiliarMaestro



