
--funcion para aplicar un descuento al cliente 
CREATE OR REPLACE FUNCTION aplica_descuento()
RETURNS trigger as $nuevo$
declare
	tc char(1);
	num_l char(8);
	dist real;
BEGIN
	--ya tuvo que haber creado el viaje
	SELECT numero_licencia into num_l
	from viaje
	 where viaje.id_viaje = NEW.id_viaje;
	--toma el tipo del cliente			   
	SELECT tipo_cliente into tc 
	FROM cliente
	WHERE NEW.id_cliente = cliente.id_cliente;
	--toma la distancia del viaje
	SELECT distancia into dist
	from viaje
	where viaje.id_viaje = NEW.id_viaje;
	--le tiene que asignar costo inicial supongamos
	--que siempre comienza en
	NEW.monto_sin_descuento := 15 + 8*dist; 
	IF tc = 'a' THEN 
	   NEW.monto_con_descuento := NEW.monto_sin_descuento * (0.85);
	   NEW.descuento := NEW.monto_sin_descuento*(0.15);
	ELSIF tc = 'e' or tc = 't' THEN 
	   NEW.monto_con_descuento := NEW.monto_sin_descuento * (0.90);
	   NEW.descuento := NEW.monto_sin_descuento*(0.10); 
	END IF;
	RETURN NEW;
END;
$nuevo$ LANGUAGE plpgsql;


--vamos a ver que es lo que pone en los rows
