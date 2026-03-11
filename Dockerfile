# Dockerfile – NGINX Webserver (Modul 169 Mini-Projekt)

# Basis-Image: offizielles NGINX (Alpine für kleinere Image-Größe)
FROM nginx:alpine

# Metadaten
LABEL maintainer="Modul169-Student"
LABEL description="Einfacher NGINX Webserver – Modul 169 Mini-Projekt"

# Standard-NGINX-Konfiguration entfernen und eigene hinzufügen
COPY nginx.conf /etc/nginx/conf.d/default.conf

# Website-Dateien in das NGINX-Webverzeichnis kopieren
# (werden im Produktivbetrieb per Volume überschrieben)
COPY website/ /usr/share/nginx/html/

# Port 80 im Container freigeben
EXPOSE 80
