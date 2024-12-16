#!/bin/bash
echo ""
echo ""
echo ""
echo "     ~ SubCrawler by R4z0r ~     "
echo ""
echo ""
echo ""
if [ "$#" -ne 2 ]; then
    echo "Uso: $0 <carpeta_de_salida> <dominio>"
    exit 1
fi

OUTPUT_DIR=$1
DOMAIN=$2

mkdir -p "$OUTPUT_DIR"

echo "[+] Verificando subdominios con subfinder..."
subfinder -d "$DOMAIN" -silent > "$OUTPUT_DIR/subdominios_tmp.txt" 2>/dev/null

echo "[+] Verificando subdominios con sublist3r..."
sublist3r -d "$DOMAIN" 2>/dev/null | grep -E "^([-a-zA-Z0-9]+\.)+$DOMAIN" | anew "$OUTPUT_DIR/subdominios_tmp.txt" >/dev/null

sort -u "$OUTPUT_DIR/subdominios_tmp.txt" > "$OUTPUT_DIR/subdominios.txt"
rm "$OUTPUT_DIR/subdominios_tmp.txt"
echo "[+] Subdominios guardados en $OUTPUT_DIR/subdominios.txt"

echo "[+] Verificando subdominios accesibles con httprobe..."
cat "$OUTPUT_DIR/subdominios.txt" | httprobe 2>/dev/null | sort -u > "$OUTPUT_DIR/subdominios_activos.txt"
echo "[+] Subdominios activos guardados en $OUTPUT_DIR/subdominios_activos.txt"

echo "[+] Iniciando crawling sobre subdominios activos..."
> "$OUTPUT_DIR/katana_full.txt" 
while read subdomain; do
    katana -u "$subdomain" -silent -d 5 2>/dev/null | sort -u | anew "$OUTPUT_DIR/katana_full.txt" >/dev/null
done < "$OUTPUT_DIR/subdominios_activos.txt"
echo "[+] Crawling completado y guardado en $OUTPUT_DIR/katana_full.txt"

echo "[+] Ejecutando gau sobre los subdominios activos..."
> "$OUTPUT_DIR/gau_full.txt" 
while read subdomain; do
    echo "$subdomain" | gau 2>/dev/null | sort -u | anew "$OUTPUT_DIR/gau_full.txt" >/dev/null
done < "$OUTPUT_DIR/subdominios_activos.txt"
echo "[+] URLs de gau guardadas en $OUTPUT_DIR/gau_full.txt"

echo "[+] Obteniendo URLs históricas con Wayback Machine..."
> "$OUTPUT_DIR/wayback_full.txt" 
while read subdomain; do
    echo "$subdomain" | waybackurls 2>/dev/null | sort -u | anew "$OUTPUT_DIR/wayback_full.txt" >/dev/null
done < "$OUTPUT_DIR/subdominios_activos.txt"
echo "[+] URLs históricas guardadas en $OUTPUT_DIR/wayback_full.txt"

echo "[+] Uniendo todos los resultados en full.txt..."
cat "$OUTPUT_DIR/katana_full.txt" "$OUTPUT_DIR/gau_full.txt" "$OUTPUT_DIR/wayback_full.txt" | sort -u > "$OUTPUT_DIR/full.txt"
echo "[+] Archivo combinado guardado en $OUTPUT_DIR/full.txt"

echo "[+] Escaneo completado. Todos los resultados han sido guardados en la carpeta $OUTPUT_DIR."
