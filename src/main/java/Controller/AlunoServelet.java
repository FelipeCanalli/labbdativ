package Controller;

import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Aluno;
import persistencia.AlunoDao;
import persistencia.GenericDao;

@WebServlet("/aluno")
public class AlunoServelet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public AlunoServelet() {
		super();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		RequestDispatcher rd = request.getRequestDispatcher("index.jsp");
		rd.forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// Entrada
		String cmd = request.getParameter("botao");
		String ra_aluno = request.getParameter("ra_aluno");
		String cpf = request.getParameter("cpf");
		String nome = request.getParameter("nome");
		String nome_social = request.getParameter("nome_social");
		String telefone1 = request.getParameter("telefone1");
		String telefone2 = request.getParameter("telefone2");
		String email_p = request.getParameter("email_p");
		String email_c = request.getParameter("email_c");
		String data_nasc = request.getParameter("data_nasc");
		String data_seg_grau = request.getParameter("data_seg_grau");
		String ints_seg_grau = request.getParameter("ints_seg_grau");
		String pontu_vesti = request.getParameter("pontu_vesti");
		String ano_ingre = request.getParameter("ano_ingre");
		String semestre_ingre = request.getParameter("semestre_ingre");
		String semestre_limite = request.getParameter("semestre_limite");
		String ano_grad_limite = request.getParameter("ano_grad_limite");
		String cod_curso = request.getParameter("cod_curso");
		String turno_curso = request.getParameter("turno_curso");

		// Saida
		String saida = "";
		String erro = "";
		Aluno a = new Aluno();
		List<Aluno> alunos = new ArrayList<>();

		if (!cmd.contains("Listar")) {
			a.setRa_aluno(ra_aluno);
		}
		if (cmd.contains("Cadastrar") || cmd.contains("Alterar")) {
			a.setRa_aluno(ra_aluno);
			a.setCpf(cpf);
			a.setNome(nome);
			a.setNome_social(nome_social);
			a.setTelefone1(telefone1);
			a.setTelefone2(telefone2);
			a.setEmail_p(email_p);
			a.setEmail_c(email_c);
			a.setData_nasc(data_nasc);
			a.setData_seg_grau(data_seg_grau);
			a.setInts_seg_grau(ints_seg_grau);
			a.setPontu_vesti(pontu_vesti);
			a.setAno_ingre(ano_ingre);
			a.setSemestre_ingre(semestre_ingre);
			a.setSemestre_limite(semestre_limite);
			a.setAno_grad_limite(ano_grad_limite);
			a.setCod_curso(cod_curso);
			a.setTurno_curso(turno_curso);

		}
		try {
			if (cmd.contains("Cadastrar")) {
				cadastrarAluno(a);
				saida = "Aluno Cadastrado com sucesso";
				a = null;
			}

			if (cmd.contains("Alterar")) {
				alterarAluno(a);
				saida = "Aluno Alterado com sucesso";
				a = null;
			}

			if (cmd.contains("Excluir")) {
				excluirAluno(a);
				saida = "Aluno Excluido com sucesso";
				a = null;
			}

			if (cmd.contains("Buscar")) {
				a = buscarAluno(a);
			}

			if (cmd.contains("Listar")) {
				alunos = listarAlunos();
			}

		} catch (SQLException | ClassNotFoundException e) {
			erro = e.getMessage();
			System.out.println(e);
			e.printStackTrace();
		} finally {

			request.setAttribute("saida", saida);
			request.setAttribute("erro", erro);
			request.setAttribute("aluno", a);
			request.setAttribute("alunos", alunos);

			RequestDispatcher rd = request.getRequestDispatcher("index.jsp");
			rd.forward(request, response);
		}
	}

	private void cadastrarAluno(Aluno a) throws SQLException, ClassNotFoundException {
		GenericDao gDao = new GenericDao();
		AlunoDao aDao = new AlunoDao(gDao);
		aDao.inserir(a);
		listarAlunos();

	}

	private void alterarAluno(Aluno a) throws SQLException, ClassNotFoundException {
		GenericDao gDao = new GenericDao();
		AlunoDao aDao = new AlunoDao(gDao);
		aDao.atualizar(a);
		listarAlunos();

	}

	private void excluirAluno(Aluno a) throws SQLException, ClassNotFoundException {
		GenericDao gDao = new GenericDao();
		AlunoDao aDao = new AlunoDao(gDao);
		aDao.excluir(a);
		listarAlunos();

	}

	private Aluno buscarAluno(Aluno a) throws SQLException, ClassNotFoundException {
		GenericDao gDao = new GenericDao();
		AlunoDao aDao = new AlunoDao(gDao);
		a = aDao.consultar(a);
		return a;
	}

	private List<Aluno> listarAlunos() throws SQLException, ClassNotFoundException {
		GenericDao gDao = new GenericDao();
		AlunoDao aDao = new AlunoDao(gDao);
		List<Aluno> alunos = aDao.listar();
		return alunos;

	}

}
