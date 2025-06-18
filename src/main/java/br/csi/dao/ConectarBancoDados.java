package br.csi.dao;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class ConectarBancoDados {
    public static Connection conectarBancoPostgres() throws ClassNotFoundException, SQLException {
        Class.forName("org.postgresql.Driver");

        // lê a variável de ambiente DB_HOST ('db')
        String dbHost = System.getenv("DB_HOST");
        if (dbHost == null) {
            dbHost = "localhost"; // se não achar DB_HOST, usa localhost como padrão
        }

        String url = "jdbc:postgresql://" + dbHost + ":5432/poow_trabalho";
        String user = "postgres";
        String senha = "1234";
        return DriverManager.getConnection(url, user, senha);
    }
}
