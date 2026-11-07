<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="br.com.senai.projeto.model.Jogo" %>
<%@ page import="br.com.senai.projeto.dao.JogoDAO" %>
<%@ page import="java.util.List" %>

<%
    JogoDAO dao = new JogoDAO();
    List<Jogo> jogos = dao.listar();
%>

<!DOCTYPE html>
<html>
<head>
    <title>Lista de Jogos</title>
</head>
<body>

<h1>Jogos cadastrados</h1>

<a href="cadastro.jsp">Cadastrar novo jogo</a>

<table border="1">

    <tr>
        <th>ID</th>
        <th>Nome</th>
        <th>Plataforma</th>
        <th>Gênero</th>
        <th>Ano</th>
        <th>Ações</th>
    </tr>

    <% for (Jogo jogo : jogos) { %>

    <tr>
        <td><%= jogo.getId() %></td>
        <td><%= jogo.getNome() %></td>
        <td><%= jogo.getPlataforma() %></td>
        <td><%= jogo.getGenero() %></td>
        <td><%= jogo.getAno() %></td>

        <td>
            <a href="editar.jsp?id=<%= jogo.getId() %>">
                Editar
            </a>

            <a href="excluir.jsp?id=<%= jogo.getId() %>">
                Excluir
            </a>
        </td>
    </tr>

    <% } %>

</table>

</body>
</html>