<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="br.com.senai.projeto.model.Jogo" %>
<%@ page import="br.com.senai.projeto.dao.JogoDAO" %>

<%
    if ("POST".equalsIgnoreCase(request.getMethod())) {

        String nome = request.getParameter("nome");
        String plataforma = request.getParameter("plataforma");
        String genero = request.getParameter("genero");
        int ano = Integer.parseInt(request.getParameter("ano"));

        Jogo jogo = new Jogo(nome, plataforma, genero, ano);

        JogoDAO dao = new JogoDAO();
        dao.cadastrar(jogo);

        response.sendRedirect("listagem.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html>
<head>
    <title>Cadastro de Jogos</title>
</head>
<body>

<h1>Cadastrar Jogo</h1>

<form action="cadastro.jsp" method="post">

    <label>Nome:</label>
    <input type="text" name="nome" required>

    <br><br>

    <label>Plataforma:</label>
    <input type="text" name="plataforma" required>

    <br><br>

    <label>Gênero:</label>
    <input type="text" name="genero" required>

    <br><br>

    <label>Ano de lançamento:</label>
    <input type="number" name="ano" required>

    <br><br>

    <button type="submit">Cadastrar</button>

</form>

</body>
</html>