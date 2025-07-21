/*
 1. Listar todos los empleados con fecha de alta posterior 01/01/2021, de la provincia de
 Tucumán de la localidad S.M. de Tucumán y del departamento VENTAS. Se debe mostrar
 CUIL, NOMAPE, DIRECC, TELEFONO, EMAIL DEPARTAMENTO, FECHA_ALTA.
*/
SELECT 
    cuil,
    nombre, 
    apellido, 
    direccion_completa, 
    telefono, 
    email, 
    departamento, 
    fecha_alta 
    FROM vw_empleados 
    WHERE (DATE(fecha_alta) > '2021-01-01') AND (ciudad = 'San Miguel de Tucuman') AND (departamento='VENTAS');

/*
 2. Listar el libro único de haberes por número de liquidación generada, para la liquidación N°
 2023-01.
*/
SELECT * FROM libro_haberes WHERE periodo = 202301 ORDER BY (liquidacion_nro);

/*
 3. Listar todos los datos del grupo familiar del empleado con DNI 23156789.
 */
query3

/*
4. Listar el recibo de sueldo generado del empleado con DNI 23156789, de la liquidación N°
 2023-01
*/
SELECT * FROM libro_haberes WHERE (dni_empleado = '23156789') AND (periodo=202301);

/*
5. Mostrar los distintos sectores a los cuales perteneció el empleado con DNI 20.732.589.
 Indicar legajos, nomape, sector, fecha de ingreso, fecha de baja y mostrar cual es el sector
 actual al que pertenece
*/
SELECT * FROM historial_lugar_laboral_empleados WHERE (dni_empleado = '20732589');

/*
6. Listar todos los datos de los cursos que realizaron los empleados que pertenecen actualmente
 al sector TESORERIA, el Ultimo año.
*/
SELECT 
    ec.nombre_curso,
    ec.codigo_curso, 
    ec.descripcion_curso, 
    ec.documento_empleado, 
    ec.nombre_empleado,
    ec.cursa_desde,
    ec.cursa_hasta,
    ec.nota_final
FROM vw_empleados_cursos ec
JOIN empleados em ON em.dni = ec.documento_empleado
JOIN departamentos dep ON dep.departamento_id = em.departamento_id
WHERE (dep.nombre = 'TESORERIA') AND (YEAR(fecha_desde_real)=2025);

/*
7. Listar el stock de todos los artículos que se encuentran en el depósito 1. Mostrar solamente
 aquellos artículos que tengan existencia.
 */
 SELECT *
 FROM vw_stock_depositos 
 WHERE (almacen_id=1 AND stock_deposito > 0);

/*
 8. Listar todos los datos de los accidentes o incidentes que se produjeron en la empresa el
 último año.
 */
 SELECT 
    em.dni as dni_empleado,
    em.nombre as nombre_empleado,
    em.apellido as apellido_empleado,
    acc.*
FROM accidentes_laborales acc
JOIN empleados em ON acc.empleado_id = em.empleado_id
WHERE YEAR(acc.fecha_accidente) = 2025;

/*
9. Mostrar todos los datos de la última revisión médica del empelado con DNI 23156789,
 incluyendo todos los parámetros médicos tomados y/o registrados.
*/
SELECT * 
FROM vw_revisiones_medicas
WHERE dni_empleado='23156789'
ORDER BY fecha_revision DESC 
LIMIT 1;

/*
10. Mostrar el promedio de peso corporal de los últimos 3 años del empelado con DNI 20.732.589.
 Mostrar: Legajo, nomape, edad, sexo.
*/
SELECT 
rev.empleado_id,
rev.nombre_empleado,
em.edad,
ROUND(AVG(rev.valor),2) AS promedio_peso
FROM vw_revisiones_medicas rev
JOIN empleados em ON rev.empleado_id = em.empleado_id
WHERE rev.parametro_medico = 'Peso'
 AND rev.fecha_revision >= DATE_SUB(CURDATE(), INTERVAL 3 YEAR)
GROUP BY rev.empleado_id, rev.nombre_empleado, em.edad;

/*
12. Listar todas las Facturas de Ventas cuyo importe bruto sea mayor a $150.000 Se debe
 mostrar: N° FACTURA, FECHA DE COMPRA, BRUTO TOTAL, NETO TOTAL, IVA,
 CANTIDAD, PRECIO UNITARIO, DESCRIPCION, RAZON SOCIAL DEL PROVEEDOR.
*/
SELECT
    fac.numero_factura as N°_factura,
    fac.fecha_factura as fecha_compra,
    det.cantidad as detalle_cantidad,
    det.precio_unitario as detalle_precio_producto,
    prod.descripcion as producto_descripcion,
    fcb.bruto_factura,
    ROUND(SUM(det.total_linea), 2) as factura_neto_total,
    ROUND(SUM(det.total_linea * 0.21)) as factura_iva,
    fac.razon_social
FROM vw_facturas fac
JOIN (
    SELECT 
    d.factura_id,
    ROUND(SUM(d.cantidad * d.precio_unitario),2) as bruto_factura
    FROM detalle_facturas d
    GROUP BY d.factura_id
    HAVING (SUM(d.cantidad * d.precio_unitario) > 150000)
) AS fcb ON fac.factura_id = fcb.factura_id
JOIN detalle_facturas det ON fac.factura_id = det.factura_id
JOIN productos prod ON det.producto_id = prod.producto_id
GROUP BY fac.numero_factura, fac.fecha_factura, det.cantidad, det.precio_unitario,
 prod.descripcion, fcb.bruto_factura, fac.razon_social
 ORDER BY fac.numero_factura;


/*
 14. Generar un reporte consolidado de todos los depósitos que muestre la valoración de los
 stocks existente a la fecha actual, para los artículos comprendidos entre los códigos 0001
 y 1100. Se debe contemplar la valorización por cada artículo en cada depósito y un total
 general de la valoración de todos los depósitos. Se debe mostrar: CODIGO, DESCRIP
CION DEL ARTICULO, STOCK, NOMBRE DEL DEPOSITO, COSTO UNITARIO y
 VALORACION.
 */
 SELECT
    prod.producto_id,
    prod.descripcion as producto_descripcion,
    st.cantidad as stock_producto_almacen,
    prod.precio_unitario as precio_producto,
    ROUND((st.cantidad * prod.precio_unitario),2) as valoracion_producto_deposito,
    SUM()
