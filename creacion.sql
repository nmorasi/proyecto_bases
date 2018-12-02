DROP TABLE IF EXISTS asociado CASCADE;
DROP TABLE IF EXISTS dueno CASCADE;
DROP TABLE IF EXISTS chofer CASCADE;
DROP TABLE IF EXISTS cliente CASCADE;
DROP TABLE IF EXISTS correos CASCADE;
DROP TABLE IF EXISTS viaje CASCADE;
DROP TABLE IF EXISTS vehiculo CASCADE;
DROP TABLE IF EXISTS ocupantes CASCADE;
CREATE TABLE asociado(
     id_asociado int,
     nombre varchar(50),
     ap_pat varchar(30),
     ap_mat varchar(30),
     calle varchar(80), 
     numero int , 
     delegacion varchar(80), 
     fecha_ingreso date, 
     PRIMARY KEY (id_asociado)
); 
CREATE TABLE dueno(
       id_asociado int, 
       rfc varchar(18)
); 
CREATE TABLE chofer(
       id_asociado int,
       num_licencia varchar(20)
);      

CREATE TABLE cliente(
       id_cliente int,
       --nombre
       nombre varchar(50), 
       ap_pat varchar(25), 
       ap_mat varchar(25),
       --direccion
       calle varchar(80),
       numero int,
       delegacion varchar(25),
       --       fotografia,
       telefono_cel char(10) , 
       telefono_casa char(10), 
       lugar_labores varchar(100),
       --informacion opcional 
       entrada time,
       salida time , 
       -- va a decir si es academico estudiante o trabajador para
       --hacer los descuentos adecuados 
       tipo char(1),
       PRIMARY KEY(id_cliente)
       
);
CREATE TABLE correos(
       id_cliente int,
       correo varchar(30)
);
--tambien deberia tener la fecha del viaje 
CREATE TABLE viaje(
       id_viaje int,
       id_asociado int,
       numero_economico int ,
       distancia real,
       tiempo time,
       numero_ocupantes int,
       varios_destinos char(1),
       PRIMARY KEY(id_viaje)
       
);

CREATE TABLE vehiculo(
       --para saber a quien le pertenece
       id_asociado int,
       --llave de la entidad
       numero_economico int,
       modelo varchar(30),
       marca varchar(30),
       ano int,
       num_cilindros int,
       num_puertas int,
       refaccion char(1),
       est_aut char(1),
       gas_hib char(1),
       num_pas int,
       cap_tanque real,
       PRIMARY KEY(numero_economico) 
       
);
--tabla para tener tener a los ocupantes de un viaje
CREATE TABLE ocupantes(
       id_viaje int ,
       id_cliente int

);

--restricciones a la tabla de los choferes y duenos.
ALTER TABLE chofer 
      ADD CONSTRAINT chofer_asociado_fk
      FOREIGN KEY (id_asociado) references asociado (id_asociado);
ALTER TABLE dueno
      ADD CONSTRAINT dueno_asociado_fk
      FOREIGN KEY (id_asociado) references asociado (id_asociado);
--restricciones para el viaje
ALTER TABLE viaje
      ADD CONSTRAINT viaje_asociado_fk
      FOREIGN KEY (id_asociado) references asociado (id_asociado),
      ADD CONSTRAINT viaje_vehiculo_fk
      FOREIGN KEY (numero_economico) references vehiculo (numero_economico); 
      
      

--restricciones para los ocupantes es decir
--que estos pertencezcan a un unico viaje 
ALTER TABLE ocupantes
      ADD CONSTRAINT ocupantes_cliente_fk
      FOREIGN KEY (id_cliente) references cliente (id_cliente), 
      ADD CONSTRAINT ocupantes_viaje_fk
      FOREIGN KEY (id_viaje) references viaje (id_viaje);
--las restricciones a la tabla del cliente 

ALTER TABLE correos
      ADD CONSTRAINT correo_cliente_fk
      FOREIGN KEY (id_cliente) references cliente (id_cliente);
      
