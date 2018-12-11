CREATE OR REPLACE FUNCTION totalRecords ()
RETURNS integer AS $total$
declare
	total integer;
BEGIN
        SELECT count(*) into total
	FROM transaccion join cliente using (id_cliente);
	RETURN total;
END; 
$total$ LANGUAGE plpgsql;
--el primero es el id del cliente y el segundo
--es lo que se le va a cobrar 
CREATE OR REPLACE FUNCTION descuentoEstudiante(int,real)
RETURNS real as $total$
declare
	total real;
	tipo char(1); 
BEGIN
	total = $2; 
	SELECT tipo_cliente into tipo from cliente
	WHERE id_cliente = $1;
	IF tipo = 'e' THEN
	   total = $2 * (0.85);
	END IF;
	RETURN total;
END;
$total$ LANGUAGE plpgsql;

-- CREATE OR REPLACE FUNCTION totalRecords ()
-- RETURNS integer AS $total$
-- declare
-- 	total integer;
-- BEGIN
--    SELECT count(*) into total FROM COMPANY;
--    RETURN total;
-- END;
-- $total$ LANGUAGE plpgsql;
