<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="br.com.senai.projeto.dao.entidadeDAO" %>

<%
    if ("POST".equalsIgnoreCase(request.getMethod())) {

        int id = Integer.parseInt(request.getParameter("id"));

        entidadeDAO dao = new entidadeDAO();
        dao.excluir(id);

        response.sendRedirect("listagem.jsp");
        return;
    }

    int id = Integer.parseInt(request.getParameter("id"));
%>

<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="theme-color" content="#090b14">
    <title>Excluir jogo — Pixel Vault</title>
    <style>
        :root {
            color-scheme: dark;
            --bg: #090b14;
            --text: #f5f6ff;
            --muted: #a4a9bd;
            --lime: #c8ff55;
            --line: rgba(255, 255, 255, .1);
            --red: #ff8585;
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

        .shell { width: min(100%, 980px); margin-inline: auto; }
        .topbar { display: flex; min-height: 54px; align-items: center; justify-content: space-between; }
        .brand { display: inline-flex; align-items: center; gap: 10px; color: var(--text); font-size: 15px; font-weight: 800; letter-spacing: -.04em; text-decoration: none; }
        .brand-mark { display: grid; width: 36px; height: 36px; place-items: center; border-radius: 11px; background: var(--lime); color: #14190b; font-size: 19px; }
        .brand-name span { color: var(--lime); }
        .back-link { color: var(--muted); font-size: 13px; text-decoration: none; }
        .back-link:hover { color: var(--lime); }

        main { display: grid; grid-template-columns: minmax(0, 1fr) minmax(280px, .75fr); align-items: center; gap: 70px; padding: 76px 0 84px; }
        .eyebrow { display: inline-flex; align-items: center; gap: 9px; margin: 0 0 15px; color: var(--red); font-size: 11px; font-weight: 800; letter-spacing: .15em; text-transform: uppercase; }
        .eyebrow::before { width: 7px; height: 7px; border-radius: 50%; background: var(--red); content: ""; box-shadow: 0 0 14px rgba(255, 133, 133, .7); }
        h1 { margin: 0; font-size: clamp(36px, 5vw, 56px); line-height: 1.02; letter-spacing: -.06em; }
        .intro { max-width: 430px; margin: 17px 0 0; color: var(--muted); font-size: 15px; }

        .card { padding: clamp(22px, 4vw, 34px); border: 1px solid var(--line); border-radius: 20px; background: linear-gradient(145deg, rgba(24, 29, 46, .96), rgba(15, 18, 30, .98)); box-shadow: 0 28px 80px rgba(0, 0, 0, .35); }
        .warning-icon { display: grid; width: 48px; height: 48px; margin-bottom: 18px; place-items: center; border: 1px solid rgba(255, 133, 133, .24); border-radius: 15px; background: rgba(255, 133, 133, .09); color: var(--red); font-size: 22px; }
        .card h2 { margin: 0 0 8px; font-size: 19px; letter-spacing: -.035em; }
        .message { margin: 0; color: var(--muted); font-size: 13px; }
        .actions { display: flex; flex-wrap: wrap; gap: 10px; margin-top: 23px; }
        .button { display: inline-flex; min-height: 46px; flex: 1; align-items: center; justify-content: center; gap: 8px; padding: 0 15px; border: 1px solid transparent; border-radius: 9px; background: var(--lime); color: #14190b; cursor: pointer; font: inherit; font-size: 13px; font-weight: 800; text-decoration: none; transition: transform .18s ease, background .18s ease; }
        .button:hover { transform: translateY(-2px); background: #d7ff83; }
        .button-danger { border-color: rgba(255, 133, 133, .3); background: rgba(255, 92, 92, .13); color: #ffaaaa; }
        .button-danger:hover { background: rgba(255, 92, 92, .22); }
        .button:focus-visible, .back-link:focus-visible, .brand:focus-visible { outline: 2px solid var(--lime); outline-offset: 4px; }
        footer { padding-top: 18px; border-top: 1px solid var(--line); color: var(--muted); font-size: 12px; }

        @media (max-width: 700px) {
            body { padding-inline: 18px; }
            main { grid-template-columns: 1fr; gap: 30px; padding: 52px 0 54px; }
            .intro { font-size: 14px; }
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
        <a class="back-link" href="listagem.jsp">← Voltar ao catálogo</a>
    </header>

    <main class="shell">
        <section>
            <p class="eyebrow">Atenção, jogador</p>
            <h1>Remover este jogo?</h1>
            <p class="intro">Esta ação não pode ser desfeita. Confirme apenas se deseja mesmo remover este título da sua coleção.</p>
        </section>

        <section class="card" aria-labelledby="confirm-title">
            <span class="warning-icon" aria-hidden="true">!</span>
            <h2 id="confirm-title">Confirme a exclusão</h2>
            <p class="message">Deseja realmente excluir o jogo da sua coleção?</p>
            <form action="excluir.jsp" method="post">
                <input type="hidden" name="id" value="<%= id %>">
                <div class="actions">
                    <button class="button button-danger" type="submit">Sim, excluir jogo</button>
                    <a class="button" href="listagem.jsp">Cancelar</a>
                </div>
            </form>
        </section>
    </main>

    <footer class="shell">PIXEL VAULT · Feito para quem vive muitas vidas em pixels.</footer>
</body>
</html>