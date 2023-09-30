use segunda_entrega;

#CREACION DE TABLAS

CREATE TABLE pagina_empresa(
cuenta varchar(50) not null, #null
cuit INT NOT NULL, 
direccion varchar(60) not null, 
preguntas varchar(200), 
primary key(cuit)
);

CREATE TABLE cuenta(
id INT NOT NULL, 
cuit_empresa INT NOT NULL, 
NAME varchar(30) NOT NULL,
password varchar(20) NOT NULL, 
FOREIGN KEY(cuit_empresa) references pagina_empresa(cuit), 
primary key(id));


CREATE TABLE DATOS_CLIENTES(
ID_CUENTA INT NOT NULL, 
NOMBRE VARCHAR(30) NOT NULL,
APELLIDO VARCHAR(30) NOT NULL,
DNI INT NOT NULL UNIQUE,
DIRECCION varchar(50) NOT NULL,
primary key(ID_CUENTA, nombre)
);


CREATE TABLE proveedores(
nombre VARCHAR(20) UNIQUE NOT NULL, 
telefono INT NOT NULL, 
id_proveedor int not null auto_increment, 
tipo_mercaderia varchar(50) not null, 
primary key(id_proveedor)
);

CREATE TABLE mercaderias(
id_merca INT NOT NULL, 
nombre VARCHAR(45) NOT NULL,  
precio DECIMAL(6,2), 
proveedor int not null, 
stock  INT NOT NULL, 
FOREIGN KEY(proveedor) REFERENCES proveedores(id_proveedor), 
primary key(id_merca)
);

 CREATE TABLE PEDIDOS(
 direccion_de_entrega VARCHAR(50) NOT NULL,
 numero_pedido INT NOT NULL, 
 fecha_entrega VARCHAR(30), 
id INT NOT NULL, 
mercaderias_pedidas INT NOT NULL, 
FOREIGN KEY(id) REFERENCES DATOS_CLIENTES(ID_CUENTA),
FOREIGN KEY(mercaderias_pedidas) REFERENCES mercaderias(id_merca)
);

CREATE TABLE reclamos(
tipo_de_reclamo VARCHAR(30) not null, # ambas dos columnas son clave primaria, las necesitas para saber que reclamos hay y diferencialos o reflejarlos con sus id. 
id INT NOT NULL,
primary key(tipo_de_reclamo,id)
);

ALTER TABLE cuenta
CHANGE COLUMN id id INT NOT NULL AUTO_INCREMENT;

CREATE UNIQUE INDEX NAME_CUENTA
ON cuenta(NAME);


ALTER TABLE PEDIDOS
CHANGE COLUMN numero_pedido numero_pedido INT NOT NULL AUTO_INCREMENT,
ADD PRIMARY KEY (numero_pedido);

create table pedido_mercaderia(
id int not null,
pedidos int not null, 
mercaderia int not null, 
cantidad int not null,
foreign key (mercaderia) references mercaderias(id_merca),
foreign key (pedidos) references PEDIDOS(numero_pedido),
primary key (id)
);

CREATE TABLE cliente_reclamo(
number int not null auto_increment, 
tipo VARCHAR(30) NOT NULL,
id_client int not null,
FOREIGN KEY(id_client) REFERENCES DATOS_CLIENTES(DNI), 
foreign key(tipo) references reclamos(tipo_de_reclamo), 
PRIMARY KEY (number));


alter table mercaderias
change column precio precio decimal(6,2) not null;

alter table cuenta
change column cuit_empresa cuit_empresa int;

CREATE UNIQUE INDEX id
ON cuenta(id);

alter table pagina_empresa
change column cuenta cuenta varchar(50);

CREATE UNIQUE INDEX id_cuenta
ON DATOS_CLIENTES(id_cuenta);

alter table mercaderias 
change column proveedor id_proveedor int not null;

alter table pedido_mercaderia
add column total decimal(8,2);

#INSERT

insert into cuenta (id,name, password) values
(null,'rpepe', 'pepito'),
(null, 'mchipi', 'martinita'),
(null,'jhernandez', 'josesito'),
(null,'lsanchez1993', 'toto1'),
(null,'mlorenzo', 'miguelito');

select * from cuenta;

insert into datos_clientes (ID_CUENTA, NOMBRE, APELLIDO, DNI, DIRECCION) VALUES
(1111,'JOSE', 'HERNANDEZ', 32323232, 'AVENIDA RIVADAVIA 23 3ºR'),
(1112, 'MARTINA', 'CHIPI', 32233215, 'GANA 254'),
(1113, 'ROBERTO', 'PEPE', 35555555, 'MALABIA 777 PB A'),
(1114, 'LUCAS', 'SANCHEZ', 31234578, 'ARGENTINA 3'),
(1115, 'MIGUEL', 'LORENZO', 45555578, 'SANCHEZ 4532');

select * from datos_clientes;

insert into proveedores values
('herramientas pucho', 1147951564,null, 'herramientas'),
('Plactiflex', 1145672310, null, 'plasticos'),
('pintez', 1136547895, null, 'pinturas'),
('Todo tornillo',1198745632, null,'tornillos y tuercas'),
('Herrero Loco', 1147896523, null, 'herramientas');

insert into proveedores values
('Bob Construye', 1178912325,null, 'Maquinarias de construccion');

select * from proveedores;

insert into mercaderias values
(30, 'martillo', 1254, 6, 20),
(31, 'aerosol rosa', 904.12, 8, 2),
(32, 'sierra', 4523,10,1),
(33,'llave 3/4',2310,6,0),
(34, 'tuerca 3/4',80, 9,1200);

select * from mercaderias;

insert into pedidos(direccion_de_entrega, numero_pedido, id, mercaderias_pedidas) values
('gallardo 452 3ºf', null, 1111, 30),
('rivadavia ',null,1112,30),
('sanchez 454 2', null, 1113,31),
('gallo 1239',null, 1114, 34),
('brasil 123', null,1115,30);

insert into pedidos(direccion_de_entrega, numero_pedido,fecha_entrega,id,mercaderias_pedidas) values
('gallardo 789 3ºf',null, '2023-08-12', 1112, 30);

select * from pedidos;

insert into reclamos values
('rotura', 1),
('falta mercaderia',2),
('tardanza entrega',3),
('mercaderia no pedida',4),
('cantidad no deseada',5);

select * from reclamos;

insert into pedido_mercaderia values
(21, 27,30, 4),
(22, 1, 34,120),
(23,28,34,100),
(24,1,31,1),
(25,35,32,1);

select * from pedido_mercaderia;


insert into cliente_reclamo values
(null,'falta mercaderia', 32323232),
(null, 'rotura', 32233215),
(null,'falta mercaderia', 45555578),
(null,'tardanza entrega', 45555578),
(null,'cantidad no deseada',31234578);

select * from cliente_reclamo;


#VIEW

select * from proveedores;
select * from mercaderias;

create view proveedores_mercaderia as
(select p.nombre,p.tipo_mercaderia, m.id_merca
from proveedores p
join mercaderias m
on p.id_proveedor = m.id_proveedor
where m.stock > 10);

select * from proveedores_mercaderia;

# segunda

select * from datos_clientes;

create view cliente as
(select apellido, dni
from datos_clientes
where id_cuenta = 1111);

select * from cliente;

# tercera

select * from cliente_reclamo;

create view reclamos_hechos as
(select tipo, number
from cliente_reclamo
where id_client = 45555578);

select * from reclamos_hechos;

# cuarta

select * from cuenta;

create view password_cuenta as
(select id, password
from cuenta
where name like upper('%ez%'));

select * from password_cuenta;

# quinta

select * from pedidos;

create view direcciones as
( select direccion_de_entrega, numero_pedido, mercaderias_pedidas
from pedidos
where id <(1114));

select * from direcciones;

# sexta

create view entrega as
(select numero_pedido
from pedidos
where direccion_de_entrega = ('gallardo 452 3ºf'));

select *from entrega;

#FUNCTION

delimiter //
create function escala_precios (precio int)
returns varchar(50)
deterministic
begin 
case 
when precio < 1000 then 
return 'Mas barato';
when precio >=1000 and precio<2000 then 
return 'Precio neutral';
when precio >2000 then 
return 'Mas caro';
end case;
end //
delimiter ;

select id_merca, nombre,precio, (precio) from mercaderias;


delimiter ~~
create function Saludo_proveedor_nuevo (nombre varchar(50), id int)
returns varchar (100)
deterministic
begin 
declare nombre_id varchar (100);
set nombre_id = concat(nombre, ' ' , id);
return concat('Bienvenido ', nombre_id);
end ~~
delimiter 

select nombre, telefono, Saludo_proveedor_nuevo(nombre,id_proveedor) from proveedores
where id_proveedor =11;

drop function Saludo_proveedor_nuevo;

# STORE PRODEDURE

delimiter //
create procedure suba_precios (
in precio_anterior decimal (6,2),
in precio_nuevo decimal (6,2))
begin 
update mercaderias set precio = precio_nuevo
where precio = precio_anterior;
end //
delimiter ;

drop procedure suba_precios;

select * from mercaderias;

call suba_precios(4523.00,4953.50);  

#ACA LO QUE HICE ES EL PODER PONERLA CANTIDAD DE STOCK QUE QUERES VER ( OSEA CUANTO HAY) DE TODAS LAS MERCADERIAS

select * from mercaderias;

delimiter !!
create procedure ver_stock(
in m_stock int)
begin
select id_merca, nombre, precio
from mercaderias
where stock < m_stock;
end !!
delimiter ;

call ver_stock(2);

drop procedure ver_stock;

# EL ORDEN QUE LE QUERES PONER A LOS CLIENTES SEGUN NOMBRE APELLIDO, LO QUE QUIERAS ASCENDETE


select * from datos_clientes;

delimiter ((
create procedure or_cliente 
(in c_orden char(50))
begin 
if c_orden <> '' then 
set @cliente = concat('order by ' , c_orden);
else 
set @cliente = '';
end if;
set @completo = concat('select * from datos_clientes ', @cliente);
prepare runSQL from @completo;
execute runSQL;
DEALLOCATE PREPARE runSQL;
end ((

drop procedure or_cliente;

call or_cliente('ID_CUENTA');


#Metodo para buscar el id maximo de un cliente hecho en un pedido. EJ el pedido numero 1.

select * from pedido_mercaderia;

delimiter %%
CREATE PROCEDURE NUMBER_id
(IN p_numero int,
out mayor float)
begin 
select max(id) into mayor
from
pedido_mercaderia
where pedidos=p_numero;
end %%

delimiter ;

drop procedure number_pd;

call number_pd(1, @p);
select @p;

# aca creamos un procedure en donde si hay nuevo cliente tiene el mismo dni  o mismo nombre sale error

 delimiter //
 create procedure nuevo_cliente (ID_CUENTA int,  NOMBRE VARCHAR(30), APELLIDO VARCHAR(30), DNI INT, DIRECCION varchar(50))
begin 
declare cliente varchar(50);
DECLARE EXIT HANDLER FOR SQLEXCEPTION, NOT FOUND, SQLWARNING    
		BEGIN
			ROLLBACK;
			SELECT 'Error de carga';
		END;
        start transaction;
        if not exists (SELECT id_cuenta from datos_clientes where NOMBRE = NOMBRE 
        and DNI = DNI) then
        begin 
        insert into datos_clientes (ID_CUENTA ,  NOMBRE , APELLIDO , DNI , DIRECCION ) values
        (ID_CUENTA ,  NOMBRE , APELLIDO , DNI , DIRECCION );
        end;
        ELSE SELECT id_cuenta from datos_clientes where NOMBRE = NOMBRE
        and DNI  = DNI ;
        END IF;
 SELECT 'Cliente agregado';  
  commit;
end; //

 # TRIGGERS
 
# Creacion para calcular el monto a pagar de un pedido

delimiter //
create trigger calculo_venta 
before insert on pedido_mercaderia
for each row
begin
declare total_pagar decimal (6,2);
set total_pagar = (
select precio from mercaderias where id_merca = new.mercaderia );
set new.total = total_pagar * new.cantidad;
end //
delimiter 

drop trigger calculo_venta;

insert into pedido_mercaderia (id, pedidos, mercaderia, cantidad) values
(28, 27,30, 2);
insert into pedido_mercaderia (id, pedidos, mercaderia, cantidad) values
(12, 43,37, 5);

select * from pedido_mercaderia;
select * from pedidos;
select * from mercaderias;

#Primero cree una tabla para poder agregar mercaderia nueva y que me figure cual fueron.

create table new_mercaderias(
id_merca INT NOT NULL, #clave primaria
nombre VARCHAR(45) NOT NULL,  #clave primaria
precio DECIMAL(6,2), 
primary key(id_merca)
);

create trigger add_merca
after insert on mercaderias
for each row 
insert into `new_mercaderias`(id_merca, nombre, precio) values (new.id_merca, new.nombre, new.precio);

drop table new_mercaderias;
drop trigger add_merca;

insert into mercaderias values
(35, 'destornillador estrella 12', 2101.25, 10, 32),
(36, 'destornillador estrella 14', 2601.25, 10, 28);

select *from mercaderias;
select * from new_mercaderias;

insert into mercaderias values
(37, 'llave 6', 601.25, 6, 10);

# Cree un trigger con descuento de un 10% para la persona que supera un monto en especial de su pedido.

DELIMITER !!
CREATE TRIGGER Descuento_compra
BEFORE INSERT ON pedido_mercaderia
FOR EACH ROW
BEGIN
  IF NEW.total > 10000 THEN
    set NEW.total = new.total - (new.total *0.10);
  END IF;
END!!


insert into pedido_mercaderia (id, pedidos, mercaderia, cantidad) values
(41, 27,36, 10);


# CREACION DE CUENTAS ALTERNAS

use segunda_entrega;

USE sys;
SELECT * FROM sys_config;
USE mysql;
SELECT * FROM user;

CREATE USER usuariouno@localhost IDENTIFIED BY '1234';

CREATE USER usuariodos@localhost IDENTIFIED BY '1234';

grant select on segunda_entrega.* to usuariouno@localhost;
grant select, update, insert on segunda_entrega.* to usuariodos@localhost;


# Creacion de Transacciones de mi proyecto

# El primer TCL lo que hice fue la implementacion de un nuevo proveedor.

select * from proveedores;


start transaction;
insert into proveedores values
('Plomeria jose', 1145796302, null,'Productos de plomeria' );

select * from proveedores
order by id_proveedor desc;

rollback; # Aca lo puse un rollback por el hecho de que al ingresar pusimos mal el nombre del proveedor.

insert into proveedores values
('Plomeria Juan', 1145796302, null,'Productos de plomeria' );

commit; # Y aca al ponerlo bien le pusimos commit para confirmarlo.

select * from proveedores;

#En este TCL lo que hago inserto tanto datos de cliente, como cambio de direccion a otros.

select * from datos_clientes;

start transaction;
insert into datos_clientes values
(1118, 'Pedro','Lito', 18787856,'Cafe 1223');

commit; # Aca corrobore que me de bien.

start transaction;
insert into datos_clientes values
(1120, 'Andrea', 'Belenciaga', 30001452, 'CAFAYATE 4545 3ºD'),
(1121, 'Antonio', 'Rui', 21445631,'Cucha Cucha 1234'),
(1122, 'Roman', 'Riquelme', 20154789, 'Boca 12');
savepoint insert_1;

select * from datos_clientes;

update datos_clientes
set DIRECCION = 'AVENIDA RIVADAVIA 1254 4ºF'
where id_cuenta = 1111;
savepoint update_1;

select * from datos_clientes;

# Aca hice un rollback para poder solamente volver a la insert de mis clientes, y no realizar el update de mi cliente respectiva a su direccion.

ROLLBACK TO insert_1; 

update datos_clientes
set DIRECCION = 'AVENIDA RIVADAVIA 1254 4ºF'
where id_cuenta = 1111;
update datos_clientes
set DIRECCION = 'EMILIO MITRE 1212'
where ID_CUENTA = 1115;

select * from datos_clientes;

# Y aca si cambio las direcciones de algunos de los clientes y le doy commit para poder finalizar mi trasaccion.
COMMIT; 

# INFORME 

# Aca lo que hacemos es mostrar cual es el pedido con mayor venta en dinero. Hice pocos insert pero la meta esta.
select * from pedidos;
select * from pedido_mercaderia;

create view max_pedidos as (
select d.direccion_de_entrega, d. mercaderias_pedidas, p.id, p.pedidos, p.cantidad
from pedidos d
join pedido_mercaderia p
on d.numero_pedido = p.pedidos
where p.total > 3000);

drop view max_pedidos;

select * from max_pedidos;

# el cliente que hice mas pedidos. Que fue el cliente con id 1111. Y en que direccion.

select * from pedidos;
select * from datos_clientes;

create view client_max as (
select d.NOMBRE, d.APELLIDO, p.direccion_de_entrega
from datos_clientes d
join pedidos p
on d.ID_CUENTA = p.id
where d.ID_CUENTA = 1111);

select * from client_max;
