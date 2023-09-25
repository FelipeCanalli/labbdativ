<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html lang="pt-br">
<head>
<meta charset="ISO-8859" />

<meta name="viewport" content="width=device-width, initial-scale=1.0" />

<title>Document</title>
</head>
<body>
	<div><jsp:include page="menu.jsp" /></div>
	<div align="center">
		<h1>AGIS</h1>
	</div>
	<div id="idTable">
		<form action="aluno" method="post">
			<table>
				<tr>
					<td><input type="text" id="ra_aluno" name="ra_aluno"
						placeholder="RA" required="required" 
						value='<c:out value="${aluno.ra_aluno }"></c:out>'></td>
				</tr>
				<tr>
					<td><input type="text" id="cpf" name="cpf" placeholder="CPF"
						required="required" value='<c:out value="${aluno.cpf }"></c:out>'>
					</td>
				</tr>
				<tr>
					<td><input type="text" id="nome" name="nome"
						placeholder="Nome" required="required"
						value='<c:out value="${aluno.nome }"></c:out>'>
				</tr>

				<tr>
					<td><input type="text" id="nome_social" name="nome_social"
						placeholder="Nome Social"
						value='<c:out value="${aluno.nome_social }"></c:out>'></td>
				</tr>

				<tr>
					<td><input type="text" id="data_nasc" name="data_nasc"
						placeholder="Data Nascimento" required="required"
						value='<c:out value="${aluno.data_nasc }"></c:out>'></td>
				</tr>

				<tr>
					<td><input type="number" id="telefone1" name="telefone1"
						placeholder="Telefone 1" required="required"
						value='<c:out value="${aluno.telefone1 }"></c:out>'></td>
					<td><input type="number" id="telefone2" name="telefone2"
						placeholder="Telefone 2" required="required"
						value='<c:out value="${aluno.telefone2 }"></c:out>'></td>
				</tr>

				<tr>
					<td><input type="text" id="email_p" name="email_p"
						placeholder="Email Pessoal" required="required"
						value='<c:out value="${aluno.email_p}"></c:out>'></td>
				</tr>

				<tr>
					<td><input type="text" id="email_c" name="email_c"
						placeholder="Email Corporativo" required="required"
						value='<c:out value="${aluno.email_c}"></c:out>'>
				</tr>

				<tr>
					<td><input type="text" id="inst_seg_grau" name="inst_seg_grau"
						placeholder="Escola Segundo Grau" required="required"
						value='<c:out value="${aluno.inst_seg_grau}"></c:out>'></td>
				</tr>

				<tr>
					<td><input type="text" id="data_seg_grau" name="data_seg_grau"
						placeholder="Data Segundo Grau Formação" required="required"
						value='<c:out value="${aluno.data_seg_grau}"></c:out>'></td>
				</tr>

				<tr>
					<td><input type="number" id="pontu_vesti" name="pontu_vesti"
						placeholder="Pontuação vestibular" required="required"
						value='<c:out value="${aluno.pontu_vesti }"></c:out>'></td>
				</tr>

				<tr>
					<td><input type="number" id="ano_ingre" name="ano_ingre"
						placeholder="Ano de ingresso" required="required"
						value='<c:out value="${aluno.ano_ingre}"></c:out>'></td>
				</tr>

				<tr>
					<td><input type="number" id="semestre_ingre"
						name="semestre_ingre" min="1" max="2"
						placeholder="Semestre de ingresso do ano" required="required"
						value='<c:out value="${aluno.semestre_ingre}"></c:out>'></td>
				</tr>

				<tr>
					<td><input type="number" id="ano_grad_limite"
						name="ano_grad_limite" placeholder="Ano graduação limite" 
						value='<c:out value="${aluno.ano_grad_limite }"></c:out>'>
					</td>
				</tr>

				<tr>
					<td><input type="number" id="semestre_limite"
						name="semestre_limite" placeholder="Semestre limite" 
						value='<c:out value="${aluno.semestre_limite }"></c:out>'>
					</td>
				</tr>

				<tr>
					<td><input type="number" id="cod_curso" name="cod_curso"
						placeholder="Código curso"
						value='<c:out value="${aluno.cod_curso}"></c:out>'></td>
				</tr>

				<tr>
					<td><input type="text" id="turno_curso" name="turno_curso"
						placeholder="Turno curso"
						value='<c:out value="${aluno.turno_curso }"></c:out>'></td>
				</tr>

				<tr>
					<td><input type="submit" id="botao" name="botao"
						value="Cadastrar" /></td>
					<td><input type="submit" id="botao" name="botao"
						value="Atualizar" /></td>
					<td><input type="submit" id="botao" name="botao"
						value="Excluir" /></td>
					<td><input type="submit" id="botao" name="botao"
						value="Listar" /></td>
				</tr>
			</table>
		</form>
	</div>
	<br />
	<div align="center">

		<c:if test="${not empty erro} }">
			<h2>
				<b><c:out value="${erro}" /></b>
			</h2>

		</c:if>

		<c:if test="${not empty erro} }">
			<h3>
				<b><c:out value="${saida}" /></b>
			</h3>
		</c:if>

	</div>
	<br />

	<div align="center">

		<c:if test="${not empty alunos }">
			<table class="table_round">
				<thead>
					<tr>
						<th>RA</th>
						<th>CPF</th>
						<th>Nome</th>
						<th>Nome Social</th>
					</tr>
				</thead>
				<tbody>

					<c:forEach var="a" items="${alunos}">
						<tr>
							<td><c:out value="${a.ra_aluno}" /></td>
							<td><c:out value="${a.cpf}" /></td>
							<td><c:out value="${a.nome}" /></td>
						</tr>
					</c:forEach>
				</tbody>

			</table>
		</c:if>

	</div>
</body>
</html>











