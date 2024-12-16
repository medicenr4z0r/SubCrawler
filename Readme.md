# SubCrawler by R4z0r

SubCrawler es una herramienta automatizada para la recolección y análisis de subdominios y rutas web a través de varias herramientas de reconocimiento. Esta herramienta permite obtener información relevante para evaluaciones de seguridad en aplicaciones web y estructuras de red.

---

## Tabla de Contenidos

1. [Características](#características)
2. [Instalación](#instalación)
3. [Requisitos Previos](#requisitos-previos)
4. [Herramientas Utilizadas](#herramientas-utilizadas)
5. [Uso](#uso)
6. [Estructura de Resultados](#estructura-de-resultados)
7. [Contribuciones](#contribuciones)

---

## Características

- Búsqueda de subdominios utilizando **subfinder** y **sublist3r**.
- Filtrado de subdominios activos con **httprobe**.
- Crawling de subdominios con **katana**.
- Análisis de URLs con **gau** y **Wayback Machine**.
- Consolidación de resultados en un único archivo.
- Salida ordenada y sin duplicados.

---

## Instalación

Clona el repositorio:
```bash
git clone https://github.com/medicenr4z0r/SubCrawler.git
cd SubCrawler
```

---

## Requisitos Previos

Antes de ejecutar SubCrawler, asegúrate de tener las siguientes herramientas instaladas:

1. **subfinder**
   ```bash
   go install -v github.com/projectdiscovery/subfinder/v2/cmd/subfinder@latest
   ```

2. **sublist3r**
   ```bash
   git clone https://github.com/aboul3la/Sublist3r.git
   cd Sublist3r
   pip3 install -r requirements.txt
   ```

3. **httprobe**
   ```bash
   go install github.com/tomnomnom/httprobe@latest
   ```

4. **katana**
   ```bash
   go install github.com/projectdiscovery/katana/cmd/katana@latest
   ```

5. **gau**
   ```bash
   go install github.com/lc/gau/v2/cmd/gau@latest
   ```

6. **Waybackurls**
   ```bash
   go install github.com/tomnomnom/waybackurls@latest
   ```

7. **anew** (opcional, para evitar duplicados)
   ```bash
   go install github.com/tomnomnom/anew@latest
   ```

Asegúrate de que todas las herramientas están disponibles en tu `PATH`.

---

## Herramientas Utilizadas

### 1. subfinder
Encuentra subdominios rápidamente utilizando múltiples fuentes.

### 2. sublist3r
Una herramienta basada en Python para enumerar subdominios utilizando motores de búsqueda y otras fuentes públicas.

### 3. httprobe
Verifica qué subdominios están activos al probar su accesibilidad HTTP/HTTPS.

### 4. katana
Realiza crawling en subdominios activos para encontrar rutas adicionales.

### 5. gau
Obtiene URLs de APIs públicas como Common Crawl, Wayback Machine, etc.

### 6. Waybackurls
Extrae URLs históricas de Wayback Machine.

### 7. anew
Gestiona salidas para evitar duplicados y facilitar el análisis.

---

## Uso

Ejecuta el script proporcionando una carpeta de salida y el dominio objetivo:
```bash
./subcrawler.sh <carpeta_de_salida> <dominio>
```
Ejemplo:
```bash
./subcrawler.sh resultados example.com
```

---

## Estructura de Resultados

El script genera la siguiente estructura en la carpeta de salida:

```
<carpeta_de_salida>/
├── subdominios.txt            # Lista de subdominios encontrados
├── subdominios_activos.txt    # Subdominios accesibles (activos)
├── katana_full.txt            # Resultados del crawling con katana
├── gau_full.txt               # URLs extraídas con gau
├── wayback_full.txt           # URLs históricas de Wayback Machine
├── full.txt                   # Todos los resultados combinados y ordenados
```

---

## Contribuciones

Si deseas contribuir a este proyecto, por favor abre un issue o envía un pull request en el repositorio oficial.

---

¡Gracias por usar SubCrawler! 🚀
