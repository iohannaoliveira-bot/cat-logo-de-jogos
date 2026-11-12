// Adicionar Listagem e consulta (Read)

package br.com.senai.projeto.config;

import java.sql.*;

public class conexao {
    private static final String URL =
            "jdbc:h2:file:./data/banco";

    private static final String USUARIO = "sa";
    private static final String SENHA = "";

    public static Connection conectar() throws SQLException {
        try {
            Class.forName("org.h2.Driver");
        } catch (ClassNotFoundException e) {
            throw new RuntimeException("Driver H2 não encontrado!", e);
        }
        return DriverManager.getConnection(
                URL, USUARIO, SENHA
        );
    }

    public static void createTable() {
        String sql = "CREATE TABLE IF NOT EXISTS entidade (\n" +
                "    id INT PRIMARY KEY,\n" +
                "    nome VARCHAR(150) NOT NULL,\n" +
                "    ano INT NOT NULL,\n" +
                "    plataforma VARCHAR(100) NOT NULL,\n" +
                "    genero VARCHAR(100) NOT NULL\n" +
                ")";

        try (Connection conn = conectar();
             Statement stmt = conn.createStatement()){
            stmt.execute(sql);

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
}