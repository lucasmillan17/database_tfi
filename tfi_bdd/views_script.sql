CREATE VIEW vw_direcciones AS
SELECT
    dir.direccion_id,
    ciu.nombre as ciudad,
    prov.nombre as provincia,
    pais.nombre as pais,
    CONCAT(dir.calle, ' ', dir.numero, 
         IF(dir.piso IS NOT NULL, CONCAT(', Piso ', dir.piso), ''),
         IF(dir.depto IS NOT NULL, CONCAT(', Depto ', dir.depto), ''),
         IF(ciu.nombre IS NOT NULL, CONCAT(', ', ciu.nombre), ''),
         IF(prov.nombre IS NOT NULL, CONCAT(', ', prov.nombre), ''),
         IF(pais.nombre IS NOT NULL, CONCAT(', ', pais.nombre), '')
  ) AS direccion_completa
FROM direcciones dir
JOIN ciudades ciu ON dir.ciudad_id=ciu.ciudad_id
JOIN provincias prov ON dir.provincia_id=prov.provincia_id
JOIN paises pais ON dir.pais_id=pais.pais_id;

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
    dir.ciudad,
    dir.provincia,
    dir.pais,
    dir.direccion_completa
FROM empleados em 
JOIN tipo_empleados tipoem ON em.tipo_empleado_id=tipoem.tipo_empleado_id
JOIN departamentos dep ON em.departamento_id=dep.departamento_id
JOIN sucursales suc ON em.sucursal_id=suc.sucursal_id
JOIN vw_direcciones dir ON em.direccion_id=dir.direccion_id; 

CREATE VIEW vw_facturas AS
SELECT
    fac.numero_factura,
    fac.tipo_factura,
    fac.fecha_factura,
    fac.total,
    est.estado,
    cl.cuil as cuil_cliente,
    cl.razon_social,
    em.empleado_id as empleado_n°,
    em.nombre as nombre_empleado,
    suc.nombre as sucursal,
    fac.factura_id
FROM facturas fac 
JOIN estado_facturas est ON fac.estado_id=est.estado_id
JOIN clientes cl ON fac.cliente_id=cl.cliente_id
JOIN empleados em ON fac.empleado_id=em.empleado_id
JOIN sucursales suc ON fac.sucursal_id=suc.sucursal_id;

CREATE VIEW libro_haberes AS
SELECT
    liq.codigo as liquidacion_nro,
    em.empleado_id as nro_empleado,
    em.dni as dni_empleado,
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
    em.dni as dni_empleado,
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

CREATE VIEW vw_empleados_cursos AS
SELECT
    cur.nombre as nombre_curso,
    cur.codigo as codigo_curso,
    cur.descripcion as descripcion_curso,
    em.dni as documento_empleado,
    CONCAT(em.apellido, ', ', em.nombre) as nombre_empleado,
    DATE_FORMAT(asi.fecha_inicio, '%d/%m/%Y') as cursa_desde,
    CASE
    WHEN asi.fecha_fin IS NULL THEN 'CURSA'
    ELSE DATE_FORMAT(asi.fecha_fin, '%d/%m/%Y')
    END AS cursa_hasta,
    asi.resultado as nota_final,

    -- datos para comparaciones

    asi.fecha_inicio as fecha_inicio_real,
    asi.fecha_fin as fecha_fin_real
    
FROM empleado_curso asi
JOIN cursos cur ON asi.curso_id = cur.curso_id
JOIN empleados em ON asi.empleado_id = em.empleado_id;

CREATE VIEW vw_stock_depositos AS
SELECT
    st.producto_id,
    pro.nombre as nombre_producto,
    st.almacen_id,
    alm.nombre as nombre_deposito,
    dir.ciudad,
    dir.provincia,
    dir.pais,
    dir.direccion_completa,
    st.cantidad as stock_deposito
FROM stocks st
JOIN productos pro ON st.producto_id=pro.producto_id
JOIN almacenes alm ON st.almacen_id=alm.almacen_id
JOIN vw_direcciones dir ON alm.direccion_id=dir.direccion_id;

CREATE VIEW vw_revisiones_medicas AS
SELECT
    rev.revision_id,
    em.empleado_id,
    em.dni as dni_empleado,
    CONCAT(em.apellido, ', ', em.nombre) as nombre_empleado,
    rev.fecha_revision,
    rev.observaciones,
    pm.nombre as parametro_medico,
    un.unidad,
    pm.valor
FROM revisiones_medicas rev
JOIN parametros_medicos pm ON rev.revision_id = pm.revision_id
JOIN unidades_medicas un ON pm.unidad_id = un.unidad_id
JOIN empleados em ON rev.empleado_id = em.empleado_id;

CREATE VIEW vw_personas AS
SELECT per.*, dir.direccion_completa
FROM personas per
JOIN vw_direcciones dir ON per.direccion_id = dir.direccion_id;

CREATE VIEW vw_clientes AS
SELECT
    cl.cliente_id,
    cl.cuil,
    cl.razon_social,
    cl.telefono,
    cl.email,
    cl.credito,
    cl.fecha_alta,
    dir.ciudad,
    dir.provincia,
    dir.pais,
    dir.direccion_completa,
    ru.nombre AS rubro,
    rk.ranking,
    rk.comentarios,
    rk.fecha_ranking
FROM clientes cl
JOIN vw_direcciones dir ON cl.direccion_id = dir.direccion_id
JOIN cliente_rubro cr ON cl.cliente_id = cr.cliente_id
JOIN rubros ru ON cr.rubro_id = ru.rubro_id
LEFT JOIN ranking_cliente rk ON cl.cliente_id = rk.cliente_id;
