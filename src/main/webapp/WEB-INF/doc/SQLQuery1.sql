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
	data_nasc DATE NOT NULL,
	telefone1 VARCHAR (11) NOT NULL,
	telefone2 VARCHAR (11) NOT NULL,
	email_p VARCHAR (100) NOT NULL,
	email_c VARCHAR (100) NOT NULL,
	data_seg_grau DATE NOT NULL,
	ints_seg_grau VARCHAR (50) NOT NULL,
	pontu_vesti FLOAT NOT NULL,
	ano_ingre INT NOT NULL,
	semestre_ingre INT NOT NULL,
	semestre_limit INT NOT NULL,
	ano_grad_limit INT NOT NULL,
	cod_curso VARCHAR (5) NOT NULL,
	turno_curso VARCHAR (10) NOT NULL
	FOREIGN KEY (cod_curso) REFERENCES curso(cod_curso)
)

CREATE TABLE disciplina(
	cod_disci int IDENTITY(1001, 1) NOT NULL PRIMARY KEY, 
	nome_disci VARCHAR (100) NOT NULL,
	qtd_horas_sem int NOT NULL
)

-- Relacionamento aluno - disciplina_curso N - N 
CREATE TABLE matricula_disc(
	id_matricula_aluno int not null primary key,
	ra_aluno VARCHAR (13) not null,
	id_disciplina_curso int IDENTITY(1001, 1) NOT NULL,
	FOREIGN KEY (ra_aluno) REFERENCES aluno(ra_aluno),
	FOREIGN KEY (id_disciplina_curso) REFERENCES disciplina_curso(id_disciplina_curso)
)

-- Relacionamento curso - disciplina N - N 
CREATE TABLE disciplina_curso(
	id_disciplina_curso int not null primary key,
	cod_curso INT NOT NULL,
	cod_disci int NOT NULL,
	FOREIGN KEY (cod_disci) REFERENCES disciplina(cod_disci),
	FOREIGN KEY (cod_curso) REFERENCES curso(cod_curso)
)

GO
-- Regra Nº1 - validar cpf

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
	print @CPF
	DECLARE @verificador VARCHAR(2)
	SET @verificador = CAST (@digito1 AS VARCHAR) + CAST (@digito2 AS VARCHAR)
IF (SUBSTRING(@cpf, 10,2) = @verificador )
	BEGIN
		SET @valido = 1
	END
	ELSE
	BEGIN
		SET @valido = 0
	END

GO

-- Regra Nº2 - valide uma idade igual ou superior a 16 anos antes da inserção
CREATE PROCEDURE sp_valida_idade(@dt_nasc DATE, @valido BIT OUTPUT)
AS
	DECLARE @hoje	DATE,
			@idade	INT
	SET @hoje = (SELECT GETDATE())
	SET @idade = DATEDIFF(DAY, @dt_nasc, @hoje) / 365
	Print @idade
	IF (@idade >= 16)
	BEGIN
		SET @valido = 1
	END
	ELSE
	BEGIN
		SET @valido = 0
	END

GO

-- Regra Nº3 -  A data limite de graduação deve ser a saída de uma procedure que calcula 5 anos do ingresso
CREATE PROCEDURE sp_calcula_limi_gradu (@ano_ingre INT, @semestre_ingre INT,  @ano_limit INT OUTPUT, @semestre_limit INT OUTPUT)
AS
SET @semestre_limit = @semestre_ingre
SET @ano_limit = @ano_ingre + 5

GO

-- Regra Nº4 -O RA inicia com o ano de ingresso, seguido pelo semestre de ingresso e 4 números aleatórios, deve ser gerado por uma procedure para inserção.
CREATE PROCEDURE sp_calcula_ra (@ano_ingre INT, @semestre_ingre INT, @ra_aluno VARCHAR (9) OUTPUT)
AS
SET @ra_aluno = CAST(@ano_ingre AS VARCHAR) + CAST(@semestre_ingre AS VARCHAR) + CAST(FLOOR(RAND() * (8999) + 1000)  AS VARCHAR)

GO
/*
5. A inserção das matrículas deve ter suas regras controladas por uma procedure e só ser confirmada
caso não haja nenhuma restrição.
	
*/




