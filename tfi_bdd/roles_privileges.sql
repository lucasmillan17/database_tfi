-- Crear roles
CREATE ROLE IF NOT EXISTS 'stock';
CREATE ROLE IF NOT EXISTS 'ventas';
CREATE ROLE IF NOT EXISTS 'compras';
CREATE ROLE IF NOT EXISTS 'rrhh';

-- Permitir que los roles vean la base y su estructura
GRANT USAGE ON tfi_bdd.* TO 'stock', 'ventas', 'compras', 'rrhh';

-- Permisos de soporte de direcciones para todos los roles
GRANT SELECT ON tfi_bdd.direcciones TO 'stock', 'ventas', 'compras', 'rrhh';
GRANT SELECT ON tfi_bdd.paises TO 'stock', 'ventas', 'compras', 'rrhh';
GRANT SELECT ON tfi_bdd.provincias TO 'stock', 'ventas', 'compras', 'rrhh';
GRANT SELECT ON tfi_bdd.ciudades TO 'stock', 'ventas', 'compras', 'rrhh';
GRANT SELECT ON tfi_bdd.codigos_postales TO 'stock', 'ventas', 'compras', 'rrhh';

-- Permisos para el rol STOCK
GRANT SELECT, INSERT, UPDATE ON tfi_bdd.productos TO 'stock';
GRANT SELECT, INSERT, UPDATE ON tfi_bdd.stocks TO 'stock';
GRANT SELECT, INSERT, UPDATE ON tfi_bdd.almacenes TO 'stock';
GRANT SELECT ON tfi_bdd.proveedores TO 'stock';
GRANT SELECT ON tfi_bdd.sucursales TO 'stock';
GRANT SELECT ON tfi_bdd.rubros TO 'stock';
GRANT SELECT ON tfi_bdd.categoria_productos TO 'stock';
GRANT SELECT ON tfi_bdd.unidades_medida TO 'stock';

-- Vistas para STOCK
GRANT SELECT ON tfi_bdd.vw_direcciones TO 'stock';
GRANT SELECT ON tfi_bdd.vw_stock_depositos TO 'stock';

-- Permisos para el rol VENTAS
GRANT SELECT, INSERT, UPDATE ON tfi_bdd.clientes TO 'ventas';
GRANT SELECT, INSERT, UPDATE ON tfi_bdd.facturas TO 'ventas';
GRANT SELECT, INSERT, UPDATE ON tfi_bdd.detalle_facturas TO 'ventas';
GRANT SELECT, INSERT, UPDATE ON tfi_bdd.remitos_clientes TO 'ventas';
GRANT SELECT, INSERT, UPDATE ON tfi_bdd.detalle_remitos_clientes TO 'ventas';
GRANT SELECT, INSERT, UPDATE ON tfi_bdd.recibos TO 'ventas';
GRANT SELECT, INSERT, UPDATE ON tfi_bdd.detalle_recibos TO 'ventas';
GRANT SELECT, INSERT, UPDATE ON tfi_bdd.pagos TO 'ventas';
GRANT SELECT ON tfi_bdd.productos TO 'ventas';
GRANT SELECT ON tfi_bdd.sucursales TO 'ventas';
GRANT SELECT ON tfi_bdd.empleados TO 'ventas';
GRANT SELECT ON tfi_bdd.condiciones_pagos TO 'ventas';
GRANT SELECT ON tfi_bdd.medios_pagos TO 'ventas';

-- Vistas para VENTAS
GRANT SELECT ON tfi_bdd.vw_direcciones TO 'ventas';
GRANT SELECT ON tfi_bdd.vw_facturas TO 'ventas';
GRANT SELECT ON tfi_bdd.vw_clientes TO 'ventas';
GRANT SELECT ON tfi_bdd.vw_empleados TO 'ventas';
GRANT SELECT ON tfi_bdd.vw_personas TO 'ventas';

-- Permisos para el rol COMPRAS
GRANT SELECT, INSERT, UPDATE ON tfi_bdd.proveedores TO 'compras';
GRANT SELECT, INSERT, UPDATE ON tfi_bdd.orden_compras TO 'compras';
GRANT SELECT, INSERT, UPDATE ON tfi_bdd.detalle_orden_compras TO 'compras';
GRANT SELECT, INSERT, UPDATE ON tfi_bdd.facturas_compras TO 'compras';
GRANT SELECT, INSERT, UPDATE ON tfi_bdd.detalle_facturas_compras TO 'compras';
GRANT SELECT, INSERT, UPDATE ON tfi_bdd.remitos TO 'compras';
GRANT SELECT, INSERT, UPDATE ON tfi_bdd.detalle_remitos TO 'compras';
GRANT SELECT, INSERT, UPDATE ON tfi_bdd.producto_proveedor TO 'compras';
GRANT SELECT, INSERT, UPDATE ON tfi_bdd.ranking_cliente TO 'compras';
GRANT SELECT ON tfi_bdd.productos TO 'compras';
GRANT SELECT ON tfi_bdd.sucursales TO 'compras';
GRANT SELECT ON tfi_bdd.empleados TO 'compras';
GRANT SELECT ON tfi_bdd.departamentos TO 'compras';
GRANT SELECT ON tfi_bdd.condiciones_pagos TO 'compras';
GRANT SELECT ON tfi_bdd.rubros TO 'compras';

-- Vistas para COMPRAS
GRANT SELECT ON tfi_bdd.vw_direcciones TO 'compras';
GRANT SELECT ON tfi_bdd.vw_facturas TO 'compras';
GRANT SELECT ON tfi_bdd.vw_empleados TO 'compras';
GRANT SELECT ON tfi_bdd.vw_personas TO 'compras';

-- Permisos para el rol RRHH
GRANT SELECT, INSERT, UPDATE ON tfi_bdd.empleados TO 'rrhh';
GRANT SELECT, INSERT, UPDATE ON tfi_bdd.personas TO 'rrhh';
GRANT SELECT, INSERT, UPDATE ON tfi_bdd.grupo_familiares TO 'rrhh';
GRANT SELECT, INSERT, UPDATE ON tfi_bdd.grupo_familiares_personas TO 'rrhh';
GRANT SELECT, INSERT, UPDATE ON tfi_bdd.parentezcos TO 'rrhh';
GRANT SELECT, INSERT, UPDATE ON tfi_bdd.departamentos TO 'rrhh';
GRANT SELECT, INSERT, UPDATE ON tfi_bdd.tipo_empleados TO 'rrhh';
GRANT SELECT, INSERT, UPDATE ON tfi_bdd.empleado_departamento_historial TO 'rrhh';
GRANT SELECT, INSERT, UPDATE ON tfi_bdd.cursos TO 'rrhh';
GRANT SELECT, INSERT, UPDATE ON tfi_bdd.empleado_curso TO 'rrhh';
GRANT SELECT, INSERT, UPDATE ON tfi_bdd.accidentes_laborales TO 'rrhh';
GRANT SELECT, INSERT, UPDATE ON tfi_bdd.tratamientos TO 'rrhh';
GRANT SELECT, INSERT, UPDATE ON tfi_bdd.revisiones_medicas TO 'rrhh';
GRANT SELECT, INSERT, UPDATE ON tfi_bdd.parametros_medicos TO 'rrhh';
GRANT SELECT, INSERT, UPDATE ON tfi_bdd.lugares_accidentes TO 'rrhh';
GRANT SELECT, INSERT, UPDATE ON tfi_bdd.diagnosticos TO 'rrhh';
GRANT SELECT, INSERT, UPDATE ON tfi_bdd.unidades_medicas TO 'rrhh';
GRANT SELECT, INSERT, UPDATE ON tfi_bdd.liquidaciones_sueldo TO 'rrhh';
GRANT SELECT, INSERT, UPDATE ON tfi_bdd.detalle_liquidaciones TO 'rrhh';
GRANT SELECT, INSERT, UPDATE ON tfi_bdd.conceptos TO 'rrhh';
GRANT SELECT ON tfi_bdd.sucursales TO 'rrhh';

-- Vistas para RRHH
GRANT SELECT ON tfi_bdd.vw_direcciones TO 'rrhh';
GRANT SELECT ON tfi_bdd.vw_empleados TO 'rrhh';
GRANT SELECT ON tfi_bdd.libro_haberes TO 'rrhh';
GRANT SELECT ON tfi_bdd.historial_lugar_laboral_empleados TO 'rrhh';
GRANT SELECT ON tfi_bdd.vw_empleados_cursos TO 'rrhh';
GRANT SELECT ON tfi_bdd.vw_revisiones_medicas TO 'rrhh';
GRANT SELECT ON tfi_bdd.vw_personas TO 'rrhh';

-- Nota: No se otorgan permisos DELETE a ningún rol aquí.