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
SELECT 
    gf.grupo_familiar_id,
    gf.descripcion,
    em.empleado_dni,
    par.parentezco,
    per.*
FROM grupo_familiares gf
JOIN empleados em ON gf.empleado_id = em.empleado_dni
JOIN grupo_familiares_personas gpf ON gf.grupo_familiar_id = gpf.grupo_familiar_id
JOIN parentezcos par ON gpf.parentezco_id = par.parentezco_id
JOIN personas per ON gpf.persona_id = per.persona_id
    WHERE em.empleado_dni = '23156789';

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
11. Listar todos los clientes con fecha de alta posterior 01/01/2021, de la provincia de Tucumán
de la localidad S.M. de Tucumán y del rubro Çaños para agua". Se debe mostrar CUIT,
RAZSOC, DIRECCION, TELEFONO, MAIL, CREDITO, RANKING.
*/
SELECT *
FROM vw_clientes
WHERE fecha_alta > '2021-01-01'
  AND provincia = 'Tucumán'
  AND ciudad = 'S.M. de Tucumán'
  AND rubro = 'Caños para agua';

/*
13 .Listar los artículos que tienen Stock mayor a 1000 de los rubros cementos, pegamentos
y electricidad. Se debe mostrar CODIGO, DESCRIPCION DEL ARTICULO, NOMBRE
DEL DEPOSITO, DOMICILIO DEL DEPOSITO Y STOCK DE SEGURIDAD.
*/
SELECT 
    pro.codigo_barra AS CODIGO,
    pro.descripcion AS DESCRIPCION,
    alm.nombre AS NOMBRE_DEPOSITO,
    dir.direccion_completa AS DOMICILIO_DEPOSITO,
    st.stock_minimo AS STOCK_SEGURIDAD,
    st.cantidad AS STOCK_ACTUAL
FROM stocks st
JOIN productos pro ON st.producto_id = pro.producto_id
JOIN rubros ru ON pro.rubro_id = ru.rubro_id
JOIN almacenes alm ON st.almacen_id = alm.almacen_id
JOIN vw_direcciones dir ON alm.direccion_id = dir.direccion_id
WHERE st.cantidad > 1000
  AND ru.nombre IN ('Cementos', 'Pegamentos', 'Electricidad');

/*
15. Mostrar el monto total de ventas realizadas por la sucursal CENTRO en el último trimestre.
*/
SELECT 
    SUM(fac.total) AS TOTAL_VENTAS
FROM facturas fac
JOIN sucursales suc ON fac.sucursal_id = suc.sucursal_id
WHERE suc.nombre = 'Centro'
  AND fac.fecha_factura >= DATE_SUB(CURDATE(), INTERVAL 3 MONTH);

/*
16. Mostrar los detalles de las entregas de mercadería de un número de factura de venta en
particular.
*/
--No devuelve nada
SELECT 
    f.numero_factura,
    rc.remito_cliente_id,
    rc.fecha_remito,
    p.producto_id,
    p.nombre AS producto,
    drc.cantidad
FROM facturas f
JOIN remitos_clientes rc ON f.factura_id = rc.factura_id
JOIN detalle_remitos_clientes drc ON rc.remito_cliente_id = drc.remito_cliente_id
JOIN productos p ON drc.producto_id = p.producto_id
WHERE f.numero_factura = 1;

/*
17. Obtener la cantidad total de un artículo vendido en todas las facturas de ventas.
*/

SELECT 
    pro.nombre AS PRODUCTO,
    SUM(df.cantidad) AS TOTAL_VENDIDO
FROM detalle_facturas df
JOIN productos pro ON df.producto_id = pro.producto_id
WHERE df.producto_id = 1;

/*
18. Consulta 08: Obtener la lista de clientes que compraron en la sucursal yerba buena.
*/

SELECT DISTINCT
    c.cliente_id,
    c.razon_social,
    c.cuil,
    c.email,
    c.telefono
FROM facturas f
JOIN sucursales s ON f.sucursal_id = s.sucursal_id
JOIN clientes c ON f.cliente_id = c.cliente_id
WHERE s.nombre = 'Yerba Buena';

/*
19. Mostrar el precio promedio total de las ventas del segundo cuatrimestre de las sucursales
CENTRO y YERBA BUENA.
*/

SELECT 
    suc.nombre AS SUCURSAL,
    AVG(df.precio_unitario * df.cantidad) AS PRECIO_PROMEDIO_TOTAL
FROM detalle_facturas df
JOIN facturas fac ON df.factura_id = fac.factura_id
JOIN sucursales suc ON fac.sucursal_id = suc.sucursal_id
WHERE suc.nombre IN ('Centro', 'Yerba Buena')
  AND MONTH(fac.fecha_factura) BETWEEN 5 AND 8
GROUP BY suc.nombre;

/*
20. Mostrar las facturas de ventas donde la condición de pago de la misma sea "Tarjeta de
crédito Visa".
*/

SELECT 
    f.numero_factura,
    f.fecha_factura,
    f.total,
    cp.condicion_pago
FROM facturas f
JOIN condiciones_pagos cp ON f.condicion_pago_id = cp.condicion_pago_id
WHERE cp.condicion_pago = 'Tarjeta de credito Visa';

/*
21. Mostrar un ranking de ventas por empleado ordenados de mayor a menor el último año.
Mostrar Legajo, nomape, edad, monto de venta (tomar neto de facturas).
*/

SELECT 
    f.empleado_id AS legajo,
    CONCAT(e.nombre, ' ', e.apellido) AS nomape,
    TIMESTAMPDIFF(YEAR, e.fecha_nacimiento, CURDATE()) AS edad,
    SUM(f.total) AS monto_ventas
FROM facturas f
JOIN empleados e ON f.empleado_id = e.empleado_id
WHERE f.fecha_factura BETWEEN '2025-01-01' AND '2025-12-31'
GROUP BY f.empleado_id, e.nombre, e.apellido, e.fecha_nacimiento
ORDER BY monto_ventas DESC;

/*
22. Listar todos los proveedores con fecha de alta posterior 01/01/2021, de la provincia de
Tucumán de la localidad S.M. de Tucumán y del rubro Çaños para agua. Se debe mostrar
CUIT, RAZON_SOCIAL, DIRECC, TELEFONO, EMAIL, CREDITO, RANKING.
*/

SELECT 
    p.cuit,
    p.razon_social,
    d.direccion_completa AS direccion,
    p.telefono,
    p.email,
    p.credito
FROM proveedores p
JOIN vw_direcciones d ON p.direccion_id = d.direccion_id
JOIN rubros r ON p.rubro_id = r.rubro_id
WHERE p.fecha_alta > '2021-01-01'
  AND d.provincia = 'Tucumán'
  AND d.ciudad = 'S.M. de Tucumán'
  AND r.nombre = 'Caños para agua';

/*
23. Listar todas las Facturas de Compras cuyo importe bruto sea mayor a $150.000 Se debe
mostrar: N° FACTURA, FECHA DE COMPRA, BRUTO TOTAL, NETO TOTAL,
IVA, CANT COMPRADA, PRECIO UNITARIO, DESCRIPCION, RAZON_SOCIAL
DEL PROVEEDOR.
*/
-- Tiene fallas hay que corregir
SELECT 
    fc.numero_factura AS nro_factura,
    fc.fecha_factura,
    SUM(dfc.cantidad * dfc.precio_unitario) AS bruto_total,
    fc.total AS neto_total,
    -- Aqui le puse que se calcula el iva asi, para no agregar nada, eso si, si hay algun otro descuento o algo hay que modificar
    (SUM(dfc.cantidad * dfc.precio_unitario) - fc.total) AS iva,
    dfc.cantidad,
    dfc.precio_unitario,
    p.nombre AS descripcion,
    pr.razon_social
FROM facturas_compras fc
JOIN detalle_facturas_compras dfc ON fc.factura_compra_id = dfc.factura_compra_id
JOIN productos p ON dfc.producto_id = p.producto_id
JOIN proveedores pr ON fc.proveedor_id = pr.proveedor_id
GROUP BY fc.factura_compra_id
HAVING bruto_total > 150000;

/*
24. Listar los artículos que tienen Stock mayor a 1000 de los rubros cementos, pegamentos
y electricidad. Se debe mostrar CODIGO, DESCRIPCION DEL ARTICULO, NOMBRE
DEL DEPOSITO, DOMICILIO DEL DEPOSITO, STOCK.

*/

SELECT 
    p.producto_id AS codigo,
    p.nombre AS descripcion_del_articulo,
    a.nombre AS nombre_del_deposito,
    d.direccion_completa AS domicilio_del_deposito,
    s.cantidad AS stock
FROM stocks s
JOIN productos p ON s.producto_id = p.producto_id
JOIN almacenes a ON s.almacen_id = a.almacen_id
JOIN vw_direcciones d ON a.direccion_id = d.direccion_id
JOIN rubros r ON p.rubro_id = r.rubro_id
WHERE s.cantidad > 1000
  AND r.nombre IN ('Cementos', 'Pegamentos', 'Electricidad');

/*
25. Generar un reporte consolidado de todos los depósitos que muestre la valoración de los
stocks existente a la fecha actual, para los artículos comprendidos entre los códigos 0001
y 1100. Se debe contemplar la valorización por cada artículo en cada depósito y un total
general de la valoración de todos los depósitos. Se debe mostrar: CODIGO, DESCRIPCION
DEL ARTICULO. STOCK, NOMBRE DEL DEPOSITO, COSTO UNITARIO y
VALORACION.
*/

/*
26. Listar el importe total comprado entre el 1-ene-2024 y el 31-dic-2024, agrupado por el
departamento que realizó la solicitud (campo orden_compras.departamento_id).
*/

SELECT 
    oc.departamento_id,
    d.nombre AS nombre_departamento,
    SUM(fc.total) AS total_comprado
FROM facturas_compras fc
JOIN orden_compras oc ON fc.orden_compra_id = oc.orden_compra_id
JOIN departamentos d ON oc.departamento_id = d.departamento_id
WHERE fc.fecha_factura BETWEEN '2024-01-01' AND '2024-12-31'
GROUP BY oc.departamento_id, d.nombre;

/*
27. Mostrar las órdenes de compra que aún no han sido finalizadas y su estado actual.
*/

SELECT 
    oc.orden_compra_id,
    oc.fecha_orden,
    ec.estado
FROM orden_compras oc
JOIN estados_compras ec ON oc.estado_id = ec.estado_id
WHERE ec.estado <> 'Recibida';

/*
28. Mostrar, para la orden de compra N.º :oc_id, la cantidad recepcionada en cada remito y
el saldo pendiente por producto.
*/

SELECT 
    p.producto_id,
    p.nombre AS producto,
    r.fecha_remito,
    dr.cantidad AS cantidad_recepcionada,
    (doc.cantidad - dr.cantidad) AS saldo_pendiente
FROM orden_compras oc
JOIN detalle_orden_compras doc ON oc.orden_compra_id = doc.orden_compra_id
JOIN productos p ON doc.producto_id = p.producto_id
JOIN remitos r ON r.orden_compra_id = oc.orden_compra_id
JOIN detalle_remitos dr ON r.remito_id = dr.remito_id AND dr.producto_id = doc.producto_id
WHERE oc.orden_compra_id = 1;

/*
29. Listar todos los pedidos pendientes y su fecha de emisión.
*/

SELECT 
    rc.remito_cliente_id,
    rc.fecha_remito,
    f.numero_factura,
    c.razon_social
FROM remitos_clientes rc
JOIN facturas f ON rc.factura_id = f.factura_id
JOIN clientes c ON rc.cliente_id = c.cliente_id
WHERE f.estado_id <> (
    SELECT estado_id FROM estado_facturas WHERE estado = 'Pagada'
);

/*
30. Para la orden de compra N.º :oc_id, indicar la fecha de cada remito, la cantidad ingresada
y el porcentaje acumulado sobre la cantidad solicitada.
*/

SELECT 
    r.fecha_remito,
    dr.cantidad AS cantidad_ingresada,
    ROUND(
        100 * dr.cantidad / (
            SELECT SUM(cantidad)
            FROM detalle_orden_compras
            WHERE orden_compra_id = r.orden_compra_id
        ), 2
    ) AS porcentaje_acumulado
FROM remitos r
JOIN detalle_remitos dr ON r.remito_id = dr.remito_id
WHERE r.orden_compra_id = 1;

/*
31. Mostrar la lista de cotizaciones con su precio cotizado para un pedido especifico.
*/

SELECT 
    co.orden_compra_id,
    cot.cotizacion_id,
    cot.precio_total
FROM cotizacion_orden co
JOIN cotizaciones cot ON co.cotizacion_id = cot.cotizacion_id
WHERE co.orden_compra_id = 1;

/*
32. Obtener la lista de proveedores que han presentado una cotización para un pedido especifico.
*/

SELECT DISTINCT
    cot.cotizacion_id,
    p.proveedor_id,
    p.razon_social
FROM cotizacion_orden co
JOIN cotizaciones cot ON co.cotizacion_id = cot.cotizacion_id
JOIN detalle_cotizaciones dc ON cot.cotizacion_id = dc.cotizacion_id
JOIN producto_proveedor pp ON dc.producto_id = pp.producto_id
JOIN proveedores p ON pp.proveedor_id = p.proveedor_id
WHERE co.orden_compra_id = 1;

/*
33. Mostrar el precio promedio total de las cotizaciones presentadas para un pedido especifico.
*/

SELECT 
    co.orden_compra_id,
    AVG(cot.precio_total) AS precio_promedio
FROM cotizacion_orden co
JOIN cotizaciones cot ON co.cotizacion_id = cot.cotizacion_id
WHERE co.orden_compra_id = 1
GROUP BY co.orden_compra_id;

/*
34. Obtener el proveedor que ha presentado la cotización más baja para un pedido especifico.
*/

SELECT 
    p.proveedor_id,
    p.razon_social,
    cot.cotizacion_id,
    cot.precio_total
FROM cotizacion_orden co
JOIN cotizaciones cot ON co.cotizacion_id = cot.cotizacion_id
JOIN detalle_cotizaciones dc ON cot.cotizacion_id = dc.cotizacion_id
JOIN producto_proveedor pp ON dc.producto_id = pp.producto_id
JOIN proveedores p ON pp.proveedor_id = p.proveedor_id
WHERE co.orden_compra_id = 1 
ORDER BY cot.precio_total ASC
LIMIT 1;

/*
35. Mostrar el estado actual de un pedido de compra específico.
*/

SELECT 
    oc.orden_compra_id,
    ec.estado
FROM orden_compras oc
JOIN estados_compras ec ON oc.estado_id = ec.estado_id
WHERE oc.orden_compra_id = 1;

/*
36. Mostrar la cotización seleccionada para un pedido especifico.
*/

SELECT 
    cot.cotizacion_id,
    cot.precio_total,
    cot.fecha_cotizacion,
    p.proveedor_id,
    p.razon_social
FROM cotizacion_orden co
JOIN cotizaciones cot ON co.cotizacion_id = cot.cotizacion_id
JOIN detalle_cotizaciones dc ON cot.cotizacion_id = dc.cotizacion_id
JOIN producto_proveedor pp ON dc.producto_id = pp.producto_id
JOIN proveedores p ON pp.proveedor_id = p.proveedor_id
WHERE co.orden_compra_id = 1
  AND co.ganadora = true;

/*
37. Mostrar las órdenes de compra donde la condición de pago de la misma sea .e-cheq"(cheque
electrónico).
*/

SELECT 
    oc.orden_compra_id,
    oc.fecha_orden,
    cp.condicion_pago
FROM orden_compras oc
JOIN condiciones_pagos cp ON oc.condicion_pago_id = cp.condicion_pago_id
WHERE cp.condicion_pago = 'Cheque electronico';

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
    fcb.factura_neto_total,
    fcb.factura_iva,
    fac.razon_social
FROM vw_facturas fac
JOIN (
    SELECT 
    d.factura_id,
    ROUND(SUM(d.cantidad * d.precio_unitario),2) as bruto_factura,
    ROUND(SUM(d.total_linea), 2) as factura_neto_total,
    ROUND(SUM(d.total_linea * 0.21)) as factura_iva
    FROM detalle_facturas d
    GROUP BY d.factura_id
    HAVING (SUM(d.cantidad * d.precio_unitario) > 150000)
) AS fcb ON fac.factura_id = fcb.factura_id
JOIN detalle_facturas det ON fac.factura_id = det.factura_id
JOIN productos prod ON det.producto_id = prod.producto_id
GROUP BY fac.numero_factura, fac.fecha_factura, det.cantidad, det.precio_unitario,
 prod.descripcion, fcb.bruto_factura, fcb.factura_neto_total, fcb.factura_iva, fac.razon_social
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
    prod.descripcion AS producto_descripcion,
    st.cantidad AS stock_producto_almacen,
    prod.precio_unitario AS precio_producto,
    alm.nombre AS nombre_almacen,
    ROUND((st.cantidad * prod.precio_unitario), 2) AS valoracion_producto_deposito,
    (
        SELECT ROUND(SUM(st2.cantidad * prod2.precio_unitario), 2)
        FROM stocks st2
        JOIN productos prod2 ON st2.producto_id = prod2.producto_id
        WHERE st2.almacen_id = st.almacen_id
            AND st2.producto_id BETWEEN 1 AND 1100
    ) AS valoracion_total_almacen
FROM stocks st
JOIN productos prod ON st.producto_id = prod.producto_id
JOIN almacenes alm ON st.almacen_id = alm.almacen_id
WHERE st.producto_id BETWEEN 1 AND 1100
ORDER BY alm.nombre;