 -- loops aninhados e rótulos


-- LIDAR COM ERROS:
-- DO
-- $$
-- BEGIN
--     RAISE NOTICE '%', 1/0;
--     RAISE NOTICE 'Acabou...';
-- EXCEPTION
--     WHEN division_by_zero THEN
--     RAISE NOTICE 'Não divida por zero';
-- END;
-- $$



-- FOREACH COM FATIAS (slice)
-- quando slice é 0 pega dado por dado -- escalar
-- quando slice é 1 pega por linha
-- {1,2,3} {4,5,6} {7,8,9}
-- quando slice é 2 pega por 2 dimensões
-- {{1,2,3},{4,5,6},{7,8,9}}

-- DO
-- $$
-- DECLARE
--     vetor INT[] := ARRAY[1,2,3];
--     matriz INT[] := ARRAY[
--         [1,2,3],
--         [4,5,6],
--         [7,8,9]
--     ];
--     var_aux INT;
--     vet_aux INT[];
-- BEGIN
--     RAISE NOTICE 'SLICE %, vetor', 0;
--     FOREACH var_aux IN ARRAY vetor LOOP
--         RAISE NOTICE '%', var_aux;
--     END LOOP;

--     RAISE NOTICE 'SLICE %, vetor', 1;
--     FOREACH vet_aux SLICE 1 IN ARRAY vetor LOOP
--         RAISE NOTICE '%', vet_aux;
--     END LOOP;

--     RAISE NOTICE 'SLICE %, matriz', 0;
--     FOREACH var_aux SLICE 0 IN ARRAY matriz LOOP
--         RAISE NOTICE '%', var_aux;
--     END LOOP;

--     RAISE NOTICE 'SLICE %, vetor', 1;
--     FOREACH vet_aux SLICE 1 IN ARRAY matriz LOOP
--         RAISE NOTICE '%', vet_aux;
--     END LOOP;

--     RAISE NOTICE 'SLICE %, vetor', 2;
--     FOREACH vet_aux SLICE 2 IN ARRAY matriz LOOP
--         RAISE NOTICE '%', vet_aux;
--     END LOOP;
-- END;
-- $$ 

-- DO 
-- $$
-- DECLARE
--     valores INT[] := ARRAY[
--     valor_aleatorio_entre(1,10),
--     valor_aleatorio_entre(1,10),
--     valor_aleatorio_entre(1,10),
--     valor_aleatorio_entre(1,10),
--     valor_aleatorio_entre(1,10)
--     ];
--     valor INT;
--     soma INT := 0;
-- BEGIN
--     FOREACH valor IN ARRAY valores LOOP 
--         RAISE NOTICE 'Valor da vez %', valor;
--         soma := soma + valor;
--     END LOOP;
--     RAISE NOTICE 'Soma: %', soma;
-- END;
-- $$

-- DO
-- $$
-- DECLARE
--     aluno RECORD;
--     media NUMERIC(10,2) := 0;
--     total_alunos INT;
-- BEGIN
--     FOR aluno IN 
--         SELECT * FROM tb_aluno
--     LOOP
--         RAISE NOTICE 'Nota do aluno %: %', 
--         aluno.cod_aluno, aluno.nota;
--         media := media + aluno.nota;
--     END LOOP;
--     SELECT COUNT(*) FROM tb_aluno INTO total_alunos;
--     RAISE NOTICE 'Média: %', media/ total_alunos;
-- END;
-- $$

-- SELECT * FROM tb_aluno;

-- DO
-- $$
-- BEGIN
--     FOR i IN 1..10 LOOP 
--         INSERT INTO tb_aluno
--         (nota)
--         VALUES
--         (valor_aleatorio_entre(0,10));
--     END LOOP;
-- END;
-- $$

-- CREATE TABLE tb_aluno(
--     cod_aluno SERIAL PRIMARY KEY,
--     nota INT
-- );

-- DO
-- $$
-- BEGIN
--     FOR i IN 1..10 LOOP 
--         RAISE NOTICE '%', i;
--     END LOOP;
-- ---- NÃO MOSTRA NADA
--     FOR i IN 1..10 LOOP 
--         RAISE NOTICE '%', i;
--     END LOOP;
-- ---- Contagem Regressiva
--     FOR i IN REVERSE 10...1 LOOP
--         RAISE NOTICE '%', i;
--     END LOOP;
-- ---- Pular de 2 em 2
--     FOR i IN 1..50 BY 2 LOOP
--         RAISE NOTICE '%', i;
--     END LOOP;
-- ----    
--      FOR i IN REVERSE 50...1 BY 2 LOOP
--         RAISE NOTICE '%', i;
--     END LOOP;
-- END;
-- $$

-- DO
-- $$
-- DECLARE
--     nota INT;
--     media NUMERIC(10,2) := 0;
--     contador INT := 1;
--     total_alunos INT := 5;
-- BEGIN
--     WHILE contador <= total_alunos LOOP 
--         SELECT valor_aleatorio_entre(0,10) INTO nota;
--         RAISE NOTICE '%', nota;
--         media := media + nota;
--         contador := contador + 1;
--     END LOOP;
--     RAISE NOTICE 'Média %', media/total_alunos;
-- END;
-- $$

-- DO
-- $$
-- DECLARE
--     nota INT;
--     media NUMERIC(10,2) := 0;
--     contador INT := 0;
-- BEGIN
--     SELECT valor_aleatorio_entre(0,11) -1 INTO nota;
--     WHILE nota >= 0 LOOP 
--         RAISE NOTICE '%', nota;
--         media := media + nota;
--         contador := contador + 1;
--         SELECT valor_aleatorio_entre(0,11) -1 INTO nota;
--     END LOOP;
--     IF contador > 0 THEN 
--         RAISE NOTICE 'Média %', media/contador;
--     ELSE 
--          RAISE NOTICE 'Nenhuma nota gerada';
--     END IF;
-- END;
-- $$

-- DO 
-- $$ 
-- DECLARE,
--     i INT;
--     j INT;
-- BEGIN
--     i := 0;
--     <<externo>>
--     LOOP
--         i := i +1;
--         EXIT WHEN i > 10;
--         j := 1;
--         <<interno>>
--         LOOP
--             RAISE NOTICE '% %', i,j;
--             j := j + 1;
--             CONTINUE externo WHEN j > 5;
--         END LOOP;
--     END LOOP;
-- END;
-- $$



-- DO
-- $$
-- DECLARE
--     i INT;
--     j INT;
-- BEGIN
--     i := 0;
--     <<externo>>
--     LOOP
--         i := i + 1;
--         EXIT WHEN i > 10;
--         j := 1;
--         <<interno>>
--         LOOP
--             RAISE NOTICE '% %', i, j;
--             j := j + 1;
--             EXIT externo WHEN j > 5;
--         END LOOP;
--     END LOOP;
-- END;
-- $$

-- DO
-- $$
-- DECLARE
--     contador INT := 0;
-- BEGIN
--     LOOP 
--         contador := contador +1;
--         EXIT WHEN contador > 100;

--         IF contador % 7 = 0 THEN 
--             CONTINUE;
--         END IF;

--         CONTINUE WHEN contador % 11 = 0;
--         RAISE NOTICE '%', contador;
--     END LOOP;
-- END;


-- DO 
-- $$
-- DECLARE
--     contador INT :=1;
-- BEGIN
--     LOOP
--         RAISE NOTICE '%', contador;
--         contador := contador + 1;
--         EXIT WHEN contador > 10;
--     END LOOP;
-- END;
-- $$

-------------------------------------------

-- DO
-- $$
-- DECLARE 
--     contador INT := 1;
-- BEGIN
--     LOOP
--         RAISE NOTICE '%', contador;
--         contador := contador + 1;
--         IF contador > 10 THEN 
--             EXIT;
--         END IF;
--     END LOOP;
-- END;
-- $$
---------------------------------------------

-- DO
-- $$
-- BEGIN
-- -- Não execute loop infinito
--     LOOP 
--         RAISE NOTICE 'Um loop Simples'
--     END LOOP;
-- END;
--$$