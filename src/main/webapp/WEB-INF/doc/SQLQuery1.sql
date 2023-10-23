CREATE DATABASE lbd_av1
GO
USE lbd_av1
GO

CREATE TABLE curso (
cod_curso INT NOT NULL primary key,
CONSTRAINT CHK_cod_curso CHECK (cod_curso >= 0 AND cod_curso <= 100),
nome_curso VARCHAR (100) NOT NULL,
carga_horaria INT NOT NULL,
sigla VARCHAR (5) NOT NULL,
nota_ult_enade INT NOT NULL,
CONSTRAINT CHK_nota_enade CHECK (nota_ult_enade >= 1 AND nota_ult_enade <= 5)
)

CREATE TABLE aluno(
	ra_aluno VARCHAR (9) not null primary key,
	cpf varchar (12) not null,
	nome VARCHAR (100) NOT NULL,
	nome_social VARCHAR (100) NULL,
	data_nasc varchar(10) NOT NULL,
	telefone1 VARCHAR (11) NOT NULL,
	telefone2 VARCHAR (11) NOT NULL,
	email_p VARCHAR (100) NOT NULL,
	email_c VARCHAR (100) NOT NULL,
	data_seg_grau varchar(10) NOT NULL,
	ints_seg_grau VARCHAR (50) NOT NULL,
	pontu_vesti FLOAT NOT NULL,
	ano_ingre INT NOT NULL,
	semestre_ingre INT NOT NULL,
	semestre_limit INT NOT NULL,
	ano_grad_limit INT NOT NULL,
	cod_curso INT NOT NULL,
	turno_curso VARCHAR (10) NOT NULL
	FOREIGN KEY (cod_curso) REFERENCES curso(cod_curso)
)

CREATE TABLE disciplina(
	cod_disci int NOT NULL PRIMARY KEY, 
	nome_disci VARCHAR (100) NOT NULL,
	qtd_horas_sem int NOT NULL
)
GO
-- Relacionamento curso - disciplina N - N 
CREATE TABLE disciplina_curso(
	id_disciplina_curso int IDENTITY(1001, 1) not null primary key,
	cod_curso INT NOT NULL,
	cod_disci int NOT NULL,
	nome_professor varchar(100) not null,
	FOREIGN KEY (cod_disci) REFERENCES disciplina(cod_disci),
	FOREIGN KEY (cod_curso) REFERENCES curso(cod_curso)
)

GO
-- Relacionamento aluno - disciplina_curso N - N 
GO

CREATE TABLE matricula_disc(
	id_matricula_aluno int not null primary key IDENTITY(1,1),
	ra_aluno VARCHAR (9) not null,
	id_disciplina_curso int  NOT NULL,
	situacao VARCHAR(12) NOT NULL,
	nota_final VARCHAR(4) NOT NULL,
	qtd_faltas int DEFAULT 0 NOT NULL,
	FOREIGN KEY (ra_aluno) REFERENCES aluno(ra_aluno),
	FOREIGN KEY (id_disciplina_curso) REFERENCES disciplina_curso(id_disciplina_curso)
)
GO
CREATE TABLE presenca_aula

-- ############################################################################
GO
-- Regra N1 - validar cpf

CREATE PROCEDURE sp_valida_cpf (@cpf VARCHAR(11), @valido BIT OUTPUT)
AS
	DECLARE @x int = 0
	DECLARE @i int = 1
	DECLARE @y int = 10
	DECLARE @soma INT = 0 
	DECLARE @digito1 INT
	DECLARE @digito2 int
	DECLARE @resto int


	WHILE (@i)  <=9   
		BEGIN
		SET @x = (SUBSTRING (@cpf, @i,1) * (@y ))
		SET @i = @i + 1
		SET @y = @y - 1
		SET @soma = @soma + @x
	END
	SET @resto = (@soma % 11)
	IF(@resto < 2)
		BEGIN
			SET @digito1 = 0
		END
	ELSE 
	SET @digito1 = 11 - @resto
		 -- ---
	SET @CPF = @CPF + CAST (@digito1 AS VARCHAR)

	SET @i = 1
	SET @y = 11 
	SET @soma = 0
	SET @resto = 0
	WHILE (@i)  <=10   
		BEGIN
		SET @x = (SUBSTRING (@cpf, @i,1) * (@y ))
		SET @i = @i + 1
		SET @y = @y - 1
		SET @soma = @soma + @x
	END
	SET @resto = (@soma % 11)
	IF(@resto < 2)
		BEGIN
			SET @digito2 = 0
		END
	SET @digito2 = 11 - @resto
	SET @CPF = @CPF + CAST (@digito2 AS VARCHAR)
	DECLARE @verificador VARCHAR(2)
	SET @verificador = CAST (@digito1 AS VARCHAR) + CAST (@digito2 AS VARCHAR)
IF (SUBSTRING(@cpf, 10,2) = @verificador )
	BEGIN
		SET @valido = 1
	END
	ELSE
	BEGIN
		SET @valido = 0
		RAISERROR('Cpf inválido', 16, 1)
	END

GO

-- Regra N2 - valide uma idade igual ou superior a 16 anos antes da insercao
CREATE PROCEDURE sp_valida_idade(@dt_nasc VARCHAR(10), @valido BIT OUTPUT)
AS
	DECLARE @hoje	DATE,
			@idade	INT
			
	set @dt_nasc = CAST(@dt_nasc as DATE)

	SET @hoje = (SELECT GETDATE())
	SET @idade = DATEDIFF(DAY, @dt_nasc, @hoje) / 365
	IF (@idade >= 16)
	BEGIN
		SET @valido = 1
	END
	ELSE
	BEGIN
		SET @valido = 0
		RAISERROR('Idade inválida', 16, 1)
	END

GO

-- Regra N3 -  A data limite de graduacao deve ser a saida de uma procedure que calcula 5 anos do ingresso
CREATE PROCEDURE sp_calcula_limi_gradu (@ano_ingre INT, @semestre_ingre INT,  @ano_limit INT OUTPUT, @semestre_limit INT OUTPUT)
AS
SET @semestre_limit = @semestre_ingre
SET @ano_limit = @ano_ingre + 5

GO

-- Regra N4 -O RA inicia com o ano de ingresso, seguido pelo semestre de ingresso e 4 numeros aleatorios, deve ser gerado por uma procedure para insercao.
CREATE PROCEDURE sp_calcula_ra (@ano_ingre INT, @semestre_ingre INT, @ra_aluno VARCHAR (9) OUTPUT)
AS
SET @ra_aluno = CAST(@ano_ingre AS VARCHAR) + CAST(@semestre_ingre AS VARCHAR) + CAST(FLOOR(RAND() * (8999) + 1000)  AS VARCHAR)

GO

/* todos os alunos, na matrícula pós vestibular devem estar matriculados,
imediatamente, em todas as disciplinas do curso escolhido.
*/

CREATE PROCEDURE sp_matricula_disciplinas (@ra_aluno VARCHAR(9), @id_curso int )
AS
	INSERT INTO matricula_disc (ra_aluno, id_disciplina_curso, situacao, nota_final)
	SELECT @ra_aluno, dc.id_disciplina_curso,'matriculado','0'
	from disciplina_curso dc, curso c, disciplina d
	where dc.cod_curso = @id_curso
	AND dc.cod_curso = c.cod_curso
	AND dc.cod_disci = d.cod_disci
GO

/*
5. A insercao das matriculas deve ter suas regras controladas por uma procedure e so ser confirmada
caso nao haja nenhuma restricao.
*/
	
	CREATE PROCEDURE sp_inserealuno (@cpf varchar(11),@nome varchar(100),@nome_social varchar(100), @data_nasc vARCHAR(10), @telefone1 varchar(11), 
	@telefone2 varchar(11), @email_p VARCHAR(100), @email_c varchar(100), @data_seg_grau varchar(10), @ints_seg_grau varchar(50) , @pontu_vesti int,
	@ano_ingre int, @semestre_ingre int, @cod_curso int, @turno_curso varchar(10))
AS
	DECLARE 
			@ra_aluno VARCHAR(9),
			@ano_grad_limit int,
			@semestre_limit int,
			@bit_cpf bit,
			@bit_dn bit,
		    @bit_matricula bit

			exec sp_calcula_limi_gradu @ano_ingre, @semestre_ingre, @ano_grad_limit output, @semestre_limit output
			exec sp_calcula_ra @ano_ingre, @semestre_ingre, @ra_aluno output;
			exec sp_valida_cpf @cpf,  @bit_cpf OUTPUT;
			exec sp_valida_idade @data_nasc, @bit_dn OUTPUT;

			IF(@bit_cpf = 1 AND @bit_dn = 1)
			BEGIN
			INSERT INTO aluno 
			VALUES (@ra_aluno, @cpf, @nome, @nome_social, @data_nasc, @telefone1, @telefone2, 
			@email_p, @email_c, @data_seg_grau, @ints_seg_grau, @pontu_vesti, @ano_ingre, @semestre_ingre, 
			@semestre_limit, @ano_grad_limit, @cod_curso, @turno_curso);
			print @ra_aluno
			print @cod_curso
		END
		ELSE
		BEGIN
			RAISERROR('Ocorreu algum erro em cadastrar o aluno', 16, 1)
		END
		BEGIN TRY
			exec sp_matricula_disciplinas @ra_aluno, @cod_curso;
		END TRY
		BEGIN CATCH
			RAISERROR('Ocorreu algum erro em cadastrar nas disciplinas do curso', 16, 1)
		END CATCH
GO

CREATE PROCEDURE sp_alteraaluno (@cpf varchar(11),@nome varchar(100),@nome_social varchar(100), @data_nasc vARCHAR(10), @telefone1 varchar(11), 
	@telefone2 varchar(11), @email_p VARCHAR(100), @email_c varchar(100), @data_seg_grau varchar(10), @ints_seg_grau varchar(50) , @pontu_vesti int,
	@ano_ingre int, @semestre_ingre int, @ano_limit int, @semestre_limit int, @cod_curso int, @turno_curso varchar(10), @ra_aluno VARCHAR(9))
	AS
	BEGIN TRY
		UPDATE aluno SET cpf = @cpf, nome = @nome, nome_social = @nome_social, data_nasc = @data_nasc ,telefone1 = @telefone1, telefone2 = @telefone2,
		email_p = @email_p, email_c = @email_c, data_seg_grau = @data_seg_grau, ints_seg_grau = @ints_seg_grau, pontu_vesti = @pontu_vesti, 
		ano_ingre = @ano_ingre, semestre_ingre = @semestre_ingre, semestre_limit = @semestre_limit, ano_grad_limit = @ano_limit, cod_curso = @cod_curso,
		turno_curso = @turno_curso
		WHERE ra_aluno = @ra_aluno;
	END TRY
	BEGIN CATCH
		RAISERROR('Ocorreu algum erro em alterar dados do aluno', 16, 1)
	END CATCH

/* RA, nome completo, nome do curso, data da primeira matrícula, pontuação do
vestibular, posição no vestibular
*/
select a.ra_aluno, a.nome,  SUBSTRING(a.ra_aluno, 1, 4) + ' ' + SUBSTRING(a.ra_aluno, 5, 1) as 'Data Matricula', a.pontu_vesti, DENSE_RANK() OVER (ORDER BY a.pontu_vesti DESC) AS POSIÇÃO
from aluno a, curso c
where a.cod_curso = c.cod_curso
order by a.pontu_vesti DESC

/*
uma lista das matrículas que o aluno foi aprovado (TAMBÉM DISPENSADO) Código da disciplina, nome da disciplina,
nome do professor, nota final, quantidade de faltas
*/
select d.cod_disci, d.nome_disci, dc.nome_professor, md.nota_final, md.qtd_faltas,
CASE WHEN md.situacao = 'dispensado' then 'D' ELSE nota_final END as nota_final
from disciplina d, disciplina_curso dc, matricula_disc md
where d.cod_disci = dc.cod_disci
AND md.id_disciplina_curso = dc.id_disciplina_curso
AND md.ra_aluno = 202114321
AND (Situacao = 'aprovado' OR Situacao = 'dispensado')

 GO

-- Caso o aluno tenha sido dispensado, deve-se apresentar a nota final D.
select md.id_matricula_aluno, md.ra_aluno, md.id_disciplina_curso, md.situacao,
CASE WHEN situacao = 'dispensado' then 'D' 
ELSE nota_final
END as nota_final
from matricula_disc md, disciplina_curso dc 
where md.id_disciplina_curso = dc.id_disciplina_curso
AND dc.cod_curso = 2
AND ra_aluno = '202114321'
