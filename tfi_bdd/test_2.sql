-- === GEOGRAFÍA Y UBICACIONES ===
INSERT INTO paises (pais_id, nombre) VALUES (7, 'Argentina');

INSERT INTO provincias (provincia_id, pais_id, nombre) VALUES 
(7, 7, 'Tucumán'),
(8, 7, 'Buenos Aires');

INSERT INTO ciudades (ciudad_id, provincia_id, nombre) VALUES 
(7, 7, 'S.M. de Tucumán'),
(8, 8, 'La Plata');

INSERT INTO codigos_postales (codigo_postal_id, ciudad_id, codigo) VALUES 
(7, 7, 4000),
(8, 8, 1900);

INSERT INTO direcciones (direccion_id, calle, numero, piso, depto, ciudad_id, provincia_id, pais_id, codigo_postal_id) VALUES 
(7, 'San Martín', 123, 2, 5, 7, 7, 7, 7),
(8, 'Belgrano', 456, NULL, NULL, 8, 8, 7, 8),
(9, 'Mitre', 789, 3, 2, 7, 7, 7, 7);

-- === ENTIDADES BÁSICAS ===
INSERT INTO tipo_departamentos (tipo_departamento_id, nombre, descripcion) VALUES 
(7, 'Administrativo', 'Gestión interna'),
(8, 'Ventas', 'Relación con clientes');

INSERT INTO sucursales (sucursal_id, nombre, direccion_id) VALUES 
(7, 'CENTRO', 7),
(8, 'YERBA BUENA', 8);

INSERT INTO departamentos (departamento_id, sucursal_id, tipo_departamento_id, nombre) VALUES 
(7, 7, 7, 'TESORERIA'),
(8, 7, 8, 'VENTAS'),
(9, 8, 8, 'COMPRAS');

-- === TIPO EMPLEADOS Y EMPLEADOS ===
INSERT INTO tipo_empleados (tipo_empleado_id, nombre, descripcion) VALUES 
(7, 'Administrativo', 'Back office'),
(8, 'Vendedor', 'Ventas directas');

INSERT INTO empleados (empleado_id, nombre, apellido, dni, cuil, fecha_nacimiento, fecha_alta, email, telefono, tipo_empleado_id, departamento_id, sucursal_id, direccion_id) VALUES 
(7, 'Juan', 'Hernandez', '23156789', '20-23156789-9', '1990-05-15', '2022-01-10', 'juanfh@empresa.com', '3814567890', 8, 8, 7, 7),
(8, 'Fabrizzio', 'Lopez', '20732589', '27-20732589-8', '1985-11-20', '2021-06-15', 'fabri159.fl@empresa.com', '3817894561', 7, 7, 7, 8),
(9, 'Luis', 'Martínez', '30123456', '20-30123456-5', '1992-07-10', '2023-03-01', 'luis@example.com', '3819871234', 8, 9, 8, 9);

-- === GRUPO FAMILIAR ===
INSERT INTO grupo_familiares (grupo_familiar_id, empleado_id, descripcion) VALUES 
(7, 7, 'Grupo familiar Juan Hernandez');

INSERT INTO parentezcos (parentezco_id, parentezco) VALUES 
(7, 'Cónyuge'),
(8, 'Hijo');

INSERT INTO personas (persona_id, nombre, apellido, dni, fecha_nacimiento, sexo, email, telefono, direccion_id) VALUES 
(7, 'Maria', 'López', '34123456', '1991-03-12', 'F', 'maria@example.com', '3811112233', 7),
(8, 'Pedro', 'Pérez', '45123456', '2015-04-05', 'M', 'pedro@example.com', '3812223344', 7);

INSERT INTO grupo_familiares_personas (grupo_familiar_id, persona_id, parentezco_id) VALUES 
(7, 7, 7),
(7, 8, 8);

-- === CLIENTES Y PROVEEDORES ===
INSERT INTO clientes (cliente_id, razon_social, cuil, email, telefono, fecha_alta, credito, direccion_id) VALUES 
(7, 'ConstruMax S.A.', '30-65432109-0', 'contacto@constru.com', '3817778889', '2023-05-15', 250000.00, 7);

INSERT INTO ranking_cliente (cliente_id, ranking, comentarios, fecha_ranking) VALUES 
(7, 5, 'Cliente frecuente', '2024-01-10');

INSERT INTO rubros (rubro_id, nombre, descripcion) VALUES 
(7, 'Caños para agua', 'Distribución y plomería'),
(8, 'Cementos', 'Material de construcción');

INSERT INTO cliente_rubro (cliente_id, rubro_id) VALUES 
(7, 7);

INSERT INTO proveedores (proveedor_id, razon_social, cuit, email, telefono, direccion_id, fecha_alta, credito, rubro_id) VALUES 
(7, 'TuboFlex SRL', '30-98765432-1', 'ventas@tuboflex.com', '3813334444', 7, '2023-01-01', 500000, 7),
(8, 'Cementos Norte', '30-11223344-5', 'info@cementosnorte.com', '3814445555', 8, '2024-01-01', 300000, 8);

INSERT INTO rankings (rubro_id, proveedor_id, ranking, fecha_ranking, comentarios) VALUES 
(7, 7, 5, '2024-06-01', 'Excelente proveedor');

-- === PRODUCTOS Y RELACIONES ===
INSERT INTO categoria_productos (categoria_id, nombre, descripcion) VALUES 
(7, 'Tuberías', 'PVC y otros'),
(8, 'Construcción', 'Material pesado');

INSERT INTO unidades_medida (unidad_medida_id, unidad) VALUES 
(7, 'm'),
(8, 'kg');

INSERT INTO productos (producto_id, rubro_id, categoria_id, nombre, descripcion, unidad_medida_id, codigo_barra, precio_unitario) VALUES 
(7, 7, 7, 'Tubo PVC 110mm', 'Tubo de PVC resistente', 7, '000000000001', 1200.00),
(8, 8, 8, 'Bolsa de Cemento 50kg', 'Cemento Portland', 8, '000000000002', 2500.00);

INSERT INTO producto_proveedor (producto_id, proveedor_id, precio_compra, fecha_alta) VALUES 
(7, 7, 1000.00, '2023-02-15'),
(8, 8, 2000.00, '2024-03-10');

-- A partir de aquí sigue el bloque de stocks, órdenes, remitos, cotizaciones, facturas y cursos...

-- === ALMACENES ===
INSERT INTO almacenes (almacen_id, sucursal_id, nombre, direccion_id) VALUES 
(7, 7, 'Depósito Central', 7),
(8, 8, 'Depósito Yerba Buena', 8);

-- === STOCK ===
INSERT INTO stocks (stock_id, producto_id, almacen_id, cantidad, stock_minimo, stock_maximo) VALUES 
(7, 7, 7, 1500, 100, 2000),
(8, 8, 7, 1200, 200, 2500);

-- === ESTADOS DE COMPRA Y CONDICIONES DE PAGO ===
INSERT INTO estados_compras (estado_id, estado) VALUES 
(7, 'Emitida'),
(8, 'Aprobada'),
(9, 'Finalizada');

INSERT INTO condiciones_pagos (condicion_pago_id, condicion_pago) VALUES 
(7, 'Transferencia Bancaria'),
(8, 'e-cheq'),
(9, 'Tarjeta de crédito Visa');

-- === ORDEN DE COMPRA ===
INSERT INTO orden_compras (orden_compra_id, proveedor_id, empleado_id, sucursal_id, departamento_id, fecha_orden, estado_id, total, condicion_pago_id) VALUES 
(7, 7, 7, 7, 8, '2024-03-15', 8, 120000.00, 8);

-- === DETALLE ORDEN COMPRA ===
INSERT INTO detalle_orden_compras (detalle_orden_id, orden_compra_id, producto_id, cantidad, precio_unitario) VALUES 
(7, 7, 7, 100, 1200.00);

-- === ESTADO DE REMITO ===
INSERT INTO estado_remitos (estado_id, estado) VALUES 
(7, 'Parcial'),
(8, 'Completo');

-- === REMITO DE COMPRA ===
INSERT INTO remitos (remito_id, proveedor_id, sucursal_id, orden_compra_id, fecha_remito, estado_id) VALUES 
(7, 7, 7, 7, '2024-03-20', 7);

INSERT INTO detalle_remitos (detalle_remito_id, remito_id, producto_id, cantidad) VALUES 
(7, 7, 7, 60); -- Parcial

-- === FACTURA DE COMPRA ===
INSERT INTO facturas_compras (factura_compra_id, orden_compra_id, proveedor_id, fecha_factura, tipo_factura, numero_factura, total) VALUES 
(7, 7, 7, '2024-03-25', 'A', 1007, 72000.00);

INSERT INTO detalle_facturas_compras (detalle_factura_compra_id, factura_compra_id, producto_id, cantidad, precio_unitario) VALUES 
(7, 7, 7, 60, 1200.00);

-- === ESTADOS Y CONDICIONES PARA VENTAS ===
INSERT INTO estado_cotizaciones (estado_id, estado) VALUES 
(7, 'Emitida'),
(8, 'Aceptada');

INSERT INTO condiciones_pago_cotizaciones (condicion_pago_id, condicion_pago) VALUES 
(7, 'Contado'),
(8, 'Tarjeta de crédito Visa');

-- === COTIZACIONES ===
INSERT INTO cotizaciones (cotizacion_id, cliente_id, empleado_id, fecha_cotizacion, validez_hasta, estado_id, precio_total, condicion_pago_id) VALUES 
(7, 7, 7, '2024-05-01', '2024-06-01', 8, 24000.00, 8);

INSERT INTO detalle_cotizaciones (detalle_cotizacion_id, cotizacion_id, producto_id, cantidad, precio_unitario) VALUES 
(7, 7, 7, 20, 1200.00);

INSERT INTO cotizacion_orden (cotizacion_id, orden_compra_id, ganadora) VALUES 
(7, 7, true);

-- === ESTADO FACTURAS VENTAS ===
INSERT INTO estado_facturas (estado_id, estado) VALUES 
(7, 'Pagada'),
(8, 'Pendiente');

-- === FACTURA DE VENTA ===
INSERT INTO facturas (factura_id, cliente_id, empleado_id, sucursal_id, fecha_factura, tipo_factura, numero_factura, estado_id, total, condicion_pago_id) VALUES 
(7, 7, 7, 7, '2024-05-03', 'A', 2007, 7, 24000.00, 8);

INSERT INTO detalle_facturas (detalle_factura_id, factura_id, producto_id, cantidad, descuento, impuesto, precio_unitario) VALUES 
(7, 7, 7, 20, 5.00, 21.00, 1200.00);

-- === REMITO CLIENTE ===
INSERT INTO remitos_clientes (remito_cliente_id, factura_id, cliente_id, fecha_remito) VALUES 
(7, 7, 7, '2024-05-04');

INSERT INTO detalle_remitos_clientes (detalle_remito_cliente_id, remito_cliente_id, producto_id, cantidad) VALUES 
(7, 7, 7, 20);

-- === RECIBO Y PAGO ===
INSERT INTO recibos (recibo_id, cliente_id, empleado_id, fecha_recibo, total) VALUES 
(7, 7, 7, '2024-05-05', 24000.00);

INSERT INTO detalle_recibos (detalle_recibo_id, recibo_id, factura_id, monto_cancelado) VALUES 
(7, 7, 7, 24000.00);

INSERT INTO medios_pagos (medio_pago_id, nombre, descripcion) VALUES 
(7, 'Tarjeta de crédito Visa', 'Visa crédito');

INSERT INTO pagos (pago_id, recibo_id, medio_pago_id, fecha_pago, monto, detalles) VALUES 
(7, 7, 7, '2024-05-05', 24000.00, 'Pago completo con tarjeta Visa');
-- === CURSOS Y ASISTENCIA ===

-- === UNIDADES MÉDICAS ===
INSERT INTO unidades_medicas (unidad_id, unidad) VALUES 
(7, 'kg'),
(8, 'mmHg');

-- === REVISIÓN MÉDICA ===
INSERT INTO revisiones_medicas (revision_id, empleado_id, fecha_revision, observaciones) VALUES 
(7, 7, '2023-11-15', 'Sin observaciones');

-- === PARÁMETROS MÉDICOS ===
INSERT INTO parametros_medicos (parametro_id, revision_id, nombre, valor, unidad_id) VALUES 
(7, 7, 'Peso', 80, 7),
(8, 7, 'Presión arterial', 120, 8);

-- === LUGARES Y DIAGNÓSTICOS ===
INSERT INTO lugares_accidentes (lugar_id, lugar) VALUES 
(7, 'Depósito principal');

INSERT INTO diagnosticos (diagnostico_id, codigo, descripcion) VALUES 
(7, 'DX01', 'Esguince de tobillo');

-- === ACCIDENTE ===
INSERT INTO accidentes_laborales (accidente_id, empleado_id, fecha_accidente, descripcion, gravedad, lugar_id, dias_incapacidad, diagnostico_id) VALUES 
(7, 7, '2024-01-20', 'Resbalón en piso húmedo', 8, 7, 7, 7);

-- === TRATAMIENTO ===
INSERT INTO tratamientos (tratamiento_id, diagnostico_id, empleado_id, fecha_inicio, fecha_fin, descripcion) VALUES 
(7, 7, 7, '2024-01-21', '2024-01-28', 'Rehabilitación leve');

-- === CURSOS ===
INSERT INTO cursos (curso_id, codigo, nombre, descripcion, horas_totales) VALUES 
(7, 'C001', 'Seguridad en el trabajo', 'Prevención de accidentes', 8);

-- === EMPLEADO CURSO ===
INSERT INTO empleado_curso (empleado_id, curso_id, fecha_inicio, fecha_fin, resultado) VALUES 
(7, 7, '2024-03-10', '2024-03-10', 100);

-- === CONCEPTOS ===
INSERT INTO conceptos (concepto_id, codigo, nombre, naturaleza, formula) VALUES 
(7, 'BASICO', 'Sueldo básico', true, NULL),
(8, 'DESCU', 'Obra social', false, NULL);

-- === LIQUIDACIÓN DE SUELDO ===
INSERT INTO liquidaciones_sueldo (liquidacion_id, empleado_id, codigo, periodo, fecha_pago, total_bruto, total_deducciones, total_neto, observaciones) VALUES 
(7, 7, '2023-01', 202301, '2023-01-31', 100000.00, 17000.00, 83000.00, 'Liquidación enero');

-- === DETALLE LIQUIDACIÓN ===
INSERT INTO detalle_liquidaciones (detalle_liquidacion_id, liquidacion_id, concepto_id, cantidad, monto_unitario) VALUES 
(7, 7, 1, 1, 100000.00),
(8, 7, 1, 1, 17000.00);
