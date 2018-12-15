

--esta funcion se llama cuando se agrega una transaccion
--por algun viaje y ajusta las ganancias de los choferes
--el primero es el chofer el
--segundo es el viaje y el tercero es su ganancia de esta transaccion
CREATE OR REPLACE FUNCTION agregar_ganancias(char(8),int,real)
RETURNS void as $$
declare 
       r_chof chofer%ROWTYPE;
       r_viaj viaje%ROWTYPE;
       --para localizar la ganancia 
       id_g int; 
BEGIN
	SELECT * into r_chof from chofer
	where chofer.numero_licencia = $1;
	SELECT * into r_viaj from viaje
	where viaje.id_viaje = $2;
	--si no crea una ganancia 
	SELECT id_ganancia into id_g
	from ganancia
       	 where mes = extract(month  from r_viaj.fecha) and
	       ano = extract(year from r_viaj.fecha) and
	       numero_licencia = r_chof.numero_licencia; 
        --si no existe la tupla de ganancia entonces creala
	IF id_g IS NULL  THEN 
	INSERT INTO ganancia
	(numero_licencia,mes,ano,bono,monto_total,monto_sin_bono)
	VALUES 
	(r_chof.numero_licencia,
	 extract (month from r_viaj.fecha),
	 extract (year from r_viaj.fecha),
	 0,
	 0 ,
	 0 );
	 END IF;
        --si tienes mas de 20 viajes tienes un bono
	IF r_viaj.tipo = 'exterior' THEN
	   update ganancia 
	   SET monto_sin_bono = monto_sin_bono  + ($3*0.92)
	   where id_ganancia = id_g;
	 ELSE
	   update ganancia 
	   SET monto_sin_bono = monto_sin_bono  + ($3*0.88)
	   where id_ganancia = id_g;
	END IF;
END;
$$ LANGUAGE plpgsql;
--funcion para aplicar un descuento al cliente 
CREATE OR REPLACE FUNCTION aplica_descuento()
RETURNS trigger as $nuevo$
declare
	tc char(1);
	num_l char(8); 
BEGIN
	num_l := (select numero_licencia from viaje
		   	   where viaje.id_viaje = NEW.id_viaje); 
	SELECT into tc tipo_cliente
	FROM cliente
	WHERE NEW.id_cliente = cliente.id_cliente;
	IF tc = 'a' THEN 
	   NEW.monto_total := NEW.monto_parcial * (0.85);
	   NEW.descuentos_aplicados := NEW.monto_parcial*(0.15);
	ELSIF tc = 'e' or tc = 't' THEN 
	   NEW.monto_total := NEW.monto_parcial * (0.90);
	   NEW.descuentos_aplicados := NEW.monto_parcial*(0.10); 
	END IF;
	perform agregar_ganancias(num_l,NEW.id_viaje,NEW.monto_total);
	RETURN NEW;
END;
$nuevo$ LANGUAGE plpgsql;


--vamos a ver que es lo que pone en los rows
