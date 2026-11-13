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
    String nome = request.getParameter("nome");
    String plataforma = request.getParameter("plataforma");
    String genero = request.getParameter("genero");
    String anoTexto = request.getParameter("ano");
    String erro = null;

    if ("POST".equalsIgnoreCase(request.getMethod())) {
        try {
            int ano = Integer.parseInt(anoTexto);
            conexao.createTable();

            Entidade entidade = new Entidade(0, nome, ano, plataforma, genero);
            new entidadeDAO().cadastrar(entidade);

            response.sendRedirect("listagem.jsp");
            return;
        } catch (NumberFormatException e) {
            erro = "Informe um ano válido.";
        } catch (RuntimeException e) {
            application.log("Erro ao cadastrar jogo.", e);
            erro = "Não foi possível salvar o jogo. Verifique a conexão com o banco de dados e tente novamente.";
        }
    }
%>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="theme-color" content="#090b14">
    <title>Cadastrar jogo — Pixel Vault</title>
    <style>
        :root {
            color-scheme: dark;
            --bg: #090b14;
            --panel: #111522;
            --text: #f5f6ff;
            --muted: #a4a9bd;
            --lime: #c8ff55;
            --line: rgba(255, 255, 255, .1);
        }

        * { box-sizing: border-box; }

        body {
            min-height: 100vh;
            margin: 0;
            padding: 28px 20px;
            background:
                radial-gradient(ellipse at 82% 18%, rgba(108, 76, 222, .17), transparent 31rem),
                radial-gradient(ellipse at 10% 85%, rgba(134, 184, 48, .1), transparent 26rem),
                var(--bg);
            color: var(--text);
            font-family: Inter, ui-sans-serif, system-ui, -apple-system, BlinkMacSystemFont, "Segoe UI", sans-serif;
            line-height: 1.5;
        }

        .topbar, main, footer { width: min(100%, 980px); margin-inline: auto; }
        .topbar { display: flex; align-items: center; justify-content: space-between; min-height: 54px; }
        .brand { display: inline-flex; align-items: center; gap: 10px; font-size: 15px; font-weight: 800; letter-spacing: -.04em; text-decoration: none; }
        .brand-mark { display: grid; width: 36px; height: 36px; place-items: center; border-radius: 11px; background: var(--lime); color: #14190b; font-size: 19px; }
        .brand-name span { color: var(--lime); }
        .back-link { color: var(--muted); font-size: 13px; text-decoration: none; }
        .back-link:hover { color: var(--lime); }

        main { display: grid; grid-template-columns: minmax(0, 1fr) minmax(280px, .75fr); align-items: center; gap: 70px; padding: 76px 0 84px; }
        .eyebrow { display: inline-flex; align-items: center; gap: 9px; margin: 0 0 15px; color: var(--lime); font-size: 11px; font-weight: 800; letter-spacing: .15em; text-transform: uppercase; }
        .eyebrow::before { width: 7px; height: 7px; border-radius: 50%; background: var(--lime); content: ""; box-shadow: 0 0 14px var(--lime); }
        h1 { margin: 0; font-size: clamp(36px, 5vw, 56px); line-height: 1.02; letter-spacing: -.06em; }
        .intro { max-width: 430px; margin: 17px 0 0; color: var(--muted); font-size: 15px; }
        .form-card { padding: clamp(22px, 4vw, 34px); border: 1px solid var(--line); border-radius: 20px; background: linear-gradient(145deg, rgba(24, 29, 46, .96), rgba(15, 18, 30, .98)); box-shadow: 0 28px 80px rgba(0, 0, 0, .35); }
        .form-heading { margin: 0 0 4px; font-size: 19px; letter-spacing: -.035em; }
        .form-hint { margin: 0 0 25px; color: var(--muted); font-size: 13px; }
        .field { margin-bottom: 17px; }
        label { display: block; margin-bottom: 7px; color: #e6e8f2; font-size: 12px; font-weight: 700; }
        input {
            width: 100%;
            min-height: 47px;
            padding: 0 13px;
            border: 1px solid rgba(255, 255, 255, .12);
            border-radius: 9px;
            outline: none;
            background: rgba(5, 7, 13, .55);
            color: var(--text);
            font: inherit;
            font-size: 14px;
            transition: border-color .18s ease, box-shadow .18s ease;
        }
        input::placeholder { color: #6f7588; }
        input:focus { border-color: var(--lime); box-shadow: 0 0 0 3px rgba(200, 255, 85, .12); }
        .error { margin: 0 0 18px; padding: 11px 13px; border: 1px solid rgba(255, 118, 118, .28); border-radius: 9px; background: rgba(255, 84, 84, .09); color: #ffb1b1; font-size: 13px; }
        .submit {
            display: flex;
            width: 100%;
            min-height: 48px;
            align-items: center;
            justify-content: center;
            gap: 9px;
            margin-top: 5px;
            border: 0;
            border-radius: 9px;
            background: var(--lime);
            color: #14190b;
            cursor: pointer;
            font: inherit;
            font-size: 14px;
            font-weight: 800;
            transition: transform .18s ease, background .18s ease;
        }
        .submit:hover { transform: translateY(-2px); background: #d7ff83; }
        .submit:focus-visible, .back-link:focus-visible, .brand:focus-visible { outline: 2px solid var(--lime); outline-offset: 4px; }
        footer { padding-top: 18px; border-top: 1px solid var(--line); color: var(--muted); font-size: 12px; }

        @media (max-width: 700px) {
            body { padding-inline: 18px; }
            main { grid-template-columns: 1fr; gap: 30px; padding: 52px 0 54px; }
            .intro { font-size: 14px; }
        }

        @media (prefers-reduced-motion: reduce) {
            *, *::before, *::after { scroll-behavior: auto !important; transition-duration: .01ms !important; }
        }
    </style>
</head>
<body>
    <header class="topbar">
        <a class="brand" href="index.jsp" aria-label="Pixel Vault, página inicial">
            <span class="brand-mark" aria-hidden="true">▣</span>
            <span class="brand-name">PIXEL <span>VAULT</span></span>
        </a>
        <a class="back-link" href="listagem.jsp">← Voltar ao catálogo</a>
    </header>

    <main>
        <section>
            <p class="eyebrow">Sua coleção, suas regras</p>
            <h1>Um novo jogo para sua coleção.</h1>
            <p class="intro">Guarde os detalhes do próximo clássico, da aventura favorita ou daquele jogo que você não para de recomendar.</p>
        </section>

        <section class="form-card" aria-labelledby="form-title">
            <h2 class="form-heading" id="form-title">Detalhes do jogo</h2>
            <p class="form-hint">Preencha as informações para adicionar ao catálogo.</p>

            <% if (erro != null) { %>
                <p class="error" role="alert"><%= escaparHtml(erro) %></p>
            <% } %>

            <form action="cadastro.jsp" method="post">
                <div class="field">
                    <label for="nome">Nome do jogo</label>
                    <input id="nome" type="text" name="nome" maxlength="150"
                           placeholder="Ex.: Hollow Knight" value="<%= escaparHtml(nome) %>" required>
                </div>

                <div class="field">
                    <label for="plataforma">Plataforma</label>
                    <input id="plataforma" type="text" name="plataforma" maxlength="100"
                           placeholder="Ex.: PC, PlayStation, Xbox" value="<%= escaparHtml(plataforma) %>" required>
                </div>

                <div class="field">
                    <label for="genero">Gênero</label>
                    <input id="genero" type="text" name="genero" maxlength="100"
                           placeholder="Ex.: Aventura, RPG, ação" value="<%= escaparHtml(genero) %>" required>
                </div>

                <div class="field">
                    <label for="ano">Ano de lançamento</label>
                    <input id="ano" type="number" name="ano" min="1"
                           placeholder="Ex.: 2024" value="<%= escaparHtml(anoTexto) %>" required>
                </div>

                <button class="submit" type="submit">Cadastrar jogo <span aria-hidden="true">→</span></button>
            </form>
        </section>
    </main>

    <footer>PIXEL VAULT · Feito para quem vive muitas vidas em pixels.</footer>
</body>
</html>
