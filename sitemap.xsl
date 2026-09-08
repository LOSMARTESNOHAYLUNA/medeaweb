<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:sm="http://www.sitemaps.org/schemas/sitemap/0.9"
  exclude-result-prefixes="sm">

<xsl:output method="html" encoding="UTF-8" indent="yes" doctype-system="about:legacy-compat"/>

<!-- ═══════════════════════════════════════════════
     TEMPLATE PRINCIPAL
═══════════════════════════════════════════════ -->
<xsl:template match="/">
<html lang="es">
<head>
  <meta charset="UTF-8"/>
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <title>Sitemap — Medea Estilistas</title>
  <style>
    *, *::before, *::after { box-sizing: border-box; margin: 0; padding: 0; }

    body {
      font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;
      background: #faf8f5;
      color: #1c1614;
      font-size: 14px;
      line-height: 1.6;
      min-height: 100vh;
    }

    /* Header */
    .header {
      background: #fff;
      border-bottom: 1px solid #e8e2da;
      padding: 1.5rem 2rem;
      display: flex;
      align-items: center;
      gap: 1.5rem;
    }
    .header-logo {
      width: 40px; height: 40px;
      background: #5d131a;
      border-radius: 50%;
      display: flex; align-items: center; justify-content: center;
      color: #fff;
      font-size: 1.1rem;
      font-weight: 600;
      flex-shrink: 0;
    }
    .header-title {
      font-size: 1.1rem;
      font-weight: 600;
      color: #1c1614;
    }
    .header-sub {
      font-size: .8rem;
      color: #8a7f76;
      margin-top: .1rem;
    }
    .header-badge {
      margin-left: auto;
      background: #f3ede5;
      border: 1px solid #e8e2da;
      color: #5d131a;
      font-size: .72rem;
      font-weight: 500;
      letter-spacing: .08em;
      text-transform: uppercase;
      padding: .3rem .8rem;
      border-radius: 20px;
    }

    /* Wrapper */
    .wrap {
      max-width: 960px;
      margin: 0 auto;
      padding: 2rem 1.5rem;
    }

    /* Stats bar */
    .stats {
      display: flex;
      gap: 1rem;
      margin-bottom: 1.5rem;
      flex-wrap: wrap;
    }
    .stat {
      background: #fff;
      border: 1px solid #e8e2da;
      border-radius: 8px;
      padding: .8rem 1.2rem;
      display: flex;
      flex-direction: column;
      gap: .2rem;
    }
    .stat-num {
      font-size: 1.4rem;
      font-weight: 600;
      color: #5d131a;
      line-height: 1;
    }
    .stat-label {
      font-size: .72rem;
      color: #8a7f76;
      text-transform: uppercase;
      letter-spacing: .08em;
    }

    /* Section title */
    .section-head {
      font-size: .68rem;
      font-weight: 600;
      letter-spacing: .18em;
      text-transform: uppercase;
      color: #5d131a;
      margin-bottom: .75rem;
      padding-bottom: .5rem;
      border-bottom: 2px solid #5d131a;
      display: flex;
      align-items: center;
      gap: .5rem;
    }

    /* Table */
    .table-wrap {
      background: #fff;
      border: 1px solid #e8e2da;
      border-radius: 10px;
      overflow: hidden;
      margin-bottom: 2rem;
      box-shadow: 0 1px 4px rgba(28,22,20,.06);
    }
    table {
      width: 100%;
      border-collapse: collapse;
    }
    thead tr {
      background: #f3ede5;
      border-bottom: 1px solid #e8e2da;
    }
    thead th {
      text-align: left;
      padding: .65rem 1rem;
      font-size: .7rem;
      font-weight: 600;
      letter-spacing: .1em;
      text-transform: uppercase;
      color: #8a7f76;
    }
    tbody tr {
      border-bottom: 1px solid #f0ebe3;
      transition: background .15s;
    }
    tbody tr:last-child { border-bottom: none; }
    tbody tr:hover { background: #fdf9f5; }
    td {
      padding: .7rem 1rem;
      vertical-align: middle;
    }

    /* URL cell */
    .url-cell a {
      color: #5d131a;
      text-decoration: none;
      font-size: .88rem;
      word-break: break-all;
      display: flex;
      align-items: center;
      gap: .4rem;
    }
    .url-cell a:hover { text-decoration: underline; color: #8a1e27; }
    .url-cell a::before {
      content: '↗';
      font-size: .7rem;
      opacity: .45;
      flex-shrink: 0;
    }

    /* Sitemap index links */
    .sitemap-link a {
      color: #5d131a;
      text-decoration: none;
      font-size: .88rem;
      font-weight: 500;
    }
    .sitemap-link a:hover { text-decoration: underline; }

    /* Priority badge */
    .priority {
      display: inline-block;
      padding: .2rem .55rem;
      border-radius: 4px;
      font-size: .72rem;
      font-weight: 600;
    }
    .p-high   { background: #f0f9f0; color: #2d7a2d; border: 1px solid #c3e6c3; }
    .p-med    { background: #fdf6eb; color: #8a5a00; border: 1px solid #f0d9a0; }
    .p-low    { background: #f3f3f3; color: #666;    border: 1px solid #ddd; }

    .date-cell { color: #8a7f76; font-size: .82rem; white-space: nowrap; }
    .freq-cell { color: #8a7f76; font-size: .82rem; }

    /* Footer */
    .footer {
      text-align: center;
      font-size: .75rem;
      color: #b0a89e;
      padding: 1.5rem 0 2rem;
    }
    .footer a { color: #5d131a; text-decoration: none; }
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

  <!-- SITEMAP ÍNDICE -->
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
            <th style="width:60%">Sitemap</th>
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

  <!-- SITEMAP DE URLS -->
  <xsl:if test="sm:urlset">
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
