DROP TABLE IF EXISTS vehiculo CASCADE;
DROP TABLE IF EXISTS socio CASCADE;
DROP TABLE IF EXISTS cliente CASCADE;
DROP TABLE IF EXISTS chofer CASCADE;
DROP TABLE IF EXISTS dueno CASCADE;
DROP TABLE IF EXISTS multa CASCADE;
DROP TABLE IF EXISTS conduce CASCADE;
DROP TABLE IF EXISTS aseguradora CASCADE;
DROP TABLE IF EXISTS seguro CASCADE;
DROP TABLE IF EXISTS transaccion CASCADE;
DROP TABLE IF EXISTS bono CASCADE;
DROP TABLE IF EXISTS viaje CASCADE;
DROP TABLE IF EXISTS baja CASCADE;
DROP TABLE IF EXISTS agente CASCADE;

CREATE TABLE vehiculo (
       num_economico int,
       modelo varchar(30),
       marca varchar(30),
       ano int ,
       num_cilindros int ,
       num_puertas int,
       refaccion char(1),
       tipo_transmicion varchar(15),
       num_pasajeros int,
       tipo_motor varchar(15),
       cap_tanque real,
       PRIMARY KEY (num_economico)
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
       mail varchar(50),
       PRIMARY KEY(id_cliente)

);
CREATE TABLE dueno(
       id_socio int,	
       rfc char(14),
       PRIMARY KEY (rfc)
);
CREATE TABLE chofer(
       id_socio int,
       numero_licencia char(8),
       PRIMARY KEY (numero_licencia)
);
 
CREATE TABLE multa(
       id_multa int,
       id_agente int,
       numero_licencia char(8),
       num_economico int,
       calle varchar(80),
       delegacion varchar(50),
       cp char(5),
       entre_calle1 varchar(80), 
       entre_calle2 varchar(80),
       hora time,
       fecha date,
       infraccion varchar(120),
       monto real,
       PRIMARY KEY (id_multa)
);
CREATE TABLE conduce(
       num_economico int,
        numero_licencia char(8)

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
       PRIMARY KEY (id_seguro)
);

	
CREATE TABLE viaje(
       id_viaje int,
       numero_licencia char(8),
       num_economico int,
       multi_destino char(1) DEFAULT 'N',
       num_personas int DEFAULT 0,
       --tiempo en minutos 
       tiempo int DEFAULT 0,
       tipo char(7),
       distancia real DEFAULT 0, 
       multi_origen char(1) DEFAULT 'N',
       fecha  date, 
       PRIMARY KEY (id_viaje)
);


CREATE TABLE transaccion(
       -- id_transaccion int, 
       -- id_viaje int,
       -- id_cliente int,
       -- monto_sin_descuento real,
       -- monto_con_descuento real,
       -- descuento real,
       -- ganancia_chofer real,
       -- PRIMARY KEY(id_transaccion)
       id_transaccion int, 
       id_viaje int,
       id_cliente int,
       monto_total real,
       --promocional, normal
       tipo_tarifa varchar(80) ,
       descuento real,
       ganancia_chofer real,
       PRIMARY KEY(id_transaccion)
);


CREATE TABLE baja(
       id_baja int,
       num_economico int,
       fecha date,
       razon varchar(100),
       PRIMARY KEY(id_baja)
); 

CREATE TABLE bono(
       numero_licencia char(8), 
       ano int,
       mes int,
       num_viajes int DEFAULT 0,
       monto real DEFAULT 0,
       PRIMARY KEY (numero_licencia,ano,mes)
);
CREATE TABLE agente(
       id_agente int,
       nombre varchar(30),
       ap_pat varchar(30),
       ap_mat varchar(30),
       PRIMARY KEY(id_agente)
); 
ALTER TABLE bono
      ADD CONSTRAINT bono_chofer_fk
      FOREIGN KEY (numero_licencia) references chofer(numero_licencia); 
ALTER TABLE viaje
      ADD CONSTRAINT viaje_vehiculo_fk
      FOREIGN KEY (num_economico) references vehiculo(num_economico) , 
      ADD CONSTRAINT viaje_chofer_fk
      FOREIGN KEY (numero_licencia) references chofer(numero_licencia);
      
ALTER TABLE transaccion
      ADD CONSTRAINT transaccion_viaje_fk
      FOREIGN KEY (id_viaje) references viaje (id_viaje),
      ADD CONSTRAINT transaccion_cliente_fk
      FOREIGN KEY (id_cliente) references cliente(id_cliente);

      
ALTER TABLE baja
      ADD CONSTRAINT baja_vehiculo_fk
      FOREIGN KEY (num_economico) references vehiculo(num_economico);
      
ALTER TABLE seguro
      ADD CONSTRAINT seguro_vehiculo_fk
      FOREIGN KEY (num_economico) references vehiculo(num_economico),
      ADD CONSTRAINT seguro_aseguradora_fk
      FOREIGN KEY (rfc) references aseguradora(rfc); 
     

ALTER TABLE conduce
      ADD CONSTRAINT conduce_vehiculo_fk
      FOREIGN KEY (num_economico) references vehiculo(num_economico),
      ADD CONSTRAINT conduce_chofer_fk
      FOREIGN KEY (numero_licencia) references chofer(numero_licencia);
      
ALTER TABLE multa
      ADD CONSTRAINT multa_agente_fk
      FOREIGN KEY (id_agente) references agente(id_agente),
      ADD CONSTRAINT multa_vehiculo_fk
      FOREIGN KEY (num_economico) references vehiculo(num_economico),
      ADD CONSTRAINT multa_chofer_fk
      FOREIGN KEY (numero_licencia) references chofer(numero_licencia);
      
ALTER TABLE dueno
      ADD CONSTRAINT dueno_socio_fk
      FOREIGN KEY (id_socio) references socio(id_socio);
      
ALTER TABLE chofer
      ADD CONSTRAINT chofer_socio_fk
      FOREIGN KEY (id_socio) references socio(id_socio);
--aqui van a ir los triggers

CREATE TRIGGER aplica_descuento_t BEFORE INSERT
       ON transaccion
       FOR EACH ROW 
       EXECUTE PROCEDURE aplica_descuento();       
