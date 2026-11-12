package br.com.senai.projeto.dao;

import br.com.senai.projeto.config.conexao;
import br.com.senai.projeto.model.Entidade;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class entidadeDAO {

    public void cadastrar(Entidade entidade) {
        String sql = "INSERT INTO entidade (id, nome, ano, plataforma, genero) VALUES (?, ?, ?, ?, ?)";

        try (Connection conn = conexao.conectar();
             PreparedStatement stmt = conn.prepareStatement(sql)) {


            stmt.setInt(1, entidade.getId());
            stmt.setString(2, entidade.getNome());
            stmt.setInt(3, entidade.getAno());
            stmt.setString(4, entidade.getPlataforma());
            stmt.setString(5, entidade.getGenero());

            stmt.executeUpdate();

        } catch (SQLException e) {
            throw new RuntimeException("Erro ao cadastrar entidade: " + e.getMessage(), e);
        }
    }
}