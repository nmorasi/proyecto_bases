\copy cliente FROM '/home/nieves/proyecto_bases/proyecto_bases/nuevo/cliente.csv' WITH (DELIMITER ',');
\copy vehiculo FROM '/home/nieves/proyecto_bases/proyecto_bases/nuevo/vehiculo.csv' WITH (DELIMITER ',');
\copy socio FROM '/home/nieves/proyecto_bases/proyecto_bases/nuevo/socio.csv' WITH (DELIMITER ',');
\copy dueno FROM '/home/nieves/proyecto_bases/proyecto_bases/nuevo/dueno.csv' WITH (DELIMITER ',');
\copy chofer FROM '/home/nieves/proyecto_bases/proyecto_bases/nuevo/chofer.csv' WITH (DELIMITER ',');
\copy agente  FROM '/home/nieves/proyecto_bases/proyecto_bases/nuevo/agente.csv' WITH (DELIMITER ',');
\copy aseguradora FROM '/home/nieves/proyecto_bases/proyecto_bases/nuevo/aseguradora.csv' WITH (DELIMITER ',');
\copy seguro FROM '/home/nieves/proyecto_bases/proyecto_bases/nuevo/seguro.csv' WITH (DELIMITER ',');
\copy multa FROM '/home/nieves/proyecto_bases/proyecto_bases/nuevo/multa.csv' WITH (DELIMITER ',');
\copy multa_vehiculo FROM '/home/nieves/proyecto_bases/proyecto_bases/nuevo/multa_vehiculo.csv' WITH (DELIMITER ',');
\copy viaje   FROM '/home/nieves/proyecto_bases/proyecto_bases/nuevo/viaje.csv' WITH (DELIMITER ',');
\copy transaccion  FROM '/home/nieves/proyecto_bases/proyecto_bases/nuevo/transaccion.csv' WITH (DELIMITER ',');

--para llenarlo bien despues 
\copy (select rfc from aseguradora) TO '/home/nieves/proyecto_bases/proyecto_bases/nuevo/rfc_aseguradora.csv' WITH (DELIMITER ',');
\copy (select numero_licencia from chofer) TO '/home/nieves/proyecto_bases/proyecto_bases/nuevo/num_lic_chofer.csv' WITH (DELIMITER ',');
