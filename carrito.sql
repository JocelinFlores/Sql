drop table if exists CARRITO;
drop table if exists CARRITO_ITEM;
drop table if exists ITEM;
drop table if exists PROVEEDOR;
drop table if exists CLIENTE;
drop table if exists METODOCOMPRA;
drop table if exists METODOPAGO;
drop table if exists PROVEEDOR_ITEM;

/*Table: carrito*/

create table CARRITO
  (
/*Los atributos de la entidad*/

    CARRITO_ID int not null auto_increment,
    CLIENTE_ID int not null,
    CLIENTE_CUENTAPLATZI varchar (60) not null,
    MPAGO_ID int not null,
    MCOMPRA_ID int not null,
    CARRITO_NUMITEM numeric (3,0) not null, /*Es importante tener
    en cuenta que MySQL trabaja con tipos de datos que se
    llaman numerics, el cual tiene un factor de precisión,
    ósea que podemos decirle cuantos decimales puede tener
    después de una coma.
Numeric(3,2) -> 123.45*/
    CARRITO_COMENT varchar (300),
    CARRITO_TAG varchar (100)
    primary key ( CARRITO_ID)
  );

  /* tabla: CARRITO_ITEM */
create table CARRITO_ITEM (
ITEM_ID int not null,
CARRITO_ID int not null,
CANTIDAD numeric(3, 0) not null,
primary key (ITEM_ID, CARRITO_ID)
);

/* tabla: CLIENTE*/
create table (
CLIENTE_ID int(10) not null auto_increment,
CLIENTE_CUENTAPLATZI varchar(60) not null,
CLIENTE_NOMBRE varchar(80) not null,
CLIENTE_FECHAINI timestamp not null,
CLIENTE_FECHANAC timestamp,
CLIENTE_CORREO varchar(60),
CLIENTE_PREFERENCIAS varchar(300),
primary key (CLIENTE_ID, CLIENTE_CUENTAPLATZI)
);

/tabla: ITEM/
create table ITEM (
ITEM_ID int not null auto_increment,
ITEM_NOMBRE varchar(60) not null,
ITEM_DESC varchar(300) not null,
ITEM_MEDIDAS varchar(60) not null,
ITEM_PESO varchar(15) not null,
ITEM_FOTO longblob,
primary key (ITEM_ID)
);

/tabla: ITEM_PROVEEDOR/
create table ITEM_PROVEEDOR (
PROV_ID numeric(5, 0) not null,
PROV_CODCC varchar(15) not null comment ‘CODIGO CAMARA DE COMERCIO’,
ITEM_ID int not null,
LOTE varchar(10) not null,
primary key (PROV_ID, PROV_CODCC, ITEM_ID)
);

/tabla: MCOMPRA/
create table MCOMPRA (
MCOMPRA_ID int not null auto_increment,
MCOMPRA_COD numeric(15, 0) not null,
MCOMPRA_METODO varchar(250) not null,
MCOMPRA_FECHAINI timestamp not null,
MCOMPRA_DIR varchar(120),
primary key (MCOMPRA_ID, MCOMPRA_COD)
);

/tabla: MPAGO/
create table MPAGO (
MPAGO_ID int not null auto_increment,
MPAGO_TIPO varchar(250) not null,
MPAGO_CODPASARELA varchar(15) not null,
MPAGO_STATUS varchar(10) not null,
MPAGO_FECHAEXPIRA timestamp not null,
primary key (MPAGO_ID)
);

/tabla: PROVEEDOR/
create table PROVEEDOR (
PROV_ID numeric(5, 0) not null,
PROV_CODCC varchar(15) not null comment ‘CODIGO CAMARA DE COMERCIO’,
PROV_NOMBRE varchar(90) not null,
PROV_DESC varchar(300) not null,
PROV_FECHAINI timestamp not null,
PROV_FECHAUCOMPRA timestamp,
PROV_MONTOUCOMPRA numeric(7, 0),
PROV_MONEDA varchar(5),
primary key (PROV_ID, PROV_CODCC)
);

/*Hay que utilizar alter table, de esta manera no dañamos
 la consistencia, las llaves foráneas ya creadas o los constraints
  que ya implementamos*/
alter table CARRITO add constraint FK_Carrito_Cliente foreing key (
CLIENTE_ID, CLIENTE_CUENTAPLATZI) references (CLIENTE_ID, CLIENTE_CUENTAPLATZI)
on delete restrict on update restrict;
/*on delete restrict on update restrict”, con esto, estamos restringiendo
 el hecho de que eliminen este alter table cuando
  hagamos una actualización a la tabla.*/
