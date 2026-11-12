package br.com.senai.projeto.model;

public class Entidade {
    private int id;
    private String nome;
    private int ano;
    private String plataforma;
    private String genero;

    public Entidade(int id, String nome, int ano, String plataforma, String genero) {
        this.id = id;
        this.nome = nome;
        this.ano = ano;
        this.plataforma = plataforma;
        this.genero = genero;
    }

    // Get e set pra usar no read eu acho
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getNome() { return nome; }
    public void setNome(String nome) { this.nome = nome; }

    public int getAno() { return ano; }
    public void setAno(int ano) { this.ano = ano; }

    public String getPlataforma() { return plataforma; }
    public void setPlataforma(String plataforma) { this.plataforma = plataforma; }

    public String getGenero() { return genero; }
    public void setGenero(String genero) { this.genero = genero; }
}
