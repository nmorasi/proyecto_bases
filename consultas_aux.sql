--dame los que son choferes y duenos de sus autos 
select count(1)
from (select id_socio
          from  socio
     	  except 
	  (select count(id_socio)
            from chofer join socio using (id_socio)
               join dueno using (id_socio)) ) as A; 
