/* ═══════════════════════════════════════════════════════
   MEDEA ESTILISTAS — main.js
   Para activar formularios: web3forms.com → reemplaza WEB3FORMS_KEY
═══════════════════════════════════════════════════════ */

const WEB3FORMS_KEY = '781b0b15-f3d3-418e-adbf-523ecf3b20a9';

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
  if (btn) {
    btn.setAttribute('aria-expanded', 'true');
    btn.classList.add('open');
  }
}
function closeMobileMenu() {
  const menu = document.getElementById('mobileMenu');
  const btn  = document.querySelector('.nav-hamburger');
  if (!menu) return;
  menu.classList.remove('open');
  document.body.style.overflow = '';
  if (btn) {
    btn.setAttribute('aria-expanded', 'false');
    btn.classList.remove('open');
  }
}
document.addEventListener('keydown', e => { if (e.key === 'Escape') closeMobileMenu(); });

// Mobile submenu accordions — toggle mm-sub on parent link tap
document.addEventListener('DOMContentLoaded', () => {
  document.querySelectorAll('.mobile-menu > a[data-toggle]').forEach(link => {
    link.addEventListener('click', e => {
      e.preventDefault();
      const sub = document.getElementById(link.dataset.toggle);
      if (!sub) return;
      const isOpen = sub.style.display === 'flex';
      // Close all subs first
      document.querySelectorAll('.mm-sub').forEach(s => s.style.display = 'none');
      document.querySelectorAll('.mobile-menu > a[data-toggle]').forEach(l => l.classList.remove('mm-open'));
      // Toggle this one
      if (!isOpen) {
        sub.style.display = 'flex';
        link.classList.add('mm-open');
      }
    });
  });
});

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
    if (sent) { window.location.href = '/gracias/'; }
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

/* ── PARALLAX HERO ─────────────────────────────────────
   Mueve la imagen de fondo a la mitad de la velocidad
   del scroll para crear efecto de profundidad.
──────────────────────────────────────────────────────── */
(function initParallax() {
  const hero = document.querySelector('.hero-bg-photo');
  const img  = hero ? hero.querySelector('.hero-parallax-img') : null;
  if (!hero || !img) return;

  let ticking = false;

  function updateParallax() {
    const rect   = hero.getBoundingClientRect();
    const viewH  = window.innerHeight;
    // Progreso: 0 cuando hero sale por abajo, 1 cuando sale por arriba
    const progress = 1 - (rect.bottom / (viewH + rect.height));
    // Rango de movimiento: ±8% del alto del hero
    const shift = (progress - 0.5) * 16;
    img.style.transform = `translateY(${shift}%)`;
    ticking = false;
  }

  window.addEventListener('scroll', () => {
    if (!ticking) {
      requestAnimationFrame(updateParallax);
      ticking = true;
    }
  }, { passive: true });

  // Llamada inicial
  updateParallax();
})();

/* ── FAQ ACCORDION ───────────────────────────────────── */
document.addEventListener('DOMContentLoaded', () => {
  document.querySelectorAll('.faq-question').forEach(btn => {
    btn.addEventListener('click', () => {
      const answer = btn.nextElementSibling;
      const isOpen = btn.classList.contains('open');

      // Cierra todos
      document.querySelectorAll('.faq-question.open').forEach(b => {
        b.classList.remove('open');
        b.nextElementSibling.classList.remove('open');
      });

      // Abre este si estaba cerrado
      if (!isOpen) {
        btn.classList.add('open');
        answer.classList.add('open');
      }
    });
  });
});

/* ══════════════════════════════════════════
   MEGA-MENU — Teclado (Tab/Enter/Escape)
══════════════════════════════════════════ */
document.addEventListener('DOMContentLoaded', () => {
  document.querySelectorAll('.nav-item.has-mega, .nav-item:has(.nav-dropdown)').forEach(item => {
    const trigger = item.querySelector('.nav-link');
    const dropdown = item.querySelector('.nav-dropdown');
    if (!trigger || !dropdown) return;
    trigger.addEventListener('keydown', e => {
      if (e.key === 'Enter' || e.key === ' ') {
        e.preventDefault();
        const links = dropdown.querySelectorAll('a');
        if (links.length) links[0].focus();
      }
    });
    dropdown.querySelectorAll('a').forEach((link, i, all) => {
      link.addEventListener('keydown', e => {
        if (e.key === 'Escape') { trigger.focus(); }
        if (e.key === 'ArrowDown') { e.preventDefault(); all[Math.min(i+1,all.length-1)].focus(); }
        if (e.key === 'ArrowUp')   { e.preventDefault(); all[Math.max(i-1,0)].focus(); }
      });
    });
  });
});

/* ══════════════════════════════════════════
   SMOOTH READ TIME
══════════════════════════════════════════ */
document.addEventListener('DOMContentLoaded', () => {
  const prose = document.querySelector('.prose');
  const badge = document.querySelector('.read-time');
  if (prose && badge) {
    const words = prose.innerText.split(/\s+/).length;
    badge.textContent = Math.max(1, Math.round(words / 200)) + ' min de lectura';
  }
});

/* ══════════════════════════════════════════
   MAP FACADE — carga diferida limpia
══════════════════════════════════════════ */
function loadMap(el) {
  el.classList.add('loaded');
  el.innerHTML = '<iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d2892.7171271515685!2d-5.6439555!3d43.529091199999996!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0xd367b7d26c80e71%3A0xb96af5fea4f8b5ab!2sMedea%20Peluqueria%20y%20Est%C3%A9tica!5e0!3m2!1ses!2ses!4v1782292334474!5m2!1ses!2ses" width="100%" height="400" style="border:0;display:block;" allowfullscreen="" loading="lazy" referrerpolicy="strict-origin-when-cross-origin"></iframe>';
}
window.loadMap = loadMap;

/* ══════════════════════════════════════════
   MAP FACADE v2 — via event listener (robusto)
══════════════════════════════════════════ */
document.addEventListener('DOMContentLoaded', function() {
  document.querySelectorAll('.map-facade').forEach(function(el) {
    function activateMap() {
      if (el.classList.contains('loaded')) return;
      el.classList.add('loaded');
      var iframe = document.createElement('iframe');
      iframe.src = 'https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d2892.7171271515685!2d-5.6439555!3d43.529091199999996!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0xd367b7d26c80e71%3A0xb96af5fea4f8b5ab!2sMedea%20Peluqueria%20y%20Est%C3%A9tica!5e0!3m2!1ses!2ses!4v1782292334474!5m2!1ses!2ses';
      iframe.width = '100%';
      iframe.height = '380';
      iframe.setAttribute('style', 'border:0;display:block;');
      iframe.setAttribute('allowfullscreen', '');
      iframe.setAttribute('loading', 'lazy');
      iframe.setAttribute('referrerpolicy', 'strict-origin-when-cross-origin');
      el.style.height = 'auto';
      el.style.cursor = 'default';
      el.innerHTML = '';
      el.appendChild(iframe);
    }
    el.addEventListener('click', activateMap);
    el.addEventListener('keydown', function(e) {
      if (e.key === 'Enter' || e.key === ' ') { e.preventDefault(); activateMap(); }
    });
  });
});

/* ══════════════════════════════════════════
   COUNTER ANIMATION — cuenta de 0 al valor objetivo
══════════════════════════════════════════ */
(function() {
  var counters = document.querySelectorAll('.counter[data-target]');
  if (!counters.length) return;

  var obs = new IntersectionObserver(function(entries) {
    entries.forEach(function(entry) {
      if (!entry.isIntersecting) return;
      var el = entry.target;
      var target = parseInt(el.dataset.target, 10);
      var duration = 1800;
      var start = null;

      function step(ts) {
        if (!start) start = ts;
        var progress = Math.min((ts - start) / duration, 1);
        // easeOutCubic
        var ease = 1 - Math.pow(1 - progress, 3);
        el.textContent = Math.floor(ease * target);
        if (progress < 1) {
          requestAnimationFrame(step);
        } else {
          el.textContent = target;
        }
      }
      requestAnimationFrame(step);
      obs.unobserve(el);
    });
  }, { threshold: 0.3 });

  counters.forEach(function(el) { obs.observe(el); });
})();
