<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:sm="http://www.sitemaps.org/schemas/sitemap/0.9"
  exclude-result-prefixes="sm">

<xsl:output method="html" encoding="UTF-8" indent="yes" doctype-system="about:legacy-compat"/>

<xsl:template match="/">
<html lang="es">
<head>
  <meta charset="UTF-8"/>
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <meta name="robots" content="noindex, follow"/>
  <title>Sitemap — Medea Estilistas</title>
  <style>
    :root {
      --bg: #faf8f5;
      --surface: #ffffff;
      --border: #e8e2da;
      --border-soft: #f0ebe3;
      --text: #1c1614;
      --muted: #8a7f76;
      --faint: #b0a89e;
      --brand: #5d131a;
      --brand-hover: #8a1e27;
      --chip-bg: #f3ede5;
      --row-hover: #fdf9f5;
      --shadow: rgba(28,22,20,.06);
      --p-high-bg:#f0f9f0; --p-high-fg:#2d7a2d; --p-high-bd:#c3e6c3;
      --p-med-bg:#fdf6eb;  --p-med-fg:#8a5a00;  --p-med-bd:#f0d9a0;
      --p-low-bg:#f3f3f3;  --p-low-fg:#666;     --p-low-bd:#ddd;
    }
    @media (prefers-color-scheme: dark) {
      :root {
        --bg: #17110f;
        --surface: #201815;
        --border: #35291f;
        --border-soft: #2a201b;
        --text: #f2e9e2;
        --muted: #b39f92;
        --faint: #7d6d62;
        --brand: #e5a3ab;
        --brand-hover: #f2c2c8;
        --chip-bg: #2a201b;
        --row-hover: #271d19;
        --shadow: rgba(0,0,0,.4);
        --p-high-bg:#14301a; --p-high-fg:#7fd18a; --p-high-bd:#245c30;
        --p-med-bg:#332612;  --p-med-fg:#e0b45f;  --p-med-bd:#5c4620;
        --p-low-bg:#2a2a2a;  --p-low-fg:#aaa;     --p-low-bd:#444;
      }
    }

    *, *::before, *::after { box-sizing: border-box; margin: 0; padding: 0; }

    body {
      font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;
      background: var(--bg);
      color: var(--text);
      font-size: 14px;
      line-height: 1.6;
      min-height: 100vh;
    }

    .header {
      background: var(--surface);
      border-bottom: 1px solid var(--border);
      padding: 1.5rem 2rem;
      display: flex;
      align-items: center;
      gap: 1.5rem;
    }
    .header-logo {
      width: 40px; height: 40px;
      background: var(--brand);
      border-radius: 50%;
      display: flex; align-items: center; justify-content: center;
      color: #fff;
      font-size: 1.1rem;
      font-weight: 600;
      flex-shrink: 0;
    }
    .header-title { font-size: 1.1rem; font-weight: 600; color: var(--text); }
    .header-sub { font-size: .8rem; color: var(--muted); margin-top: .1rem; }
    .header-badge {
      margin-left: auto;
      background: var(--chip-bg);
      border: 1px solid var(--border);
      color: var(--brand);
      font-size: .72rem;
      font-weight: 500;
      letter-spacing: .08em;
      text-transform: uppercase;
      padding: .3rem .8rem;
      border-radius: 20px;
    }

    .wrap { max-width: 960px; margin: 0 auto; padding: 2rem 1.5rem; }

    .backlink {
      display: inline-flex;
      align-items: center;
      gap: .4rem;
      margin-bottom: 1.25rem;
      color: var(--brand);
      text-decoration: none;
      font-size: .82rem;
      font-weight: 500;
    }
    .backlink:hover { text-decoration: underline; }

    .stats { display: flex; gap: 1rem; margin-bottom: 1.5rem; flex-wrap: wrap; }
    .stat {
      background: var(--surface);
      border: 1px solid var(--border);
      border-radius: 8px;
      padding: .8rem 1.2rem;
      display: flex; flex-direction: column; gap: .2rem;
    }
    .stat-num { font-size: 1.4rem; font-weight: 600; color: var(--brand); line-height: 1; }
    .stat-label { font-size: .72rem; color: var(--muted); text-transform: uppercase; letter-spacing: .08em; }

    .section-head {
      font-size: .68rem; font-weight: 600; letter-spacing: .18em;
      text-transform: uppercase; color: var(--brand);
      margin-bottom: .75rem; padding-bottom: .5rem;
      border-bottom: 2px solid var(--brand);
      display: flex; align-items: center; gap: .5rem;
    }

    .table-wrap {
      background: var(--surface);
      border: 1px solid var(--border);
      border-radius: 10px;
      overflow-x: auto;
      margin-bottom: 2rem;
      box-shadow: 0 1px 4px var(--shadow);
    }
    table { width: 100%; border-collapse: collapse; }
    thead tr { background: var(--chip-bg); border-bottom: 1px solid var(--border); }
    thead th {
      text-align: left; padding: .65rem 1rem;
      font-size: .7rem; font-weight: 600; letter-spacing: .1em;
      text-transform: uppercase; color: var(--muted);
    }
    tbody tr { border-bottom: 1px solid var(--border-soft); transition: background .15s; }
    tbody tr:last-child { border-bottom: none; }
    tbody tr:hover { background: var(--row-hover); }
    td { padding: .7rem 1rem; vertical-align: middle; }

    .url-cell a {
      color: var(--brand); text-decoration: none; font-size: .88rem;
      word-break: break-all; display: flex; align-items: center; gap: .4rem;
    }
    .url-cell a:hover { text-decoration: underline; color: var(--brand-hover); }
    .url-cell a::before { content: '\2197'; font-size: .7rem; opacity: .45; flex-shrink: 0; }

    .sitemap-link a { color: var(--brand); text-decoration: none; font-size: .88rem; font-weight: 500; }
    .sitemap-link a:hover { text-decoration: underline; }

    .priority { display: inline-block; padding: .2rem .55rem; border-radius: 4px; font-size: .72rem; font-weight: 600; }
    .p-high { background: var(--p-high-bg); color: var(--p-high-fg); border: 1px solid var(--p-high-bd); }
    .p-med  { background: var(--p-med-bg);  color: var(--p-med-fg);  border: 1px solid var(--p-med-bd); }
    .p-low  { background: var(--p-low-bg);  color: var(--p-low-fg);  border: 1px solid var(--p-low-bd); }

    .date-cell { color: var(--muted); font-size: .82rem; white-space: nowrap; }
    .freq-cell { color: var(--muted); font-size: .82rem; }

    .footer { text-align: center; font-size: .75rem; color: var(--faint); padding: 1.5rem 0 2rem; }
    .footer a { color: var(--brand); text-decoration: none; }
    .footer a:hover { text-decoration: underline; }
  </style>
</head>
<body>

<div class="header">
  <div class="header-logo">M</div>
  <div>
    <div class="header-title">Medea Estilistas</div>
    <div class="header-sub">medeaestilistas.es — Sitemap XML</div>
  </div>
  <div class="header-badge">XML Sitemap</div>
</div>

<div class="wrap">

  <!-- ═══════ SITEMAP ÍNDICE ═══════ -->
  <xsl:if test="sm:sitemapindex">
    <div class="stats">
      <div class="stat">
        <span class="stat-num"><xsl:value-of select="count(sm:sitemapindex/sm:sitemap)"/></span>
        <span class="stat-label">Sitemaps</span>
      </div>
    </div>

    <div class="section-head">Sitemap índice</div>
    <div class="table-wrap">
      <table>
        <thead>
          <tr>
            <th style="width:70%">Sitemap</th>
            <th>Última modificación</th>
          </tr>
        </thead>
        <tbody>
          <xsl:for-each select="sm:sitemapindex/sm:sitemap">
            <tr>
              <td class="sitemap-link">
                <a href="{sm:loc}"><xsl:value-of select="sm:loc"/></a>
              </td>
              <td class="date-cell"><xsl:value-of select="sm:lastmod"/></td>
            </tr>
          </xsl:for-each>
        </tbody>
      </table>
    </div>
  </xsl:if>

  <!-- ═══════ SITEMAP DE URLS ═══════ -->
  <xsl:if test="sm:urlset">
    <a class="backlink" href="/sitemap.xml">&#8592; Volver al índice</a>

    <div class="stats">
      <div class="stat">
        <span class="stat-num"><xsl:value-of select="count(sm:urlset/sm:url)"/></span>
        <span class="stat-label">URLs indexadas</span>
      </div>
      <div class="stat">
        <span class="stat-num"><xsl:value-of select="count(sm:urlset/sm:url[sm:priority &gt;= 0.9])"/></span>
        <span class="stat-label">Prioridad alta</span>
      </div>
      <div class="stat">
        <span class="stat-num"><xsl:value-of select="count(sm:urlset/sm:url[sm:priority &lt; 0.9 and sm:priority &gt;= 0.5])"/></span>
        <span class="stat-label">Prioridad media</span>
      </div>
    </div>

    <div class="section-head">URLs</div>
    <div class="table-wrap">
      <table>
        <thead>
          <tr>
            <th style="width:55%">URL</th>
            <th>Última modificación</th>
            <th>Frecuencia</th>
            <th>Prioridad</th>
          </tr>
        </thead>
        <tbody>
          <xsl:for-each select="sm:urlset/sm:url">
            <xsl:sort select="sm:priority" order="descending" data-type="number"/>
            <tr>
              <td class="url-cell">
                <a href="{sm:loc}"><xsl:value-of select="sm:loc"/></a>
              </td>
              <td class="date-cell"><xsl:value-of select="sm:lastmod"/></td>
              <td class="freq-cell"><xsl:value-of select="sm:changefreq"/></td>
              <td>
                <xsl:choose>
                  <xsl:when test="sm:priority &gt;= 0.9">
                    <span class="priority p-high"><xsl:value-of select="sm:priority"/></span>
                  </xsl:when>
                  <xsl:when test="sm:priority &gt;= 0.5">
                    <span class="priority p-med"><xsl:value-of select="sm:priority"/></span>
                  </xsl:when>
                  <xsl:otherwise>
                    <span class="priority p-low"><xsl:value-of select="sm:priority"/></span>
                  </xsl:otherwise>
                </xsl:choose>
              </td>
            </tr>
          </xsl:for-each>
        </tbody>
      </table>
    </div>
  </xsl:if>

  <div class="footer">
    <a href="/">medeaestilistas.es</a> · Generado automáticamente · <a href="/sitemap.xml">Ver sitemap índice</a>
  </div>

</div>
</body>
</html>
</xsl:template>

</xsl:stylesheet>
