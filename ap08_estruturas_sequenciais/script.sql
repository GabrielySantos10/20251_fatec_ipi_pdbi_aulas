-- RANDOM() TIRA O 1
--FLOOR deixa o numeric em inteiro, arredonda pra baixo
DO $$
DECLARE 
    n1 NUMERIC (5,2);
    n2  INT;
    limite_inferior INT := 5;
    limite_superior INT := 17;
BEGIN 
    -- 0 <= N1 <1 (REAL) [0,1)
    n1 := random ();
    RAISE NOTICE 'n1: %', n1;
    -- 0 <= N1 <1 (REAL) [1,10)
    n1 := 1 + random() * 9;
    RAISE NOTICE '%', n1;
    n2 := floor(random() * 10 + 1)::INT;
    RAISE NOTICE 'n2: %', n2;
    --    n2 := floor(random() * (17 - 5 + 1) + 5)::INT;
    n2 := floor(random() * (limite_superior - limite_inferior + 1) + limite_inferior)::INT;
    RAISE NOTICE 'Intervalo Qualquer: %', n2;
END;
$$
--vdoáriaveis
-- DO
-- $$
-- DECLARE 
--     v_codigo INTEGER := 1;
--     v_nome_completo VARCHAR(200) := 'João';
--     v_salario NUMERIC(11,2) := 20.5;
-- BEGIN
--     RAISE NOTICE 'Meu código é %, me chamo %, e salário é %',
--     v_codigo, v_nome_completo, v_salario;
-- END;
-- $$
-- placeholders de expressões em string
-- DO 
-- $$
-- BEGIN
--     RAISE NOTICE '% + % = %', 2,2,2 + 2;
-- END;
-- $$
-- DO
-- '
-- BEGIN 
--     RAISE NOTICE ''Meu primeiro bloquinho anônimo'';
-- END;
-- '
-- CREATE DATABASE "20251_fatec_ipi_pdvi_gabriely_santos";