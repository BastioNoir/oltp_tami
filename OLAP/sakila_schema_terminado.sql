-- sakila_escu Sample Database Schema
-- Version 0.8

-- Copyright (c) 2006, MySQL AB
-- All rights reserved.

-- Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:

--  * Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.
--  * Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.
--  * Neither the name of MySQL AB nor the names of its contributors may be used to endorse or promote products derived from this software without specific prior written permission.

-- THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.


SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL';

DROP SCHEMA IF EXISTS sakila_escu;
CREATE SCHEMA sakila_escu;
USE sakila_escu;

--
-- Table structure for table `COCHE`
--

CREATE TABLE COCHE ( 
ID_COCHE     SMALLINT NOT NULL, 
TIPO_RUEDA   VARCHAR(6) NOT NULL,
VEL_MAX      DECIMAL(5,2),
LARGO        DECIMAL(4,2),
ANCHO        DECIMAL(4,2),
POTENCIA_MOTOR      DECIMAL(5,2),
ULTIMA_ACTUALIZACION TIMESTAMP NOT NULL,
	PRIMARY KEY (ID_COCHE),
);

--
-- Table structure for table `PILOTO`
--

CREATE TABLE PILOTO (
  qc_id SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT,
  id_piloto VARCHAR(9) NOT NULL,
  sexo VARCHAR(1) NOT NULL,
  edad DECIMAL(6,3),
  peso DECIMAL(6,3),
  altura DECIMAL(6,3),
  anho_experiencia DECIMAL(6,3),
  last_name VARCHAR(45) NOT NULL,
  ultima_actualizacion TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY  (qc_id)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE PATROCINADOR (
ID_PATROCINADOR        SMALLINT NOT NULL,
ULTIMA_ACTUALIZACION TIMESTAMP NOT NULL,
    CONSTRAINT pkPATROCINADOR PRIMARY KEY (ID_PATROCINADOR)
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
CREATE TABLE CIRCUITO
(
    NOM_CIRCUITO VARCHAR(50) NOT NULL,
    PAIS VARCHAR(50),
    CIUDAD VARCHAR(50),
    N_CURVAS   VARCHAR(7) NOT NULL,
    ULTIMA_ACTUALIZACION TIMESTAMP NOT NULL,
    CONSTRAINT chN_CURVAS CHECK(N_CURVAS IN('POCAS','ALGUNAS','MUCHAS')),
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
    CONSTRAINT pkDNI_PILOTO PRIMARY KEY (DNI_PILOTO),
    CONSTRAINT chSEXO CHECK(SEXO IN('M','F')),
    CONSTRAINT fkPILOTO_DNI_PERSONA FOREIGN KEY (DNI_PILOTO) REFERENCES PERSONA(DNI) ON DELETE CASCADE,
    CONSTRAINT fkPILOTO_ID_COCHE FOREIGN KEY (ID_COCHE) REFERENCES COCHE(ID_COCHE)
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
--
-- Table structure for table `dim_coche`
--

CREATE TABLE dim_coche (
  qcoche_id SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT,
  id_coche SMALLINT UNSIGNED NOT NULL,
  ancho        DECIMAL(4,2),
  largo        DECIMAL(4,2),
  potencia     DECIMAL(5,2),
  vel_max      DECIMAL(5,2),
  importe_patrocinios    DECIMAL(10,2),
  num_patrocinadores DECIMAL(3,0),
  n_pruebas_exitosas DECIMAL(3,0),
  num_version SMALLINT,
  valido_desde DATETIME NOT NULL,
  valido_hasta DATETIME NOT NULL,
  ultima_actualizacion TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY  (qcoche_id)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Table structure for table `dim_circuito`
--

CREATE TABLE dim_circuito (
  dc_id SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT,
  nom_circuito SMALLINT UNSIGNED NOT NULL,
  num_curvas VARCHAR(7),
  precipitacion DECIMAL(5,2),
  temperatura DECIMAL(2,0),
  viento DECIMAL(3,0),
  lugar_meteorologia VARCHAR(50),
  pais VARCHAR(50),
  ciudad VARCHAR(50),
  ultima_actualizacion TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY  (dc_id)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Table structure for table `dim_tiempo`
--

CREATE TABLE dim_tiempo (
  cc_id SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT,
  anho YEAR NOT NULL,
  trimestre SMALLINT UNSIGNED NOT NULL,
  mes SMALLINT UNSIGNED NOT NULL,
  semana DECIMAL(2,0),
  dia DECIMAL(3,0),
  ultima_actualizacion TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY  (cc_id)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Table structure for table `fact_rendimiento`
--

CREATE TABLE fact_rendimiento (
  rendimiento_id SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT,
  qc_id SMALLINT UNSIGNED NOT NULL,
  qcoche_id SMALLINT UNSIGNED NOT NULL,
  cc_id SMALLINT UNSIGNED NOT NULL,
  dc_id SMALLINT UNSIGNED NOT NULL,
  dinero_patrocinio DECIMAL(10,2),
  percent_pruebas_exitosas DECIMAL(3,0),
  mejores_vueltas DECIMAL(3,0),
  PRIMARY KEY  (rendimiento_id),
  KEY idx_fk_qc_id (qc_id),
  KEY idx_fk_qcoche_id (qcoche_id),
  KEY idx_cc_id (cc_id),
  KEY idx_dc_id (dc_id),
  CONSTRAINT fk_dim_piloto FOREIGN KEY (qc_id) REFERENCES dim_piloto (qc_id) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT fk_dim_coche FOREIGN KEY (qcoche_id) REFERENCES dim_coche (qcoche_id) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT fk_dim_circuito FOREIGN KEY (cc_id) REFERENCES dim_circuito (cc_id) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT fk_dim_tiempo FOREIGN KEY (dc_id) REFERENCES dim_tiempo (dc_id) ON DELETE RESTRICT ON UPDATE CASCADE
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;


