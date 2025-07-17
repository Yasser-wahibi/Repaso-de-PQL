-- 3. Trigger de registro de transacciones (AFTER INSERT/UPDATE)
-- Crea un trigger sobre la tabla TVENTA que se dispare después de insertar o actualizar una fila.
-- El trigger debe:
-- Insertar en una tabla llamada, por ejemplo, TLOG_VENTAS (que tendrás que crear con campos como ID_LOG, NUM_VEN, FECHA_VENTA, CANTIDAD, ACCION, FECHA_LOG) la información del cambio:
-- El NUM_VEN (vendedor que realizó la venta).
-- La fecha de la venta (FECHA).
-- La cantidad vendida (CANTIDAD).
-- El tipo de acción: 'INSERT' o 'UPDATE'.
-- La fecha y hora en la que se activa el trigger.
-- Maneja las excepciones para que, en caso de fallo, se muestre un mensaje o se registre el error en otra tabla.


-- EN MI TABLA DE VENTAS NO TENGO EL ID_LOG POR LO QUE NO LO HE PUESTO
CREATE TABLE TLOG_VENTAS (
    NUM_VEN CHAR(3),
    FECHA_VENTA DATE,
    cantidad number(5),
    acccion varchar2(200),
    fecha_activacion VARCHAR2(200)
);

CREATE OR REPLACE TRIGGER tventa_log after insert or UPDATE on tventa for EACH ROW
DECLARE

NUM_VEN TVENDEDOR.COD_VEN%TYPE;
BEGIN
    if INSERTING then 
        SELECT VENDEDOR INTO NUM_VEN FROM TCLIENTE WHERE DNI= :NEW.CLIENTE;
        INSERT INTO TLOG_VENTAS VALUES (NUM_VEN,:NEW.FECHA,:NEW.CANTIDAD, 'INSERCCION', TO_CHAR(SYSDATE,  'DD/MM/YYYY  HH24:MI:SS' ));
    end if;

        if UPDATING then 
        SELECT VENDEDOR INTO NUM_VEN FROM TCLIENTE WHERE DNI= :NEW.CLIENTE;
        INSERT INTO TLOG_VENTAS VALUES (NUM_VEN,:NEW.FECHA,:NEW.CANTIDAD, 'ACTUALIZACION', TO_CHAR(SYSDATE, 'DD/MM/YYYY  HH24:MI:SS'));
    end if;
end;
/