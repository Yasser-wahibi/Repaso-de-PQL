-- Crea un trigger de logon a nivel de schema o de base de datos (dependiendo de los privilegios que tengas en el servidor) que:

-- Inserte en una tabla llamada TSESIONES el nombre del usuario que inicia sesión, junto con la fecha y hora del logon.

-- CREATE TABLE TSESIONES (
--         USUARIO VARCHAR2(100),
--         FECHA DATE,
--         HORA VARCHAR2(100)
-- );

-- CREATE OR REPLACE TRIGGER TRIESP1 AFTER logon ON DATABASE
-- DECLARE
--     BEGIN
--         INSERT INTO C##SCOTT.TSESIONES VALUES(USER,SYSDATE, TO_CHAR(SYSDATE ,'HH24:MI:SS'));
--     END;
-- /



-- Crea un trigger de logoff que:

-- Actualice esa misma tabla TSESIONES, marcando la fecha y hora de salida (logoff) para el usuario correspondiente.
-- CREATE OR REPLACE TRIGGER TRIESP2 AFTER logon ON DATABASE
-- DECLARE
--     BEGIN
--         INSERT INTO C##SCOTT.TSESIONES VALUES(USER,SYSDATE, TO_CHAR(SYSDATE ,'HH24:MI:SS') || '(LOGOOFF)' );
--     END;
-- /


