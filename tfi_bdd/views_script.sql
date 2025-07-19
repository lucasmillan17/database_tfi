CREATE VIEW vw_empleados AS 
SELECT 
    em.nombre,
    em.apellido,
    em.dni,
    em.cuil,
    em.fecha_nacimiento,
    em.fecha_alta,
    em.email,
    em.telefono,
    tipoem.nombre as tipo_empleado,
    dep.nombre as departamento,
    suc.nombre as sucursal,
    CONCAT(dir.calle, ' ', dir.numero, 
         IF(dir.piso IS NOT NULL, CONCAT(', Piso ', dir.piso), ''),
         IF(dir.depto IS NOT NULL, CONCAT(', Depto ', dir.depto), ''),
         IF(ciu.nombre IS NOT NULL, CONCAT(', ', ciu.nombre), ''),
         IF(prov.nombre IS NOT NULL, CONCAT(', ', prov.nombre), ''),
         IF(pais.nombre IS NOT NULL, CONCAT(', ', pais.nombre), '')
  ) AS direccion_completa
FROM empleados em 
JOIN tipo_empleados tipoem ON em.tipo_empleado_id=tipoem.tipo_empleado_id
JOIN departamentos dep ON em.departamento_id=dep.departamento_id
JOIN sucursales suc ON em.sucursal_id=suc.sucursal_id
JOIN direcciones dir ON em.direccion_id=dir.direccion_id
JOIN ciudades ciu ON dir.ciudad_id=ciu.ciudad_id
JOIN provincias prov ON dir.provincia_id=prov.provincia_id
JOIN paises pais ON dir.pais_id=pais.pais_id;

CREATE VIEW vw_facturas AS
SELECT
    fac.numero_factura,
    fac.tipo_factura,
    fac.fecha_factura,
    fac.total,
    est.estado,
    cl.cuil as cuil_cliente,
    em.empleado_id as empleado_n°,
    em.nombre as nombre_empleado,
    suc.nombre as sucursal
FROM facturas fac 
JOIN estado_facturas est ON fac.estado_id=est.estado_id
JOIN clientes cl ON fac.cliente_id=cl.cliente_id
JOIN empleados em ON fac.empleado_id=em.empleado_id
JOIN sucursales suc ON fac.sucursal_id=suc.sucursal_id;

CREATE VIEW libro_haberes AS
SELECT
    liq.codigo as liquidacion_nro,
    em.empleado_id as nro_empleado,
    CONCAT(em.apellido, ', ', em.nombre) as nombre_empleado,
    liq.periodo,
    liq.fecha_pago,
    liq.total_bruto,
    liq.total_deducciones,
    liq.total_neto
FROM liquidaciones_sueldo liq
JOIN empleados em ON liq.empleado_id=em.empleado_id;

CREATE VIEW historial_lugar_laboral_empleados AS
SELECT
    em.dni as documento_empleado,
    CONCAT(em.apellido, ', ', em.nombre) as nombre_empleado,
    suc.nombre as sucursal,
    dep.nombre as departamento,
    DATE_FORMAT(his.fecha_desde, '%d/%m/%Y') as desde,
    CASE
    WHEN his.fecha_hasta IS NULL THEN 'ACTUAL'
    ELSE DATE_FORMAT(his.fecha_hasta, '%d/%m/%Y')
    END AS hasta
FROM empleado_departamento_historial his
JOIN empleados em ON his.empleado_id = em.empleado_id
JOIN departamentos dep ON his.departamento_id = dep.departamento_id
JOIN sucursales suc ON dep.sucursal_id = suc.sucursal_id;


