
package br.com.senai.projeto.dao
;
import br.com.senai.projeto.config.conexao
        ;
import br.com.senai.projeto.model.Entidade
        ;
import java.sql.Connection
        ;
import java.sql.PreparedStatement
        ;
import java.sql.ResultSet
        ;
import java.sql.SQLException
        ;
public class entidadeDAO {


    public void cadastrar(Entidade entidade) {
        String sql = "INSERT INTO entidade (id, nome, ano, plataforma, genero) VALUES (?, ?, ?, ?, ?)"
                ;
        try (Connection conn = conexao.conectar()
             ;
             PreparedStatement stmt = conn.prepareStatement(sql)) {


            stmt.setInt(1, entidade.getId())
            ;
            stmt.setString(2, entidade.getNome())
            ;
            stmt.setInt(3, entidade.getAno())
            ;
            stmt.setString(4, entidade.getPlataforma())
            ;
            stmt.setString(5, entidade.getGenero())
            ;
            stmt.executeUpdate()
            ;
        } catch (SQLException e) {
            throw new RuntimeException("Erro ao cadastrar entidade: " + e.getMessage(), e)
                    ;
        }
    }


    public void listar() {
        String sql = "SELECT * FROM entidade"
                ;
        try (Connection conn = conexao.conectar()
             ;
             PreparedStatement stmt = conn.prepareStatement(sql)
             ;
             ResultSet rs = stmt.executeQuery()) {


            while (rs.next()) {
                int id = rs.getInt("id")
                        ;
                String nome = rs.getString("nome")
                        ;
                int ano = rs.getInt("ano")
                        ;
                String plataforma = rs.getString("plataforma")
                        ;
                String genero = rs.getString("genero")
                        ;
                System.out.println("ID: " + id + ", Nome: " + nome + ", Ano: " + ano +
                        ", Plataforma: " + plataforma + ", Gênero: " + genero)
                ;
            }
        } catch (SQLException e) {
            throw new RuntimeException("Erro ao listar entidades: " + e.getMessage(), e)
                    ;
        }
    }


    public void consultar(int id) {
        String sql = "SELECT * FROM entidade WHERE id = ?"
                ;
        try (Connection conn = conexao.conectar()
             ;
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, id)
            ;
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    String nome = rs.getString("nome")
                            ;
                    int ano = rs.getInt("ano")
                            ;
                    String plataforma = rs.getString("plataforma")
                            ;
                    String genero = rs.getString("genero")
                            ;
                    System.out.println("ID: " + id + ", Nome: " + nome + ", Ano: " + ano +
                            ", Plataforma: " + plataforma + ", Gênero: " + genero)
                    ;
                } else {
                    System.out.println("Entidade não encontrada.")
                    ;
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException("Erro ao consultar entidade: " + e.getMessage(), e)
                    ;
        }
    }
    public void atualizar(Entidade entidade) {
        String sql = "UPDATE entidade SET nome = ?, ano = ?, plataforma = ?, genero = ? WHERE id = ?"
                ;
        try (Connection conn = conexao.conectar()
             ;
             PreparedStatement stmt = conn.prepareStatement(sql)) {


            stmt.setString(1, entidade.getNome())
            ;
            stmt.setInt(2, entidade.getAno())
            ;
            stmt.setString(3, entidade.getPlataforma())
            ;
            stmt.setString(4, entidade.getGenero())
            ;
            stmt.setInt(5, entidade.getId())
            ;
            int rowsAffected = stmt.executeUpdate()
                    ;
            if (rowsAffected > 0) {
                System.out.println("Entidade atualizada com sucesso.")
                ;
            } else {
                System.out.println("Nenhuma entidade encontrada com o ID fornecido.")
                ;
            }


        } catch (SQLException e) {
            throw new RuntimeException("Erro ao atualizar entidade: " + e.getMessage(), e)
                    ;
        }
    }
}