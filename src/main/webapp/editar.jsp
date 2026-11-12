<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="br.com.senai.projeto.model.Jogo" %>
<%@ page import="br.com.senai.projeto.dao.JogoDAO" %>

<%
    JogoDAO dao = new JogoDAO();

    if ("POST".equalsIgnoreCase(request.getMethod())) {

        int id = Integer.parseInt(request.getParameter("id"));
        String nome = request.getParameter("nome");
        String plataforma = request.getParameter("plataforma");
        String genero = request.getParameter("genero");
        int ano = Integer.parseInt(request.getParameter("ano"));

        Jogo jogo = new Jogo(id, nome, plataforma, genero, ano);

        dao.atualizar(jogo);

        response.sendRedirect("listagem.jsp");
        return;
    }

    int id = Integer.parseInt(request.getParameter("id"));
    Jogo jogo = dao.buscarPorId(id);

    if (jogo == null) {
        response.sendRedirect("listagem.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html>
<head>
    <title>Editar Jogo</title>
</head>
<body>

<h1>Editar Jogo</h1>

<form action="editar.jsp" method="post">

    <input type="hidden" name="id" value="<%= jogo.getId() %>">

    <label>Nome:</label>
    <input type="text" name="nome"
           value="<%= jogo.getNome() %>" required>

    <br><br>

    <label>Plataforma:</label>
    <input type="text" name="plataforma"
           value="<%= jogo.getPlataforma() %>" required>

    <br><br>

    <label>Gênero:</label>
    <input type="text" name="genero"
           value="<%= jogo.getGenero() %>" required>

    <br><br>

    <label>Ano:</label>
    <input type="number" name="ano"
           value="<%= jogo.getAno() %>" required>

    <br><br>

    <button type="submit">Salvar alterações</button>

</form>

</body>
</html>