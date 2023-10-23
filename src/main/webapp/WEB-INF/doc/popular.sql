-- CURSOS
insert into curso values(1,'Depuração de Sistemas',2400,'ANADS',4)
insert into curso values(2,'Analise e Desenvolvimento de sistemas',2400,'ANADS',4)
insert into curso values(3,'Logistica',2400,'LOG',3)
insert into curso values(4, 'Desenvolvimento de Software Muiltiplafatorma',2400,'DSM',2)
insert into curso values(5, 'Gestão Internacional',1400,'GI',5)
select * from curso

-- ALUNOS
INSERT INTO aluno (ra_aluno, cpf, nome, nome_social, data_nasc, telefone1, telefone2,
email_p, email_c, data_seg_grau, ints_seg_grau, pontu_vesti, ano_ingre, semestre_ingre, semestre_limit, ano_grad_limit, cod_curso, turno_curso)
VALUES ('202116789', '12345678901', 'João Silva', NULL, '15/03/1995', '1122334455', '9988776655', 
'joao@email.com', 'contato@email.com', '20/10/2009', 'Escola A', 700, 2015, 1, 1, 2020, 1, 'Matutino');
INSERT INTO aluno
VALUES ('202114321', '98765432109', 'Maria Santos', 'Mário Santos', '18/02/2003', '9988776655', '1122334455', 
'maria@email.com', 'contato@email.com', '20/10/2009', 'Escola B', 700, 2015, 1, 1, 2020, 1, 'Noturno');
INSERT INTO aluno
VALUES ('202113456', '78912345612', 'Carlos Pereira', NULL, '25/05/1945', '5544332211', '1122334455', 
'carlos@email.com', 'contato@email.com', '20/10/2009', 'Escola C', 700, 2015, 2, 2, 2020, 2, 'Matutino');
INSERT INTO aluno 
VALUES ('202119123', '45678912345', 'Ana Silva', NULL, '15/03/1995', '1122334455', '5544332211', 
'ana@email.com', 'contato@email.com', '20/10/2009', 'Escola A', 700, 2015, 2, 2, 2020, 2, '4');
INSERT INTO aluno 
VALUES ('202113416', '98712345678', 'Lucas Oliveira', 'Luana Oliveira', '15/03/1995', '9988776655', '5544332211', 
'lucas@email.com', 'contato@email.com', '20/10/2009', 'Escola D', 700, 2015, 1, 1, 2020, 1, 'Matutino');
INSERT INTO aluno
VALUES ('202114321', '12345678901', 'Maria Santos', NULL, '15/03/1995', '1122334455', '9988776655', 
'maria@email.com', 'contato@email.com', '20/10/2009', 'Escola B', 700, 2015, 1, 1, 2020, 2, 'Noturno');
INSERT INTO aluno
VALUES ('202115555', '98765432109', 'Pedro Oliveira', 'Pedro Silva', '15/03/1995', '9988776655', '1122334455', 
'pedro@email.com', 'contato@email.com', '20/10/2009', 'Escola C', 700, 2015, 2, 2, 2020, 2, 'Matutino');
INSERT INTO aluno
VALUES ('202215599', '98765432119', 'Pedro Oliveira', 'Pedro Silva', '15/03/1995', '9988776655', '1122334455', 
'pedro@email.com', 'contato@email.com', '20/10/2009', 'Escola C', 700, 2015, 2, 2, 2020, 4, 'Matutino');
select * from aluno

-- DISCIPLINAS
INSERT INTO disciplina VALUES(1,'Cálculo II',200)
INSERT INTO disciplina VALUES(2,'Java I',200)
INSERT INTO disciplina VALUES(3,'Engenharia de Software I',300)
INSERT INTO disciplina VALUES(4,'Engenharia de Software II',200)
INSERT INTO disciplina VALUES(5,'Engenharia de Software III',100)
INSERT INTO disciplina VALUES(6,'Banco de Dados Relacional',600)
select * from disciplina

-- DISCIPLINA CURSO 
INSERT INTO disciplina_curso VALUES (2,2, 'Satoshi')
INSERT INTO disciplina_curso VALUES (4,2, 'Satoshi')
INSERT INTO disciplina_curso VALUES (2,3, 'Satoshi')
INSERT INTO disciplina_curso VALUES (4,3, 'Satoshi')
INSERT INTO disciplina_curso VALUES (2,5, 'Satoshi')
INSERT INTO disciplina_curso VALUES (4,5, 'Satoshi')
INSERT INTO disciplina_curso VALUES (2,6, 'Satoshi')
INSERT INTO disciplina_curso VALUES (4,6, 'Satoshi')
select * from disciplina_curso

-- LISTAGEM RA ALUNO - NOME CURSO 
SELECT a.ra_aluno, c.nome_curso
FROM aluno a, curso c
where a.cod_curso = c.cod_curso

-- LISTAGEM TODAS DISCIPLINAS DE UM CURSO 
select c.nome_curso, dc.cod_disci, d.nome_disci as 'Nome Disciplina'
from disciplina_curso dc, curso c, disciplina d
where dc.cod_curso = 2
AND dc.cod_curso = c.cod_curso
AND dc.cod_disci = d.cod_disci

-- LISTAGEM DE TODAS ID DISCIPLINA_CURSO DE UM CURSO
select dc.id_disciplina_curso
from disciplina_curso dc, curso c, disciplina d
where dc.cod_curso = 2
AND dc.cod_curso = c.cod_curso
AND dc.cod_disci = d.cod_disci

-- ALUNO DISCIPLINA
INSERT INTO matricula_disc VALUES (202113416,1001,'matriculado','10',0)
INSERT INTO matricula_disc VALUES (202113456,1001, 'matriculado', '6',0)
INSERT INTO matricula_disc VALUES (202114321,1002, 'dispensado','D',0)
INSERT INTO matricula_disc VALUES (202114321,1002, 'dispensado','D',0)
INSERT INTO matricula_disc VALUES (202317270,1003, 'aprovado','10',0)

-- ########################################################################
