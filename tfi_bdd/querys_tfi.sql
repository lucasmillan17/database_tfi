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

SELECT * FROM libro_haberes WHERE periodo = 202301 ORDER BY (liquidacion_nro);

query3

SELECT * FROM libro_haberes WHERE (dni_empleado = '23156789') AND (periodo=202301);

SELECT * FROM historial_lugar_laboral_empleados WHERE (dni_empleado = '20732589');

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