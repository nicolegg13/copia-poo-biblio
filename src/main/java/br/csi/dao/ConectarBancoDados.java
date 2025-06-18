package br.csi.dao;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class ConectarBancoDados {
    public static Connection conectarBancoPostgres() throws ClassNotFoundException, SQLException {
        Class.forName("org.postgresql.Driver");

        // Tenta ler o nome do host do banco de uma variável de ambiente 'DB_HOST'.
        // Se a variável não existir (por exemplo, ao rodar localmente fora do Docker),
        // ele usará 'localhost' como padrão.
        String dbHost = System.getenv("DB_HOST");
        if (dbHost == null) {
            dbHost = "localhost";
        }

        // A URL agora usa a variável 'dbHost' para se conectar.
        // Dentro do Docker Compose, dbHost será 'db'. Fora, será 'localhost'.
        String url = "jdbc:postgresql://" + dbHost + ":5432/poow_trabalho";
        String user = "postgres";
        String senha = "1234";
        return DriverManager.getConnection(url, user, senha);
    }
}
