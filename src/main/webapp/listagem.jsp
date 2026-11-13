<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="br.com.senai.projeto.config.conexao" %>
<%@ page import="br.com.senai.projeto.dao.entidadeDAO" %>
<%@ page import="br.com.senai.projeto.model.Entidade" %>
<%@ page import="java.util.List" %>
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
    List<Entidade> jogos = null;
    String erro = null;
    try {
        conexao.createTable();
        jogos = new entidadeDAO().listarTodas();
    } catch (RuntimeException e) {
        application.log("Erro ao carregar catálogo de jogos.", e);
        erro = "Não foi possível carregar o catálogo. Verifique a conexão com o banco de dados.";
    }
%>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="theme-color" content="#090b14">
    <title>Catálogo de jogos — Pixel Vault</title>
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
                radial-gradient(ellipse at 78% 12%, rgba(108, 76, 222, .17), transparent 32rem),
                radial-gradient(ellipse at 10% 85%, rgba(134, 184, 48, .09), transparent 26rem),
                var(--bg);
            color: var(--text);
            font-family: Inter, ui-sans-serif, system-ui, -apple-system, BlinkMacSystemFont, "Segoe UI", sans-serif;
            line-height: 1.5;
        }

        .shell { width: min(100%, 1040px); margin-inline: auto; }
        .topbar { display: flex; min-height: 54px; align-items: center; justify-content: space-between; }
        .brand { display: inline-flex; align-items: center; gap: 10px; color: var(--text); font-size: 15px; font-weight: 800; letter-spacing: -.04em; text-decoration: none; }
        .brand-mark { display: grid; width: 36px; height: 36px; place-items: center; border-radius: 11px; background: var(--lime); color: #14190b; font-size: 19px; }
        .brand-name span { color: var(--lime); }
        .top-link { color: var(--muted); font-size: 13px; text-decoration: none; }
        .top-link:hover, .footer-link:hover { color: var(--lime); }

        main { padding: 72px 0 74px; }
        .heading { display: flex; align-items: end; justify-content: space-between; gap: 24px; margin-bottom: 27px; }
        .eyebrow { display: inline-flex; align-items: center; gap: 9px; margin: 0 0 14px; color: var(--lime); font-size: 11px; font-weight: 800; letter-spacing: .15em; text-transform: uppercase; }
        .eyebrow::before { width: 7px; height: 7px; border-radius: 50%; background: var(--lime); content: ""; box-shadow: 0 0 14px var(--lime); }
        h1 { margin: 0; font-size: clamp(36px, 5vw, 54px); line-height: 1.02; letter-spacing: -.06em; }
        .subtitle { margin: 12px 0 0; color: var(--muted); font-size: 14px; }
        .button {
            display: inline-flex;
            min-height: 45px;
            flex-shrink: 0;
            align-items: center;
            justify-content: center;
            gap: 9px;
            padding: 0 17px;
            border-radius: 9px;
            background: var(--lime);
            color: #14190b;
            font-size: 13px;
            font-weight: 800;
            text-decoration: none;
            transition: transform .18s ease, background .18s ease;
        }
        .button:hover { transform: translateY(-2px); background: #d7ff83; }
        .button:focus-visible, .top-link:focus-visible, .footer-link:focus-visible { outline: 2px solid var(--lime); outline-offset: 4px; }

        .catalog { overflow: hidden; border: 1px solid var(--line); border-radius: 16px; background: linear-gradient(145deg, rgba(24, 29, 46, .96), rgba(15, 18, 30, .98)); box-shadow: 0 28px 80px rgba(0, 0, 0, .28); }
        .catalog-bar { display: flex; min-height: 57px; align-items: center; justify-content: space-between; gap: 16px; padding: 0 20px; border-bottom: 1px solid var(--line); }
        .catalog-title { font-size: 14px; font-weight: 750; }
        .catalog-count { color: var(--muted); font-size: 12px; }
        .table-scroll { overflow-x: auto; }
        table { width: 100%; border-collapse: collapse; text-align: left; }
        th { padding: 13px 20px; background: rgba(255, 255, 255, .025); color: var(--muted); font-size: 10px; font-weight: 800; letter-spacing: .1em; text-transform: uppercase; white-space: nowrap; }
        td { padding: 16px 20px; border-top: 1px solid rgba(255, 255, 255, .065); color: #e8eaf3; font-size: 13px; }
        tbody tr { transition: background .15s ease; }
        tbody tr:hover { background: rgba(255, 255, 255, .035); }
        td:first-child { color: var(--lime); font-size: 12px; font-weight: 800; }
        .game-name { color: var(--text); font-weight: 700; }
        .pill { display: inline-block; padding: 4px 9px; border: 1px solid rgba(168, 139, 255, .22); border-radius: 99px; background: rgba(168, 139, 255, .08); color: #d0c1ff; font-size: 11px; white-space: nowrap; }
        .year { color: var(--muted); font-variant-numeric: tabular-nums; }
        .row-actions { display: flex; align-items: center; gap: 8px; }
        .row-action { display: inline-flex; min-height: 32px; align-items: center; justify-content: center; padding: 0 10px; border: 1px solid var(--line); border-radius: 7px; color: var(--text); font-size: 11px; font-weight: 700; text-decoration: none; white-space: nowrap; transition: background .15s ease, border-color .15s ease; }
        .row-action:hover { border-color: rgba(200, 255, 85, .4); background: rgba(200, 255, 85, .08); }
        .row-action-danger { color: #ffaaaa; }
        .row-action-danger:hover { border-color: rgba(255, 133, 133, .4); background: rgba(255, 92, 92, .1); }
        .notice { margin: 0; padding: 19px 21px; color: var(--muted); font-size: 13px; }
        .notice-error { border: 1px solid rgba(255, 118, 118, .28); border-radius: 10px; background: rgba(255, 84, 84, .09); color: #ffb1b1; }
        .empty { padding: 46px 24px; text-align: center; }
        .empty-icon { display: grid; width: 48px; height: 48px; margin: 0 auto 15px; place-items: center; border: 1px solid rgba(200, 255, 85, .2); border-radius: 15px; background: rgba(200, 255, 85, .08); color: var(--lime); font-size: 22px; }
        .empty h2 { margin: 0; font-size: 18px; letter-spacing: -.03em; }
        .empty p { margin: 7px 0 19px; color: var(--muted); font-size: 13px; }
        .empty .button { min-height: 40px; }
        footer { display: flex; justify-content: space-between; gap: 18px; padding: 18px 0 10px; border-top: 1px solid var(--line); color: var(--muted); font-size: 12px; }
        .footer-link { color: var(--muted); text-decoration: none; }

        @media (max-width: 600px) {
            body { padding: 20px 16px; }
            main { padding: 51px 0 54px; }
            .heading { align-items: start; flex-direction: column; gap: 18px; }
            .catalog-bar { padding-inline: 15px; }
            th, td { padding-inline: 14px; }
            footer { flex-direction: column; }
        }

        @media (prefers-reduced-motion: reduce) {
            *, *::before, *::after { transition-duration: .01ms !important; }
        }
    </style>
</head>
<body>
    <header class="shell topbar">
        <a class="brand" href="index.jsp" aria-label="Pixel Vault, página inicial">
            <span class="brand-mark" aria-hidden="true">▣</span>
            <span class="brand-name">PIXEL <span>VAULT</span></span>
        </a>
        <a class="top-link" href="index.jsp">← Página inicial</a>
    </header>

    <main class="shell">
        <section class="heading">
            <div>
                <p class="eyebrow">Sua coleção gamer</p>
                <h1>Jogos cadastrados</h1>
                <p class="subtitle">Todos os títulos da sua coleção, em um só lugar.</p>
            </div>
            <a class="button" href="cadastro.jsp">＋ Cadastrar novo jogo</a>
        </section>

        <section class="catalog" aria-label="Catálogo de jogos">
            <% if (erro != null) { %>
                <p class="notice notice-error" role="alert"><%= escaparHtml(erro) %></p>
            <% } else if (jogos.isEmpty()) { %>
                <div class="empty">
                    <span class="empty-icon" aria-hidden="true">▣</span>
                    <h2>Sua coleção começa aqui</h2>
                    <p>Ainda não há jogos cadastrados. Adicione o primeiro título!</p>
                    <a class="button" href="cadastro.jsp">Cadastrar primeiro jogo <span aria-hidden="true">→</span></a>
                </div>
            <% } else { %>
                <div class="catalog-bar">
                    <span class="catalog-title">Minha coleção</span>
                    <span class="catalog-count"><%= jogos.size() %> jogo(s)</span>
                </div>
                <div class="table-scroll">
                    <table>
                        <thead>
                            <tr>
                                <th scope="col">ID</th>
                                <th scope="col">Nome</th>
                                <th scope="col">Plataforma</th>
                                <th scope="col">Gênero</th>
                                <th scope="col">Ano</th>
                                <th scope="col">Ações</th>
                            </tr>
                        </thead>
                        <tbody>
                            <% for (Entidade jogo : jogos) { %>
                                <tr>
                                    <td><%= jogo.getId() %></td>
                                    <td class="game-name"><%= escaparHtml(jogo.getNome()) %></td>
                                    <td><span class="pill"><%= escaparHtml(jogo.getPlataforma()) %></span></td>
                                    <td><%= escaparHtml(jogo.getGenero()) %></td>
                                    <td class="year"><%= jogo.getAno() %></td>
                                    <td>
                                        <div class="row-actions">
                                            <a class="row-action" href="editar.jsp?id=<%= jogo.getId() %>">Editar</a>
                                            <a class="row-action row-action-danger" href="excluir.jsp?id=<%= jogo.getId() %>">Excluir</a>
                                        </div>
                                    </td>
                                </tr>
                            <% } %>
                        </tbody>
                    </table>
                </div>
            <% } %>
        </section>
    </main>

    <footer class="shell">
        <span>PIXEL VAULT · Feito para quem vive muitas vidas em pixels.</span>
        <a class="footer-link" href="cadastro.jsp">Adicionar jogo <span aria-hidden="true">→</span></a>
    </footer>
</body>
</html>
