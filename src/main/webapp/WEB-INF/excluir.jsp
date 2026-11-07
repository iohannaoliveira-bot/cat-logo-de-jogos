<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="br.com.senai.projeto.dao.JogoDAO" %>

<%
    if ("POST".equalsIgnoreCase(request.getMethod())) {

        int id = Integer.parseInt(request.getParameter("id"));

        JogoDAO dao = new JogoDAO();
        dao.excluir(id);

        response.sendRedirect("listagem.jsp");
        return;
    }

    int id = Integer.parseInt(request.getParameter("id"));
%>

<!DOCTYPE html>
<html>
<head>
    <title>Excluir Jogo</title>
</head>
<body>

<h1>Excluir Jogo</h1>

<p>Deseja realmente excluir este jogo?</p>

<form action="excluir.jsp" method="post">

    <input type="hidden" name="id" value="<%= id %>">

    <button type="submit">Confirmar exclusão</button>

</form>

<a href="listagem.jsp">Cancelar</a>

</body>
</html>