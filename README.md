# Mini-Projekt – Modul 169: Webserver mit Docker

## Aufgabenstellung

Erstellen eines eigenen Webserver-Images mit **NGINX**, das eine einfache Webseite ausliefert.  
Die Webseite soll über Port **8080** im Browser erreichbar sein.  
Der Container wird so gestartet, dass Website-Dateien und Log-Dateien in **lokalen Verzeichnissen** liegen.

---

## Projektstruktur

```
Mini-Projekt_NK_Modul169/
├── Dockerfile           # Docker-Image-Definition (NGINX Alpine)
├── docker-compose.yml   # Container-Konfiguration mit Volume-Mounts & Port-Mapping
├── nginx.conf           # NGINX-Serverkonfiguration
├── website/             # Webseiten-Dateien (werden per Volume eingebunden)
│   ├── index.html
│   └── style.css
├── logs/                # NGINX-Log-Dateien (werden zur Laufzeit erzeugt)
└── README.md
```

---

## Voraussetzungen

- [Docker](https://www.docker.com/) installiert
- [Docker Compose](https://docs.docker.com/compose/) installiert

---

## Starten des Containers

### Mit Docker Compose (empfohlen)

```bash
docker compose up -d --build
```

Der Container läuft danach im Hintergrund. Die Webseite ist erreichbar unter:

👉 **http://localhost:8080**

### Mit Docker direkt

```bash
# Image bauen
docker build -t modul169-webserver .

# Container starten mit Volume-Mounts und Port-Mapping
docker run -d \
  --name modul169-webserver \
  -p 8080:80 \
  -v "$(pwd)/website:/usr/share/nginx/html:ro" \
  -v "$(pwd)/logs:/var/log/nginx" \
  modul169-webserver
```

---

## Volumes (lokale Verzeichnisse)

| Lokales Verzeichnis | Container-Pfad              | Beschreibung                        |
|---------------------|-----------------------------|-------------------------------------|
| `./website`         | `/usr/share/nginx/html`     | HTML/CSS-Dateien der Webseite       |
| `./logs`            | `/var/log/nginx`            | NGINX Access- und Error-Logs        |

Die Website-Dateien (`website/`) können lokal bearbeitet werden – Änderungen sind sofort im Browser sichtbar (kein Neustart nötig).  
Log-Dateien (`logs/access.log`, `logs/error.log`) werden automatisch beim ersten Aufruf erzeugt.

---

## Container stoppen

```bash
docker compose down
```

---

## Dockerfile

Das Image basiert auf dem offiziellen **nginx:alpine**-Image (schlanke Alpine-Linux-Basis).

```dockerfile
FROM nginx:alpine
LABEL maintainer="Modul169-Student"
LABEL description="Einfacher NGINX Webserver – Modul 169 Mini-Projekt"
COPY nginx.conf /etc/nginx/conf.d/default.conf
COPY website/ /usr/share/nginx/html/
EXPOSE 80
```

- Port **80** im Container → wird auf Host-Port **8080** gemappt
- Website-Dateien werden beim Build ins Image kopiert **und** per Volume zur Laufzeit eingebunden
- Log-Konfiguration in `nginx.conf`

---

## Webseite

Die Webseite (`website/index.html`) ist eine einfache deutschsprachige Seite, die das Projekt beschreibt.  
Sie verwendet eine separate CSS-Datei (`website/style.css`) für das Styling.
