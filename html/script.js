let THEME = null;
let LOCALE = null;
let UIMODE = "fullscreen";
let DATA = null;

const qs = (s) => document.querySelector(s);
const qsa = (s) => Array.from(document.querySelectorAll(s));

const root = qs('#root');
const panel = qs('#panel');
const compactCard = qs('#compactCard');

const titleText = qs('#titleText');
const titleTextCompact = qs('#titleTextCompact');
const totalOnline = qs('#totalOnline');
const totalDuty = qs('#totalDuty');
const totalOnlineLabel = qs('#totalOnlineLabel');
const totalDutyLabel = qs('#totalDutyLabel');

const totalOnlineC = qs('#totalOnlineC');
const totalDutyC = qs('#totalDutyC');
const totalOnlineLabelC = qs('#totalOnlineLabelC');
const totalDutyLabelC = qs('#totalDutyLabelC');

const servicesList = qs('#servicesList');
const servicesListCompact = qs('#servicesListCompact');

const searchInput = qs('#searchInput');
const toggleModeBtn = qs('#toggleModeBtn');
const closeBtn = qs('#closeBtn');
const closeBtnCompact = qs('#closeBtnCompact');
const toggleModeBtnCompact = qs('#toggleModeBtnCompact');

const thName = qs('#thName'), thJob = qs('#thJob'), thGrade = qs('#thGrade'), thPing = qs('#thPing'), thDuty = qs('#thDuty'), thAdmin = qs('#thAdmin');
const servicesTitle = qs('#servicesTitle');
const footerText = qs('#footerText');
const footerTextCompact = qs('#footerTextCompact');
const playersBody = qs('#playersBody');

function applyTheme(t) {
  THEME = t;
  const r = document.documentElement;
  r.style.setProperty('--bg', t.bg);
  r.style.setProperty('--panel', t.panel);
  r.style.setProperty('--accent', t.accent);
  r.style.setProperty('--accent2', t.accent2);
  r.style.setProperty('--text', t.text);
  r.style.setProperty('--muted', t.muted);
  r.style.setProperty('--success', t.success);
  r.style.setProperty('--danger', t.danger);
  r.style.setProperty('--warning', t.warning);
  r.style.setProperty('--shadow', t.shadow);
}

function applyLocale(l) {
  LOCALE = l;
  titleText.textContent = l.title;
  titleTextCompact.textContent = l.title;
  totalOnlineLabel.textContent = l.total_players;
  totalDutyLabel.textContent = l.on_duty;
  totalOnlineLabelC.textContent = l.total_players;
  totalDutyLabelC.textContent = l.on_duty;
  servicesTitle.textContent = l.services;
  searchInput.placeholder = l.search;
  toggleModeBtn.textContent = (UIMODE === "fullscreen" ? LOCALE.compact : LOCALE.fullscreen);
  footerText.textContent = l.footer;
  footerTextCompact.textContent = l.footer;
  thName.textContent = l.name;
  thJob.textContent = l.job;
  thGrade.textContent = l.grade;
  thPing.textContent = l.ping;
  thDuty.textContent = l.duty;
  thAdmin.textContent = l.admin;
}

function setUIMode(mode) {
  UIMODE = mode;
  panel.classList.toggle('fullscreen', mode === 'fullscreen');
  panel.classList.toggle('hidden', mode !== 'fullscreen');
  compactCard.classList.toggle('hidden', mode !== 'compact');
  toggleModeBtn.textContent = (UIMODE === "fullscreen" ? LOCALE.compact : LOCALE.fullscreen);
  // The compact button always shows "Fullscreen" to switch back
  if (toggleModeBtnCompact) {
    toggleModeBtnCompact.textContent = LOCALE.fullscreen;
  }
}

function drawServices(arr) {
  servicesList.innerHTML = '';
  servicesListCompact.innerHTML = '';
  arr.forEach(svc => {
    const chip = document.createElement('div');
    chip.className = 'service-chip';
    const dot = document.createElement('div');
    dot.className = 'service-dot';
    dot.style.background = svc.color;
    chip.appendChild(dot);

    const label = document.createElement('div');
    label.textContent = `${svc.icon ? (svc.icon + ' ') : ''}${svc.label}`;
    chip.appendChild(label);

    const counts = document.createElement('div');
    counts.className = 'service-counts';
    counts.textContent = ` (${svc.duty}/${svc.total})`;
    chip.appendChild(counts);

    servicesList.appendChild(chip);

    const chipC = chip.cloneNode(true);
    servicesListCompact.appendChild(chipC);
  });
}

function drawPlayers(players) {
  playersBody.innerHTML = '';
  const query = searchInput.value.trim().toLowerCase();
  players
    .filter(p => !query || (p.name.toLowerCase().includes(query)))
    .sort((a,b) => a.name.localeCompare(b.name))
    .forEach(p => {
      const row = document.createElement('div');
      row.className = 'player-row';

      const name = document.createElement('div');
      name.className = 'col col-name';
      name.textContent = p.name;

      const job = document.createElement('div');
      job.className = 'col col-job';
      job.textContent = p.job;

      const grade = document.createElement('div');
      grade.className = 'col col-grade';
      grade.textContent = p.grade || '';

      const ping = document.createElement('div');
      ping.className = 'col col-ping';
      ping.textContent = p.ping;

      const duty = document.createElement('div');
      duty.className = 'col col-duty';
      const pill = document.createElement('div');
      pill.className = 'pill ' + (p.duty ? 'success' : 'danger');
      const dot = document.createElement('div');
      dot.className = 'dot ' + (p.duty ? 'on' : 'off');
      const text = document.createElement('div');
      text.textContent = p.duty ? LOCALE.duty_on : LOCALE.duty_off;
      pill.appendChild(dot); pill.appendChild(text);
      duty.appendChild(pill);

      const admin = document.createElement('div');
      admin.className = 'col col-admin';
      if (p.admin) {
        const tag = document.createElement('div');
        tag.className = 'admin-tag';
        tag.style.borderColor = p.admin.color + '66';
        const dot2 = document.createElement('div');
        dot2.className = 'dot'; dot2.style.background = p.admin.color;
        const text2 = document.createElement('div');
        text2.textContent = `${p.admin.icon ? (p.admin.icon + ' ') : ''}${p.admin.label}`;
        tag.appendChild(dot2); tag.appendChild(text2);
        admin.appendChild(tag);
      } else {
        admin.textContent = '';
      }

      row.appendChild(name);
      row.appendChild(job);
      row.appendChild(grade);
      row.appendChild(ping);
      row.appendChild(duty);
      row.appendChild(admin);

      playersBody.appendChild(row);
    });
}

function updateTotals(totals) {
  totalOnline.textContent = totals.online;
  totalDuty.textContent = totals.duty;
  totalOnlineC.textContent = totals.online;
  totalDutyC.textContent = totals.duty;
}

window.addEventListener('message', (e) => {
  const msg = e.data || {};
  if (msg.action === 'open') {
    root.classList.remove('hidden');
    applyTheme(msg.theme);
    applyLocale(msg.locale);
    setUIMode(msg.ui || 'fullscreen');
  } else if (msg.action === 'close') {
    root.classList.add('hidden');
  } else if (msg.action === 'setUIMode') {
    setUIMode(msg.ui || 'fullscreen');
  } else if (msg.action === 'update') {
    DATA = msg.data;
    updateTotals(DATA.totals);
    drawServices(DATA.services);
    drawPlayers(DATA.players);
  }
});

toggleModeBtn.addEventListener('click', () => {
  fetch(`https://${GetParentResourceName()}/toggleUIMode`, { method: 'POST', body: '{}' });
});

closeBtn.addEventListener('click', () => {
  fetch(`https://${GetParentResourceName()}/close`, { method: 'POST', body: '{}' });
});
closeBtnCompact.addEventListener('click', () => {
  fetch(`https://${GetParentResourceName()}/close`, { method: 'POST', body: '{}' });
});

if (toggleModeBtnCompact) {
  toggleModeBtnCompact.addEventListener('click', () => {
    fetch(`https://${GetParentResourceName()}/toggleUIMode`, { method: 'POST', body: '{}' });
  });
}

searchInput.addEventListener('input', () => {
  if (DATA) drawPlayers(DATA.players);
});
