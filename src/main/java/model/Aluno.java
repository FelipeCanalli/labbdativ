package model;

public class Aluno {
	private String ra_aluno;
	private String cpf;
	private String nome;
	private String nome_social;
	private String data_nasc;
	private String telefone1;
	private String telefone2;
	private String email_p;
	private String email_c;
	private String data_seg_grau;
	private String inst_seg_grau;
	private String pontu_vesti;
	private String ano_ingre;
	private String semestre_ingre;
	private String semestre_limite;
	private String ano_grad_limite;
	private String cod_curso;
	private String turno_curso;


	public String getRa_aluno() {
		return ra_aluno;
	}


	public void setRa_aluno(String ra_aluno) {
		this.ra_aluno = ra_aluno;
	}


	public String getCpf() {
		return cpf;
	}


	public void setCpf(String cpf) {
		this.cpf = cpf;
	}


	public String getNome() {
		return nome;
	}


	public void setNome(String nome) {
		this.nome = nome;
	}


	public String getNome_social() {
		return nome_social;
	}


	public void setNome_social(String nome_social) {
		this.nome_social = nome_social;
	}


	public String getData_nasc() {
		return data_nasc;
	}


	public void setData_nasc(String data_nasc) {
		this.data_nasc = data_nasc;
	}


	public String getTelefone1() {
		return telefone1;
	}


	public void setTelefone1(String telefone1) {
		this.telefone1 = telefone1;
	}


	public String getTelefone2() {
		return telefone2;
	}


	public void setTelefone2(String telefone2) {
		this.telefone2 = telefone2;
	}


	public String getEmail_p() {
		return email_p;
	}


	public void setEmail_p(String email_p) {
		this.email_p = email_p;
	}


	public String getEmail_c() {
		return email_c;
	}


	public void setEmail_c(String email_c) {
		this.email_c = email_c;
	}


	public String getData_seg_grau() {
		return data_seg_grau;
	}


	public void setData_seg_grau(String data_seg_grau) {
		this.data_seg_grau = data_seg_grau;
	}


	public String getInst_seg_grau() {
		return inst_seg_grau;
	}


	public void setInst_seg_grau(String inst_seg_grau) {
		this.inst_seg_grau = inst_seg_grau;
	}


	public String getPontu_vesti() {
		return pontu_vesti;
	}


	public void setPontu_vesti(String pontu_vesti) {
		this.pontu_vesti = pontu_vesti;
	}


	public String getAno_ingre() {
		return ano_ingre;
	}


	public void setAno_ingre(String ano_ingre) {
		this.ano_ingre = ano_ingre;
	}


	public String getSemestre_ingre() {
		return semestre_ingre;
	}


	public void setSemestre_ingre(String semestre_ingre) {
		this.semestre_ingre = semestre_ingre;
	}


	public String getSemestre_limite() {
		return semestre_limite;
	}


	public void setSemestre_limite(String semestre_limite) {
		this.semestre_limite = semestre_limite;
	}


	public String getAno_grad_limite() {
		return ano_grad_limite;
	}


	public void setAno_grad_limite(String ano_grad_limite) {
		this.ano_grad_limite = ano_grad_limite;
	}


	public String getCod_curso() {
		return cod_curso;
	}


	public void setCod_curso(String cod_curso) {
		this.cod_curso = cod_curso;
	}


	public String getTurno_curso() {
		return turno_curso;
	}


	public void setTurno_curso(String turno_curso) {
		this.turno_curso = turno_curso;
	}


	@Override
	public String toString() {
		return "Aluno [ra_aluno=" + ra_aluno + ", cpf=" + cpf + ", nome=" + nome + ", nome_social=" + nome_social
				+ ", data_nasc=" + data_nasc + ", telefone1=" + telefone1 + ", telefone2=" + telefone2 + ", email_p="
				+ email_p + ", email_c=" + email_c + ", data_seg_grau=" + data_seg_grau + ", inst_seg_grau="
				+ inst_seg_grau + ", pontu_vesti=" + pontu_vesti + ", ano_ingre=" + ano_ingre + ", semestre_ingre="
				+ semestre_ingre + ", semestre_limite=" + semestre_limite + ", ano_grad_limite=" + ano_grad_limite
				+ ", cod_curso=" + cod_curso + ", turno_curso=" + turno_curso + "]";
	}

}
