-- 1. Cursor simple con lógica condicional
-- Crea un procedimiento llamado prc_calcular_comision que:

-- Utilice un cursor para recorrer la tabla TVENDEDOR y para cada vendedor (NUM_VEN, NOMBRE, PORCEN, TITULACION, ZONA), verifique si la columna PORCEN está por debajo de un valor que tú consideres mínimo (por ejemplo, 5%).

-- Si PORCEN es menor al mínimo, actualiza su valor a ese mínimo (por ejemplo, 5%).

-- Muestra por pantalla (o utiliza DBMS_OUTPUT.PUT_LINE) el NUM_VEN y el nuevo valor de PORCEN tras la actualización.

-- Asegúrate de manejar correctamente las excepciones y de emplear, si procede, bloques de transacción (COMMIT/ROLLBACK) para reflejar o deshacer los cambios.

CREATE OR REPLACE PROCEDURE prc_calcular_comision
IS 

CURSOR CVENDEDOR IS
    SELECT *
    FROM TVENDEDOR;
FILAVENDEDOR CVENDEDOR%ROWTYPE;
MINIMO NUMBER :=5;
BEGIN
    OPEN CVENDEDOR;
        LOOP
            FETCH CVENDEDOR INTO FILAVENDEDOR;
            EXIT WHEN CVENDEDOR%NOTFOUND;
            --EN MI TABLA NO EXITE LA COLUMAN ZONA POR LO QUE CON ESTO YA ES SUFICIENTE
            IF FILAVENDEDOR.PORCEN<MINIMO THEN
                UPDATE TVENDEDOR SET PORCEN=MINIMO WHERE COD_VEN= FILAVENDEDOR.COD_VEN;
            END IF;
            dbms_OUTPUT.PUT_LINE('NOMBRE: '|| FILAVENDEDOR.NOM_VEN || 'CODIGO:' || FILAVENDEDOR.COD_VEN|| 'TITULACION: ' || FILAVENDEDOR.TITULACION || 'PORCEN: ' || FILAVENDEDOR.PORCEN);
        END LOOP;
    CLOSE CVENDEDOR;
    -- NO TIENE QENTIDO HACCER UN EXCEPTION PORQUE NO EN SI EL CODIGO FUNCIONA BIEN 
END;
/
