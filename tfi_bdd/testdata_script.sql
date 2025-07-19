INSERT INTO paises (pais_id, nombre) VALUES 
(1, 'Argentina'),
(2, 'Brasil'),
(3, 'Chile'),
(4, 'Uruguay'),
(5, 'Paraguay');

INSERT INTO provincias (provincia_id, pais_id, nombre) VALUES
(1, 1, 'Buenos Aires'),
(2, 1, 'Córdoba'),
(3, 2, 'São Paulo'),
(4, 3, 'Santiago'),
(5, 4, 'Montevideo');

INSERT INTO ciudades (ciudad_id, provincia_id, nombre) VALUES
(1, 1, 'La Plata'),
(2, 2, 'Villa Carlos Paz'),
(3, 3, 'Campinas'),
(4, 4, 'Maipú'),
(5, 5, 'Las Piedras');

INSERT INTO codigos_postales (codigo_postal_id, ciudad_id, codigo) VALUES
(1, 1, 1900),
(2, 2, 5152),
(3, 3, 13083),
(4, 4, 9580000),
(5, 5, 90200);

INSERT INTO direcciones (direccion_id, calle, numero, piso, depto, ciudad_id, provincia_id, pais_id, codigo_postal_id) VALUES
(1, 'Calle 12', 123, 2, 4, 1, 1, 1, 1),
(2, 'Av. San Martín', 456, NULL, NULL, 2, 2, 1, 2),
(3, 'Rua das Flores', 789, 5, 2, 3, 3, 2, 3),
(4, 'Av. Libertador', 1011, 3, 1, 4, 4, 3, 4),
(5, 'Calle Rincón', 202, NULL, NULL, 5, 5, 4, 5);

INSERT INTO tipo_departamentos (nombre, descripcion) VALUES
('Administración', 'Gestión administrativa general'),
('Producción', 'Área de fabricación y ensamblado'),
('Ventas', 'Comercialización y atención al cliente'),
('Logística', 'Distribución y almacenaje'),
('RRHH', 'Recursos Humanos y personal');

INSERT INTO sucursales (nombre, direccion_id) VALUES
('Casa Central', 1),
('Sucursal Norte', 2),
('Sucursal Sur', 3),
('Sucursal Este', 4),
('Sucursal Oeste', 5);

INSERT INTO departamentos (sucursal_id, tipo_departamento_id, nombre) VALUES
(1, 1, 'Administración Central'),
(1, 5, 'Recursos Humanos Central'),
(2, 2, 'Producción Norte'),
(3, 3, 'Ventas Sur'),
(4, 4, 'Logística Este');

INSERT INTO tipo_empleados (nombre, descripcion) VALUES
('Permanente', 'Empleado en relación de dependencia'),
('Temporal', 'Empleado contratado por tiempo limitado'),
('Pasante', 'Alumno en práctica profesional'),
('Consultor', 'Asesor externo por proyecto'),
('Tercerizado', 'Empleado de empresa contratista');

INSERT INTO empleados (nombre, apellido, dni, cuil, fecha_nacimiento, fecha_alta, email, telefono, tipo_empleado_id, departamento_id, sucursal_id, direccion_id) VALUES
('Lucía', 'Pérez', 30456789, 20304567891, '1990-06-15', '2020-01-10', 'lucia.perez@empresa.com', 381456789, 1, 1, 1, 1),
('Matías', 'Gómez', 32567890, 20325678902, '1988-02-20', '2021-03-05', 'matias.gomez@empresa.com', 381987654, 2, 2, 1, 2),
('Sofía', 'López', 33678901, 20336789013, '1995-11-03', '2022-07-01', 'sofia.lopez@empresa.com', 381123456, 3, 3, 2, 3),
('Julián', 'Fernández', 34789012, 20347890124, '1992-09-12', '2019-06-20', 'julian.fernandez@empresa.com', 381321654, 1, 4, 3, 4),
('Carla', 'Martínez', 35890123, 20358901235, '1985-12-30', '2018-04-15', 'carla.martinez@empresa.com', 381789123, 1, 5, 4, 5);

INSERT INTO clientes (razon_social, cuil, email, telefono, direccion_id) VALUES
('Distribuidora del Sur S.A.', '30-12345678-9', 'contacto@delsur.com', '1123456789', 1),
('Ferretería El Tornillo', '30-23456789-0', 'ventas@eltornillo.com', '1134567890', 2),
('Supermercado Central', '30-34567890-1', 'compras@supercentral.com', '1145678901', 3),
('Hotel Patagonia', '30-45678901-2', 'recepcion@hotelpatagonia.com', '1156789012', 4),
('Farmacia Vida', '30-56789012-3', 'info@farmaciavida.com', '1167890123', 5);

INSERT INTO proveedores (razon_social, cuit, email, telefono, direccion_id) VALUES
('Proveedora Industrial S.A.', '30-11111111-1', 'info@proveedora.com', '1122233344', 1),
('Importadora Global', '30-22222222-2', 'ventas@importglobal.com', '1133344455', 2),
('Papelera Norte', '30-33333333-3', 'pedidos@papeleranorte.com', '1144455566', 3),
('Textiles del Este', '30-44444444-4', 'textiles@este.com', '1155566677', 4),
('Químicos Andinos', '30-55555555-5', 'quimicos@andinos.com', '1166677788', 5);

INSERT INTO rubros (nombre, descripcion) VALUES
('Oficina', 'Materiales y muebles de oficina'),
('Limpieza', 'Productos de higiene y limpieza'),
('Alimentos', 'Productos comestibles y bebidas'),
('Textiles', 'Ropa y telas para fabricación'),
('Herramientas', 'Equipamiento de trabajo y herramientas');

INSERT INTO categoria_productos (nombre, descripcion) VALUES
('Muebles', 'Sillas, escritorios, estanterías'),
('Papelería', 'Resmas, sobres, carpetas'),
('Bebidas', 'Agua, gaseosas, jugos'),
('Ropa laboral', 'Uniformes, guantes, botas'),
('Herramientas manuales', 'Martillos, destornilladores, llaves');

INSERT INTO unidades_medida (unidad) VALUES
('kg'),
('lt'),
('u'),  -- unidades
('m'),
('ml');

INSERT INTO productos (rubro_id, categoria_id, nombre, descripcion, unidad_medida_id, codigo_barra, precio_unitario) VALUES
(1, 1, 'Escritorio Ejecutivo', 'Mueble de oficina con cajonera', 3, '779812345001', 35000.00),
(1, 2, 'Resma A4', 'Papel tamaño A4 500 hojas', 3, '779812345002', 1200.00),
(2, 3, 'Botella de Agua 1.5L', 'Agua mineral sin gas', 2, '779812345003', 250.00),
(4, 4, 'Pantalón de trabajo', 'Ropa resistente para fábrica', 3, '779812345004', 7800.00),
(5, 5, 'Destornillador Philips', 'Herramienta manual estándar', 3, '779812345005', 950.00);

INSERT INTO producto_proveedor (producto_id, proveedor_id, precio_compra, fecha_alta) VALUES
(1, 1, 30000.00, '2023-01-01'),
(2, 1, 1000.00, '2023-01-15'),
(3, 2, 180.00, '2023-02-10'),
(4, 4, 6400.00, '2023-03-05'),
(5, 5, 700.00, '2023-04-20');

INSERT INTO almacenes (sucursal_id, nombre, direccion_id) VALUES
(1, 'Almacén Central', 1),
(2, 'Depósito Norte', 2),
(3, 'Depósito Sur', 3),
(4, 'Depósito Este', 4),
(5, 'Almacén Oeste', 5);

INSERT INTO stocks (producto_id, almacen_id, cantidad, stock_minimo, stock_maximo) VALUES
(1, 1, 10, 2, 20),
(2, 1, 50, 10, 100),
(3, 2, 100, 20, 200),
(4, 3, 15, 5, 30),
(5, 4, 30, 10, 50);

INSERT INTO estados_compras (estado) VALUES
('Pendiente'),
('Aprobada'),
('Rechazada'),
('Recibida'),
('Cancelada');

INSERT INTO condiciones_pagos (condicion_pago) VALUES
('Contado'),
('30 días'),
('60 días'),
('Transferencia'),
('Cheque diferido');

INSERT INTO orden_compras (proveedor_id, empleado_id, sucursal_id, departamento_id, fecha_orden, estado_id, total, condicion_pago_id) VALUES
(1, 1, 1, 1, '2024-01-10', 1, 35000.00, 1),
(2, 2, 1, 2, '2024-01-12', 2, 5000.00, 2),
(3, 3, 2, 3, '2024-02-01', 3, 18000.00, 3),
(4, 4, 3, 4, '2024-02-15', 4, 7800.00, 4),
(5, 5, 4, 5, '2024-03-05', 5, 4750.00, 5);

INSERT INTO detalle_orden_compras (orden_compra_id, producto_id, cantidad, precio_unitario) VALUES
(1, 1, 1, 35000.00),
(2, 2, 5, 1000.00),
(3, 3, 100, 180.00),
(4, 4, 1, 7800.00),
(5, 5, 5, 950.00);

INSERT INTO estado_remitos (estado) VALUES
('Pendiente'),
('En tránsito'),
('Recibido'),
('Rechazado'),
('Anulado');

INSERT INTO remitos (proveedor_id, sucursal_id, orden_compra_id, fecha_remito, estado_id) VALUES
(1, 1, 1, '2024-01-15', 3),
(2, 1, 2, '2024-01-20', 1),
(3, 2, 3, '2024-02-03', 2),
(4, 3, 4, '2024-02-18', 3),
(5, 4, 5, '2024-03-07', 4);

INSERT INTO detalle_remitos (remito_id, producto_id, cantidad) VALUES
(1, 1, 1),
(2, 2, 5),
(3, 3, 100),
(4, 4, 1),
(5, 5, 5);

INSERT INTO facturas_compras (orden_compra_id, proveedor_id, fecha_factura, tipo_factura, numero_factura, total) VALUES
(1, 1, '2024-01-16', 'A', 1001, 35000.00),
(2, 2, '2024-01-22', 'B', 1002, 5000.00),
(3, 3, '2024-02-05', 'A', 1003, 18000.00),
(4, 4, '2024-02-20', 'B', 1004, 7800.00),
(5, 5, '2024-03-10', 'A', 1005, 4750.00);

INSERT INTO detalle_facturas_compras (factura_compra_id, producto_id, cantidad, precio_unitario) VALUES
(1, 1, 1, 35000.00),
(2, 2, 5, 1000.00),
(3, 3, 100, 180.00),
(4, 4, 1, 7800.00),
(5, 5, 5, 950.00);

INSERT INTO estado_cotizaciones (estado) VALUES
('Pendiente'),
('Aprobada'),
('Rechazada'),
('Vencida'),
('Finalizada');

INSERT INTO condiciones_pago_cotizaciones (condicion_pago) VALUES
('Contado'),
('15 días'),
('30 días'),
('Transferencia'),
('Crédito');

INSERT INTO cotizaciones (cliente_id, empleado_id, fecha_cotizacion, validez_hasta, estado_id, precio_total, condicion_pago_id) VALUES
(1, 1, '2024-01-05', '2024-01-15', 1, 45000.00, 1),
(2, 2, '2024-01-10', '2024-01-25', 2, 5200.00, 2),
(3, 3, '2024-02-01', '2024-02-15', 3, 20000.00, 3),
(4, 4, '2024-02-10', '2024-02-28', 4, 8900.00, 4),
(5, 5, '2024-03-01', '2024-03-15', 5, 6250.00, 5);

INSERT INTO detalle_cotizaciones (cotizacion_id, producto_id, cantidad, precio_unitario) VALUES
(1, 1, 1, 45000.00),
(2, 2, 5, 1040.00),
(3, 3, 80, 250.00),
(4, 4, 1, 8900.00),
(5, 5, 5, 1250.00);

INSERT INTO cotizacion_orden (cotizacion_id, orden_compra_id, ganadora) VALUES
(1, 1, true),
(2, 2, false),
(3, 3, true),
(4, 4, false),
(5, 5, true);

INSERT INTO estado_facturas (estado) VALUES
('Pendiente'),
('Pagada'),
('Parcialmente pagada'),
('Vencida'),
('Cancelada');

INSERT INTO facturas (cliente_id, empleado_id, sucursal_id, fecha_factura, tipo_factura, numero_factura, estado_id, total) VALUES
(1, 1, 1, '2024-01-20', 'A', 2001, 2, 45000.00),
(2, 2, 1, '2024-01-25', 'B', 2002, 1, 5200.00),
(3, 3, 2, '2024-02-10', 'A', 2003, 3, 20000.00),
(4, 4, 3, '2024-02-15', 'B', 2004, 4, 8900.00),
(5, 5, 4, '2024-03-05', 'A', 2005, 2, 6250.00);

INSERT INTO detalle_facturas (factura_id, producto_id, cantidad, precio_unitario) VALUES
(1, 1, 1, 45000.00),
(2, 2, 5, 1040.00),
(3, 3, 80, 250.00),
(4, 4, 1, 8900.00),
(5, 5, 5, 1250.00);

INSERT INTO remitos_clientes (factura_id, cliente_id, fecha_remito) VALUES
(1, 1, '2024-01-21'),
(2, 2, '2024-01-26'),
(3, 3, '2024-02-11'),
(4, 4, '2024-02-16'),
(5, 5, '2024-03-06');

INSERT INTO detalle_remitos_clientes (remito_cliente_id, producto_id, cantidad) VALUES
(1, 1, 1),
(2, 2, 5),
(3, 3, 80),
(4, 4, 1),
(5, 5, 5);

INSERT INTO recibos (cliente_id, empleado_id, fecha_recibo, total) VALUES
(1, 1, '2024-01-22', 45000.00),
(2, 2, '2024-01-27', 5200.00),
(3, 3, '2024-02-12', 15000.00),
(4, 4, '2024-02-17', 8900.00),
(5, 5, '2024-03-07', 6250.00);

INSERT INTO detalle_recibos (recibo_id, factura_id, monto_cancelado) VALUES
(1, 1, 45000.00),
(2, 2, 5200.00),
(3, 3, 15000.00),
(4, 4, 8900.00),
(5, 5, 6250.00);

INSERT INTO medios_pagos (nombre, descripcion) VALUES
('Efectivo', 'Pago en efectivo'),
('Transferencia bancaria', 'Pago mediante CBU'),
('Tarjeta de crédito', 'Visa, MasterCard'),
('Cheque', 'Cheque común o diferido'),
('Mercado Pago', 'Pago con billetera digital');

INSERT INTO pagos (recibo_id, medio_pago_id, fecha_pago, monto, detalles) VALUES
(1, 1, '2024-01-22', 45000.00, 'Pago contado'),
(2, 2, '2024-01-27', 5200.00, 'Transferencia BNA'),
(3, 3, '2024-02-12', 15000.00, 'Adelanto parcial'),
(4, 4, '2024-02-17', 8900.00, 'Pago con tarjeta'),
(5, 5, '2024-03-07', 6250.00, 'Cheque al día');

INSERT INTO personas (nombre, apellido, dni, fecha_nacimiento, sexo, email, telefono, direccion_id) VALUES
('Laura', 'Sosa', '27543123', '1980-05-20', 'F', 'laura.sosa@mail.com', '381111111', 1),
('Pedro', 'Sosa', '30543211', '2005-08-12', 'M', 'pedro.sosa@mail.com', '381111112', 1),
('María', 'Fernández', '22567890', '1975-03-15', 'F', 'maria.fernandez@mail.com', '381222221', 2),
('Santiago', 'Fernández', '45567890', '2003-11-04', 'M', 'santiago.fernandez@mail.com', '381222222', 2),
('Gabriel', 'Martínez', '23456789', '1983-02-18', 'M', 'gabriel.martinez@mail.com', '381333333', 3);

INSERT INTO grupo_familiares (empleado_id, descripcion) VALUES
(1, 'Familia Sosa'),
(2, 'Familia Fernández'),
(3, 'Sin dependientes'),
(4, 'Familia extendida'),
(5, 'Familia Martínez');

INSERT INTO parentezcos (parentezco) VALUES
('Padre'),
('Madre'),
('Hijo/a'),
('Hermano/a'),
('Cónyuge');

INSERT INTO grupo_familiares_personas (grupo_familiar_id, persona_id, parentezco_id) VALUES
(1, 1, 5),  -- Laura Sosa (cónyuge)
(1, 2, 3),  -- Pedro Sosa (hijo)
(2, 3, 2),  -- María Fernández (madre)
(2, 4, 3),  -- Santiago Fernández (hijo)
(5, 5, 1);  -- Gabriel Martínez (padre)

INSERT INTO diagnosticos (codigo, descripcion) VALUES
('DX001', 'Esguince de tobillo leve'),
('DX002', 'Corte superficial en mano derecha'),
('DX003', 'Fractura de radio'),
('DX004', 'Quemadura de segundo grado'),
('DX005', 'Contusión craneal leve');

INSERT INTO lugares_accidentes (lugar) VALUES
('Depósito de mercadería'),
('Zona de carga y descarga'),
('Oficina administrativa'),
('Área de producción'),
('Escaleras internas');

INSERT INTO accidentes_laborales (empleado_id, fecha_accidente, descripcion, gravedad, lugar_id, dias_incapacidad, diagnostico_id) VALUES
(1, '2023-02-15 09:30:00', 'Resbalón en el depósito', 2, 3, 5, 1),
(2, '2023-04-10 14:00:00', 'Corte leve manipulando herramienta', 1, 2, 2, 2),
(3, '2023-06-22 08:45:00', 'Caída desde escalera', 3, 1, 10, 3),
(4, '2023-07-05 16:15:00', 'Quemadura con maquinaria', 2, 4, 7, 4),
(5, '2023-08-12 11:10:00', 'Golpe en la cabeza con estantería', 2, 5, 4, 5);


INSERT INTO liquidaciones_sueldo (empleado_id, codigo, periodo, fecha_pago, observaciones) VALUES
(1, 'LS001', 202407, '2024-07-31', 'Liquidación mensual julio'),
(2, 'LS002', 202407, '2024-07-31', 'Liquidación mensual julio'),
(3, 'LS003', 202407, '2024-07-31', 'Liquidación mensual julio'),
(4, 'LS004', 202407, '2024-07-31', 'Liquidación mensual julio'),
(5, 'LS005', 202407, '2024-07-31', 'Liquidación mensual julio');

INSERT INTO conceptos (codigo, nombre, naturaleza, formula) VALUES
('BAS', 'Sueldo básico', true , 'horas_trabajadas * valor_hora'),
('HET', 'Horas extra', true, 'horas_extra * valor_hora_extra'),
('PRE', 'Presentismo', true, 'sueldo_basico * 0.1'),
('JUB', 'Aporte jubilatorio', false, 'sueldo_bruto * 0.11'),
('OBS', 'Obra social', false, 'sueldo_bruto * 0.03');

INSERT INTO detalle_liquidaciones (liquidacion_id, concepto_id, cantidad, monto_unitario) VALUES
(1, 1, 1, 300000.00), -- Sueldo básico
(1, 2, 1, 50000.00),  -- Horas extra
(1, 5, 1, 15000.00), -- Obra Social
(1, 4, 1, 30000.00), -- Jubilación
(1, 3, 1, 42500.00), -- Presentismo

(2, 1, 1, 280000.00),
(2, 3, 1, 12000.00),
(2, 4, 1, 28000.00),
(2, 5, 1, 32000.00),

(3, 1, 1, 350000.00),
(3, 2, 1, 50000.00),
(3, 3, 1, 20000.00),
(3, 4, 1, 40000.00),
(3, 5, 1, 40000.00),

(4, 1, 1, 310000.00),
(4, 2, 1, 50000.00),
(4, 3, 1, 15000.00),
(4, 4, 1, 40000.00),
(4, 5, 1, 45000.00),

(5, 1, 1, 280000.00),
(5, 2, 1, 30000.00),
(5, 3, 1, 12500.00),
(5, 4, 1, 30000.00),
(5, 5, 1, 35000.00);

INSERT INTO tratamientos (diagnostico_id, empleado_id, fecha_inicio, fecha_fin, descripcion)
VALUES 
(1, 1, '2024-02-01', '2024-03-01', 'Tratamiento con fisioterapia y reposo'),
(2, 2, '2024-04-10', NULL, 'Tratamiento psicológico continuo'),
(3, 3, '2024-01-15', '2024-02-10', 'Rehabilitación post fractura'),
(4, 4, '2024-05-05', '2024-06-01', 'Medicamentos y reposo en domicilio'),
(5, 5, '2024-06-15', NULL, 'Evaluación periódica por dolor lumbar crónico');

INSERT INTO revisiones_medicas (empleado_id, fecha_revision, observaciones)
VALUES 
(1, '2024-06-01', 'Buen estado general'),
(2, '2024-06-10', 'Presión arterial alta detectada'),
(3, '2024-06-15', 'Control de rutina sin anomalías'),
(4, '2024-06-20', 'Leve fatiga reportada'),
(5, '2024-06-25', 'Buena recuperación del accidente');

INSERT INTO rankings (rubro_id, proveedor_id, ranking, fecha_ranking, comentarios)
VALUES 
(1, 1, 5, '2024-06-01', 'Entrega puntual y productos de calidad'),
(2, 2, 3, '2024-06-02', 'Demoras frecuentes'),
(3, 3, 4, '2024-06-03', 'Buena atención al cliente'),
(4, 4, 2, '2024-06-04', 'Problemas con la facturación'),
(5, 5, 5, '2024-06-05', 'Excelente proveedor recomendado');

INSERT INTO unidades_medicas (unidad)
VALUES 
('mmHg'),
('bpm'),
('C°');

INSERT INTO parametros_medicos (revision_id, nombre, valor, unidad_id)
VALUES 
(1, 'Presión arterial', 120, 1),
(2, 'Frecuencia cardíaca', 80, 2),
(3, 'Temperatura', 37, 3),
(4, 'Presión arterial', 130, 1),
(5, 'Frecuencia cardíaca', 78, 2);

INSERT INTO empleado_departamento_historial (empleado_id, departamento_id, fecha_desde, fecha_hasta)
VALUES 
(1, 1, '2022-01-01', '2023-01-01'),
(1, 2, '2023-01-02', NULL),
(2, 1, '2021-05-15', '2022-12-31'),
(3, 3, '2022-03-10', NULL),
(4, 4, '2023-02-20', NULL);

INSERT INTO cursos (codigo, nombre, descripcion, horas_totales)
VALUES 
('CUR001', 'Seguridad laboral', 'Normas de seguridad e higiene en el trabajo', 40),
('CUR002', 'Primeros auxilios', 'Actuación ante emergencias médicas básicas', 20),
('CUR003', 'Ergonomía', 'Correctas posturas y técnicas de movimiento', 30),
('CUR004', 'Capacitación en maquinaria', 'Uso seguro de maquinaria industrial', 50),
('CUR005', 'Liderazgo', 'Desarrollo de habilidades de liderazgo', 35);


INSERT INTO empleado_curso (empleado_id, curso_id, fecha_inicio, fecha_fin, resultado)
VALUES 
(1, 1, '2024-01-10', '2024-02-10', 95),
(2, 2, '2024-02-15', '2024-03-15', 88),
(3, 3, '2024-03-01', NULL, NULL),
(4, 1, '2024-03-20', '2024-04-20', 90),
(5, 2, '2024-04-01', '2024-04-30', 92);