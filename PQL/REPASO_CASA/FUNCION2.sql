-- 2. Cursor doble (nested cursors) para generar un informe
-- Crea una función llamada fn_informe_clientes que devuelva un VARCHAR2 (o CLOB, si quieres manejar un texto más largo).

-- La función debe:

-- Recorrer todos los vendedores en TVENDEDOR (cursor externo).

-- Para cada vendedor, abrir un segundo cursor (cursor interno) que recorra todos los clientes en TCLIENTE cuyo campo VENDEDOR coincida con el NUM_VEN del cursor externo.

-- Construir un texto con la siguiente estructura, por cada vendedor:

-- Vendedor: <NUM_VEN> - <NOMBRE>
-- ----------------------------
-- DNI Cliente | Nombre Cliente | Compras
-- --------------------------------------
-- <DNI>       | <NOMBRE>       | <COMPRAS>
-- ...
-- Devuelve todo ese texto en la variable de salida de la función.

-- Desde un bloque anónimo (o desde un procedimiento que llames prc_mostrar_informe), imprime el resultado de la función por pantalla o mediante DBMS_OUTPUT.PUT_LINE.

CREATE OR REPLACE FUNCTION fn_informe_clientes 
RETURN VARCHAR2 IS

CURSOR CVENDEDOR IS
    SELECT COD_VEN,NOM_VEN
    FROM TVENDEDOR;
FILAVENDEDOR CVENDEDOR%ROWTYPE;
SALIDA VARCHAR2(3000):='';
CURSOR CCLIENTE IS 
    SELECT *
    FROM TCLIENTE
    WHERE FILAVENDEDOR.COD_VEN=VENDEDOR;
FILACLIENTE CCLIENTE%ROWTYPE;
BEGIN

    OPEN CVENDEDOR;
        LOOP
            FETCH  CVENDEDOR INTO FILAVENDEDOR;
            EXIT WHEN CVENDEDOR%NOTFOUND;
            SALIDA:=SALIDA || 'Vendedor:' ||FILAVENDEDOR.COD_VEN ||' - '|| FILAVENDEDOR.NOM_VEN|| CHR(10);
            SALIDA:=SALIDA||CHR(10) || 'DNI Cliente | Nombre Cliente | Compras'|| CHR(10);
            SALIDA :=CHR(10)|| SALIDA || '----------------|-----------------------|---------' || CHR(10);
                OPEN CCLIENTE;
                    LOOP
                        FETCH  CCLIENTE INTO FILACLIENTE;
                        EXIT WHEN CCLIENTE%NOTFOUND;
                       SALIDA:=SALIDA||FILACLIENTE.DNI|| '|' || FILACLIENTE.NOMBRE|| '|'  || FILACLIENTE.COMPRAS ||CHR(10);
                    END LOOP;
                CLOSE CCLIENTE;
        END LOOP;
    CLOSE CVENDEDOR;
    RETURN SALIDA;
END;
/