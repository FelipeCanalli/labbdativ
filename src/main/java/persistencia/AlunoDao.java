package persistencia;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import model.Aluno;

public class AlunoDao implements ICrud<Aluno> {

	private GenericDao gDao;

	public AlunoDao(GenericDao gDao) {
		this.gDao = gDao;
	}

	@Override
	public void inserir(Aluno a) throws SQLException, ClassNotFoundException {
		Connection c = gDao.getConnection();
		String sql = "exec sp_inserealuno ?,?,?,?,?,?,?,?,?,?,?,?,?,?,?";
		PreparedStatement ps = c.prepareStatement(sql);
		ps.setString(1, a.getCpf());
		ps.setString(2, a.getNome());
		ps.setString(3, a.getNome_social());
		ps.setString(4, a.getData_nasc());
		ps.setString(5, a.getTelefone1());
		ps.setString(6, a.getTelefone2());
		ps.setString(7, a.getEmail_p());
		ps.setString(8, a.getEmail_c());
		ps.setString(9, a.getData_seg_grau());
		ps.setString(10, a.getInts_seg_grau());
		ps.setString(11, a.getPontu_vesti());
		ps.setString(12, a.getAno_ingre());
		ps.setString(13, a.getSemestre_ingre());
		ps.setString(14, a.getCod_curso());
		ps.setString(15, a.getTurno_curso());
		ps.execute();
		ps.close();
		c.close();
	}

	@Override
	public void atualizar(Aluno a) throws SQLException, ClassNotFoundException {
		System.out.println(a);
		Connection c = gDao.getConnection();
		String sql = "exec sp_alteraaluno ?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?";
		PreparedStatement ps = c.prepareStatement(sql);
		ps.setString(1, a.getCpf());
		ps.setString(2, a.getNome());
		ps.setString(3, a.getNome_social());
		ps.setString(4, a.getData_nasc());
		ps.setString(5, a.getTelefone1());
		ps.setString(6, a.getTelefone2());
		ps.setString(7, a.getEmail_p());
		ps.setString(8, a.getEmail_c());
		ps.setString(9, a.getData_seg_grau());
		ps.setString(10, a.getInts_seg_grau());
		ps.setString(11, a.getPontu_vesti());
		ps.setString(12, a.getAno_ingre());
		ps.setString(13, a.getSemestre_ingre());
		ps.setString(14, a.getAno_grad_limite()); 
		ps.setString(15, a.getSemestre_limite()); 
		ps.setString(16, a.getCod_curso());
		ps.setString(17, a.getTurno_curso());
		ps.setString(18, a.getRa_aluno());

		ps.execute();
		ps.close();
		c.close();
	}

	@Override
	public void excluir(Aluno a) throws SQLException, ClassNotFoundException {
		Connection c = gDao.getConnection();
		String sql = "DELETE aluno WHERE ra_aluno =  ?";
		PreparedStatement ps = c.prepareStatement(sql);
		ps.setString(1, a.getRa_aluno());
		ps.execute();
		ps.close();
		c.close();

	}

	@Override
	public Aluno consultar(Aluno a) throws SQLException, ClassNotFoundException {
		Connection c = gDao.getConnection();
		String sql = "SELECT * from aluno WHERE ra_aluno =  ?";
		PreparedStatement ps = c.prepareStatement(sql);
		ps.setString(1, a.getRa_aluno());
		ResultSet rs = ps.executeQuery();
		if (rs.next()) {
			a.setRa_aluno(rs.getString("ra_aluno"));
			a.setCpf(rs.getString("cpf"));
			a.setNome(rs.getString("nome"));
			a.setNome_social(rs.getString("nome_social"));
			a.setData_nasc(rs.getString("data_nasc"));
			a.setTelefone1(rs.getString("telefone1"));
			a.setTelefone2(rs.getString("telefone2"));
			a.setEmail_p(rs.getString("email_p"));
			a.setEmail_c(rs.getString("email_c"));
			a.setData_seg_grau(rs.getString("data_seg_grau"));
			a.setInts_seg_grau(rs.getString("ints_seg_grau"));
			a.setPontu_vesti(rs.getString("pontu_vesti"));
			a.setAno_ingre(rs.getString("ano_ingre"));
			a.setSemestre_ingre(rs.getString("semestre_ingre"));
			a.setSemestre_limite(rs.getString("semestre_limit"));
			a.setAno_grad_limite(rs.getString("ano_grad_limit"));
			a.setCod_curso(rs.getString("cod_curso"));
			a.setTurno_curso(rs.getString("turno_curso"));
		}
		rs.close();
		ps.close();
		c.close();
		return a;
	}

	@Override
	public List<Aluno> listar() throws SQLException, ClassNotFoundException {
		List<Aluno> alunos = new ArrayList<>();
		Connection c = gDao.getConnection();
		String sql = "SELECT * FROM aluno ";
		PreparedStatement ps = c.prepareStatement(sql);
		ResultSet rs = ps.executeQuery();
		while (rs.next()) {
			Aluno a = new Aluno();
			a.setRa_aluno(rs.getString("ra_aluno"));
			a.setCpf(rs.getString("cpf"));
			a.setNome(rs.getString("nome"));
			a.setNome_social(rs.getString("nome_social"));
			a.setData_nasc(rs.getString("data_nasc"));
			a.setTelefone1(rs.getString("telefone1"));
			a.setTelefone2(rs.getString("telefone2"));
			a.setEmail_p(rs.getString("email_p"));
			a.setEmail_c(rs.getString("email_c"));
			a.setData_seg_grau(rs.getString("data_seg_grau"));
			a.setInts_seg_grau(rs.getString("ints_seg_grau"));
			a.setPontu_vesti(rs.getString("pontu_vesti"));
			a.setAno_ingre(rs.getString("ano_ingre"));
			a.setSemestre_ingre(rs.getString("semestre_ingre"));
			a.setSemestre_limite(rs.getString("semestre_limit"));
			a.setAno_grad_limite(rs.getString("ano_grad_limit"));
			a.setCod_curso(rs.getString("cod_curso"));
			a.setTurno_curso(rs.getString("turno_curso"));

			alunos.add(a);
		}
		rs.close();
		ps.close();
		c.close();
		return alunos;
	}

}
