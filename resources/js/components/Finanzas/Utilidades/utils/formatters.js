// ─── Utilitarios Comunes para Finanzas ──────────────────────────────────────────────
export const fmt = (n) => 'S/ ' + parseFloat(n ?? 0).toLocaleString('es-PE', { minimumFractionDigits: 2, maximumFractionDigits: 2 });
export const pct = (n) => `${parseFloat(n ?? 0).toFixed(1)}%`;
export const mono = (n) => parseFloat(n ?? 0).toLocaleString('es-PE', { minimumFractionDigits: 2, maximumFractionDigits: 2 });
