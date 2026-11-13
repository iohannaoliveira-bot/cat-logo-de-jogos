<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="theme-color" content="#090b14">
    <meta name="description" content="Explore, organize e cadastre seus jogos favoritos no Pixel Vault.">
    <title>Pixel Vault — seu universo gamer</title>
    <style>
        :root {
            color-scheme: dark;
            --bg: #090b14;
            --panel: #111522;
            --text: #f5f6ff;
            --muted: #a4a9bd;
            --lime: #c8ff55;
            --purple: #a88bff;
            --line: rgba(255, 255, 255, .1);
        }

        * { box-sizing: border-box; }

        html { scroll-behavior: smooth; }

        body {
            margin: 0;
            min-width: 320px;
            background:
                radial-gradient(ellipse at 76% 34%, rgba(108, 76, 222, .17), transparent 34rem),
                radial-gradient(ellipse at 12% 0%, rgba(134, 184, 48, .1), transparent 28rem),
                var(--bg);
            color: var(--text);
            font-family: Inter, ui-sans-serif, system-ui, -apple-system, BlinkMacSystemFont, "Segoe UI", sans-serif;
            line-height: 1.5;
        }

        a { color: inherit; text-decoration: none; }

        .shell { width: min(1120px, calc(100% - 48px)); margin: 0 auto; }

        .topbar {
            display: flex;
            align-items: center;
            justify-content: space-between;
            min-height: 82px;
            border-bottom: 1px solid var(--line);
        }

        .brand { display: inline-flex; align-items: center; gap: 11px; font-weight: 800; letter-spacing: -.04em; }
        .brand-mark {
            display: grid;
            width: 38px;
            height: 38px;
            place-items: center;
            border-radius: 12px;
            background: var(--lime);
            color: #14190b;
            font-size: 20px;
        }
        .brand-name { font-size: 17px; }
        .brand-name span { color: var(--lime); }

        .nav { display: flex; align-items: center; gap: 32px; color: var(--muted); font-size: 14px; }
        .nav a:hover, .text-link:hover { color: var(--lime); }
        .nav .nav-cta { color: var(--text); }

        .button {
            display: inline-flex;
            min-height: 48px;
            align-items: center;
            justify-content: center;
            gap: 10px;
            padding: 0 20px;
            border: 1px solid transparent;
            border-radius: 10px;
            font-size: 14px;
            font-weight: 750;
            transition: transform .18s ease, background .18s ease, border-color .18s ease;
        }
        .button:hover { transform: translateY(-2px); }
        .button-primary { background: var(--lime); color: #14190b; }
        .button-primary:hover { background: #d7ff83; }
        .button-secondary { border-color: var(--line); background: rgba(255, 255, 255, .035); }
        .button-secondary:hover { border-color: rgba(255, 255, 255, .3); }

        .hero {
            display: grid;
            grid-template-columns: 1.05fr .95fr;
            align-items: center;
            gap: 54px;
            min-height: 560px;
            padding: 72px 0 86px;
        }

        .eyebrow {
            display: inline-flex;
            align-items: center;
            gap: 9px;
            margin: 0 0 21px;
            color: var(--lime);
            font-size: 11px;
            font-weight: 800;
            letter-spacing: .16em;
            text-transform: uppercase;
        }
        .eyebrow::before { width: 7px; height: 7px; border-radius: 50%; background: var(--lime); content: ""; box-shadow: 0 0 14px var(--lime); }

        h1 {
            max-width: 610px;
            margin: 0;
            font-size: clamp(44px, 6vw, 72px);
            line-height: .99;
            letter-spacing: -.065em;
        }
        h1 span { color: var(--lime); }
        .hero-copy { max-width: 490px; margin: 24px 0 30px; color: var(--muted); font-size: 16px; }
        .hero-actions { display: flex; flex-wrap: wrap; gap: 12px; }

        .showcase {
            position: relative;
            display: grid;
            min-height: 365px;
            place-items: center;
        }
        .showcase-glow {
            position: absolute;
            width: min(340px, 80%);
            aspect-ratio: 1;
            border-radius: 50%;
            background: rgba(165, 134, 255, .21);
            filter: blur(72px);
        }
        .game-card {
            position: relative;
            width: min(335px, 90%);
            padding: 14px;
            border: 1px solid rgba(255, 255, 255, .15);
            border-radius: 22px;
            background: linear-gradient(145deg, rgba(33, 38, 59, .97), rgba(15, 18, 30, .98));
            box-shadow: 0 30px 90px rgba(0, 0, 0, .48), 0 0 60px rgba(168, 139, 255, .11);
            transform: rotate(3deg);
        }
        .game-art {
            position: relative;
            display: flex;
            min-height: 235px;
            overflow: hidden;
            align-items: center;
            justify-content: center;
            border-radius: 14px;
            background:
                radial-gradient(circle at 50% 42%, rgba(200, 255, 85, .45), transparent 12%),
                radial-gradient(ellipse at 50% 88%, rgba(168, 139, 255, .72), transparent 40%),
                linear-gradient(155deg, #26354e, #15152b 62%, #10131d);
        }
        .game-art::before, .game-art::after {
            position: absolute;
            width: 180px;
            height: 180px;
            border: 1px solid rgba(255, 255, 255, .18);
            border-radius: 50%;
            content: "";
        }
        .game-art::after { width: 245px; height: 245px; }
        .orbit-icon {
            z-index: 1;
            display: grid;
            width: 100px;
            height: 100px;
            place-items: center;
            border: 1px solid rgba(255, 255, 255, .35);
            border-radius: 28px;
            background: linear-gradient(145deg, rgba(200, 255, 85, .95), rgba(158, 220, 71, .72));
            box-shadow: 0 0 45px rgba(200, 255, 85, .35);
            color: #17200c;
            font-size: 48px;
            transform: rotate(-9deg);
        }
        .spark { position: absolute; z-index: 1; color: #fff; font-size: 18px; }
        .spark-one { top: 25%; left: 23%; }
        .spark-two { right: 20%; bottom: 25%; color: var(--lime); }
        .game-info { display: flex; align-items: center; justify-content: space-between; padding: 17px 4px 5px; }
        .game-info strong { display: block; font-size: 14px; }
        .game-info small { color: var(--muted); }
        .rating { color: var(--lime); font-size: 13px; font-weight: 800; }
        .float-tag {
            position: absolute;
            z-index: 2;
            display: flex;
            align-items: center;
            gap: 9px;
            padding: 11px 14px;
            border: 1px solid var(--line);
            border-radius: 12px;
            background: rgba(17, 21, 34, .94);
            box-shadow: 0 12px 35px rgba(0, 0, 0, .3);
            font-size: 12px;
            font-weight: 700;
        }
        .float-tag span { color: var(--lime); font-size: 17px; }
        .tag-top { top: 45px; right: 0; }
        .tag-bottom { bottom: 44px; left: 2px; }

        .section { padding: 35px 0 83px; }
        .section-heading { display: flex; align-items: end; justify-content: space-between; gap: 20px; margin-bottom: 24px; }
        .section-heading h2 { margin: 0; font-size: 23px; letter-spacing: -.04em; }
        .section-heading p { margin: 6px 0 0; color: var(--muted); font-size: 13px; }
        .text-link { color: var(--lime); font-size: 13px; font-weight: 750; }

        .feature-grid { display: grid; grid-template-columns: repeat(3, 1fr); gap: 15px; }
        .feature {
            min-height: 168px;
            padding: 22px;
            border: 1px solid var(--line);
            border-radius: 16px;
            background: linear-gradient(145deg, rgba(255, 255, 255, .045), rgba(255, 255, 255, .015));
        }
        .feature-icon {
            display: grid;
            width: 38px;
            height: 38px;
            margin-bottom: 17px;
            place-items: center;
            border-radius: 11px;
            background: rgba(200, 255, 85, .1);
            color: var(--lime);
            font-size: 18px;
        }
        .feature:nth-child(2) .feature-icon { background: rgba(168, 139, 255, .12); color: var(--purple); }
        .feature:nth-child(3) .feature-icon { background: rgba(101, 207, 255, .1); color: #65cfff; }
        .feature h3 { margin: 0 0 6px; font-size: 15px; }
        .feature p { margin: 0; color: var(--muted); font-size: 13px; }

        .bottom-cta {
            display: flex;
            align-items: center;
            justify-content: space-between;
            gap: 24px;
            margin-bottom: 70px;
            padding: 28px 32px;
            border: 1px solid rgba(200, 255, 85, .2);
            border-radius: 18px;
            background: linear-gradient(100deg, rgba(200, 255, 85, .09), rgba(168, 139, 255, .08));
        }
        .bottom-cta h2 { margin: 0; font-size: 20px; letter-spacing: -.035em; }
        .bottom-cta p { margin: 5px 0 0; color: var(--muted); font-size: 13px; }
        footer { display: flex; justify-content: space-between; gap: 18px; padding: 22px 0 30px; border-top: 1px solid var(--line); color: var(--muted); font-size: 12px; }
        footer strong { color: var(--text); }

        @media (max-width: 760px) {
            .shell { width: min(100% - 36px, 560px); }
            .topbar { min-height: 72px; }
            .nav { gap: 17px; }
            .nav > a:first-child { display: none; }
            .nav .button { min-height: 40px; padding: 0 13px; font-size: 12px; }
            .hero { grid-template-columns: 1fr; gap: 12px; padding: 66px 0 45px; }
            .hero-copy { max-width: 560px; }
            .showcase { min-height: 335px; }
            .tag-top { right: 3%; }
            .tag-bottom { left: 3%; }
            .section { padding-bottom: 60px; }
        }

        @media (max-width: 520px) {
            .brand-name { font-size: 15px; }
            .brand-mark { width: 34px; height: 34px; }
            .nav { gap: 10px; }
            .nav .nav-cta { display: none; }
            .hero { padding-top: 52px; }
            .hero-copy { font-size: 14px; }
            .hero-actions { align-items: stretch; }
            .hero-actions .button { flex: 1; padding: 0 13px; font-size: 12px; }
            .showcase { min-height: 305px; }
            .game-card { width: min(300px, 82%); }
            .game-art { min-height: 205px; }
            .float-tag { padding: 9px 11px; font-size: 11px; }
            .tag-top { top: 28px; }
            .tag-bottom { bottom: 27px; }
            .feature-grid { grid-template-columns: 1fr; }
            .feature { min-height: auto; }
            .feature-icon { margin-bottom: 12px; }
            .section-heading { align-items: start; }
            .bottom-cta { align-items: start; flex-direction: column; padding: 23px; }
            footer { flex-direction: column; }
        }

        @media (prefers-reduced-motion: reduce) {
            html { scroll-behavior: auto; }
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
        <nav class="nav" aria-label="Navegação principal">
            <a href="#sobre">Sobre</a>
            <a class="nav-cta" href="listagem.jsp">Explorar catálogo</a>
            <a class="button button-primary" href="cadastro.jsp">＋ Cadastrar jogo</a>
        </nav>
    </header>

    <main>
        <section class="shell hero" aria-labelledby="hero-title">
            <div>
                <p class="eyebrow">Seu próximo jogo favorito começa aqui</p>
                <h1 id="hero-title">Seu universo gamer, <span>em um só lugar.</span></h1>
                <p class="hero-copy">
                    Organize sua coleção, descubra o que já faz parte dela e mantenha cada aventura a um clique de distância.
                </p>
                <div class="hero-actions">
                    <a class="button button-primary" href="listagem.jsp">Ver meu catálogo <span aria-hidden="true">→</span></a>
                    <a class="button button-secondary" href="cadastro.jsp">Adicionar um jogo</a>
                </div>
            </div>

            <div class="showcase" aria-label="Destaque visual de jogos">
                <div class="showcase-glow"></div>
                <div class="float-tag tag-top"><span aria-hidden="true">✦</span> Sua coleção, do seu jeito</div>
                <article class="game-card">
                    <div class="game-art" aria-hidden="true">
                        <span class="spark spark-one">✦</span>
                        <span class="orbit-icon">▣</span>
                        <span class="spark spark-two">✧</span>
                    </div>
                    <div class="game-info">
                        <div>
                            <strong>Grandes aventuras</strong>
                            <small>Começam na sua coleção</small>
                        </div>
                        <span class="rating">★ 10/10</span>
                    </div>
                </article>
                <div class="float-tag tag-bottom"><span aria-hidden="true">◈</span> PC · console · nostalgia</div>
            </div>
        </section>

        <section class="shell section" id="sobre" aria-labelledby="features-title">
            <div class="section-heading">
                <div>
                    <h2 id="features-title">Tudo para sua vida gamer</h2>
                    <p>Simples de usar. Pronto para a próxima fase.</p>
                </div>
                <a class="text-link" href="listagem.jsp">Acessar catálogo <span aria-hidden="true">→</span></a>
            </div>
            <div class="feature-grid">
                <article class="feature">
                    <div class="feature-icon" aria-hidden="true">▤</div>
                    <h3>Sua coleção organizada</h3>
                    <p>Veja seus jogos e encontre rapidamente as informações de cada título.</p>
                </article>
                <article class="feature">
                    <div class="feature-icon" aria-hidden="true">＋</div>
                    <h3>Cadastro sem complicação</h3>
                    <p>Adicione nome, plataforma, gênero e ano para completar seu catálogo.</p>
                </article>
                <article class="feature">
                    <div class="feature-icon" aria-hidden="true">✎</div>
                    <h3>Sempre atualizado</h3>
                    <p>Edite os detalhes ou remova um jogo quando sua coleção mudar.</p>
                </article>
            </div>
        </section>

        <section class="shell bottom-cta" aria-label="Comece sua coleção">
            <div>
                <h2>Pronto para montar seu próximo save?</h2>
                <p>Seu catálogo começa com um jogo. O resto é história.</p>
            </div>
            <a class="button button-primary" href="cadastro.jsp">Cadastrar meu primeiro jogo <span aria-hidden="true">→</span></a>
        </section>
    </main>

    <footer class="shell">
        <span><strong>PIXEL VAULT</strong> · Seu universo gamer</span>
        <span>Feito para quem vive muitas vidas em pixels.</span>
    </footer>
</body>
</html>
