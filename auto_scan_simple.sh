#!/bin/bash
# auto_scan_simple.sh
# Detecta escáner automáticamente y realiza un escaneo JPEG

OUT_DIR="/mnt"
RESOLUTION=300
MODE="color"
FORMAT="jpeg"
TIMESTAMP="$(date +'%Y%m%d%H%M%S')"
OUT_FILE="${OUT_DIR}/${TIMESTAMP}.jpg"

echo "🔍 Buscando escáner con 'scanimage -L'..."
SCAN_LIST=$(scanimage -L 2>/dev/null)

if [ -z "$SCAN_LIST" ]; then
  echo "❌ No se detectó ningún escáner. Verifica conexión o drivers."
  exit 1
fi

echo "📄 Salida completa de 'scanimage -L':"
echo "---------------------------------"
echo "$SCAN_LIST"
echo "---------------------------------"

# Extraer el identificador del dispositivo
DEVICE=$(echo "$SCAN_LIST" | sed -n "s/.*device \`\([^']*\)'.*/\1/p")

if [ -z "$DEVICE" ]; then
  echo "❌ No se pudo extraer un identificador de dispositivo válido."
  exit 2
fi

echo "✅ Dispositivo detectado: $DEVICE"

# Crear carpeta si no existe
if [ ! -d "$OUT_DIR" ]; then
  echo "📁 Creando carpeta de salida: $OUT_DIR"
  sudo mkdir -p "$OUT_DIR"
fi

# Ejecutar el escaneo
echo "📸 Iniciando escaneo..."
if sudo scanimage -d "$DEVICE" --mode="$MODE" --resolution="$RESOLUTION" --format="$FORMAT" > "$OUT_FILE"; then
  echo "✅ Escaneo completado correctamente."
  echo "🖼️ Archivo guardado en: $OUT_FILE"
else
  echo "❌ Error durante el escaneo. Verifica el dispositivo o permisos."
  [ -f "$OUT_FILE" ] && rm -f "$OUT_FILE"
  exit 3
fi
