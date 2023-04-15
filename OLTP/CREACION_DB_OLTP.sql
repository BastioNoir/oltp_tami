CREATE TABLE COCHE ( 
ID_COCHE     SMALLINT NOT NULL, 
TIPO_RUEDA   VARCHAR(6) NOT NULL,
VEL_MAX      DECIMAL(5,2),
LARGO        DECIMAL(4,2),
ANCHO        DECIMAL(4,2),
POTENCIA_MOTOR      DECIMAL(5,2),
ULTIMA_ACTUALIZACION TIMESTAMP NOT NULL,
    CONSTRAINT pkCOCHE PRIMARY KEY (ID_COCHE),
    CONSTRAINT chTIPO_RUEDA 
        CHECK(TIPO_RUEDA IN('SECO','MOJADO')),
    CONSTRAINT chVEL_MAX 
        CHECK(VEL_MAX>100)
);


CREATE TABLE COLOR_COCHE (
ID_COCHE    SMALLINT NOT NULL,
COLOR_COCHE    VARCHAR(10) NOT NULL,
    CONSTRAINT pkCOLOR PRIMARY KEY (ID_COCHE, COLOR_COCHE),
    CONSTRAINT fkCOCHE FOREIGN KEY (ID_COCHE) REFERENCES COCHE(ID_COCHE)
);


CREATE TABLE PATROCINADOR (
ID_PATROCINADOR        SMALLINT NOT NULL,
ULTIMA_ACTUALIZACION TIMESTAMP NOT NULL,
    CONSTRAINT pkPATROCINADOR PRIMARY KEY (ID_PATROCINADOR)
);


CREATE TABLE MECENAS (
NIF_MECENAS     CHAR(9) NOT NULL,
ID_PATROCINADOR        SMALLINT NOT NULL,
    CONSTRAINT pkMECENAS PRIMARY KEY (NIF_MECENAS),
    CONSTRAINT fkPATROCINADOR FOREIGN KEY (ID_PATROCINADOR) REFERENCES PATROCINADOR(ID_PATROCINADOR)
);


CREATE TABLE MARCA (
NIF_MARCA    CHAR(9) NOT NULL,
ID_PATROCINADOR        SMALLINT NOT NULL,
    CONSTRAINT pkNIF_MARCA PRIMARY KEY (NIF_MARCA),
    CONSTRAINT fkMARCA_PATROCINADOR FOREIGN KEY (ID_PATROCINADOR) REFERENCES PATROCINADOR(ID_PATROCINADOR)
);


CREATE TABLE CATEGORIA (
NIF_MARCA    CHAR(9) NOT NULL,
CATEGORIA_MARCA    VARCHAR(30) NOT NULL,
    CONSTRAINT pkCATEGORIA PRIMARY KEY (NIF_MARCA, CATEGORIA_MARCA),
    CONSTRAINT fkMARCA FOREIGN KEY (NIF_MARCA) REFERENCES MARCA(NIF_MARCA)
);


CREATE TABLE PATROCINA (
ID_COCHE    SMALLINT NOT NULL,
ID_PATROCINADOR  SMALLINT NOT NULL,
DINERO_APORTA    DECIMAL(10,2),
DUR_CONTRATO     DOUBLE,                            
    CONSTRAINT pkPATROCINA PRIMARY KEY (ID_COCHE, ID_PATROCINADOR),
    CONSTRAINT fkPATROCINA_COCHE FOREIGN KEY (ID_COCHE) REFERENCES COCHE(ID_COCHE),
    CONSTRAINT fkPATROCINA_PATROCINADOR FOREIGN KEY (ID_PATROCINADOR) REFERENCES PATROCINADOR(ID_PATROCINADOR),
    CONSTRAINT chDINERO_APORTA CHECK(DINERO_APORTA>23.00)
);


CREATE TABLE FEDERACION (
NIF_FEDERACION    CHAR(9) NOT NULL,
FECHA_CREACION    DATETIME NOT NULL,
NOM_FEDERACION    VARCHAR(20) NOT NULL,
    CONSTRAINT pkFEDERACION PRIMARY KEY (NIF_FEDERACION)
);


CREATE TABLE TEMPORADA (
NOM_TEMPORADA    VARCHAR(20) NOT NULL,
NIF_FEDERACION    CHAR(9) NOT NULL,
FECHA_INI_TEMP    DATETIME NOT NULL,
FECHA_FIN_TEMP    DATETIME NOT NULL,
    CONSTRAINT pkTEMPORADA PRIMARY KEY (NOM_TEMPORADA),
    CONSTRAINT fkFEDERACION FOREIGN KEY (NIF_FEDERACION) REFERENCES FEDERACION(NIF_FEDERACION) 
);


CREATE TABLE CIRCUITO
(
    NOM_CIRCUITO VARCHAR(50) NOT NULL,
    PAIS VARCHAR(50),
    CIUDAD VARCHAR(50),
    N_CURVAS DECIMAL(3,2),
    ULTIMA_ACTUALIZACION TIMESTAMP NOT NULL,
    CONSTRAINT pkCIRCUITO PRIMARY KEY (NOM_CIRCUITO)
);


CREATE TABLE CARRERA (
ID_CARRERA    SMALLINT NOT NULL,
NOM_CARRERA    VARCHAR(50)NOT NULL,
NOM_CIRCUITO    VARCHAR(50)NOT NULL,
NOM_TEMPORADA   VARCHAR(20) NOT NULL,
ULTIMA_ACTUALIZACION TIMESTAMP NOT NULL,
    CONSTRAINT pkCARRERA PRIMARY KEY (ID_CARRERA),
    CONSTRAINT fkCARRERA_CIRCUITO FOREIGN KEY (NOM_CIRCUITO) REFERENCES CIRCUITO(NOM_CIRCUITO),
    CONSTRAINT fkCARRERA_TEMPORADA FOREIGN KEY (NOM_TEMPORADA) REFERENCES TEMPORADA(NOM_TEMPORADA)
);


CREATE TABLE PARTICIPA_EN (
ID_COCHE    SMALLINT NOT NULL,
ID_CARRERA    SMALLINT NOT NULL,
PUNTOS        SMALLINT NOT NULL,
TIEMPO_MEJOR_VUELTA DECIMAL(6,3),
FECHA_INI_CARRERA  DATETIME NOT NULL,
FECHA_FIN_CARRERA  DATETIME NOT NULL,
    CONSTRAINT pkPARTICIPA_EN PRIMARY KEY (ID_COCHE, ID_CARRERA, PUNTOS),
    CONSTRAINT fkPARTICIPA_EN_COCHE FOREIGN KEY (ID_COCHE) REFERENCES COCHE(ID_COCHE),
    CONSTRAINT fkPARTICIPA_EN_CARRERA FOREIGN KEY (ID_CARRERA) REFERENCES CARRERA(ID_CARRERA),
    CONSTRAINT chPUNTOS CHECK(PUNTOS>=0 AND PUNTOS<=1000)
);


CREATE TABLE COMPETICION (
    ID_COCHE SMALLINT NOT NULL,
    ID_CARRERA SMALLINT NOT NULL,
    CONSTRAINT pkCOMPETICION PRIMARY KEY (ID_COCHE, ID_CARRERA),
    CONSTRAINT fkCOMPETICION_COCHE FOREIGN KEY (ID_COCHE) REFERENCES COCHE(ID_COCHE),
    CONSTRAINT fkCOMPETICION_CARRERA FOREIGN KEY (ID_CARRERA) REFERENCES CARRERA(ID_CARRERA)
);


CREATE TABLE INCIDENCIA (
N_INCID        DECIMAL(38) NOT NULL,
DESCR_INCIDENCIA    VARCHAR(200),
FECHA_INCIDENCIA    DATETIME NOT NULL,
ID_COCHE    SMALLINT NOT NULL,
ID_CARRERA    SMALLINT NOT NULL,
    CONSTRAINT pkINCIDENCIA PRIMARY KEY (N_INCID, ID_COCHE, ID_CARRERA),
    CONSTRAINT fkINCIDENCIA_COMPETICION FOREIGN KEY (ID_COCHE,ID_CARRERA) REFERENCES COMPETICION(ID_COCHE, ID_CARRERA) ON DELETE CASCADE
);


CREATE TABLE PERSONA
(
    DNI CHAR(9) NOT NULL,
    NOMBRE VARCHAR(15) NOT NULL,
    APELLIDOS VARCHAR(35) NOT NULL,
    SALARIO DECIMAL(6,2),
    NUM_CASA SMALLINT,
    CALLE_CASA VARCHAR(20),
    PISO_CASA SMALLINT,
    CONSTRAINT pkPERSONA PRIMARY KEY(DNI)
);


CREATE TABLE PERSONA_TLF
(
    TLF_PERSONA VARCHAR(9) NOT NULL,
    DNI CHAR(9) NOT NULL,
    CONSTRAINT pkPERSONAS_TLF PRIMARY KEY (TLF_PERSONA, DNI),
    CONSTRAINT fkDNI_PERSONA FOREIGN KEY (DNI) REFERENCES PERSONA(DNI) ON DELETE CASCADE
);

CREATE TABLE JEFE_EQUIPO
(
    DNI_JEFE CHAR(9) NOT NULL,
    FECHA_ADMISION DATETIME NOT NULL,
    CONSTRAINT pkDNI_JEFE PRIMARY KEY (DNI_JEFE),
    CONSTRAINT fkDNI_JEFE FOREIGN KEY (DNI_JEFE) REFERENCES PERSONA(DNI) ON DELETE CASCADE
);


CREATE TABLE PILOTO
(
    DNI_PILOTO CHAR(9) NOT NULL,
    TITULAR CHAR(9),
    SEXO VARCHAR(1),
    EDAD DECIMAL(6,3),
    ANHOS_EXP DECIMAL(6,3),
    ALTURA DECIMAL(6,3),
    PESO DECIMAL(6,3),
    ID_COCHE SMALLINT NOT NULL,
	ULTIMA_ACTUALIZACION TIMESTAMP NOT NULL,
    CONSTRAINT pkDNI_PILOTO PRIMARY KEY (DNI_PILOTO),
    CONSTRAINT chSEXO CHECK(SEXO IN('M','F')),
    CONSTRAINT fkPILOTO_DNI_PERSONA FOREIGN KEY (DNI_PILOTO) REFERENCES PERSONA(DNI) ON DELETE CASCADE,
    CONSTRAINT fkPILOTO_ID_COCHE FOREIGN KEY (ID_COCHE) REFERENCES COCHE(ID_COCHE)
);


CREATE TABLE FAMILIAR_CONTACTO
(
    DNI_FAMILIAR CHAR(9) NOT NULL,
    NOM_FAMILIAR VARCHAR(15),
    TLF_FAMILIAR BIGINT,
    VINCULO VARCHAR(30),
    DNI_PILOTO CHAR(9) NOT NULL,
    CONSTRAINT pkFAMILIAR_PILOTO PRIMARY KEY (DNI_FAMILIAR,NOM_FAMILIAR,TLF_FAMILIAR,VINCULO,DNI_PILOTO),
    CONSTRAINT fkFAMILIAR_PILOTO FOREIGN KEY (DNI_PILOTO) REFERENCES PILOTO(DNI_PILOTO) ON DELETE CASCADE
);


CREATE TABLE ENTRENAMIENTO
(
    COD_ENTRENAMIENTO SMALLINT NOT NULL,
    DESCR_ENTRENAMIENTO VARCHAR(100),
    DNI_PILOTO CHAR(9) NOT NULL,
    NOM_CIRCUITO VARCHAR(50) NOT NULL,
    CONSTRAINT pkENTRENAMIENTO PRIMARY KEY (COD_ENTRENAMIENTO),
    CONSTRAINT fkPILOTO FOREIGN KEY (DNI_PILOTO) REFERENCES PILOTO(DNI_PILOTO) ON DELETE CASCADE,
    CONSTRAINT fkCIRCUITO FOREIGN KEY (NOM_CIRCUITO) REFERENCES CIRCUITO(NOM_CIRCUITO)
);


CREATE TABLE VUELTA
(
    NUM_VUELTA SMALLINT NOT NULL,
    TIEMPO_VUELTA DECIMAL(6,3),
    COD_ENTRENAMIENTO SMALLINT NOT NULL,
    CONSTRAINT pkVUELTA PRIMARY KEY (NUM_VUELTA, COD_ENTRENAMIENTO),
    CONSTRAINT fkENTRENAMIENTO FOREIGN KEY (COD_ENTRENAMIENTO) REFERENCES ENTRENAMIENTO(COD_ENTRENAMIENTO) ON DELETE CASCADE
);


CREATE TABLE STAFF
( 
  DNI		CHAR(9) NOT NULL,
  COD_STAFF	SMALLINT NOT NULL,
  CONSTRAINT pkSTAFF	
	  PRIMARY KEY(DNI),
  CONSTRAINT fkSTAFF_DNI_PERSONA
	  FOREIGN KEY(DNI) REFERENCES PERSONA(DNI) ON DELETE CASCADE,
  CONSTRAINT chSTAFF_COD_STAFF
    CHECK (COD_STAFF>0)
);


CREATE TABLE MIEMBRO_FINANZAS
( 
  DNI		CHAR(9) NOT NULL,
  ANHO_EXPERIENCIA	SMALLINT,
  CONSTRAINT pkMIEMBRO_FINANZAS
	  PRIMARY KEY(DNI),
  CONSTRAINT fkMIEMBRO_FINANZAS_DNI_STAFF
	  FOREIGN KEY(DNI) REFERENCES STAFF(DNI) ON DELETE CASCADE,
  CONSTRAINT chEXPERIENCIA CHECK(ANHO_EXPERIENCIA>0)
);


CREATE TABLE MIEMBRO_PRODUCCION
( 
  DNI		CHAR(9) NOT NULL,
  ID_COCHE	SMALLINT NOT NULL,
  JORNADA VARCHAR(7) NOT NULL,
  FECHA_INI_CONSTRUCCION	DATETIME NOT NULL,
  FECHA_FIN_CONSTRUCCION	DATETIME NOT NULL,
  CONSTRAINT pkMIEMBRO_PRODUCCION
	  PRIMARY KEY(DNI),
  CONSTRAINT fkDNI_STAFF
	  FOREIGN KEY(DNI) REFERENCES STAFF(DNI) ON DELETE CASCADE,
  CONSTRAINT fkID_COCHE
	  FOREIGN KEY(ID_COCHE) REFERENCES COCHE(ID_COCHE),
  CONSTRAINT chJORNADA
	  CHECK(JORNADA IN ('TOTAL','PARCIAL'))
);


CREATE TABLE MIEMBRO_COMUNICACIONES
(
    DNI            CHAR(9) NOT NULL,
    PUESTO_COMUNICACIONES    VARCHAR(50),
    ID_COCHE SMALLINT NOT NULL,
    CONSTRAINT pkM_COMUNICACIONES PRIMARY KEY (DNI),
    CONSTRAINT fkDNI_COMUNICACIONES FOREIGN KEY (DNI) REFERENCES STAFF(DNI) ON DELETE CASCADE,
    CONSTRAINT fkCOCHE_COMUNICACIONES FOREIGN KEY (ID_COCHE) REFERENCES COCHE(ID_COCHE)
);


CREATE TABLE INGENIERO
(
    DNI           CHAR(9) NOT NULL,
    TITULO        VARCHAR(50),
    ID_COCHE    SMALLINT NOT NULL, 

    CONSTRAINT pkINGENIERO PRIMARY KEY (DNI),
    CONSTRAINT fkINGENIERO_STAFF FOREIGN KEY (DNI) REFERENCES STAFF(DNI),
    CONSTRAINT fkINGENIERO_COCHE FOREIGN KEY (ID_COCHE) REFERENCES COCHE(ID_COCHE)
);


CREATE TABLE MECANICO
(
    DNI           CHAR(9) NOT NULL,
    ID_COCHE    SMALLINT NOT NULL,
    ESPECIALIZACION VARCHAR(20) NOT NULL,
    CONSTRAINT pkMECANICO PRIMARY KEY (DNI),
    CONSTRAINT fkMECANICO_STAFF FOREIGN KEY (DNI) REFERENCES STAFF(DNI),
    CONSTRAINT fkMECANICO_COCHE FOREIGN KEY (ID_COCHE) REFERENCES COCHE(ID_COCHE),
    CONSTRAINT chESPECIALIZACION
	  CHECK(ESPECIALIZACION IN ('RUEDAS','SISTEMA DE FRENO','ELECTRÓNICA','SISTEMA DE DIRECCIÓN', 'CARROCERÍA'))
);


CREATE TABLE TALLER
(
    DNI         CHAR(9) NOT NULL,
    NUM_TLLR    SMALLINT NOT NULL,
    CALLE_TLLR  VARCHAR(200) NOT NULL,
    CONSTRAINT pkDNI_TALLER PRIMARY KEY (DNI),
    CONSTRAINT fkDNI_MECANICO FOREIGN KEY (DNI) REFERENCES MECANICO(DNI)
);


CREATE TABLE BOXES
(
    DNI           CHAR(9) NOT NULL,
    T_REACCION    DECIMAL(4,2) NOT NULL,
    CONSTRAINT pkDNI_BOXES PRIMARY KEY (DNI),
    CONSTRAINT fkBOXES_MECANICO FOREIGN KEY (DNI) REFERENCES MECANICO(DNI),
    CONSTRAINT chBOXES CHECK(T_REACCION>0)
);


CREATE TABLE PRUEBA
(
    COD_PRUEBA   SMALLINT NOT NULL,
    LUGAR        VARCHAR(150),
    FECHA_PRUEBA        DATETIME NOT NULL,
    ID_COCHE    SMALLINT NOT NULL,
    ULTIMA_ACTUALIZACION TIMESTAMP NOT NULL,

    CONSTRAINT pkPRUEBA PRIMARY KEY (COD_PRUEBA),
    CONSTRAINT fkPRUEBA_COCHE FOREIGN KEY (ID_COCHE) REFERENCES COCHE(ID_COCHE)
);


CREATE TABLE REPARA
(
    DNI             CHAR(9) NOT NULL,
    ID_COCHE        SMALLINT NOT NULL,
    FECHA_INI_REP    DATETIME NOT NULL,
    FECHA_FIN_REP    DATETIME NOT NULL,

    CONSTRAINT pkREPARA PRIMARY KEY (DNI,ID_COCHE),
    CONSTRAINT fkREPARA_MECANICO FOREIGN KEY(DNI) REFERENCES MECANICO(DNI),
    CONSTRAINT fkREPARA_COCHE FOREIGN KEY(ID_COCHE) REFERENCES COCHE(ID_COCHE)
);


CREATE TABLE REALIZA
(
    COD_PRUEBA    SMALLINT NOT NULL,
    DNI           CHAR(9) NOT NULL,

    CONSTRAINT pkREALIZA PRIMARY KEY (COD_PRUEBA, DNI),
    CONSTRAINT fkPRUEBA FOREIGN KEY (COD_PRUEBA) REFERENCES PRUEBA(COD_PRUEBA),
    CONSTRAINT fkINGENIERO FOREIGN KEY (DNI) REFERENCES INGENIERO(DNI)
);


CREATE TABLE INGENIERO_JEFE
( 
  DNI_INGENIERO_JEFE		CHAR(9) NOT NULL,
  TITULO		VARCHAR(200) NOT NULL,
  CURRICULUM		VARCHAR(200) NOT NULL,
  CONSTRAINT pkINGENIERO_JEFE
	  PRIMARY KEY(DNI_INGENIERO_JEFE),
  CONSTRAINT fkING_JEFE_DNI_MECANICO
  	FOREIGN KEY(DNI_INGENIERO_JEFE) REFERENCES MECANICO(DNI) ON DELETE CASCADE,
  CONSTRAINT fkING_JEFE_DNI_INGENIERO
	  FOREIGN KEY(DNI_INGENIERO_JEFE) REFERENCES INGENIERO(DNI) ON DELETE CASCADE
);


CREATE TABLE SUPERVISA(
    DNI_INGENIERO_JEFE CHAR(9) NOT NULL,
    DNI_STAFF CHAR(9) NOT NULL,
    CONSTRAINT pkSUPERVISA
	  PRIMARY KEY(DNI_INGENIERO_JEFE,DNI_STAFF),
    CONSTRAINT fkSUPERVISA_DNI_INGENIERO
	  FOREIGN KEY(DNI_INGENIERO_JEFE) REFERENCES INGENIERO_JEFE(DNI_INGENIERO_JEFE),
    CONSTRAINT fkSUPERVISA_STAFF
	  FOREIGN KEY(DNI_STAFF) REFERENCES STAFF(DNI)
);


CREATE TABLE PIEZA
( 
  COD_PIEZA	SMALLINT NOT NULL,
  NOM_PIEZA	VARCHAR(30) NOT NULL,
  DESCR_PIEZA	VARCHAR(200) NOT NULL,
  PRECIO	DECIMAL(6,2),
  CONSTRAINT pkPIEZA
	  PRIMARY KEY(COD_PIEZA)
);


CREATE TABLE FABRICANTE
( 
  NIF_FABRICANTE 	CHAR(9) NOT NULL,
  NOM_FABRICANTE 	VARCHAR(30) NOT NULL,
  NUM_FABRICANTE 	SMALLINT NOT NULL,
  CALLE_FABRICANTE      VARCHAR(100) NOT NULL,
  CONSTRAINT pkFABRICANTE
	  PRIMARY KEY(NIF_FABRICANTE),
  CONSTRAINT chFABRICANTE
	  CHECK(NUM_FABRICANTE<999)
);


CREATE TABLE FACTURA
(
  COD_FACTURA	SMALLINT NOT NULL,
  FECHA_FACTURA	DATETIME NOT NULL,
  NIF_FABRICANTE CHAR(9) NOT NULL,
  DNI CHAR(9) NOT NULL,
  CONSTRAINT pkFACTURA
	  PRIMARY KEY(COD_FACTURA),
  CONSTRAINT fkNIF_FABRICANTE
	  FOREIGN KEY(NIF_FABRICANTE) REFERENCES FABRICANTE(NIF_FABRICANTE),
  CONSTRAINT pkDNI_FINANZAS
	  FOREIGN KEY(DNI) REFERENCES MIEMBRO_FINANZAS(DNI)

);


CREATE TABLE LINEA_FACTURA
(
  COD_FACTURA	SMALLINT NOT NULL,
  L_FACTURA	SMALLINT NOT NULL,
  CANTIDAD	SMALLINT NOT NULL,
  TOTAL DECIMAL(8,2),
  CONSTRAINT pkLINEA_FACTURA
	  PRIMARY KEY(COD_FACTURA, L_FACTURA),
  CONSTRAINT fkLFACTURA_COD_FACTURA
	  FOREIGN KEY(COD_FACTURA) REFERENCES FACTURA(COD_FACTURA) ON DELETE CASCADE, 
  CONSTRAINT chLINEA_FACTURA
    CHECK(L_FACTURA>0),
  CONSTRAINT chCANTIDAD
    CHECK(CANTIDAD>0)
);


CREATE TABLE RECOGIDA_EN
(
  COD_FACTURA	SMALLINT NOT NULL,
  L_FACTURA	SMALLINT NOT NULL,
  COD_PIEZA	SMALLINT NOT NULL,

  CONSTRAINT pkRECOGIDA_EN
  	PRIMARY KEY(COD_FACTURA,L_FACTURA,COD_PIEZA),
  CONSTRAINT fkRECOGIDA_EN_LINEA_FAC
	  FOREIGN KEY(COD_FACTURA,L_FACTURA) REFERENCES LINEA_FACTURA(COD_FACTURA, L_FACTURA),
  CONSTRAINT fkRECOGIDA_EN_PIEZA
	  FOREIGN KEY(COD_PIEZA) REFERENCES PIEZA(COD_PIEZA)
);


CREATE TABLE COMPUESTO_DE
(
  COD_PIEZA	SMALLINT NOT NULL,
  ID_COCHE	SMALLINT NOT NULL,
  CONSTRAINT pkCOMPUESTO_DE
   	PRIMARY KEY (COD_PIEZA,ID_COCHE),
  CONSTRAINT fkCOMPUESTO_DE_PIEZA
       	FOREIGN KEY (COD_PIEZA) REFERENCES PIEZA(COD_PIEZA),
  CONSTRAINT fkCOMPUESTO_DE_COCHE
	  FOREIGN KEY (ID_COCHE) REFERENCES COCHE(ID_COCHE)
);


CREATE TABLE TLF_FABRICANTE
(
  TLF_FABRICANTE	CHAR(9) NOT NULL,
  NIF_FABRICANTE	CHAR(9) NOT NULL,
  CONSTRAINT pkTLF_FABRICANTE
   	PRIMARY KEY (TLF_FABRICANTE,NIF_FABRICANTE),
  CONSTRAINT fkFABRICANTE
	  FOREIGN KEY (NIF_FABRICANTE) REFERENCES FABRICANTE(NIF_FABRICANTE) ON DELETE CASCADE
);
