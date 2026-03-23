/* ═══════════════════════════════════════════════════════
   MEDEA ESTILISTAS — main.js
   Para activar formularios: web3forms.com → reemplaza WEB3FORMS_KEY
═══════════════════════════════════════════════════════ */

const WEB3FORMS_KEY = 'TU_CLAVE_AQUI';

/* ── NAV SCROLL ─────────────────────────────────────── */
const nav = document.getElementById('nav');
if (nav) {
  const onScroll = () => nav.classList.toggle('scrolled', window.scrollY > 50);
  window.addEventListener('scroll', onScroll, { passive: true });
  onScroll();
}

/* ── MOBILE MENU ────────────────────────────────────── */
function openMobileMenu() {
  const menu = document.getElementById('mobileMenu');
  const btn  = document.querySelector('.nav-hamburger');
  if (!menu) return;
  menu.classList.add('open');
  document.body.style.overflow = 'hidden';
  if (btn) btn.setAttribute('aria-expanded', 'true');
}
function closeMobileMenu() {
  const menu = document.getElementById('mobileMenu');
  const btn  = document.querySelector('.nav-hamburger');
  if (!menu) return;
  menu.classList.remove('open');
  document.body.style.overflow = '';
  if (btn) btn.setAttribute('aria-expanded', 'false');
}
document.addEventListener('keydown', e => { if (e.key === 'Escape') closeMobileMenu(); });

/* ── REVEAL ON SCROLL ───────────────────────────────── */
const revealObs = new IntersectionObserver(entries => {
  entries.forEach((e, i) => {
    if (e.isIntersecting) setTimeout(() => e.target.classList.add('visible'), i * 70);
  });
}, { threshold: 0.07 });
document.querySelectorAll('.reveal').forEach(el => revealObs.observe(el));

/* ── DATE PICKER ────────────────────────────────────── */
document.querySelectorAll('input[type="date"]').forEach(input => {
  const t = new Date(); t.setDate(t.getDate() + 1);
  input.min = t.toISOString().split('T')[0];
});

/* ── FORMULARIO DE CITA ─────────────────────────────── */
document.querySelectorAll('.cita-form').forEach(form => {
  form.addEventListener('submit', async e => {
    e.preventDefault();
    const btn = form.querySelector('[type="submit"]');
    const successEl = form.closest('.form-card')?.querySelector('.form-success');
    btn.disabled = true; btn.textContent = 'Enviando…';
    const data = new FormData(form);
    const timeSlot = form.querySelector('.time-slot input:checked');
    const fields = {
      access_key: WEB3FORMS_KEY,
      subject: `Nueva cita — Medea Estilistas — ${data.get('servicio') || 'Consulta'}`,
      name: data.get('nombre') || '',
      email: data.get('email') || 'no indicado',
      phone: data.get('telefono') || '',
      servicio: data.get('servicio') || '',
      fecha: data.get('fecha') || '',
      hora: timeSlot ? timeSlot.value : 'Sin preferencia',
      notas: data.get('notas') || '',
      botcheck: '',
    };
    let sent = false;
    if (WEB3FORMS_KEY !== 'TU_CLAVE_AQUI') {
      try {
        const res = await fetch('https://api.web3forms.com/submit', {
          method: 'POST',
          headers: { 'Content-Type': 'application/json', Accept: 'application/json' },
          body: JSON.stringify(fields),
        });
        sent = res.ok;
      } catch (_) {}
    } else {
      await new Promise(r => setTimeout(r, 600));
      sent = true;
    }
    if (sent && successEl) { form.style.display = 'none'; successEl.classList.add('show'); }
    else { btn.disabled = false; btn.textContent = 'Solicitar cita'; alert('Ha habido un problema. Llámanos al 985 337 963.'); }
  });
});

/* ══════════════════════════════════════════════════════
   COOKIES RGPD — LOPDGDD + Reglamento Europeo
══════════════════════════════════════════════════════ */
const COOKIE_KEY = 'medea_cookies_v1';

function getCookieConsent() {
  try { return JSON.parse(localStorage.getItem(COOKIE_KEY)); } catch { return null; }
}
function setCookieConsent(prefs) {
  localStorage.setItem(COOKIE_KEY, JSON.stringify({ ...prefs, date: new Date().toISOString() }));
}
function hideBanner() {
  document.getElementById('cookie-banner')?.classList.remove('show');
  document.getElementById('cookie-reopen')?.classList.add('show');
}
function acceptAll()       { setCookieConsent({ necessary: true, analytics: true, marketing: true });  hideBanner(); }
function acceptNecessary() { setCookieConsent({ necessary: true, analytics: false, marketing: false }); hideBanner(); }
function reopenCookies()   {
  document.getElementById('cookie-banner')?.classList.add('show');
  document.getElementById('cookie-reopen')?.classList.remove('show');
}

// Exponer al HTML (onclick)
window.openMobileMenu  = openMobileMenu;
window.closeMobileMenu = closeMobileMenu;
window.acceptAll       = acceptAll;
window.acceptNecessary = acceptNecessary;
window.reopenCookies   = reopenCookies;

// Iniciar al cargar
document.addEventListener('DOMContentLoaded', () => {
  if (!getCookieConsent()) {
    document.getElementById('cookie-banner')?.classList.add('show');
  } else {
    document.getElementById('cookie-reopen')?.classList.add('show');
  }
});
