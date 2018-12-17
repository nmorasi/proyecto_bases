
--funcion para aplicar un descuento al cliente 
CREATE OR REPLACE FUNCTION aplica_descuento()
RETURNS trigger as $nuevo$
declare
	tc char(1);
	num_l char(8);
	dist real;
	numero_viajes int;
	viaj_r viaje%rowtype;
BEGIN

	--sacarle la informacion a viaje
	select * into viaj_r
	from viaje
	where NEW.id_viaje = viaje.id_viaje;
	--toma la distancia del viaje
	dist := viaj_r.distancia;
	--como el sistema de alguna manera adivina la distancia entonces y
	-- el tiempo esta determinado por esta entonces aproveche aqui para poner ese campo
	--suponiendo que se tarda 5 minutos por hora	
	UPDATE viaje
	SET num_personas  = num_personas + 1, 
	    tiempo = 5*dist
	WHERE id_viaje = viaj_r.id_viaje;

	--ya tuvo que haber creado el viaje
	--este es el numero de licencia
	num_l := viaj_r.numero_licencia; 
	--toma el tipo del cliente			   
	SELECT tipo_cliente into tc 
	FROM cliente
	WHERE NEW.id_cliente = cliente.id_cliente;
	--para anadirle el descuento del cliente frecuente 
	SELECT count(1) into numero_viajes
	from transaccion where transaccion.id_cliente = NEW.id_cliente;


	--le tiene que asignar costo inicial 
	NEW.monto_sin_descuento := 15.0 + (8*dist);
	--si va dentro de cu entonces no debe haber descuento
	IF viaj_r.tipo = 'interno' THEN
	      IF numero_viajes > 4 THEN
 	         NEW.monto_sin_descuento := 15.0;
		 NEW.monto_con_descuento := 10.0;
		 NEW.descuento := 5;
	      ELSE
		 NEW.monto_sin_descuento := 15.0;
	     	 NEW.monto_con_descuento := NEW.monto_sin_descuento;
	      END IF; 
	--nosotros consideramos que solo los descuentos se hacen cuando se va fuera de cu	      
	ELSE
		--por lo de cliente frecuente 
		IF numero_viajes > 4 THEN
		   NEW.monto_sin_descuento := 15.0 + (6*dist);
		END IF;
	--con este va a aplicar el descuento por su condicion
	--de estudiante academico o profesor
		IF tc = 'a' THEN 
			   NEW.monto_con_descuento := NEW.monto_sin_descuento * (0.85);
			   NEW.descuento := NEW.monto_sin_descuento*(0.15);
			   
		ELSIF tc = 'e' or tc = 't' THEN 
	  	           NEW.monto_con_descuento := NEW.monto_sin_descuento * (0.90);
		       	   NEW.descuento := NEW.monto_sin_descuento*(0.10); 
		END IF;

	END IF;
	--decidimos poner al final el descuento por todas las personas que van 
	--pero primero tenemos que arreglar los campos del viaje 
	IF viaj_r.num_personas > 0 THEN
	   --rectificar la informacion del viaje
	   	UPDATE viaje
		SET multi_destino  = 'S',
		    multi_origen = 'S'
		WHERE id_viaje = viaj_r.id_viaje;
	   --aplicar la el descuento por cada uno
	        NEW.monto_con_descuento = NEW.monto_con_descuento * (1 - (viaj_r.num_personas * 0.10));
		NEW.descuento = NEW.monto_sin_descuento - NEW.monto_con_descuento;
	END IF;

	--finalmente ya con el descuento ya puedes decir cuales son las ganancias del chofer por transaccion
	IF viaj_r.tipo = 'interno' THEN 
	   NEW.ganancia_chofer = NEW.monto_con_descuento*(0.8); 
	 ELSE
	    NEW.ganancia_chofer = NEW.monto_con_descuento*(0.12);
	 END IF;
	RETURN NEW;
	
END;
$nuevo$ LANGUAGE plpgsql;


--vamos a ver que es lo que pone en los rows
