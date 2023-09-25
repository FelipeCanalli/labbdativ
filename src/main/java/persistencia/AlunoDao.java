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

		String sql = "INSERT INTO aluno (cpf, nome, nome_social, data_nasc, telefone1, telefone2, email_p, email_c, data_seg_grau, ints_seg_grau, pontu_vesti, ano_ingre, semestre_ingre, cod_curso, turno_curso) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
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
		ps.setString(10, a.getInst_seg_grau());
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

		Connection c = gDao.getConnection();
		String sql = "UPDATE aluno SET cpf = ?, nome = ?,nome_social = ?, data_nasc = ?,telefone1 = ?,telefone2 = ?,email_p = ?, email_c = ?, data_seg_grau = ?, ints_seg_grau = ?, pontu_vesti = ?, ano_ingre = ?, semestre_ingre = ?, semestre_limit = ?,   ano_grad_limit = ?,	cod_curso = ?,	  turno_curso = ?	WHERE ra_aluno = ?";
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
		ps.setString(10, a.getInst_seg_grau());
		ps.setString(11, a.getPontu_vesti());
		ps.setString(12, a.getAno_ingre());
		ps.setString(13, a.getSemestre_ingre());
		ps.setString(14, a.getSemestre_limite());
		ps.setString(15, a.getAno_grad_limite());
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
		String sql = "SELECt * from aluno WHERE ra_aluno =  ?";
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
            		a.setInst_seg_grau(rs.getString("ints_seg_grau"));
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
            		a.setInst_seg_grau(rs.getString("ints_seg_grau"));
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
//
//INSERT INTO aluno (ra_aluno, cpf, nome, nome_social, data_nasc, telefone1, telefone2, email_p, email_c, data_seg_grau, ints_seg_grau, pontu_vesti, ano_ingre, semestre_ingre, semestre_limit, ano_grad_limit, cod_curso, turno_curso)
//VALUES ('123456789', '12345678901', 'João Silva', NULL, '1995-03-15', '1122334455', '9988776655', 'joao@email.com', 'contato@email.com', '2012-06-30', 'Escola A', 7.5, 2015, 1, 10, 2019, 'C001', 'Matutino');
//
//
//INSERT INTO aluno (ra_aluno, cpf, nome, nome_social, data_nasc, telefone1, telefone2, email_p, email_c, data_seg_grau, ints_seg_grau, pontu_vesti, ano_ingre, semestre_ingre, semestre_limit, ano_grad_limit, cod_curso, turno_curso)
//VALUES ('987654321', '98765432109', 'Maria Santos', 'Mário Santos', '1998-07-20', '9988776655', '1122334455', 'maria@email.com', 'contato@email.com', '2016-06-15', 'Escola B', 8.2, 2019, 1, 8, 2023, 'C002', 'Noturno');
//
//
//INSERT INTO aluno (ra_aluno, cpf, nome, nome_social, data_nasc, telefone1, telefone2, email_p, email_c, data_seg_grau, ints_seg_grau, pontu_vesti, ano_ingre, semestre_ingre, semestre_limit, ano_grad_limit, cod_curso, turno_curso)
//VALUES ('789123456', '78912345612', 'Carlos Pereira', NULL, '2000-11-02', '5544332211', '1122334455', 'carlos@email.com', 'contato@email.com', '2018-05-20', 'Escola C', 6.8, 2020, 2, 6, 2024, 'C003', 'Matutino');
//
//
//INSERT INTO aluno (ra_aluno, cpf, nome, nome_social, data_nasc, telefone1, telefone2, email_p, email_c, data_seg_grau, ints_seg_grau, pontu_vesti, ano_ingre, semestre_ingre, semestre_limit, ano_grad_limit, cod_curso, turno_curso)
//VALUES ('456789123', '45678912345', 'Ana Silva', NULL, '1997-09-10', '1122334455', '5544332211', 'ana@email.com', 'contato@email.com', '2015-07-12', 'Escola A', 7.0, 2018, 2, 8, 2022, 'C001', 'Noturno');
//
//
//INSERT INTO aluno (ra_aluno, cpf, nome, nome_social, data_nasc, telefone1, telefone2, email_p, email_c, data_seg_grau, ints_seg_grau, pontu_vesti, ano_ingre, semestre_ingre, semestre_limit, ano_grad_limit, cod_curso, turno_curso)
//VALUES ('987123456', '98712345678', 'Lucas Oliveira', 'Luana Oliveira', '1999-04-25', '9988776655', '5544332211', 'lucas@email.com', 'contato@email.com', '2017-06-28', 'Escola D', 7.9, 2019, 1, 8, 2023, 'C004', 'Matutino');
//
