DELIMITER //

CREATE TRIGGER actualizar_total_factura_insert
AFTER INSERT ON detalle_facturas
FOR EACH ROW
BEGIN
    UPDATE facturas 
    SET total = (
        SELECT SUM(cantidad * precio_unitario)
        FROM detalle_facturas
        WHERE factura_id = NEW.factura_id
    )
    WHERE factura_id = NEW.factura_id;
END;
//

DELIMITER ;

DELIMITER //

CREATE TRIGGER actualizar_total_factura_update
AFTER UPDATE ON detalle_facturas
FOR EACH ROW
BEGIN
    UPDATE facturas 
    SET total = (
        SELECT SUM(cantidad * precio_unitario)
        FROM detalle_facturas
        WHERE factura_id = NEW.factura_id
    )
    WHERE factura_id = NEW.factura_id;
END;
//

DELIMITER ;

DELIMITER //

CREATE TRIGGER actualizar_total_factura_delete
AFTER DELETE ON detalle_facturas
FOR EACH ROW
BEGIN
    UPDATE detalle_facturas 
    SET total = (
        SELECT SUM(cantidad * precio_unitario)
        FROM detalle_facturas
        WHERE factura_id = OLD.factura_id
    )
    WHERE factura_id = OLD.factura_id;
END;
//

DELIMITER ;

DELIMITER //

CREATE TRIGGER actualizar_total_cotizacion_insert
AFTER INSERT ON detalle_cotizaciones
FOR EACH ROW
BEGIN
    UPDATE cotizaciones 
    SET precio_total = (
        SELECT SUM(cantidad * precio_unitario)
        FROM detalle_cotizaciones
        WHERE cotizacion_id = NEW.cotizacion_id
    )
    WHERE cotizacion_id = NEW.cotizacion_id;
END;
//

DELIMITER ;

DELIMITER //

CREATE TRIGGER actualizar_total_cotizacion_update
AFTER UPDATE ON detalle_cotizaciones
FOR EACH ROW
BEGIN
    UPDATE cotizaciones 
    SET precio_total = (
        SELECT SUM(cantidad * precio_unitario)
        FROM detalle_cotizaciones
        WHERE cotizacion_id = NEW.cotizacion_id
    )
    WHERE cotizacion_id = NEW.cotizacion_id;
END;
//

DELIMITER ;

DELIMITER //

CREATE TRIGGER actualizar_total_cotizacion_delete
AFTER DELETE ON detalle_cotizaciones
FOR EACH ROW
BEGIN
    UPDATE cotizaciones 
    SET precio_total = (
        SELECT SUM(cantidad * precio_unitario)
        FROM detalle_cotizaciones
        WHERE cotizacion_id = OLD.cotizacion_id
    )
    WHERE cotizacion_id = OLD.cotizacion_id;
END;
//

DELIMITER ;

DELIMITER //

CREATE TRIGGER actualizar_total_orden_compras_insert
AFTER INSERT ON detalle_orden_compras
FOR EACH ROW
BEGIN
    UPDATE orden_compras 
    SET total = (
        SELECT SUM(cantidad * precio_unitario)
        FROM detalle_orden_compras
        WHERE orden_compra_id = NEW.orden_compra_id
    )
    WHERE orden_compra_id = NEW.orden_compra_id;
END;
//

DELIMITER ;

DELIMITER //

CREATE TRIGGER actualizar_total_orden_compras_update
AFTER UPDATE ON detalle_orden_compras
FOR EACH ROW
BEGIN
    UPDATE orden_compras 
    SET total = (
        SELECT SUM(cantidad * precio_unitario)
        FROM detalle_orden_compras
        WHERE orden_compra_id = NEW.orden_compra_id
    )
    WHERE orden_compra_id = NEW.orden_compra_id;
END;
//

DELIMITER ;

DELIMITER //

CREATE TRIGGER actualizar_total_orden_compras_delete
AFTER DELETE ON detalle_orden_compras
FOR EACH ROW
BEGIN
    UPDATE orden_compras 
    SET total = (
        SELECT SUM(cantidad * precio_unitario)
        FROM detalle_orden_compras
        WHERE orden_compra_id = OLD.orden_compra_id
    )
    WHERE orden_compra_id = OLD.orden_compra_id;
END;
//

DELIMITER ;

DELIMITER //

CREATE TRIGGER actualizar_total_recibos_insert
AFTER INSERT ON detalle_recibos
FOR EACH ROW
BEGIN
    UPDATE recibos 
    SET total = (
        SELECT SUM(monto_cancelado)
        FROM detalle_recibos
        WHERE recibo_id = NEW.recibo_id
    )
    WHERE recibo_id = NEW.recibo_id;
END;
//

DELIMITER ;

DELIMITER //

CREATE TRIGGER actualizar_total_recibos_update
AFTER UPDATE ON detalle_recibos
FOR EACH ROW
BEGIN
    UPDATE recibos 
    SET total = (
        SELECT SUM(monto_cancelado)
        FROM detalle_recibos
        WHERE recibo_id = NEW.recibo_id
    )
    WHERE recibo_id = NEW.recibo_id;
END;
//

DELIMITER ;

DELIMITER //

CREATE TRIGGER actualizar_total_recibos_delete
AFTER DELETE ON detalle_recibos
FOR EACH ROW
BEGIN
    UPDATE recibos 
    SET total = (
        SELECT SUM(monto_cancelado)
        FROM detalle_recibos
        WHERE recibo_id = OLD.recibo_id
    )
    WHERE recibo_id = OLD.recibo_id;
END;
//

DELIMITER ;

DELIMITER //

CREATE TRIGGER actualizar_total_facturas_compras_insert
AFTER INSERT ON detalle_facturas_compras
FOR EACH ROW
BEGIN
    UPDATE facturas_compras 
    SET total = (
        SELECT SUM(cantidad * precio_unitario)
        FROM detalle_facturas_compras
        WHERE factura_compra_id = NEW.factura_compra_id
    )
    WHERE factura_compra_id = NEW.factura_compra_id;
END;
//

DELIMITER ;

DELIMITER //

CREATE TRIGGER actualizar_total_facturas_compras_update
AFTER UPDATE ON detalle_facturas_compras
FOR EACH ROW
BEGIN
    UPDATE facturas_compras 
    SET total = (
        SELECT SUM(cantidad * precio_unitario)
        FROM detalle_facturas_compras
        WHERE factura_compra_id = NEW.factura_compra_id
    )
    WHERE factura_compra_id = NEW.factura_compra_id;
END;
//

DELIMITER ;

DELIMITER //

CREATE TRIGGER actualizar_total_facturas_compras_delete
AFTER DELETE ON detalle_facturas_compras
FOR EACH ROW
BEGIN
    UPDATE facturas_compras 
    SET total = (
        SELECT SUM(cantidad * precio_unitario)
        FROM detalle_facturas_compras
        WHERE factura_compra_id = OLD.factura_compra_id
    )
    WHERE factura_compra_id = OLD.factura_compra_id;
END;
//

DELIMITER ;

DELIMITER //

CREATE TRIGGER recalcular_totales_liquidacion_insert
AFTER INSERT ON detalle_liquidaciones
FOR EACH ROW
BEGIN
    DECLARE bruto DECIMAL(10,2);
    DECLARE deducciones DECIMAL(10,2);
    
    -- Calcular total bruto
    SELECT IFNULL(SUM(dl.monto_unitario * dl.cantidad), 0)
    INTO bruto
    FROM detalle_liquidaciones dl
    JOIN conceptos c ON dl.concepto_id = c.concepto_id
    WHERE c.naturaleza = true
      AND dl.liquidacion_id = NEW.liquidacion_id;
    
    -- Calcular total deducciones
    SELECT IFNULL(SUM(dl.monto_unitario * dl.cantidad), 0)
    INTO deducciones
    FROM detalle_liquidaciones dl
    JOIN conceptos c ON dl.concepto_id = c.concepto_id
    WHERE c.naturaleza = false
      AND dl.liquidacion_id = NEW.liquidacion_id;

    -- Actualizar la liquidación con los tres valores
    UPDATE liquidaciones_sueldo
    SET total_bruto = bruto,
        total_deducciones = deducciones,
        total_neto = bruto - deducciones
    WHERE liquidacion_id = NEW.liquidacion_id;
END;
//

DELIMITER ;

DELIMITER //

CREATE TRIGGER recalcular_totales_liquidacion_update
AFTER UPDATE ON detalle_liquidaciones
FOR EACH ROW
BEGIN
    DECLARE bruto DECIMAL(10,2);
    DECLARE deducciones DECIMAL(10,2);
    
    -- Calcular total bruto
    SELECT IFNULL(SUM(dl.monto_unitario * dl.cantidad), 0)
    INTO bruto
    FROM detalle_liquidaciones dl
    JOIN conceptos c ON dl.concepto_id = c.concepto_id
    WHERE c.naturaleza = true
      AND dl.liquidacion_id = NEW.liquidacion_id;
    
    -- Calcular total deducciones
    SELECT IFNULL(SUM(dl.monto_unitario * dl.cantidad), 0)
    INTO deducciones
    FROM detalle_liquidaciones dl
    JOIN conceptos c ON dl.concepto_id = c.concepto_id
    WHERE c.naturaleza = false
      AND dl.liquidacion_id = NEW.liquidacion_id;

    -- Actualizar la liquidación con los tres valores
    UPDATE liquidaciones_sueldo
    SET total_bruto = bruto,
        total_deducciones = deducciones,
        total_neto = bruto - deducciones
    WHERE liquidacion_id = NEW.liquidacion_id;
END;
//

DELIMITER ;

DELIMITER //

CREATE TRIGGER recalcular_totales_liquidacion_delete
AFTER DELETE ON detalle_liquidaciones
FOR EACH ROW
BEGIN
    DECLARE bruto DECIMAL(10,2);
    DECLARE deducciones DECIMAL(10,2);
    
    -- Calcular total bruto
    SELECT IFNULL(SUM(dl.monto_unitario * dl.cantidad), 0)
    INTO bruto
    FROM detalle_liquidaciones dl
    JOIN conceptos c ON dl.concepto_id = c.concepto_id
    WHERE c.naturaleza = true
      AND dl.liquidacion_id = OLD.liquidacion_id;
    
    -- Calcular total deducciones
    SELECT IFNULL(SUM(dl.monto_unitario * dl.cantidad), 0)
    INTO deducciones
    FROM detalle_liquidaciones dl
    JOIN conceptos c ON dl.concepto_id = c.concepto_id
    WHERE c.naturaleza = false
      AND dl.liquidacion_id = OLD.liquidacion_id;

    -- Actualizar la liquidación con los tres valores
    UPDATE liquidaciones_sueldo
    SET total_bruto = bruto,
        total_deducciones = deducciones,
        total_neto = bruto - deducciones
    WHERE liquidacion_id = OLD.liquidacion_id;
END;
//

DELIMITER ;
