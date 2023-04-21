
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
  ultima_actualizacion TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY  (qcoche_id)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Table structure for table `dim_circuito`
--

CREATE TABLE dim_circuito (
  dc_id SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT,
  nom_circuito VARCHAR(50) NOT NULL,
  num_curvas VARCHAR(7),
  precipitacion DECIMAL(5,2),
  temperatura DECIMAL(2,0),
  viento DECIMAL(3,0),
  pais VARCHAR(50),
  ciudad VARCHAR(50),
  desgaste_frenos VARCHAR(50),
  longitud DECIMAL(5,0),
  ultima_actualizacion TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY  (dc_id)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Table structure for table `dim_piloto`
--

CREATE TABLE dim_piloto (
  qc_id SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT,
  DNI_PILOTO CHAR(9) NOT NULL,
  edad DECIMAL(6,3) UNSIGNED NOT NULL,
  sexo VARCHAR(1),
  peso DECIMAL(6,3),
  altura DECIMAL(6,3),
  anhos_experiencia DECIMAL(6,3),
  num_version SMALLINT,
  valido_desde DATETIME NOT NULL,
  valido_hasta DATETIME NOT NULL,
  ultima_actualizacion TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY  (qc_id)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Table structure for table `dim_tiempo`
--

CREATE TABLE dim_tiempo (
  cc_id INT UNSIGNED NOT NULL AUTO_INCREMENT,
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
  cc_id INT UNSIGNED NOT NULL,
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
  CONSTRAINT fk_dim_circuito FOREIGN KEY (dc_id) REFERENCES dim_circuito (dc_id) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT fk_dim_tiempo FOREIGN KEY (cc_id) REFERENCES dim_tiempo (cc_id) ON DELETE RESTRICT ON UPDATE CASCADE
)ENGINE=InnoDB DEFAULT CHARSET=utf8;



