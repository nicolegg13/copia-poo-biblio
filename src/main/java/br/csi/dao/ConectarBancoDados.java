package br.csi.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class ConectarBancoDados {
    public static Connection conectarBancoPostgres() throws ClassNotFoundException, SQLException {
        Class.forName("org.postgresql.Driver");

        // Pega a URL do banco de dados da variável de ambiente
        // Se a variável não existir, usa 'localhost' como padrão (para rodar fora do Docker)
        String dbHost = System.getenv("DB_HOST");
        if (dbHost == null) {
            dbHost = "localhost"; // Valor padrão caso não esteja rodando no Docker
        }

        String url = "jdbc:postgresql://" + dbHost + ":5432/poow_trabalho";
        String user = "postgres";
        String senha = "1234";

        return DriverManager.getConnection(url, user, senha);
    }
}
