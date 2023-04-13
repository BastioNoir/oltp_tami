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
  id_coche     SMALLINT NOT NULL, 
  vel_max      DECIMAL(5,2),
  largo        DECIMAL(4,2),
  ancho        DECIMAL(4,2),
  potencia_motor      DECIMAL(5,2),
  ultima_actualizacion TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
	PRIMARY KEY (ID_COCHE)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Table structure for table `PILOTO`
--

CREATE TABLE PILOTO (
  id_piloto VARCHAR(9) NOT NULL,
  sexo VARCHAR(1) NOT NULL,
  edad DECIMAL(6,3),
  peso DECIMAL(6,3),
  altura DECIMAL(6,3),
  anho_experiencia DECIMAL(6,3),
  last_name VARCHAR(45) NOT NULL,
  ultima_actualizacion TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY  (id_piloto)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE PATROCINADOR (
  id_patrocinador        SMALLINT NOT NULL,
  ultima_actualizacion TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (id_patrocinador)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE PATROCINA (
  id_coche    SMALLINT NOT NULL,
  id_patrocinador  SMALLINT NOT NULL,
  dinero_aporta    DECIMAL(10,2),
  dur_contrato     DOUBLE,                            
  PRIMARY KEY (id_coche, id_patrocinador),
  CONSTRAINT fk_patrocina_coche FOREIGN KEY (id_coche) REFERENCES COCHE (id_coche) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT fk_patrocina_patrocinador FOREIGN KEY (id_patrocinador) REFERENCES PATROCINADOR (id_patrocinador) ON DELETE RESTRICT ON UPDATE CASCADE
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE CIRCUITO
(
    nom_circuito VARCHAR(50) NOT NULL,
    pais VARCHAR(50),
    ciudad VARCHAR(50),
    n_curvas   VARCHAR(50),
    ultima_actualizacion TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (nom_circuito)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE CARRERA (
  id_carrera    SMALLINT NOT NULL,
  nom_carrera    VARCHAR(50)NOT NULL,
  nom_circuito    VARCHAR(50)NOT NULL,
  ultima_actualizacion TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (id_carrera),
  CONSTRAINT fkcarrera_circuito FOREIGN KEY (nom_circuito) REFERENCES CIRCUITO (nom_circuito) ON DELETE RESTRICT ON UPDATE CASCADE
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE PARTICIPA_EN (
  id_coche    SMALLINT NOT NULL,
  id_carrera    SMALLINT NOT NULL,
  puntos        SMALLINT NOT NULL,
  tiempo_mejor_vuelta DECIMAL(6,3),
  fecha_inicio_carrera  DATETIME NOT NULL,
  fecha_fin_carrera  DATETIME NOT NULL,
  PRIMARY KEY (id_coche, id_carrera, puntos),
    CONSTRAINT fkparticipa_en_coche FOREIGN KEY (id_coche) REFERENCES COCHE(id_coche) ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT fkparticipa_en_carrera FOREIGN KEY (id_carrera) REFERENCES CARRERA(id_carrera) ON DELETE RESTRICT ON UPDATE CASCADE
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE PRUEBA
(
  cod_prueba   SMALLINT NOT NULL,
  lugar        VARCHAR(150),
  fecha_prueba        DATETIME NOT NULL,
  id_coche    SMALLINT NOT NULL,
  ultima_actualizacion TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (COD_PRUEBA),
  CONSTRAINT fkprueba_coche FOREIGN KEY (id_coche) REFERENCES COCHE(id_coche) ON DELETE RESTRICT ON UPDATE CASCADE
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
