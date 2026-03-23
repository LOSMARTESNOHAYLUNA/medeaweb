#!/usr/bin/env python3
"""
Medea Estilistas — Servidor local de desarrollo
================================================
Uso:
  1. Coloca este archivo en la carpeta raíz del proyecto (medea-web/)
  2. Abre una terminal en esa carpeta
  3. Ejecuta:  python3 servidor.py
  4. Abre en el navegador:  http://localhost:8080

Para parar el servidor: Ctrl + C
"""

import http.server
import socketserver
import webbrowser
import threading
import os
import sys

PORT = 8080
DIRECTORY = os.path.dirname(os.path.abspath(__file__))

class MedeaHandler(http.server.SimpleHTTPRequestHandler):
    def __init__(self, *args, **kwargs):
        super().__init__(*args, directory=DIRECTORY, **kwargs)

    def log_message(self, fmt, *args):
        # Formato limpio de logs
        print(f"  → {self.path}")

    def end_headers(self):
        # Evitar caché durante el desarrollo
        self.send_header('Cache-Control', 'no-cache, no-store, must-revalidate')
        self.send_header('Pragma', 'no-cache')
        super().end_headers()

    def do_GET(self):
        # Si la ruta no tiene extensión, intentar servir index.html
        path = self.path.split('?')[0]
        if not os.path.splitext(path)[1]:
            if not path.endswith('/'):
                self.path = path + '/'
            # Busca index.html en la carpeta
            file_path = os.path.join(DIRECTORY, self.path.lstrip('/'), 'index.html')
            if os.path.exists(file_path):
                self.path = self.path + 'index.html'
        super().do_GET()

def abrir_navegador():
    import time
    time.sleep(0.8)
    webbrowser.open(f'http://localhost:{PORT}')

if __name__ == '__main__':
    os.chdir(DIRECTORY)

    print(f"""
╔══════════════════════════════════════════╗
║     Medea Estilistas — Dev Server        ║
╠══════════════════════════════════════════╣
║  URL:  http://localhost:{PORT}             ║
║  Dir:  {DIRECTORY[:30]:<30}  ║
║  Para parar: Ctrl + C                   ║
╚══════════════════════════════════════════╝
    """)

    # Abrir el navegador automáticamente
    threading.Thread(target=abrir_navegador, daemon=True).start()

    with socketserver.TCPServer(('', PORT), MedeaHandler) as httpd:
        try:
            httpd.serve_forever()
        except KeyboardInterrupt:
            print("\n\n✓ Servidor parado. ¡Hasta pronto!")
            sys.exit(0)
