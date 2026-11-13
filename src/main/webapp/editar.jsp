<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="br.com.senai.projeto.config.conexao" %>
<%@ page import="br.com.senai.projeto.dao.entidadeDAO" %>
<%@ page import="br.com.senai.projeto.model.Entidade" %>
<%!
    private String escaparHtml(String valor) {
        if (valor == null) return "";
        return valor.replace("&", "&amp;")
                    .replace("<", "&lt;")
                    .replace(">", "&gt;")
                    .replace("\"", "&quot;")
                    .replace("'", "&#39;");
    }
%>
<%
    String idTexto = request.getParameter("id");
    int id;
    try {
        id = Integer.parseInt(idTexto);
        if (id < 1) throw new NumberFormatException();
    } catch (NumberFormatException e) {
        response.sendRedirect("listagem.jsp");
        return;
    }

    Entidade jogo = null;
    String erro = null;
    String nome = "";
    String plataforma = "";
    String genero = "";
    String anoTexto = "";

    try {
        conexao.createTable();
        entidadeDAO dao = new entidadeDAO();
        jogo = dao.buscarPorId(id);

        if (jogo == null) {
            response.sendRedirect("listagem.jsp");
            return;
        }

        nome = jogo.getNome();
        plataforma = jogo.getPlataforma();
        genero = jogo.getGenero();
        anoTexto = String.valueOf(jogo.getAno());

        if ("POST".equalsIgnoreCase(request.getMethod())) {
            nome = request.getParameter("nome");
            plataforma = request.getParameter("plataforma");
            genero = request.getParameter("genero");
            anoTexto = request.getParameter("ano");

            try {
                int ano = Integer.parseInt(anoTexto);
                dao.atualizar(new Entidade(id, nome, ano, plataforma, genero));
                response.sendRedirect("listagem.jsp");
                return;
            } catch (NumberFormatException e) {
                erro = "Informe um ano válido.";
            }
        }
    } catch (RuntimeException e) {
        application.log("Erro ao editar jogo.", e);
        erro = "Não foi possível carregar ou salvar as alterações. Verifique a conexão com o banco de dados.";
    }
%>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="theme-color" content="#090b14">
    <title>Editar jogo — Pixel Vault</title>
    <style>
        :root { color-scheme: dark; --bg: #090b14; --text: #f5f6ff; --muted: #a4a9bd; --lime: #c8ff55; --line: rgba(255,255,255,.1); }
        * { box-sizing: border-box; }
        body {
            min-height: 100vh; margin: 0; padding: 28px 20px;
            background: radial-gradient(ellipse at 82% 18%, rgba(108,76,222,.17), transparent 31rem), radial-gradient(ellipse at 10% 85%, rgba(134,184,48,.1), transparent 26rem), var(--bg);
            color: var(--text); font-family: Inter, ui-sans-serif, system-ui, -apple-system, BlinkMacSystemFont, "Segoe UI", sans-serif; line-height: 1.5;
        }
        .shell { width: min(100%, 980px); margin-inline: auto; }
        .topbar { display: flex; min-height: 54px; align-items: center; justify-content: space-between; }
        .brand { display: inline-flex; align-items: center; gap: 10px; color: var(--text); font-size: 15px; font-weight: 800; letter-spacing: -.04em; text-decoration: none; }
        .brand-mark { display: grid; width: 36px; height: 36px; place-items: center; border-radius: 11px; background: var(--lime); color: #14190b; font-size: 19px; }
        .brand-name span { color: var(--lime); }
        .back-link { color: var(--muted); font-size: 13px; text-decoration: none; }
        .back-link:hover { color: var(--lime); }
        main { display: grid; grid-template-columns: minmax(0,1fr) minmax(280px,.75fr); align-items: center; gap: 70px; padding: 76px 0 84px; }
        .eyebrow { display: inline-flex; align-items: center; gap: 9px; margin: 0 0 15px; color: var(--lime); font-size: 11px; font-weight: 800; letter-spacing: .15em; text-transform: uppercase; }
        .eyebrow::before { width: 7px; height: 7px; border-radius: 50%; background: var(--lime); content: ""; box-shadow: 0 0 14px var(--lime); }
        h1 { margin: 0; font-size: clamp(36px,5vw,56px); line-height: 1.02; letter-spacing: -.06em; }
        .intro { max-width: 430px; margin: 17px 0 0; color: var(--muted); font-size: 15px; }
        .card { padding: clamp(22px,4vw,34px); border: 1px solid var(--line); border-radius: 20px; background: linear-gradient(145deg, rgba(24,29,46,.96), rgba(15,18,30,.98)); box-shadow: 0 28px 80px rgba(0,0,0,.35); }
        .card h2 { margin: 0 0 4px; font-size: 19px; letter-spacing: -.035em; }
        .hint { margin: 0 0 25px; color: var(--muted); font-size: 13px; }
        .field { margin-bottom: 17px; }
        label { display: block; margin-bottom: 7px; color: #e6e8f2; font-size: 12px; font-weight: 700; }
        input { width: 100%; min-height: 47px; padding: 0 13px; border: 1px solid rgba(255,255,255,.12); border-radius: 9px; outline: none; background: rgba(5,7,13,.55); color: var(--text); font: inherit; font-size: 14px; transition: border-color .18s ease, box-shadow .18s ease; }
        input:focus { border-color: var(--lime); box-shadow: 0 0 0 3px rgba(200,255,85,.12); }
        .error { margin: 0 0 18px; padding: 11px 13px; border: 1px solid rgba(255,118,118,.28); border-radius: 9px; background: rgba(255,84,84,.09); color: #ffb1b1; font-size: 13px; }
        .actions { display: flex; flex-wrap: wrap; gap: 10px; margin-top: 21px; }
        .button { display: inline-flex; min-height: 46px; flex: 1; align-items: center; justify-content: center; gap: 8px; padding: 0 15px; border: 1px solid transparent; border-radius: 9px; background: var(--lime); color: #14190b; cursor: pointer; font: inherit; font-size: 13px; font-weight: 800; text-decoration: none; transition: transform .18s ease, background .18s ease; }
        .button:hover { transform: translateY(-2px); background: #d7ff83; }
        .button-secondary { border-color: var(--line); background: rgba(255,255,255,.035); color: var(--text); }
        .button-secondary:hover { border-color: rgba(255,255,255,.3); background: rgba(255,255,255,.07); }
        .button:focus-visible, .back-link:focus-visible, .brand:focus-visible { outline: 2px solid var(--lime); outline-offset: 4px; }
        footer { padding-top: 18px; border-top: 1px solid var(--line); color: var(--muted); font-size: 12px; }
        @media (max-width: 700px) { body { padding-inline: 18px; } main { grid-template-columns: 1fr; gap: 30px; padding: 52px 0 54px; } .intro { font-size: 14px; } }
        @media (prefers-reduced-motion: reduce) { *, *::before, *::after { transition-duration: .01ms !important; } }
    </style>
</head>
<body>
    <header class="shell topbar">
        <a class="brand" href="index.jsp" aria-label="Pixel Vault, página inicial">
            <span class="brand-mark" aria-hidden="true">▣</span>
            <span class="brand-name">PIXEL <span>VAULT</span></span>
        </a>
        <a class="back-link" href="listagem.jsp">← Voltar ao catálogo</a>
    </header>

    <main class="shell">
        <section>
            <p class="eyebrow">Atualize sua coleção</p>
            <h1>Deixe os detalhes em dia.</h1>
            <p class="intro">Edite as informações deste jogo. As alterações aparecem no catálogo assim que forem salvas.</p>
        </section>

        <section class="card" aria-labelledby="form-title">
            <h2 id="form-title">Editar jogo</h2>
            <p class="hint">Jogo #<%= id %></p>

            <% if (erro != null) { %>
                <p class="error" role="alert"><%= escaparHtml(erro) %></p>
            <% } %>

            <% if (jogo != null) { %>
                <form action="editar.jsp" method="post">
                    <input type="hidden" name="id" value="<%= id %>">
                    <div class="field">
                        <label for="nome">Nome do jogo</label>
                        <input id="nome" type="text" name="nome" maxlength="150" value="<%= escaparHtml(nome) %>" required>
                    </div>
                    <div class="field">
                        <label for="plataforma">Plataforma</label>
                        <input id="plataforma" type="text" name="plataforma" maxlength="100" value="<%= escaparHtml(plataforma) %>" required>
                    </div>
                    <div class="field">
                        <label for="genero">Gênero</label>
                        <input id="genero" type="text" name="genero" maxlength="100" value="<%= escaparHtml(genero) %>" required>
                    </div>
                    <div class="field">
                        <label for="ano">Ano de lançamento</label>
                        <input id="ano" type="number" name="ano" min="1" value="<%= escaparHtml(anoTexto) %>" required>
                    </div>
                    <div class="actions">
                        <button class="button" type="submit">Salvar alterações <span aria-hidden="true">→</span></button>
                        <a class="button button-secondary" href="listagem.jsp">Cancelar</a>
                    </div>
                </form>
            <% } else if (erro != null) { %>
                <a class="button button-secondary" href="listagem.jsp">Voltar ao catálogo</a>
            <% } %>
        </section>
    </main>

    <footer class="shell">PIXEL VAULT · Feito para quem vive muitas vidas em pixels.</footer>
</body>
</html>
