# 🤡 Kuyayki Clown — Reporte Visita Hospitalaria

Dashboard web del reporte **Visita Hospitalaria Mes**. Lee en vivo los dos
formularios (Google Sheets publicados como CSV), consolida la información,
aplica la lógica de Power Query y muestra una tabla con segmentaciones
(filtros) al estilo *clown*. Se actualiza automáticamente cada 12 horas.

## 📁 Estructura

```
WEB_VERCEL/
├── public/
│   └── index.html      ← El reporte completo (todo el código está aquí)
├── package.json
├── vercel.json
├── .gitignore
└── README.md
```

> Todo el reporte vive en `public/index.html` (HTML + CSS + JS en un solo
> archivo). No hay dependencias ni paso de build: es un sitio estático.

## 🚀 Subir a GitHub + Vercel

### 1) Crear el repositorio en GitHub
Sube **el contenido de esta carpeta** (`WEB_VERCEL`) a un repo nuevo.

Desde esta carpeta, en una terminal:

```bash
git init
git add .
git commit -m "Reporte Kuyayki Clown - version inicial"
git branch -M main
git remote add origin https://github.com/TU_USUARIO/kuyayki-reporte.git
git push -u origin main
```

### 2) Conectar a Vercel
1. Entra a https://vercel.com e inicia sesión (puedes usar tu cuenta de GitHub).
2. Botón **Add New… → Project**.
3. Elige el repositorio que acabas de subir.
4. Vercel detectará que es un sitio estático. Deja la configuración por defecto:
   - **Framework Preset:** Other
   - **Build Command:** (vacío)
   - **Output Directory:** `public`
5. Pulsa **Deploy**. En ~1 minuto tendrás una URL pública tipo
   `https://kuyayki-reporte.vercel.app`.

Cada vez que hagas `git push`, Vercel volverá a desplegar automáticamente.

## 🔄 Actualización de datos

- Los datos se leen **en tiempo real** desde los CSV de Google Sheets cada vez
  que alguien abre la página, y además se refrescan solos cada **12 horas**
  si la pestaña queda abierta.
- No necesitas volver a desplegar para que se actualicen los datos: solo
  cambian las fuentes de Google.

## 🧪 Probar en local

```bash
npm run dev
```

Esto sirve la carpeta `public` en un puerto local (requiere Node/npm).
También puedes abrirlo con el archivo `ABRIR REPORTE.bat` de la carpeta
`REPORTE` (no abras el HTML con doble clic directo: el navegador bloquea la
descarga de datos por seguridad cuando se usa `file://`).
