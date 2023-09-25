package persistencia;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class GenericDao {

	private Connection c;

	public Connection getConnection() throws ClassNotFoundException, SQLException {
		String hostName = "localhost";
		String dbName = "lbd_av1";
		String user = "felipe";
		String senha = "123";

		try {
			Class.forName("net.sourceforge.jtds.jdbc.Driver");

			c = DriverManager
					.getConnection(String.format("jdbc:jtds:sqlserver://%s:1443;databaseName=%s;user=%s;password=%s",
							hostName, dbName, user, senha));
			System.out.println(c);
		} catch (ClassNotFoundException e) {
			System.err.println("Driver JDBC não encontrado.");
		} catch (SQLException e) {
			System.err.println("Erro ao conectar ao banco de dados: " + e.getMessage());
		}
		return c;
	}
}






