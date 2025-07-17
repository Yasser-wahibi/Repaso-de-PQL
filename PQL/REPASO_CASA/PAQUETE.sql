-- 5. Paquete con procedimientos y funciones para controlar empleados
-- Utilizando las tablas TEMPLEADO, TDEPARTAMENTO y TGRADO, haz lo siguiente:

-- Crea un paquete llamado pkg_rrhh. En la especificación (pkg_rrhh.pks) declara:

CREATE OR REPLACE PACKAGE pkg_rrhh IS
-- Un procedimiento prc_subir_sueldo que reciba como parámetros el NUM_EMP y un porcentaje de aumento.
PROCEDURE prc_subir_sueldo(N_EMP EMPLEADO.NUM_EMP%TYPE, PORCEN NUMBER );

-- Una función fn_verificar_grado que reciba el NUM_EMP y devuelva el grado (columna GRADO de la tabla TGRADO) que le correspondería en función de su salario actual. Supón que para determinar el grado, debes comparar el salario del empleado con los valores SALARIO_MIN y SALARIO_MAX de TGRADO.
FUNCTION fn_verificar_grado(N_EMP EMPLEADO.NUM_EMP%TYPE) RETURN GRADO.GRADO%TYPE;


PROCEDURE prc_asignar_grado (N_EMP EMPLEADO.NUM_EMP%TYPE) ;
END;
/


CREATE OR REPLACE PACKAGE BODY pkg_rrhh IS
-- Un procedimiento prc_subir_sueldo que reciba como parámetros el NUM_EMP y un porcentaje de aumento.
PROCEDURE prc_subir_sueldo(N_EMP EMPLEADO.NUM_EMP%TYPE, PORCEN NUMBER ) IS
CHECK2 EMPLEADO%ROWTYPE;
BEGIN
    SELECT * INTO CHECK2 FROM EMPLEADO  WHERE NUM_EMP=N_EMP;
    UPDATE EMPLEADO SET SALARIO=SALARIO*(1+(PORCEN/100)) WHERE NUM_EMP=N_EMP;

    EXCEPTION
        WHEN NO_DATA_FOUND THEN 
        DBMS_OUTPUT.PUT_LINE('EL EMPLAEDO NO EXISTE');
END;

-- Una función fn_verificar_grado que reciba el NUM_EMP y devuelva el grado (columna GRADO de la tabla TGRADO) que le correspondería en función de su salario actual. Supón que para determinar el grado, debes comparar el salario del empleado con los valores SALARIO_MIN y SALARIO_MAX de TGRADO.
FUNCTION fn_verificar_grado(N_EMP EMPLEADO.NUM_EMP%TYPE) 
RETURN GRADO.GRADO%TYPE IS

CHECK2 EMPLEADO%ROWTYPE;
GRADORESULTADO GRADO.GRADO%TYPE;
BEGIN
    SELECT * INTO CHECK2 FROM EMPLEADO  WHERE NUM_EMP=N_EMP;
    SELECT GRADO INTO GRADORESULTADO FROM GRADO WHERE EXISTS (SELECT * FROM EMPLEADO WHERE NUM_EMP= N_EMP AND SALARIO BETWEEN SALARIO_MIN AND SALARIO_MAX);
    RETURN GRADORESULTADO;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN 
        DBMS_OUTPUT.PUT_LINE('EL EMPLAEDO NO EXISTE');
        RETURN NULL;
END;


PROCEDURE prc_asignar_grado (N_EMP EMPLEADO.NUM_EMP%TYPE) IS
CHECK2 EMPLEADO%ROWTYPE;
NOM EMPLEADO.NOMBRE%TYPE;
DEP EMPLEADO.NUM_DEP%TYPE;
SAL EMPLEADO.SALARIO%TYPE;
GRADORESULTADO GRADO.GRADO%TYPE;

BEGIN
    SELECT * INTO CHECK2 FROM EMPLEADO  WHERE NUM_EMP=N_EMP;
    SELECT NOMBRE INTO NOM FROM EMPLEADO  WHERE NUM_EMP=N_EMP;
    SELECT NUM_DEP INTO DEP FROM EMPLEADO  WHERE NUM_EMP=N_EMP;
    SELECT SALARIO INTO SAL FROM EMPLEADO  WHERE NUM_EMP=N_EMP;
     SELECT GRADO INTO GRADORESULTADO FROM GRADO WHERE EXISTS (SELECT * FROM EMPLEADO WHERE NUM_EMP= N_EMP AND SALARIO BETWEEN SALARIO_MIN AND SALARIO_MAX);
     
   DBMS_OUTPUT.PUT_LINE('NOMBRE: '|| NOM ||'DEP: '||DEP ||'SALARIO: '||SAL || 'GRADO: '||GRADORESULTADO);
    EXCEPTION
        WHEN NO_DATA_FOUND THEN 
        DBMS_OUTPUT.PUT_LINE('EL EMPLAEDO NO EXISTE');
                                       
END;


END ;
/










