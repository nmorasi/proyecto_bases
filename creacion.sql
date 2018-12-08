DROP TABLE IF EXISTS vehiculo CASCADE;
DROP TABLE IF EXISTS socio CASCADE;
DROP TABLE IF EXISTS cliente CASCADE;
DROP TABLE IF EXISTS socio CASCADE;
DROP TABLE IF EXISTS agente CASCADE;
DROP TABLE IF EXISTS chofer CASCADE;
DROP TABLE IF EXISTS dueno CASCADE;
CREATE TABLE vehiculo (
       id_vehiculo int,
       modelo varchar(30),
       marca varchar(30),
       ano int ,
       num_cilindros int ,
       num_puertas int,
       tipo_transmicion varchar(15),
       num_pasajeros int,
       tipo_motor varchar(15),
       cap_tanque real,
       PRIMARY KEY (id_vehiculo)
) ; 

CREATE TABLE socio (
       id_socio int,
       nombre varchar(30),
       ap_paterno varchar(30),
       ap_materno varchar(30),
       calle varchar(80),
       numero int ,
       cp int,
       delegacion varchar(50),
       f_ingreso date,
       email varchar(80),
       tel_movil char(10),
       foto varchar(100), 
       PRIMARY KEY(id_socio)
); 

CREATE TABLE cliente (
       id_cliente int,
       nombre varchar(30),
       ap_paterno varchar(30),
       ap_materno varchar(30),
       delegacion varchar(50),
       calle varchar(80),
       numero int,
       cp int,
       lugar_adscripcion varchar(150),
       --a academico , t trabajador , e estudiante 
       tipo_cliente char(1),
       hora_e time,
       hora_s time,
       foto varchar(100),
       tel_casa char(8),
       tel_movil char(10),
       mail varchar(80),
       PRIMARY KEY(id_cliente)

);
CREATE TABLE dueno(
       rfc char(14), 
       id_socio int,
       PRIMARY KEY (rfc)
);
CREATE TABLE chofer(
       numero_licencia char(8),
       id_socio int,
       PRIMARY KEY (numero_licencia)
);
CREATE TABLE agente(
       id_agente int,
       nombre varchar(30),
       ap_pat varchar(30),
       ap_mat varchar(30),
       PRIMARY KEY (id_agente)
);
ALTER TABLE dueno
      ADD CONSTRAINT dueno_socio_fk
      FOREIGN KEY (id_socio) references socio(id_socio);
      
ALTER TABLE chofer
      ADD CONSTRAINT chofer_socio_fk
      FOREIGN KEY (id_socio) references socio(id_socio);
