
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
	NEW.monto_total := 15.0 + (8*dist);
	--si va dentro de cu entonces no debe haber descuento
	IF viaj_r.tipo = 'interno' THEN
	      IF numero_viajes > 4 THEN
 	         NEW.monto_total := 10;
		 NEW.descuento := 5;
		 NEW.tipo_tarifa = 'promocional'; 
	      ELSE
		 NEW.monto_total := 15.0;
	     	 NEW.descuento := 0;
	      END IF; 
	--nosotros consideramos que solo los descuentos se hacen cuando se va fuera de cu porque un descuento sobre 15 pesos ???       
	ELSE
		--por lo de cliente frecuente 
		IF numero_viajes > 4 THEN
		   NEW.monto_total := 15.0 + (6*dist);
		   NEW.descuento := (2*dist); --osea 8 (sin descuento) - 6 (con descuento) va a ser lo ahorrado por el total de kilometros
		END IF;
	--con este va a aplicar el descuento por su condicion
	--de estudiante academico o profesor
		IF tc = 'a' THEN
		      	   NEW.descuento := NEW.monto_total * (0.15); 
			   NEW.monto_total := NEW.monto_total * (0.85);
			   NEW.tipo_tarifa := 'promocional';
			   
		ELSIF tc = 'e' or tc = 't' THEN
		           NEW.descuento := NEW.monto_total * (0.10); 
			   NEW.monto_total := NEW.monto_total * (0.90);
			   NEW.tipo_tarifa := 'promocional';
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
	   	--a cada uno de los asistentes deberias agregarle promocional y a ti mismo promocional
		UPDATE transaccion
		SET descuento = monto_total*(0.10),
		    monto_total = monto_total*(0.90),
		    tipo_tarifa = 'promocional'
		where id_viaje = viaj_r.id_viaje and id_cliente <> NEW.id_cliente;
		NEW.tipo_tarifa := 'promocional';
	END IF;

	--finalmente ya con el descuento ya puedes decir cuales son las ganancias del chofer por transaccion
	IF viaj_r.tipo = 'interno' THEN 
	   NEW.ganancia_chofer = NEW.monto_total*(0.08); 
	 ELSE
	    NEW.ganancia_chofer = NEW.monto_total*(0.12);
	END IF;
	RETURN NEW;
END;
$nuevo$ LANGUAGE plpgsql;


