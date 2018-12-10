DROP TABLE IF EXISTS vehiculo CASCADE;
DROP TABLE IF EXISTS socio CASCADE;
DROP TABLE IF EXISTS cliente CASCADE;
DROP TABLE IF EXISTS socio CASCADE;
DROP TABLE IF EXISTS agente CASCADE;
DROP TABLE IF EXISTS chofer CASCADE;
DROP TABLE IF EXISTS dueno CASCADE;
DROP TABLE IF EXISTS multa CASCADE;
DROP TABLE IF EXISTS taxi CASCADE;
DROP TABLE IF EXISTS aseguradora CASCADE;
DROP TABLE IF EXISTS seguro CASCADE;
DROP TABLE IF EXISTS taxi_baja CASCADE;
DROP TABLE IF EXISTS transaccion CASCADE;
DROP TABLE IF EXISTS ganancia CASCADE;
DROP TABLE IF EXISTS viaje CASCADE;
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
CREATE TABLE taxi(
       num_economico int,
       rfc char(14),
       refaccion char(1),
       id_vehiculo int, 
       PRIMARY KEY (num_economico) 
); 
CREATE TABLE multa(
       id_multa int,
       calle varchar(80),
       delegacion varchar(50),
       cp char(5),
       entre_calle1 varchar(80), 
       entre_calle2 varchar(80),
       hora time,
       fecha date,
       descp varchar(120),
       monto real,
       id_agente int,
       num_economico int, 
       PRIMARY KEY (id_multa)
);
CREATE TABLE aseguradora(
       rfc char(14),
       nombre varchar(150), 
       PRIMARY KEY(rfc) 
); 
CREATE TABLE seguro(
       id_seguro int,
       rfc char(14),
       num_economico int,
       tipo_seguro varchar(50),
       cobertura int,
       PRIMARY KEY (id_seguro)
);
CREATE TABLE ganancia(
       id_ganancia int,
       numero_licencia char(8),
       mes int,
       ano int,
       bono real ,
       monto_total real,
       monto_sin_bono real,
       PRIMARY KEY (id_ganancia)
);

	
CREATE TABLE viaje(
       id_viaje int,
       numero_licencia char(8),
       num_economico int,
       multi_destino char(1),
       num_personas int,
       tiempo interval,
       tipo char(7),
       distancia real, 
       multi_origen char(1),
       PRIMARY KEY (id_viaje)
);


CREATE TABLE transaccion(
       id_transaccion int, 
       id_viaje int,
       id_cliente int,
       monto_total real,
       descuentos_aplicados real ,
       monto_parcial real ,
       ganancia_chofer real, 
       PRIMARY KEY(id_transaccion)
);


CREATE TABLE taxi_baja(
       id_baja int, 
       num_economico int, 
       razon varchar(100), 
       PRIMARY KEY (id_baja)
);
ALTER TABLE viaje
      ADD CONSTRAINT viaje_taxi_fk
      FOREIGN KEY (num_economico) references taxi(num_economico) , 
      ADD CONSTRAINT viaje_chofer_fk
      FOREIGN KEY (numero_licencia) references chofer(numero_licencia);
      
ALTER TABLE transaccion
      ADD CONSTRAINT transaccion_viaje_fk
      FOREIGN KEY (id_viaje) references viaje (id_viaje),
      ADD CONSTRAINT transaccion_cliente_fk
      FOREIGN KEY (id_cliente) references cliente(id_cliente);

ALTER TABLE ganancia
      ADD CONSTRAINT ganancia_chofer_fk
      FOREIGN KEY (numero_licencia) references chofer(numero_licencia);
      
ALTER TABLE taxi_baja
      ADD CONSTRAINT taxi_baja_taxi_fk
      FOREIGN KEY (num_economico) references taxi(num_economico); 
      
ALTER TABLE seguro
      ADD CONSTRAINT seguro_taxi_fk
      FOREIGN KEY (num_economico) references taxi(num_economico),
      ADD CONSTRAINT seguro_aseguradora_fk
      FOREIGN KEY (rfc) references aseguradora(rfc); 
      
ALTER TABLE taxi
      ADD CONSTRAINT taxi_vehiculo_fk
      FOREIGN KEY (id_vehiculo) references vehiculo(id_vehiculo),
      ADD CONSTRAINT taxi_dueno_fk
      FOREIGN KEY (rfc) references dueno(rfc); 

ALTER TABLE multa
      ADD CONSTRAINT multa_agente_fk
      FOREIGN KEY (id_agente) references agente(id_agente),
      ADD CONSTRAINT multa_taxi_fk
      FOREIGN KEY (num_economico) references taxi(num_economico);
     
      
ALTER TABLE dueno
      ADD CONSTRAINT dueno_socio_fk
      FOREIGN KEY (id_socio) references socio(id_socio);
      
ALTER TABLE chofer
      ADD CONSTRAINT chofer_socio_fk
      FOREIGN KEY (id_socio) references socio(id_socio);
