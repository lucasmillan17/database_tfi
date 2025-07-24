CREATE DATABASE IF NOT EXISTS tfi_bdd;
USE tfi_bdd;

CREATE TABLE IF NOT EXISTS paises (
	-- Creamos atributos
	pais_id int primary key AUTO_INCREMENT unique,
	nombre varchar(50) not null,
	
	-- Creamos created_at y updated_at
	created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS provincias (
	-- Creamos atributos
	provincia_id int primary key AUTO_INCREMENT,
	pais_id int not null,
	nombre varchar(50) not null,
	
	-- Definimos referencias
	foreign key (pais_id) references paises(pais_id),
	
	-- Creamos created_at y updated_at
	created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS ciudades (
	-- Creamos atributos
	ciudad_id int primary key AUTO_INCREMENT,
	provincia_id int not null,
	nombre varchar(50) not null,
	
	-- Definimos referencias
	foreign key (provincia_id) references provincias(provincia_id),
	
	-- Creamos created_at y updated_at
	created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS codigos_postales (
	-- Creamos atributos
	codigo_postal_id int primary key AUTO_INCREMENT,
	ciudad_id int not null,
	codigo int not null,
	
	-- Definimos referencias
	foreign key(ciudad_id) references ciudades(ciudad_id),
	
	-- Creamos created_at y updated_at
	created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS direcciones (
	-- Creamos atributos
	direccion_id int primary key AUTO_INCREMENT,
	calle varchar(50) not null,
	numero int not null,
	piso int,
	depto int,
	ciudad_id int not null,
	provincia_id int not null,
	pais_id int not null,
	codigo_postal_id int,

	CHECK(numero > 0 OR numero IS NULL),
	CHECK(piso > 0 OR piso IS NULL),
	CHECK(depto > 0 OR depto IS NULL),
	
	-- Definimos referencias
	foreign key (ciudad_id) references ciudades(ciudad_id),
	foreign key (provincia_id) references provincias(provincia_id),
	foreign key (pais_id) references paises(pais_id),
	foreign key (codigo_postal_id) references codigos_postales(codigo_postal_id),
	
	-- Creamos created_at y updated_at
	created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS tipo_departamentos (
	-- Creamos atributos
	tipo_departamento_id int primary key AUTO_INCREMENT,
	nombre varchar(50) not null,
	descripcion varchar(100), 
	
	-- Definimos referencias
	-- SIN REFERENCIAS
	
	-- Creamos created_at y updated_at
	created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS sucursales (
	-- Creamos atributos
	sucursal_id int primary key AUTO_INCREMENT,
	nombre varchar(50) not null,
	direccion_id int,
	
	-- Definimos referencias
	foreign key(direccion_id) references direcciones(direccion_id),
	
	-- Creamos created_at y updated_at
	created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS departamentos (
	-- Creamos atributos
	departamento_id int primary key AUTO_INCREMENT,
	sucursal_id int,
	tipo_departamento_id int,
	nombre varchar(50) not null,
	
	-- Definimos referencias
	foreign key(sucursal_id) references sucursales(sucursal_id),
	foreign key(tipo_departamento_id) references tipo_departamentos(tipo_departamento_id),
	
	-- Creamos created_at y updated_at
	created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS tipo_empleados (
	-- Creamos atributos
	tipo_empleado_id int primary key AUTO_INCREMENT,
	nombre varchar(50) not null,
	descripcion varchar(100),
	
	-- Definimos referencias
	-- SIN REFERENCIAS
	
	-- Creamos created_at y updated_at
	created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS empleados (
	-- Creamos atributos
	empleado_id int primary key AUTO_INCREMENT,
	nombre varchar(50) not null,
	apellido varchar(50) not null,
	dni varchar (15) UNIQUE,
	cuil varchar(15) UNIQUE,
	fecha_nacimiento datetime,
	fecha_alta datetime,
	email varchar(75),
	telefono varchar(20),
	tipo_empleado_id int,
	departamento_id int,
	sucursal_id int,
	direccion_id int,
	-- Definimos un indice en fecha_alta 
	INDEX idx_fecha_alta (fecha_alta),
	
	-- Definimos referencias
	foreign key(tipo_empleado_id) references tipo_empleados(tipo_empleado_id),
	foreign key(departamento_id) references departamentos(departamento_id),
	foreign key(sucursal_id) references sucursales(sucursal_id),
	foreign key(direccion_id) references direcciones(direccion_id),
	
	-- Creamos created_at y updated_at
	created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS clientes (
	-- Creamos atributos
	cliente_id int primary key auto_increment,
	razon_social varchar(50) not null,
	cuil varchar (15),
	email varchar(50),
	telefono varchar(20),
	fecha_alta DATE,
	credito decimal(12,2) default 0.00,
	direccion_id int,
	
	-- Definimos un indice en fecha_alta 
	INDEX idx_fecha_alta (fecha_alta),

	-- Definimos referencias
	foreign key(direccion_id) references direcciones(direccion_id),
	
	-- Creamos created_at y updated_at
	created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS rubros (
	-- Creamos atributos
	rubro_id int primary key auto_increment,
	nombre varchar(50) not null,
	descripcion varchar(100),
	
	-- Definimos referencias
	-- SIN REFERENCIAS
	
	-- Creamos created_at y updated_at
	created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS proveedores (
	-- Creamos atributos
	proveedor_id int primary key auto_increment,
	razon_social varchar(50) not null,
	cuit varchar (15) UNIQUE,
	email varchar(50),
	telefono varchar(20),
	direccion_id int,
	fecha_alta DATE,
	credito int,
	rubro_id int,
	
	-- Definimos un indice en fecha_alta 
	INDEX idx_fecha_alta (fecha_alta),
	-- Definimos referencias
	foreign key(direccion_id) references direcciones(direccion_id),
	foreign key (rubro_id) references rubros(rubro_id),
	-- Creamos created_at y updated_at
	created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS categoria_productos (
	-- Creamos atributos
	categoria_id int primary key auto_increment,
	nombre varchar(50) not null,
	descripcion varchar(100),
	
	-- Definimos referencias
	-- SIN REFERENCIAS
	
	-- Creamos created_at y updated_at
	created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS unidades_medida (
	-- Creamos atributos
	unidad_medida_id int primary key auto_increment,
	unidad varchar(10),
	
	-- Definimos referencias
	-- SIN REFERENCIAS
	
	-- Creamos created_at y updated_at
	created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS productos (
	-- Creamos atributos
	producto_id int primary key auto_increment,
	rubro_id int,
	categoria_id int,
	nombre varchar(50) not null,
	descripcion varchar(100),
	unidad_medida_id int not null,
	codigo_barra varchar (25) unique,
	precio_unitario decimal(12,2) not null,

	CHECK(precio_unitario > 0),
	
	-- Definimos referencias
	foreign key(rubro_id) references rubros(rubro_id),
	foreign key(categoria_id) references categoria_productos(categoria_id),
	foreign key(unidad_medida_id) references unidades_medida(unidad_medida_id),
	
	-- Creamos created_at y updated_at
	created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS producto_proveedor (
	-- Creamos atributos
	producto_id int not null,
	proveedor_id int not null,
	precio_compra decimal(12,2),
	fecha_alta datetime,
	-- Definimos un indice en fecha_alta 
	INDEX idx_fecha_alta (fecha_alta),
	
	primary key(producto_id, proveedor_id),
	CHECK(precio_compra > 0),
	
	-- Definimos referencias
	foreign key(producto_id) references productos(producto_id),
	foreign key(proveedor_id) references proveedores(proveedor_id),
	
	-- Creamos created_at y updated_at
	created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS rankings (
	-- Creamos atributos
	rubro_id int not null,
	proveedor_id int not null,
	ranking int,
	fecha_ranking datetime,
	comentarios varchar(100),
	
	primary key(rubro_id, proveedor_id),
	-- Definimos referencias
	foreign key(rubro_id) references rubros(rubro_id),
	foreign key(proveedor_id) references proveedores(proveedor_id),
	
	-- Creamos created_at y updated_at
	created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS almacenes (
	-- Creamos atributos
	almacen_id int primary key auto_increment,
	sucursal_id int,
	nombre varchar(50) not null,
	direccion_id int,
	
	-- Definimos referencias
	foreign key(sucursal_id) references sucursales(sucursal_id),
	foreign key(direccion_id) references direcciones(direccion_id),
	
	-- Creamos created_at y updated_at
	created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS stocks (
	-- Creamos atributos
	stock_id int primary key auto_increment,
	producto_id int not null,
	almacen_id int not null,
	cantidad int,
	stock_minimo int,
	stock_maximo int,

	CHECK (
  	(stock_maximo IS NULL OR stock_minimo IS NULL OR stock_maximo > stock_minimo)
  	AND (stock_minimo IS NULL OR stock_minimo >= 0)
  	),
	CHECK(cantidad >=0 OR cantidad IS NULL),
	CHECK(cantidad >= stock_minimo AND cantidad <= stock_maximo),
	
	-- Definimos referencias
	foreign key(producto_id) references productos(producto_id),
	foreign key(almacen_id) references almacenes(almacen_id),
	
	-- Creamos created_at y updated_at
	created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS estados_compras (
	-- Creamos atributos
	estado_id int primary key auto_increment,
	estado varchar(15) not null,
	
	-- Definimos referencias
	
	
	-- Creamos created_at y updated_at
	created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS condiciones_pagos (
	-- Creamos atributos
	condicion_pago_id int primary key auto_increment,
	condicion_pago varchar(50) not null,
	
	-- Definimos referencias
	
	
	-- Creamos created_at y updated_at
	created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS orden_compras (
	-- Creamos atributos
	orden_compra_id int primary key auto_increment,
	proveedor_id int,
	empleado_id int,
	sucursal_id int,
	departamento_id int,
	fecha_orden datetime not null,
	estado_id int,
	total decimal(12,2),
	condicion_pago_id int,

	CHECK(total > 0 OR total IS NULL),
	
	-- Definimos referencias
	foreign key(proveedor_id) references proveedores(proveedor_id),
	foreign key(empleado_id) references empleados(empleado_id),
	foreign key(sucursal_id) references sucursales(sucursal_id),
	foreign key(departamento_id) references departamentos(departamento_id),
	foreign key(estado_id) references estados_compras(estado_id),
	foreign key(condicion_pago_id) references condiciones_pagos(condicion_pago_id),
	
	-- Creamos created_at y updated_at
	created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS detalle_orden_compras (
	-- Creamos atributos
	detalle_orden_id int primary key auto_increment,
	orden_compra_id int not null,
	producto_id int not null,
	cantidad int not null,
	precio_unitario decimal(12,2) not null,

	 total_linea DECIMAL(10,2) 
        GENERATED ALWAYS AS (ROUND((precio_unitario * cantidad), 2)) STORED,

	CHECK(cantidad > 0),
	CHECK(precio_unitario > 0),
	
	-- Definimos referencias
	foreign key(orden_compra_id) references orden_compras(orden_compra_id),
	foreign key(producto_id) references productos(producto_id),
	
	-- Creamos created_at y updated_at
	created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS estado_remitos (
	-- Creamos atributos
	estado_id int primary key auto_increment,
	estado varchar(20) not null,
	
	-- Definimos referencias
	
	
	-- Creamos created_at y updated_at
	created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS remitos (
	-- Creamos atributos
	remito_id int primary key auto_increment,
	proveedor_id int,
	sucursal_id int,
	orden_compra_id int,
	fecha_remito datetime not null,
	estado_id int,
	
	-- Definimos referencias
	foreign key(proveedor_id) references proveedores(proveedor_id),
	foreign key(sucursal_id) references sucursales(sucursal_id),
	foreign key(orden_compra_id) references orden_compras(orden_compra_id),
	foreign key(estado_id) references estado_remitos(estado_id),
	
	-- Creamos created_at y updated_at
	created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS detalle_remitos (
	-- Creamos atributos
	detalle_remito_id int primary key auto_increment,
	remito_id int not null,
	producto_id int not null,
	cantidad int not null,

	CHECK(cantidad >0),
	
	-- Definimos referencias
	foreign key(remito_id) references remitos(remito_id),
	foreign key(producto_id) references productos(producto_id),
	
	-- Creamos created_at y updated_at
	created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS facturas_compras (
	-- Creamos atributos
	factura_compra_id int primary key auto_increment,
	orden_compra_id int,
	proveedor_id int,
	fecha_factura datetime not null,
	tipo_factura char(1),
	numero_factura int UNIQUE,
	total decimal(12,2),

	CHECK(total > 0 OR total IS NULL),

	-- Definimos un indice en fecha_factura
	INDEX idx_fecha_factura (fecha_factura),

	-- Definimos referencias
	foreign key(orden_compra_id) references orden_compras(orden_compra_id),
	foreign key(proveedor_id) references proveedores(proveedor_id),
	
	-- Creamos created_at y updated_at
	created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS detalle_facturas_compras (
	-- Creamos atributos
	detalle_factura_compra_id int primary key auto_increment,
	factura_compra_id int not null,
	producto_id int not null,
	cantidad int not null,
	precio_unitario decimal(12,2) not null,

	 total_linea DECIMAL(10,2) 
        GENERATED ALWAYS AS (ROUND((precio_unitario * cantidad), 2)) STORED,

	CHECK(cantidad > 0),
	CHECK(precio_unitario > 0),
	
	-- Definimos referencias
	foreign key(factura_compra_id) references facturas_compras(factura_compra_id),
	foreign key(producto_id) references productos(producto_id),
	
	-- Creamos created_at y updated_at
	created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS estado_cotizaciones (
	-- Creamos atributos
	estado_id int primary key auto_increment,
	estado varchar(20) not null,
	
	-- Definimos referencias
	
	
	-- Creamos created_at y updated_at
	created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS condiciones_pago_cotizaciones (
	-- Creamos atributos
	condicion_pago_id int primary key auto_increment,
	condicion_pago varchar(50) not null,
	
	-- Definimos referencias
	
	
	-- Creamos created_at y updated_at
	created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS cotizaciones (
	-- Creamos atributos
	cotizacion_id int primary key auto_increment,
	cliente_id int,
	empleado_id int,
	fecha_cotizacion datetime not null,
	validez_hasta datetime,
	estado_id int,
	precio_total decimal(12,2),
	condicion_pago_id int,
	
	CHECK(precio_total > 0 OR precio_total IS NULL),
	
	-- Definimos referencias
	foreign key(cliente_id) references clientes(cliente_id),
	foreign key(empleado_id) references empleados(empleado_id),
	foreign key(estado_id) references estado_cotizaciones(estado_id),
	foreign key(condicion_pago_id) references condiciones_pago_cotizaciones(condicion_pago_id),
	
	-- Creamos created_at y updated_at
	created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS detalle_cotizaciones (
	-- Creamos atributos
	detalle_cotizacion_id int primary key auto_increment,
	cotizacion_id int not null,
	producto_id int not null,
	cantidad int not null,
	precio_unitario decimal(12,2) not null,

	 total_linea DECIMAL(10,2) 
        GENERATED ALWAYS AS (ROUND((precio_unitario * cantidad), 2)) STORED,

	CHECK(cantidad > 0),
	CHECK(precio_unitario > 0),
	
	-- Definimos referencias
	foreign key(cotizacion_id) references cotizaciones(cotizacion_id),
	foreign key(producto_id) references productos(producto_id),
	
	-- Creamos created_at y updated_at
	created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS cotizacion_orden (
	-- Creamos atributos
	cotizacion_id int not null,
	orden_compra_id int not null,
	ganadora boolean default false,
	
	primary key(cotizacion_id, orden_compra_id),
	
	-- Definimos referencias
	foreign key(cotizacion_id) references cotizaciones(cotizacion_id),
	foreign key(orden_compra_id) references orden_compras(orden_compra_id),
	
	-- Creamos created_at y updated_at
	created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS estado_facturas (
	-- Creamos atributos
	estado_id int primary key auto_increment,
	estado varchar(20) not null,
	
	-- Definimos referencias
	
	
	-- Creamos created_at y updated_at
	created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS facturas (
	-- Creamos atributos
	factura_id int primary key auto_increment,
	cliente_id int,
	empleado_id int,
	sucursal_id int,
	fecha_factura datetime not null,
	tipo_factura char(1) not null,
	numero_factura int UNIQUE,
	estado_id int,
	total decimal(12,2),
	condicion_pago_id int,

	CHECK(numero_factura > 0 OR numero_factura IS NULL),
	CHECK(total > 0 OR total IS NULL),
	
	-- Definimos un indice en fecha_factura
	INDEX idx_fecha_factura (fecha_factura),

	-- Definimos referencias
	foreign key(cliente_id) references clientes(cliente_id),
	foreign key(empleado_id) references empleados(empleado_id),
	foreign key(sucursal_id) references sucursales(sucursal_id),
	foreign key(estado_id) references estado_facturas(estado_id),
	foreign key (condicion_pago_id) references condiciones_pagos(condicion_pago_id),
	-- Creamos created_at y updated_at
	created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS detalle_facturas (
	-- Creamos atributos
	detalle_factura_id int primary key auto_increment,
	factura_id int not null,
	producto_id int not null,
	cantidad int not null,
	descuento decimal(5,2),
	impuesto decimal(5,2),

	CHECK((descuento>=0 and descuento<=100) OR descuento IS NULL),
	CHECK((impuesto>=0 and impuesto<=100) OR impuesto IS NULL),

	precio_unitario decimal(10,2) not null,

	 total_linea DECIMAL(10,2) 
        GENERATED ALWAYS AS (ROUND((
			(precio_unitario * cantidad) * 
			(1 - COALESCE(descuento, 0) / 100)) * 
			(1 + COALESCE(impuesto, 0) / 100), 2)) STORED,

	CHECK(cantidad > 0),
	CHECK(precio_unitario > 0),
	
	-- Definimos referencias
	foreign key(factura_id) references facturas(factura_id),
	foreign key(producto_id) references productos(producto_id),
	
	-- Creamos created_at y updated_at
	created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS remitos_clientes (
	-- Creamos atributos
	remito_cliente_id int primary key auto_increment,
	factura_id int,
	cliente_id int,
	fecha_remito datetime not null,
	
	-- Definimos referencias
	foreign key(factura_id) references facturas(factura_id),
	foreign key(cliente_id) references clientes(cliente_id),
	
	-- Creamos created_at y updated_at
	created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS detalle_remitos_clientes (
	-- Creamos atributos
	detalle_remito_cliente_id int primary key auto_increment,
	remito_cliente_id int not null,
	producto_id int not null,
	cantidad int not null,

	CHECK(cantidad > 0),
	
	-- Definimos referencias
	foreign key(remito_cliente_id) references remitos_clientes(remito_cliente_id),
	foreign key(producto_id) references productos(producto_id),
	
	-- Creamos created_at y updated_at
	created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS recibos (
	-- Creamos atributos
	recibo_id int primary key auto_increment,
	cliente_id int,
	empleado_id int,
	fecha_recibo datetime not null,
	total decimal(12,2),

	CHECK(total > 0 OR total IS NULL),
	
	-- Definimos referencias
	foreign key(cliente_id) references clientes(cliente_id),
	foreign key(empleado_id) references empleados(empleado_id),
	
	-- Creamos created_at y updated_at
	created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS detalle_recibos (
	-- Creamos atributos
	detalle_recibo_id int primary key auto_increment,
	recibo_id int not null,
	factura_id int not null,
	monto_cancelado decimal(12,2) not null,

	CHECK(monto_cancelado > 0),
	
	-- Definimos referencias
	foreign key(recibo_id) references recibos(recibo_id),
	foreign key(factura_id) references facturas(factura_id),
	
	-- Creamos created_at y updated_at
	created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS medios_pagos (
	-- Creamos atributos
	medio_pago_id int primary key auto_increment,
	nombre varchar(50),
	descripcion varchar(100),
	
	-- Definimos referencias
	
	
	-- Creamos created_at y updated_at
	created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS pagos (
	-- Creamos atributos
	pago_id int primary key auto_increment,
	recibo_id int not null,
	medio_pago_id int not null,
	fecha_pago datetime not null,
	monto decimal(12,2) not null,
	detalles varchar(100),

	CHECK(monto > 0),
	
	
	-- Definimos referencias
	foreign key(recibo_id) references recibos(recibo_id),
	foreign key(medio_pago_id) references medios_pagos(medio_pago_id),
	
	-- Creamos created_at y updated_at
	created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS personas (
	-- Creamos atributos
	persona_id int primary key auto_increment,
	nombre varchar(50) not null,
	apellido varchar(50) not null,
	dni varchar (15) UNIQUE,
	fecha_nacimiento datetime,
	sexo char(1),
	email varchar(60),
	telefono varchar(20),
	direccion_id int,
	
	-- Definimos referencias
	foreign key(direccion_id) references direcciones(direccion_id),
	
	-- Creamos created_at y updated_at
	created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS grupo_familiares (
	-- Creamos atributos
	grupo_familiar_id int primary key auto_increment,
	empleado_id int not null,
	descripcion varchar (100),
	
	-- Definimos referencias
	foreign key(empleado_id) references empleados(empleado_id),
	
	-- Creamos created_at y updated_at
	created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS parentezcos (
	-- Creamos atributos
	parentezco_id int primary key auto_increment,
	parentezco varchar(20),
	
	-- Definimos referencias
	
	
	-- Creamos created_at y updated_at
	created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS grupo_familiares_personas (
	-- Creamos atributos
	grupo_familiar_id int not null,
	persona_id int not null,
	parentezco_id int,
	
	primary key(grupo_familiar_id, persona_id),
	
	-- Definimos referencias
	foreign key(grupo_familiar_id) references grupo_familiares(grupo_familiar_id),
	foreign key(persona_id) references personas(persona_id),
	foreign key(parentezco_id) references parentezcos(parentezco_id),
	
	-- Creamos created_at y updated_at
	created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS empleado_departamento_historial (
	-- Creamos atributos
	empleado_id int not null,
	departamento_id int not null,
	fecha_desde datetime not null,
	fecha_hasta datetime,
	
	primary key(empleado_id, departamento_id),

	CHECK(fecha_hasta >= fecha_desde OR fecha_hasta IS NULL),
	
	-- Definimos referencias
	foreign key(empleado_id) references empleados(empleado_id),
	foreign key(departamento_id) references departamentos(departamento_id),
	
	-- Creamos created_at y updated_at
	created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS cursos (
	-- Creamos atributos
	curso_id int primary key auto_increment,
	codigo varchar(10),
	nombre varchar(50) not null,
	descripcion varchar(100),
	horas_totales int,

	CHECK(horas_totales > 0 OR horas_totales IS NULL),
	
	-- Definimos referencias
	
	
	-- Creamos created_at y updated_at
	created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS empleado_curso (
	-- Creamos atributos
	empleado_id int not null,
	curso_id int not null,
	fecha_inicio datetime not null,
	fecha_fin datetime,
	resultado int,

	CHECK(fecha_fin>=fecha_inicio OR fecha_fin IS NULL),
	
	primary key(empleado_id, curso_id),
	
	-- Definimos referencias
	foreign key(empleado_id) references empleados(empleado_id),
	foreign key(curso_id) references cursos(curso_id),
	
	-- Creamos created_at y updated_at
	created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS diagnosticos (
	-- Creamos atributos
	diagnostico_id int primary key auto_increment,
	codigo varchar(10),
	descripcion varchar(100),
	
	-- Definimos referencias
	
	
	-- Creamos created_at y updated_at
	created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS lugares_accidentes (
	-- Creamos atributos
	lugar_id int primary key auto_increment,
	lugar varchar(50),
	
	-- Definimos referencias
	
	
	-- Creamos created_at y updated_at
	created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS accidentes_laborales (
	-- Creamos atributos
	accidente_id int primary key auto_increment,
	empleado_id int not null,
	fecha_accidente datetime not null,
	descripcion varchar(100),
	gravedad int,
	lugar_id int,
	dias_incapacidad int,
	diagnostico_id int,

	CHECK(gravedad >= 0 OR gravedad IS NULL),
	CHECK(dias_incapacidad >=0 OR dias_incapacidad IS NULL),
	
	-- Definimos referencias
	foreign key(empleado_id) references empleados(empleado_id),
	foreign key(diagnostico_id) references diagnosticos(diagnostico_id),
	foreign key(lugar_id) references lugares_accidentes(lugar_id),
	
	-- Creamos created_at y updated_at
	created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS tratamientos (
	-- Creamos atributos
	tratamiento_id int primary key auto_increment,
	diagnostico_id int,
	empleado_id int,
	fecha_inicio datetime,
	fecha_fin datetime,
	descripcion varchar(100),

	CHECK(fecha_fin>=fecha_inicio OR fecha_fin IS NULL),
	
	-- Definimos referencias
	foreign key(empleado_id) references empleados(empleado_id),
	foreign key(diagnostico_id) references diagnosticos(diagnostico_id),
	
	-- Creamos created_at y updated_at
	created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS revisiones_medicas (
	-- Creamos atributos
	revision_id int primary key auto_increment,
	empleado_id int not null,
	fecha_revision datetime not null,
	observaciones varchar(100),
	
	-- Definimos referencias
	foreign key(empleado_id) references empleados(empleado_id),
	
	-- Creamos created_at y updated_at
	created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS unidades_medicas (
	-- Creamos atributos
	unidad_id int primary key auto_increment,
	unidad varchar(10),
	
	-- Definimos referencias
	-- SIN REFERENCIAS
	
	-- Creamos created_at y updated_at
	created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS parametros_medicos (
	-- Creamos atributos
	parametro_id int primary key auto_increment,
	revision_id int not null,
	nombre varchar(50) not null,
	valor int,
	unidad_id int,
	
	-- Definimos referencias
	foreign key(revision_id) references revisiones_medicas(revision_id),
	foreign key(unidad_id) references unidades_medicas(unidad_id),
	
	-- Creamos created_at y updated_at
	created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS conceptos (
	-- Creamos atributos
	concepto_id int primary key auto_increment,
	codigo varchar(10),
	nombre varchar(50) not null,
	naturaleza boolean not null,
	formula varchar(50),
	
	-- Definimos referencias
	
	
	-- Creamos created_at y updated_at
	created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS liquidaciones_sueldo (
	-- Creamos atributos
	liquidacion_id int primary key auto_increment,
	empleado_id int not null,
	codigo varchar(10) not null,
	periodo int not null,
	fecha_pago datetime not null,
	total_bruto decimal(10,2),
	total_deducciones decimal(10,2),
	total_neto decimal(10,2),
	observaciones varchar(100),

	CHECK(periodo > 0),
	CHECK(total_bruto >= 0 OR total_bruto IS NULL),
	CHECK(total_deducciones >= 0 OR total_deducciones IS NULL),
	CHECK(total_neto >= 0 OR total_neto IS NULL),
	
	-- Definimos referencias
	foreign key(empleado_id) references empleados(empleado_id),
	
	-- Creamos created_at y updated_at
	created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS detalle_liquidaciones (
	-- Creamos atributos
	detalle_liquidacion_id int primary key auto_increment,
	liquidacion_id int not null,
	concepto_id int not null,
	cantidad int not null,
	monto_unitario decimal(10,2) not null,

	monto_total DECIMAL(10,2) 
        GENERATED ALWAYS AS (ROUND((monto_unitario * cantidad), 2)) STORED,

	CHECK(cantidad > 0),
	CHECK(monto_unitario > 0),	
	
	-- Definimos referencias
	foreign key(liquidacion_id) references liquidaciones_sueldo(liquidacion_id),
	foreign key(concepto_id) references conceptos(concepto_id),
	
	-- Creamos created_at y updated_at
	created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Relación cliente ↔ rubro
CREATE TABLE IF NOT EXISTS cliente_rubro (
	-- Creamos atributos
    cliente_id int not null,
    rubro_id int not null,
    primary key (cliente_id, rubro_id),
	
	-- Definimos referencias
    foreign key (cliente_id) references clientes(cliente_id),
    foreign key (rubro_id) references rubros(rubro_id),
	
	-- Creamos created_at y updated_at
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Ranking del cliente
CREATE TABLE IF NOT EXISTS ranking_cliente (
	-- Creamos atributos
    cliente_id int primary key,
    ranking int check (ranking between 1 and 5),
    comentarios varchar(100),
    fecha_ranking date,

	-- Definimos referencias
    foreign key (cliente_id) references clientes(cliente_id),
	
	-- Creamos created_at y updated_at
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);